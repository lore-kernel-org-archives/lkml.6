Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs4nK8Yo37OSzxbaaRsx6Xxg4pdeK/wloYNXNsTSC9TDtOje0vGsYDefZrybBwPXprmBrPk
ARC-Seal: i=1; a=rsa-sha256; t=1520955129; cv=none;
        d=google.com; s=arc-20160816;
        b=De1NU3W9HThrVJp/90uRp+s3xuR3RfwOSIpyegxcCYFMnE3gWFbp5QU2opjHYYR/et
         sE6QwucV0At4f9QqVFjAAp0G6L69xbpNSbKNmolbTRooImJotmfNBDMSp+teWerRd+4j
         KIhvlKOyxCwo33RwcwSZdOcoUY0+/QXRCrsvFrpLjfYJOhoEqZT3XBbgizQtWot3uU/1
         iFWg1a0uOQIFOFEBnb/xYGYDjpPL6Jdf5NJQSwI5o7t6UVEPdsxNXL9k8MbJGRWDCUEi
         xiXKcgZFghlFQjWYbn79Zqnhhy+rBC5GhfJTMQ3Bd1p5qGzmfm6rzpWx4xA0kGYfRXMO
         /hGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XnqytUsHczArtSde6nlTUQYVbcjRonbIwwdLe2uNFq4=;
        b=UYbMQjAECl0cFzP5dVneJPR28Bm2P3Uri8lHSlSm4uxx4NeSk9MG9g1fVp7Gc2ne6R
         D8EdFAuAc1fCIiOBuSCEzBLdR6wLl4WMOpiZa8ictqo/Sje7zQL/UVLIAMM4dDcz9BuE
         zwwwA3XgJtCXgv1FQUKzF1Y9Pnysxo+3KKzlxlWE/IK+zqrjAVeccLMNHIGjSlrpX+qs
         5ibaaa96rE9A8PYrYkWDLxN348MKzM7VUFxTbSGyIY2MHIryYlAN9RrDkjRfsa6Fd72K
         lii+ZIiIhQI4ZXlQL430b0G6JT6iEhLtI8uNyEappEuNA4BGQxU2KIJgtIaHghbYU9JI
         aDlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?=E8=8C=83=E9=BE=99=E9=A3=9E?= <long7573@126.com>,
	Nicolai Stange <nstange@suse.de>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 072/146] ALSA: seq: More protection for concurrent write and ioctl races
Date: Tue, 13 Mar 2018 16:23:59 +0100
Message-Id: <20180313152326.317882899@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837046485996537?=
X-GMAIL-MSGID: =?utf-8?q?1594837046485996537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -910,7 +910,8 @@ int snd_seq_dispatch_event(struct snd_se
 static int snd_seq_client_enqueue_event(struct snd_seq_client *client,
 					struct snd_seq_event *event,
 					struct file *file, int blocking,
-					int atomic, int hop)
+					int atomic, int hop,
+					struct mutex *mutexp)
 {
 	struct snd_seq_event_cell *cell;
 	int err;
@@ -948,7 +949,8 @@ static int snd_seq_client_enqueue_event(
 		return -ENXIO; /* queue is not allocated */
 
 	/* allocate an event cell */
-	err = snd_seq_event_dup(client->pool, event, &cell, !blocking || atomic, file);
+	err = snd_seq_event_dup(client->pool, event, &cell, !blocking || atomic,
+				file, mutexp);
 	if (err < 0)
 		return err;
 
@@ -1017,12 +1019,11 @@ static ssize_t snd_seq_write(struct file
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
@@ -1073,7 +1074,7 @@ static ssize_t snd_seq_write(struct file
 		/* ok, enqueue it */
 		err = snd_seq_client_enqueue_event(client, &event, file,
 						   !(file->f_flags & O_NONBLOCK),
-						   0, 0);
+						   0, 0, &client->ioctl_mutex);
 		if (err < 0)
 			break;
 
@@ -1084,6 +1085,8 @@ static ssize_t snd_seq_write(struct file
 		written += len;
 	}
 
+ out:
+	mutex_unlock(&client->ioctl_mutex);
 	return written ? written : err;
 }
 
@@ -2263,7 +2266,8 @@ static int kernel_client_enqueue(int cli
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
@@ -125,7 +125,7 @@ int snd_seq_fifo_event_in(struct snd_seq
 		return -EINVAL;
 
 	snd_use_lock_use(&f->use_lock);
-	err = snd_seq_event_dup(f->pool, event, &cell, 1, NULL); /* always non-blocking */
+	err = snd_seq_event_dup(f->pool, event, &cell, 1, NULL, NULL); /* always non-blocking */
 	if (err < 0) {
 		if ((err == -ENOMEM) || (err == -EAGAIN))
 			atomic_inc(&f->overflow);
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -220,7 +220,8 @@ void snd_seq_cell_free(struct snd_seq_ev
  */
 static int snd_seq_cell_alloc(struct snd_seq_pool *pool,
 			      struct snd_seq_event_cell **cellp,
-			      int nonblock, struct file *file)
+			      int nonblock, struct file *file,
+			      struct mutex *mutexp)
 {
 	struct snd_seq_event_cell *cell;
 	unsigned long flags;
@@ -244,7 +245,11 @@ static int snd_seq_cell_alloc(struct snd
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
@@ -287,7 +292,7 @@ __error:
  */
 int snd_seq_event_dup(struct snd_seq_pool *pool, struct snd_seq_event *event,
 		      struct snd_seq_event_cell **cellp, int nonblock,
-		      struct file *file)
+		      struct file *file, struct mutex *mutexp)
 {
 	int ncells, err;
 	unsigned int extlen;
@@ -304,7 +309,7 @@ int snd_seq_event_dup(struct snd_seq_poo
 	if (ncells >= pool->total_elements)
 		return -ENOMEM;
 
-	err = snd_seq_cell_alloc(pool, &cell, nonblock, file);
+	err = snd_seq_cell_alloc(pool, &cell, nonblock, file, mutexp);
 	if (err < 0)
 		return err;
 
@@ -330,7 +335,8 @@ int snd_seq_event_dup(struct snd_seq_poo
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
