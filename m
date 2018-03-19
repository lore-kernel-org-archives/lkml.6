Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsUa360YcM36s6G1NTV48YQzp8rpRt7WS5ZuqMdCRjkoAqYLFtilaPlVsElKqE7DciyZMyL
ARC-Seal: i=1; a=rsa-sha256; t=1521484167; cv=none;
        d=google.com; s=arc-20160816;
        b=tM69vhOwuRV2jjdIAy0q/gXBJrWZARHiZtx0vtubu5WeSZ3bi1L0j+Qp9hKGlC8JNo
         W+dWcbanWaRduxwRl1V71q8scrB8BtWY0RGudk+dNw5MJ+IaownrRVC3Ij684KGMrV+t
         xUM07i1HUHjrtryhYY7BBdowUXfBGGSLV+VDpelXzTxwfWr9Uz4dAXHkg+WOJORyGqYY
         AACsHab0TG91Htm1ew/EJQgATI7gD2ygoB9r9S/IqIrz+SeXMY1vm9zKtfWZUNqmylNE
         kddsDXdCHi6hmMqvuNrtZJrWBuaUIhxDQG6d6Q4U46r9YW2wjhVwGTuG+ZlHWa8xs65B
         KgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NeDNzi3ZHudXlDXWURNRexqCc5MmubJ/vGbHTgT3w84=;
        b=JooaTCndJhWH3KUV8VychnbSm95ch6R8yk7JBg79xHk973FMUSbFEr2McDeuwOQPAd
         nwd0EMYPkJldy0QIPBWiQXiVqC75oXs/TnOWD+/wXRwES4/6CgCJCSmqFs0kb5lwLSXc
         QA1cHq/p7MNzKs3WOgOAObRY1Gadi6CtnT6aVVNxAupF9engHiom09IFNPwLqCnlnzpN
         6B61hqc0IZFYcNEtmKA2hK/O6rGE5huOMBKqpRbF00JHNbYi6xR7OIyteTaMsdKC3hKW
         k0qFsyHj9jjFz97EsKu1K0I9VH6/SmG9/T/imEih5Z79VMthuUOq/b4hnEw0a/VsU1u7
         ot7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicolai Stange <nstange@suse.de>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 15/41] ALSA: seq: Fix possible UAF in snd_seq_check_queue()
Date: Mon, 19 Mar 2018 19:08:15 +0100
Message-Id: <20180319180733.220848226@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390645359098514?=
X-GMAIL-MSGID: =?utf-8?q?1595391782089461227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/seq_prioq.c |   28 ++++++++++++++--------------
 sound/core/seq/seq_prioq.h |    6 ++----
 sound/core/seq/seq_queue.c |   28 +++++++++-------------------
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
@@ -277,30 +277,20 @@ void snd_seq_check_queue(struct snd_seq_
 
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
