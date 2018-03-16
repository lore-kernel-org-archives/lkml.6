Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsQMDajMJfOwkOXpKjQSyr8HgF8RFlu9kLsccKGsOo7PIwAtv2ePCdmmVaR/lBEan1gyT1a
ARC-Seal: i=1; a=rsa-sha256; t=1521213816; cv=none;
        d=google.com; s=arc-20160816;
        b=KM7+OeBpK9OcwraiMaGN3aPvqMGFX15qEIhIBSyJGcOzw9xX4qMdFjWCva8htHzXmw
         WG1QR/xNDoe7/wybOslCJK73mM8ICsuB6+Py+AplI32SKJcGT+96tT+f96Zvlm6bhJUF
         2OVoYQ7NHWNKK3Yg3HfOyTA/r+Ricnl5rTfPGd9H/fLNx0dxLxUGjpMQIVz7N0VUScet
         wsPMyOMxUoGyqvvgCL2E3HMTT8i7Bi8SsZJS9mJ3AcukraMTr166OgmVoWaEUkgg7a2z
         Q8zNY97k3wRJhfr6q2nf29WNLDijiLeGIALXaxA59av2p7JGIPoT7d4zyyPmWtmcjMCa
         W+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oktGr2fdMQM5HO+t4OOTNSAU+omRrHkKs6tOxo8Z/Kg=;
        b=b8kfiZknZZXpqIdaq4d+10RVLr2VSbIr6Loz5UsmCtgo3GW20dP79nL1645xkCyKca
         ZQjKY9OrotaofW3l3X7u8ZAOL4BW+Y2xUFX/w41qU0J8v6BHV0seX0MwCsMJWQiJXB1v
         6uxQ+2x7b6kWDcX+31RPJAaptKvlLU4Os6Y2IaT2g4BCGMgCVQ/roRkOMUl36v03BbRh
         PM/YhpjNfrb7DkiLHngI2glX72XoumhgpSOwLfgCMohxGF9C9BQecqrA33EMdV2xlZx7
         ZB3a85pgtmG5sleB59olkCAIrl/SlyLRQ7eb+3rNPZjSWpgcui2Sl7S5QghX6UXILYrR
         zK2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?=E8=8C=83=E9=BE=99=E9=A3=9E?= <long7573@126.com>,
	Nicolai Stange <nstange@suse.de>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 06/25] ALSA: seq: More protection for concurrent write and ioctl races
Date: Fri, 16 Mar 2018 16:22:53 +0100
Message-Id: <20180316152233.019267900@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108299103257252?=
X-GMAIL-MSGID: =?utf-8?q?1595108299103257252?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/seq_clientmgr.c |   18 +++++++++++-------
 sound/core/seq/seq_fifo.c      |    2 +-
 sound/core/seq/seq_memory.c    |   14 ++++++++++----
 sound/core/seq/seq_memory.h    |    3 ++-
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
