Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VQdnJX08GVvKNAAAmS7hNA
	; Thu, 07 Jun 2018 14:10:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B89C3608B8; Thu,  7 Jun 2018 14:10:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 19549602FC;
	Thu,  7 Jun 2018 14:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19549602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933280AbeFGOJz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:09:55 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39404 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932877AbeFGOJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:30 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbQ-0005Zx-BG; Thu, 07 Jun 2018 15:09:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003DT-C0; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Nicolai Stange" <nstange@suse.de>,
        "Takashi Iwai" <tiwai@suse.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.340415478@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 342/410] ALSA: seq: Fix possible UAF in
 snd_seq_check_queue()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit d0f833065221cbfcbadf19fd4102bcfa9330006a upstream.

Although we've covered the races between concurrent write() and
ioctl() in the previous patch series, there is still a possible UAF in
the following scenario:

A: user client closed		B: timer irq
  -> snd_seq_release()		  -> snd_seq_timer_interrupt()
    -> snd_seq_free_client()	    -> snd_seq_check_queue()
				      -> cell = snd_seq_prioq_cell_peek()
      -> snd_seq_prioq_leave()
         .... removing all cells
      -> snd_seq_pool_done()
         .... vfree()
				      -> snd_seq_compare_tick_time(cell)
				         ... Oops

So the problem is that a cell is peeked and accessed without any
protection until it's retrieved from the queue again via
snd_seq_prioq_cell_out().

This patch tries to address it, also cleans up the code by a slight
refactoring.  snd_seq_prioq_cell_out() now receives an extra pointer
argument.  When it's non-NULL, the function checks the event timestamp
with the given pointer.  The caller needs to pass the right reference
either to snd_seq_tick or snd_seq_realtime depending on the event
timestamp type.

A good news is that the above change allows us to remove the
snd_seq_prioq_cell_peek(), too, thus the patch actually reduces the
code size.

Reviewed-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/seq/seq_prioq.c | 28 ++++++++++++++--------------
 sound/core/seq/seq_prioq.h |  6 ++----
 sound/core/seq/seq_queue.c | 28 +++++++++-------------------
 3 files changed, 25 insertions(+), 37 deletions(-)

--- a/sound/core/seq/seq_prioq.c
+++ b/sound/core/seq/seq_prioq.c
@@ -87,7 +87,7 @@ void snd_seq_prioq_delete(struct snd_seq
 	if (f->cells > 0) {
 		/* drain prioQ */
 		while (f->cells > 0)
-			snd_seq_cell_free(snd_seq_prioq_cell_out(f));
+			snd_seq_cell_free(snd_seq_prioq_cell_out(f, NULL));
 	}
 	
 	kfree(f);
@@ -214,8 +214,18 @@ int snd_seq_prioq_cell_in(struct snd_seq
 	return 0;
 }
 
+/* return 1 if the current time >= event timestamp */
+static int event_is_ready(struct snd_seq_event *ev, void *current_time)
+{
+	if ((ev->flags & SNDRV_SEQ_TIME_STAMP_MASK) == SNDRV_SEQ_TIME_STAMP_TICK)
+		return snd_seq_compare_tick_time(current_time, &ev->time.tick);
+	else
+		return snd_seq_compare_real_time(current_time, &ev->time.time);
+}
+
 /* dequeue cell from prioq */
-struct snd_seq_event_cell *snd_seq_prioq_cell_out(struct snd_seq_prioq *f)
+struct snd_seq_event_cell *snd_seq_prioq_cell_out(struct snd_seq_prioq *f,
+						  void *current_time)
 {
 	struct snd_seq_event_cell *cell;
 	unsigned long flags;
@@ -227,6 +237,8 @@ struct snd_seq_event_cell *snd_seq_prioq
 	spin_lock_irqsave(&f->lock, flags);
 
 	cell = f->head;
+	if (cell && current_time && !event_is_ready(&cell->event, current_time))
+		cell = NULL;
 	if (cell) {
 		f->head = cell->next;
 
@@ -252,18 +264,6 @@ int snd_seq_prioq_avail(struct snd_seq_p
 	return f->cells;
 }
 
-
-/* peek at cell at the head of the prioq */
-struct snd_seq_event_cell *snd_seq_prioq_cell_peek(struct snd_seq_prioq * f)
-{
-	if (f == NULL) {
-		pr_debug("ALSA: seq: snd_seq_prioq_cell_in() called with NULL prioq\n");
-		return NULL;
-	}
-	return f->head;
-}
-
-
 static inline int prioq_match(struct snd_seq_event_cell *cell,
 			      int client, int timestamp)
 {
--- a/sound/core/seq/seq_prioq.h
+++ b/sound/core/seq/seq_prioq.h
@@ -44,14 +44,12 @@ void snd_seq_prioq_delete(struct snd_seq
 int snd_seq_prioq_cell_in(struct snd_seq_prioq *f, struct snd_seq_event_cell *cell);
 
 /* dequeue cell from prioq */ 
-struct snd_seq_event_cell *snd_seq_prioq_cell_out(struct snd_seq_prioq *f);
+struct snd_seq_event_cell *snd_seq_prioq_cell_out(struct snd_seq_prioq *f,
+						  void *current_time);
 
 /* return number of events available in prioq */
 int snd_seq_prioq_avail(struct snd_seq_prioq *f);
 
-/* peek at cell at the head of the prioq */
-struct snd_seq_event_cell *snd_seq_prioq_cell_peek(struct snd_seq_prioq *f);
-
 /* client left queue */
 void snd_seq_prioq_leave(struct snd_seq_prioq *f, int client, int timestamp);        
 
--- a/sound/core/seq/seq_queue.c
+++ b/sound/core/seq/seq_queue.c
@@ -273,30 +273,20 @@ void snd_seq_check_queue(struct snd_seq_
 
       __again:
 	/* Process tick queue... */
-	while ((cell = snd_seq_prioq_cell_peek(q->tickq)) != NULL) {
-		if (snd_seq_compare_tick_time(&q->timer->tick.cur_tick,
-					      &cell->event.time.tick)) {
-			cell = snd_seq_prioq_cell_out(q->tickq);
-			if (cell)
-				snd_seq_dispatch_event(cell, atomic, hop);
-		} else {
-			/* event remains in the queue */
+	for (;;) {
+		cell = snd_seq_prioq_cell_out(q->tickq,
+					      &q->timer->tick.cur_tick);
+		if (!cell)
 			break;
-		}
+		snd_seq_dispatch_event(cell, atomic, hop);
 	}
 
-
 	/* Process time queue... */
-	while ((cell = snd_seq_prioq_cell_peek(q->timeq)) != NULL) {
-		if (snd_seq_compare_real_time(&q->timer->cur_time,
-					      &cell->event.time.time)) {
-			cell = snd_seq_prioq_cell_out(q->timeq);
-			if (cell)
-				snd_seq_dispatch_event(cell, atomic, hop);
-		} else {
-			/* event remains in the queue */
+	for (;;) {
+		cell = snd_seq_prioq_cell_out(q->timeq, &q->timer->cur_time);
+		if (!cell)
 			break;
-		}
+		snd_seq_dispatch_event(cell, atomic, hop);
 	}
 
 	/* free lock */
