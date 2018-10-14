Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C4FC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D4520895
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D4520895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeJNXhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:37:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36025 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727678AbeJNXLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:54 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLh-0004cj-QT; Sun, 14 Oct 2018 16:30:34 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLa-0000j4-AI; Sun, 14 Oct 2018 16:30:26 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.734782887@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 333/366] ALSA: timer: Call notifier in the same spinlock
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f65e0d299807d8a11812845c972493c3f9a18e10 upstream.

snd_timer_notify1() is called outside the spinlock and it retakes the
lock after the unlock.  This is rather racy, and it's safer to move
snd_timer_notify() call inside the main spinlock.

The patch also contains a slight refactoring / cleanup of the code.
Now all start/stop/continue/pause look more symmetric and a bit better
readable.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.16:
 - Fix up another use of "event" in _snd_timer_stop()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -347,8 +347,6 @@ int snd_timer_open(struct snd_timer_inst
 	return err;
 }
 
-static int _snd_timer_stop(struct snd_timer_instance *timeri, int event);
-
 /*
  * close a timer instance
  * call this with register_mutex down.
@@ -445,7 +443,6 @@ unsigned long snd_timer_resolution(struc
 static void snd_timer_notify1(struct snd_timer_instance *ti, int event)
 {
 	struct snd_timer *timer;
-	unsigned long flags;
 	unsigned long resolution = 0;
 	struct snd_timer_instance *ts;
 	struct timespec tstamp;
@@ -469,34 +466,66 @@ static void snd_timer_notify1(struct snd
 		return;
 	if (timer->hw.flags & SNDRV_TIMER_HW_SLAVE)
 		return;
-	spin_lock_irqsave(&timer->lock, flags);
 	list_for_each_entry(ts, &ti->slave_active_head, active_list)
 		if (ts->ccallback)
 			ts->ccallback(ts, event + 100, &tstamp, resolution);
-	spin_unlock_irqrestore(&timer->lock, flags);
 }
 
-static int snd_timer_start1(struct snd_timer *timer, struct snd_timer_instance *timeri,
-			    unsigned long sticks)
+/* start/continue a master timer */
+static int snd_timer_start1(struct snd_timer_instance *timeri,
+			    bool start, unsigned long ticks)
 {
+	struct snd_timer *timer;
+	int result;
+	unsigned long flags;
+
+	timer = timeri->timer;
+	if (!timer)
+		return -EINVAL;
+
+	spin_lock_irqsave(&timer->lock, flags);
+	if (timer->card && timer->card->shutdown) {
+		result = -ENODEV;
+		goto unlock;
+	}
+	if (timeri->flags & (SNDRV_TIMER_IFLG_RUNNING |
+			     SNDRV_TIMER_IFLG_START)) {
+		result = -EBUSY;
+		goto unlock;
+	}
+
+	if (start)
+		timeri->ticks = timeri->cticks = ticks;
+	else if (!timeri->cticks)
+		timeri->cticks = 1;
+	timeri->pticks = 0;
+
 	list_move_tail(&timeri->active_list, &timer->active_list_head);
 	if (timer->running) {
 		if (timer->hw.flags & SNDRV_TIMER_HW_SLAVE)
 			goto __start_now;
 		timer->flags |= SNDRV_TIMER_FLG_RESCHED;
 		timeri->flags |= SNDRV_TIMER_IFLG_START;
-		return 1;	/* delayed start */
+		result = 1; /* delayed start */
 	} else {
-		timer->sticks = sticks;
+		if (start)
+			timer->sticks = ticks;
 		timer->hw.start(timer);
 	      __start_now:
 		timer->running++;
 		timeri->flags |= SNDRV_TIMER_IFLG_RUNNING;
-		return 0;
+		result = 0;
 	}
+	snd_timer_notify1(timeri, start ? SNDRV_TIMER_EVENT_START :
+			  SNDRV_TIMER_EVENT_CONTINUE);
+ unlock:
+	spin_unlock_irqrestore(&timer->lock, flags);
+	return result;
 }
 
