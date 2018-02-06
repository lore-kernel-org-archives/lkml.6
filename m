Return-Path: <alexandre.belloni@free-electrons.com>
X-Google-Smtp-Source: AH8x227e9vzmMoACVFuavu+L7yAjhbBMHh5OCJXLbaC3TgOGyolVYhC7hKOuxFoSBnVd6dv2GALS
ARC-Seal: i=1; a=rsa-sha256; t=1517955163; cv=none;
        d=google.com; s=arc-20160816;
        b=OmkBIrhix5cdz2mm4WxMwIEe5Qgszma30U2w/WmQIx4FikIJuAp0h1LGzeOMi+Jk4I
         MDaagoUHm64lrZv/c/rwnP8BNgnAriJBDwSJsUq8VzVkHyeAgmr/XtanMd3dvzjiTZvs
         LocfbKhig6LF7dDHG3fhn11UTQwiXVsKFLUFCa3uSo6b4tnPeot79pDhPJYrKICuPHSC
         xVvw0iXmNeRPRL/tjm4xXhoKF+OtWVRuiM5eEh3dgG1NnGitBLfdu6ezjv1mRooJECpO
         Sk/3QJhorLn69P1odjd0R+iJTpPiSA8j7xZ/P7XMiHSCYj9lWrbzQ49C478q2+lF4J5A
         O5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=lIIjqrMVdYHSraijIB5OauoI7Mhfdrt7QuAE4v58PW4=;
        b=sf6cyvRI7rl2/jW6ZSJprQ3VC4gRWBkpulia7+PimoswhF958W3LTyB7oDBuYWRWu+
         RT1JZ2WbYcsSjh5F2Nfv0lBRC86zu26O7YwqMXfMV8JHR8TbUDi3M9SfT+NX0ffjI1G6
         mpoipPEXmnau/SaUbeGVEDkZZgHvrdn+/j0uuT3Ldvexm/CnkTiMGaY59iQHv/Uhl3Ks
         As771P7mfZkiVdIbu1JbDZCcqWkdBm+8h7EBKgprs7xZV6VTQq8IWfqTlOrWCX6qn2dy
         uSyAhb4ZsXHlzd1YHUyYSaw49FH4F+7kDIavLJugf3XAfjL4mCDEvQGrWWiZAKXNndj/
         0g6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@free-electrons.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@free-electrons.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@free-electrons.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@free-electrons.com
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] char: rtc: remove unused rtc_control() API
Date: Tue,  6 Feb 2018 23:12:26 +0100
Message-Id: <20180206221226.10511-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591691353805740704?=
X-GMAIL-MSGID: =?utf-8?q?1591691353805740704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since commit 34ce71a96dcb ("ALSA: timer: remove legacy rtctimer"), the
rtc_register/rtc_control/rtc_unregister API is unused. As it is highly
unlikely to be needed again, remove it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

Hi,

I'd like that one to go through the RTC tree as I have other changes in rtc.h
planned for the next release.

 drivers/char/rtc.c  | 83 -----------------------------------------------------
 include/linux/rtc.h |  4 ---
 2 files changed, 87 deletions(-)

diff --git a/drivers/char/rtc.c b/drivers/char/rtc.c
index c6a317120a55..3d86115e5624 100644
--- a/drivers/char/rtc.c
+++ b/drivers/char/rtc.c
@@ -809,89 +809,6 @@ static __poll_t rtc_poll(struct file *file, poll_table *wait)
 }
 #endif
 
-int rtc_register(rtc_task_t *task)
-{
-#ifndef RTC_IRQ
-	return -EIO;
-#else
-	if (task == NULL || task->func == NULL)
-		return -EINVAL;
-	spin_lock_irq(&rtc_lock);
-	if (rtc_status & RTC_IS_OPEN) {
-		spin_unlock_irq(&rtc_lock);
-		return -EBUSY;
-	}
-	spin_lock(&rtc_task_lock);
-	if (rtc_callback) {
-		spin_unlock(&rtc_task_lock);
-		spin_unlock_irq(&rtc_lock);
-		return -EBUSY;
-	}
-	rtc_status |= RTC_IS_OPEN;
-	rtc_callback = task;
-	spin_unlock(&rtc_task_lock);
-	spin_unlock_irq(&rtc_lock);
-	return 0;
-#endif
-}
-EXPORT_SYMBOL(rtc_register);
-
-int rtc_unregister(rtc_task_t *task)
-{
-#ifndef RTC_IRQ
-	return -EIO;
-#else
-	unsigned char tmp;
-
-	spin_lock_irq(&rtc_lock);
-	spin_lock(&rtc_task_lock);
-	if (rtc_callback != task) {
-		spin_unlock(&rtc_task_lock);
-		spin_unlock_irq(&rtc_lock);
-		return -ENXIO;
-	}
-	rtc_callback = NULL;
-
-	/* disable controls */
-	if (!hpet_mask_rtc_irq_bit(RTC_PIE | RTC_AIE | RTC_UIE)) {
-		tmp = CMOS_READ(RTC_CONTROL);
-		tmp &= ~RTC_PIE;
-		tmp &= ~RTC_AIE;
-		tmp &= ~RTC_UIE;
-		CMOS_WRITE(tmp, RTC_CONTROL);
-		CMOS_READ(RTC_INTR_FLAGS);
-	}
-	if (rtc_status & RTC_TIMER_ON) {
-		rtc_status &= ~RTC_TIMER_ON;
-		del_timer(&rtc_irq_timer);
-	}
-	rtc_status &= ~RTC_IS_OPEN;
-	spin_unlock(&rtc_task_lock);
-	spin_unlock_irq(&rtc_lock);
-	return 0;
-#endif
-}
-EXPORT_SYMBOL(rtc_unregister);
-
-int rtc_control(rtc_task_t *task, unsigned int cmd, unsigned long arg)
-{
-#ifndef RTC_IRQ
-	return -EIO;
-#else
-	unsigned long flags;
-	if (cmd != RTC_PIE_ON && cmd != RTC_PIE_OFF && cmd != RTC_IRQP_SET)
-		return -EINVAL;
-	spin_lock_irqsave(&rtc_task_lock, flags);
-	if (rtc_callback != task) {
-		spin_unlock_irqrestore(&rtc_task_lock, flags);
-		return -ENXIO;
-	}
-	spin_unlock_irqrestore(&rtc_task_lock, flags);
-	return rtc_do_ioctl(cmd, arg, 1);
-#endif
-}
-EXPORT_SYMBOL(rtc_control);
-
 /*
  *	The various file operations we support.
  */
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index fc6c90b57be0..5024b61119b6 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -212,10 +212,6 @@ void rtc_aie_update_irq(void *private);
 void rtc_uie_update_irq(void *private);
 enum hrtimer_restart rtc_pie_update_irq(struct hrtimer *timer);
 
-int rtc_register(rtc_task_t *task);
-int rtc_unregister(rtc_task_t *task);
-int rtc_control(rtc_task_t *t, unsigned int cmd, unsigned long arg);
-
 void rtc_timer_init(struct rtc_timer *timer, void (*f)(void *p), void *data);
 int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer *timer,
 		    ktime_t expires, ktime_t period);
-- 
2.15.1
