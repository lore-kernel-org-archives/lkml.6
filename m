Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9NVQELVYGVuTAwAAmS7hNA
	; Thu, 07 Jun 2018 16:09:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F1A2F6074D; Thu,  7 Jun 2018 16:09:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 351FA60590;
	Thu,  7 Jun 2018 16:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 351FA60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935508AbeFGQJK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:09:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39204 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932872AbeFGOJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:02 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0005Zr-RF; Thu, 07 Jun 2018 15:08:59 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvax-0002i7-SG; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Nicolai Stange" <nstange@suse.de>,
        "Takashi Iwai" <tiwai@suse.de>,
        "=?UTF-8?Q?=E8=8C=83=E9=BE=99=E9=A3=9E?=" <long7573@126.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.454751756@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 026/410] ALSA: seq: More protection for concurrent
 write and ioctl races
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

commit 7bd80091567789f1c0cb70eb4737aac8bcd2b6b9 upstream.

This patch is an attempt for further hardening against races between
the concurrent write and ioctls.  The previous fix d15d662e89fc
("ALSA: seq: Fix racy pool initializations") covered the race of the
pool initialization at writer and the pool resize ioctl by the
client->ioctl_mutex (CVE-2018-1000004).  However, basically this mutex
should be applied more widely to the whole write operation for
avoiding the unexpected pool operations by another thread.

The only change outside snd_seq_write() is the additional mutex
argument to helper functions, so that we can unlock / relock the given
mutex temporarily during schedule() call for blocking write.