-static int snd_timer_start_slave(struct snd_timer_instance *timeri)
+/* start/continue a slave timer */
+static int snd_timer_start_slave(struct snd_timer_instance *timeri,
+				 bool start)
 {
 	unsigned long flags;
 
@@ -510,88 +539,37 @@ static int snd_timer_start_slave(struct
 		spin_lock(&timeri->timer->lock);
 		list_add_tail(&timeri->active_list,
 			      &timeri->master->slave_active_head);
+		snd_timer_notify1(timeri, start ? SNDRV_TIMER_EVENT_START :
+				  SNDRV_TIMER_EVENT_CONTINUE);
 		spin_unlock(&timeri->timer->lock);
 	}
 	spin_unlock_irqrestore(&slave_active_lock, flags);
 	return 1; /* delayed start */
 }
 
-/*
- *  start the timer instance
- */
-int snd_timer_start(struct snd_timer_instance *timeri, unsigned int ticks)
-{
-	struct snd_timer *timer;
-	int result = -EINVAL;
-	unsigned long flags;
-
-	if (timeri == NULL || ticks < 1)
-		return -EINVAL;
-	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE) {
-		result = snd_timer_start_slave(timeri);
-		if (result >= 0)
-			snd_timer_notify1(timeri, SNDRV_TIMER_EVENT_START);
-		return result;
-	}
-	timer = timeri->timer;
-	if (timer == NULL)
-		return -EINVAL;
-	if (timer->card && timer->card->shutdown)
-		return -ENODEV;
-	spin_lock_irqsave(&timer->lock, flags);
-	if (timeri->flags & (SNDRV_TIMER_IFLG_RUNNING |
-			     SNDRV_TIMER_IFLG_START)) {
-		result = -EBUSY;
-		goto unlock;
-	}
-	timeri->ticks = timeri->cticks = ticks;
-	timeri->pticks = 0;
-	result = snd_timer_start1(timer, timeri, ticks);
- unlock:
-	spin_unlock_irqrestore(&timer->lock, flags);
-	if (result >= 0)
-		snd_timer_notify1(timeri, SNDRV_TIMER_EVENT_START);
-	return result;
-}
-
-static int _snd_timer_stop(struct snd_timer_instance *timeri, int event)
+/* stop/pause a master timer */
+static int snd_timer_stop1(struct snd_timer_instance *timeri, bool stop)
 {
 	struct snd_timer *timer;
+	int result = 0;
 	unsigned long flags;
 
-	if (snd_BUG_ON(!timeri))
-		return -ENXIO;
-
-	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE) {
-		spin_lock_irqsave(&slave_active_lock, flags);
-		if (!(timeri->flags & SNDRV_TIMER_IFLG_RUNNING)) {
-			spin_unlock_irqrestore(&slave_active_lock, flags);
-			return -EBUSY;
-		}
-		if (timeri->timer)
-			spin_lock(&timeri->timer->lock);
-		timeri->flags &= ~SNDRV_TIMER_IFLG_RUNNING;
-		list_del_init(&timeri->ack_list);
-		list_del_init(&timeri->active_list);
-		if (timeri->timer)
-			spin_unlock(&timeri->timer->lock);
-		spin_unlock_irqrestore(&slave_active_lock, flags);
-		goto __end;
-	}
 	timer = timeri->timer;
 	if (!timer)
 		return -EINVAL;
 	spin_lock_irqsave(&timer->lock, flags);
 	if (!(timeri->flags & (SNDRV_TIMER_IFLG_RUNNING |
 			       SNDRV_TIMER_IFLG_START))) {
-		spin_unlock_irqrestore(&timer->lock, flags);
-		return -EBUSY;
+		result = -EBUSY;
+		goto unlock;
 	}
 	list_del_init(&timeri->ack_list);
 	list_del_init(&timeri->active_list);
-	if (timer->card && timer->card->shutdown) {
-		spin_unlock_irqrestore(&timer->lock, flags);
-		return 0;
+	if (timer->card && timer->card->shutdown)
+		goto unlock;
+	if (stop) {
+		timeri->cticks = timeri->ticks;
+		timeri->pticks = 0;
 	}
 	if ((timeri->flags & SNDRV_TIMER_IFLG_RUNNING) &&
 	    !(--timer->running)) {
@@ -606,39 +584,64 @@ static int _snd_timer_stop(struct snd_ti
 		}
 	}
 	timeri->flags &= ~(SNDRV_TIMER_IFLG_RUNNING | SNDRV_TIMER_IFLG_START);
-	if (event == SNDRV_TIMER_EVENT_STOP)
+	if (stop)
 		timeri->flags &= ~SNDRV_TIMER_IFLG_PAUSED;
 	else
 		timeri->flags |= SNDRV_TIMER_IFLG_PAUSED;
+	snd_timer_notify1(timeri, stop ? SNDRV_TIMER_EVENT_STOP :
+			  SNDRV_TIMER_EVENT_CONTINUE);
+ unlock:
 	spin_unlock_irqrestore(&timer->lock, flags);
-      __end:
-	if (event != SNDRV_TIMER_EVENT_RESOLUTION)
-		snd_timer_notify1(timeri, event);
+	return result;
+}
+
+/* stop/pause a slave timer */
+static int snd_timer_stop_slave(struct snd_timer_instance *timeri, bool stop)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&slave_active_lock, flags);
+	if (!(timeri->flags & SNDRV_TIMER_IFLG_RUNNING)) {
+		spin_unlock_irqrestore(&slave_active_lock, flags);
+		return -EBUSY;
+	}
+	timeri->flags &= ~SNDRV_TIMER_IFLG_RUNNING;
+	if (timeri->timer) {
+		spin_lock(&timeri->timer->lock);
+		list_del_init(&timeri->ack_list);
+		list_del_init(&timeri->active_list);
+		snd_timer_notify1(timeri, stop ? SNDRV_TIMER_EVENT_STOP :
+				  SNDRV_TIMER_EVENT_CONTINUE);
+		spin_unlock(&timeri->timer->lock);
+	}
+	spin_unlock_irqrestore(&slave_active_lock, flags);
 	return 0;
 }
 
 /*
+ *  start the timer instance
+ */
+int snd_timer_start(struct snd_timer_instance *timeri, unsigned int ticks)
+{
+	if (timeri == NULL || ticks < 1)
+		return -EINVAL;
+	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
+		return snd_timer_start_slave(timeri, true);
+	else
+		return snd_timer_start1(timeri, true, ticks);
+}
+
+/*
  * stop the timer instance.
  *
  * do not call this from the timer callback!
  */
 int snd_timer_stop(struct snd_timer_instance *timeri)
 {
-	struct snd_timer *timer;
-	unsigned long flags;
-	int err;
-
-	err = _snd_timer_stop(timeri, SNDRV_TIMER_EVENT_STOP);
-	if (err < 0)
-		return err;
-	timer = timeri->timer;
-	if (!timer)
-		return -EINVAL;
-	spin_lock_irqsave(&timer->lock, flags);
-	timeri->cticks = timeri->ticks;
-	timeri->pticks = 0;
-	spin_unlock_irqrestore(&timer->lock, flags);
-	return 0;
+	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
+		return snd_timer_stop_slave(timeri, true);
+	else
+		return snd_timer_stop1(timeri, true);
 }
 
 /*
@@ -646,36 +649,14 @@ int snd_timer_stop(struct snd_timer_inst
  */
 int snd_timer_continue(struct snd_timer_instance *timeri)
 {
-	struct snd_timer *timer;
-	int result = -EINVAL;
-	unsigned long flags;
-
-	if (timeri == NULL)
-		return result;
 	/* timer can continue only after pause */
 	if (!(timeri->flags & SNDRV_TIMER_IFLG_PAUSED))
 		return -EINVAL;
 
 	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
-		return snd_timer_start_slave(timeri);
-	timer = timeri->timer;
-	if (! timer)
-		return -EINVAL;
-	if (timer->card && timer->card->shutdown)
-		return -ENODEV;
-	spin_lock_irqsave(&timer->lock, flags);
-	if (timeri->flags & SNDRV_TIMER_IFLG_RUNNING) {
-		result = -EBUSY;
-		goto unlock;
-	}
-	if (!timeri->cticks)
-		timeri->cticks = 1;
-	timeri->pticks = 0;
-	result = snd_timer_start1(timer, timeri, timer->sticks);
- unlock:
-	spin_unlock_irqrestore(&timer->lock, flags);
-	snd_timer_notify1(timeri, SNDRV_TIMER_EVENT_CONTINUE);
-	return result;
+		return snd_timer_start_slave(timeri, false);
+	else
+		return snd_timer_start1(timeri, false, 0);
 }
 
 /*
@@ -683,7 +664,10 @@ int snd_timer_continue(struct snd_timer_
  */
 int snd_timer_pause(struct snd_timer_instance * timeri)
 {
-	return _snd_timer_stop(timeri, SNDRV_TIMER_EVENT_PAUSE);
+	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
+		return snd_timer_stop_slave(timeri, false);
+	else
+		return snd_timer_stop1(timeri, false);
 }
 
 /*