Fixes: d15d662e89fc ("ALSA: seq: Fix racy pool initializations")
Reported-by: 范龙飞 <long7573@126.com>
Reported-by: Nicolai Stange <nstange@suse.de>
Reviewed-and-tested-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/seq/seq_clientmgr.c | 18 +++++++++++-------
 sound/core/seq/seq_fifo.c      |  2 +-
 sound/core/seq/seq_memory.c    | 14 ++++++++++----
 sound/core/seq/seq_memory.h    |  3 ++-
 4 files changed, 24 insertions(+), 13 deletions(-)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -919,7 +919,8 @@ int snd_seq_dispatch_event(struct snd_se
 static int snd_seq_client_enqueue_event(struct snd_seq_client *client,
 					struct snd_seq_event *event,
 					struct file *file, int blocking,
-					int atomic, int hop)
+					int atomic, int hop,
+					struct mutex *mutexp)
 {
 	struct snd_seq_event_cell *cell;
 	int err;
@@ -957,7 +958,8 @@ static int snd_seq_client_enqueue_event(
 		return -ENXIO; /* queue is not allocated */
 
 	/* allocate an event cell */
-	err = snd_seq_event_dup(client->pool, event, &cell, !blocking || atomic, file);
+	err = snd_seq_event_dup(client->pool, event, &cell, !blocking || atomic,
+				file, mutexp);
 	if (err < 0)
 		return err;
 
@@ -1026,12 +1028,11 @@ static ssize_t snd_seq_write(struct file
 		return -ENXIO;
 
 	/* allocate the pool now if the pool is not allocated yet */ 
+	mutex_lock(&client->ioctl_mutex);
 	if (client->pool->size > 0 && !snd_seq_write_pool_allocated(client)) {
-		mutex_lock(&client->ioctl_mutex);
 		err = snd_seq_pool_init(client->pool);
-		mutex_unlock(&client->ioctl_mutex);
 		if (err < 0)
-			return -ENOMEM;
+			goto out;
 	}
 
 	/* only process whole events */
@@ -1082,7 +1083,7 @@ static ssize_t snd_seq_write(struct file
 		/* ok, enqueue it */
 		err = snd_seq_client_enqueue_event(client, &event, file,
 						   !(file->f_flags & O_NONBLOCK),
-						   0, 0);
+						   0, 0, &client->ioctl_mutex);
 		if (err < 0)
 			break;
 
@@ -1093,6 +1094,8 @@ static ssize_t snd_seq_write(struct file
 		written += len;
 	}
 
+ out:
+	mutex_unlock(&client->ioctl_mutex);
 	return written ? written : err;
 }
 
@@ -2355,7 +2358,8 @@ static int kernel_client_enqueue(int cli
 	if (! cptr->accept_output)
 		result = -EPERM;
 	else /* send it */
-		result = snd_seq_client_enqueue_event(cptr, ev, file, blocking, atomic, hop);
+		result = snd_seq_client_enqueue_event(cptr, ev, file, blocking,
+						      atomic, hop, NULL);
 
 	snd_seq_client_unlock(cptr);
 	return result;
--- a/sound/core/seq/seq_fifo.c
+++ b/sound/core/seq/seq_fifo.c
@@ -123,7 +123,7 @@ int snd_seq_fifo_event_in(struct snd_seq
 		return -EINVAL;
 
 	snd_use_lock_use(&f->use_lock);
-	err = snd_seq_event_dup(f->pool, event, &cell, 1, NULL); /* always non-blocking */
+	err = snd_seq_event_dup(f->pool, event, &cell, 1, NULL, NULL); /* always non-blocking */
 	if (err < 0) {
 		if ((err == -ENOMEM) || (err == -EAGAIN))
 			atomic_inc(&f->overflow);
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -221,7 +221,8 @@ void snd_seq_cell_free(struct snd_seq_ev
  */
 static int snd_seq_cell_alloc(struct snd_seq_pool *pool,
 			      struct snd_seq_event_cell **cellp,
-			      int nonblock, struct file *file)
+			      int nonblock, struct file *file,
+			      struct mutex *mutexp)
 {
 	struct snd_seq_event_cell *cell;
 	unsigned long flags;
@@ -245,7 +246,11 @@ static int snd_seq_cell_alloc(struct snd
 		set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&pool->output_sleep, &wait);
 		spin_unlock_irq(&pool->lock);
+		if (mutexp)
+			mutex_unlock(mutexp);
 		schedule();
+		if (mutexp)
+			mutex_lock(mutexp);
 		spin_lock_irq(&pool->lock);
 		remove_wait_queue(&pool->output_sleep, &wait);
 		/* interrupted? */
@@ -288,7 +293,7 @@ __error:
  */
 int snd_seq_event_dup(struct snd_seq_pool *pool, struct snd_seq_event *event,
 		      struct snd_seq_event_cell **cellp, int nonblock,
-		      struct file *file)
+		      struct file *file, struct mutex *mutexp)
 {
 	int ncells, err;
 	unsigned int extlen;
@@ -305,7 +310,7 @@ int snd_seq_event_dup(struct snd_seq_poo
 	if (ncells >= pool->total_elements)
 		return -ENOMEM;
 
-	err = snd_seq_cell_alloc(pool, &cell, nonblock, file);
+	err = snd_seq_cell_alloc(pool, &cell, nonblock, file, mutexp);
 	if (err < 0)
 		return err;
 
@@ -331,7 +336,8 @@ int snd_seq_event_dup(struct snd_seq_poo
 			int size = sizeof(struct snd_seq_event);
 			if (len < size)
 				size = len;
-			err = snd_seq_cell_alloc(pool, &tmp, nonblock, file);
+			err = snd_seq_cell_alloc(pool, &tmp, nonblock, file,
+						 mutexp);
 			if (err < 0)
 				goto __error;
 			if (cell->event.data.ext.ptr == NULL)
--- a/sound/core/seq/seq_memory.h
+++ b/sound/core/seq/seq_memory.h
@@ -66,7 +66,8 @@ struct snd_seq_pool {
 void snd_seq_cell_free(struct snd_seq_event_cell *cell);
 
 int snd_seq_event_dup(struct snd_seq_pool *pool, struct snd_seq_event *event,
-		      struct snd_seq_event_cell **cellp, int nonblock, struct file *file);
+		      struct snd_seq_event_cell **cellp, int nonblock,
+		      struct file *file, struct mutex *mutexp);
 
 /* return number of unused (free) cells */
 static inline int snd_seq_unused_cells(struct snd_seq_pool *pool)
