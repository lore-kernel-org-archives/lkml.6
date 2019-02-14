Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0681C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F9A218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438895AbfBNNhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:37:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55509 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407077AbfBNNhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:37:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id r17so6266172wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 05:37:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V6WRyIOPX3HErD5Ujxi9mUsuhCGUrXyoLn0mbsJHGpA=;
        b=DINPMLqHsYJkQiPf8eiGqS1mrNi5mKe7TsVgExVHzrTiDyCqq2TbsHoQehD1Ae60Pp
         cdjHNSijMMdktEgQaKd9JTuYH/swFVygRI+CElnIGA+NMQXWq5t4mLuujYfeREi9NIXO
         bpCxZEmV0x4fViFGqe0UWqYQbkSlJ/1lyOYnjmYhObSfPDEK88OsCsBYEgbxvGq5k7S2
         XPolX/VKuxnq3U7gs12mwDUg67JFw/SyX1nfCE3UGQHxo2AUacL+8ZsirMmDO1uAd8cA
         k/o5Ld/4VLgJd2cyA+h+NADCclVzGQjd2DXhnsrJGdM5irUfpx9G6tWTAyAya7HOGHAX
         GmZg==
X-Gm-Message-State: AHQUAuZ1CNvOwS9YJ1CCaZ1I2SUC7kuQa2gEYJB7jbWwQqM/rMqmvFnh
        rQ9iOprSLCn2yrtorcysxe8AGg==
X-Google-Smtp-Source: AHgI3IYVRtbrXkiWmdObpyDoOrqe6EPaSSCQqLUlcLeB/qtwLvZh4rPsHXLSSikTi6bKPp4osUvovQ==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr751606wmg.144.1550151465026;
        Thu, 14 Feb 2019 05:37:45 -0800 (PST)
Received: from localhost.localdomain.com ([151.29.175.58])
        by smtp.gmail.com with ESMTPSA id b13sm4008566wmj.42.2019.02.14.05.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 05:37:44 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     tglx@linutronix.de, bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        williams@redhat.com, Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH RT 2/2] time/hrtimer: Embed hrtimer mode into hrtimer_sleeper
Date:   Thu, 14 Feb 2019 14:37:16 +0100
Message-Id: <20190214133716.10187-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190214133716.10187-1-juri.lelli@redhat.com>
References: <20190214133716.10187-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes to hrtimer mode (potentially made by __hrtimer_init_sleeper() on
PREEMPT_RT_FULL are not visible to do_nanosleep(), and thus not
accounted for by hrtimer_start_expires() call path.

Embed hrtimer mode into hrtimer_sleeper struct, so that the same mode is
used by code following hrtimer_sleeper initialization.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/hrtimer.h |  2 ++
 kernel/time/hrtimer.c   | 11 ++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index c6d4941c7dd8..d5f11ef5330a 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -130,12 +130,14 @@ struct hrtimer {
  * struct hrtimer_sleeper - simple sleeper structure
  * @timer:	embedded timer structure
  * @task:	task to wake up
+ * @mode:	hrtimer mode
  *
  * task is set to NULL, when the timer expires.
  */
 struct hrtimer_sleeper {
 	struct hrtimer timer;
 	struct task_struct *task;
+	enum hrtimer_mode mode;
 };
 
 #ifdef CONFIG_64BIT
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 4a905fb721a1..5067aba434fe 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1725,6 +1725,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 	__hrtimer_init(&sl->timer, clock_id, mode);
 	sl->timer.function = hrtimer_wakeup;
 	sl->task = task;
+	sl->mode = mode;
 }
 
 /**
@@ -1774,20 +1775,20 @@ int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
 	return -ERESTART_RESTARTBLOCK;
 }
 
-static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mode)
+static int __sched do_nanosleep(struct hrtimer_sleeper *t)
 {
 	struct restart_block *restart;
 
 	do {
 		set_current_state(TASK_INTERRUPTIBLE);
-		hrtimer_start_expires(&t->timer, mode);
+		hrtimer_start_expires(&t->timer, t->mode);
 
 		if (likely(t->task))
 			freezable_schedule();
 
 		__set_current_state(TASK_RUNNING);
 		hrtimer_cancel(&t->timer);
-		mode = HRTIMER_MODE_ABS;
+		t->mode = HRTIMER_MODE_ABS;
 
 	} while (t->task && !signal_pending(current));
 
@@ -1817,7 +1818,7 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 	hrtimer_init_sleeper_on_stack(&t, restart->nanosleep.clockid,
 				      HRTIMER_MODE_ABS, current);
 	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
-	ret = do_nanosleep(&t, HRTIMER_MODE_ABS);
+	ret = do_nanosleep(&t);
 	destroy_hrtimer_on_stack(&t.timer);
 	return ret;
 }
@@ -1836,7 +1837,7 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode, current);
 	hrtimer_set_expires_range_ns(&t.timer, timespec64_to_ktime(*rqtp), slack);
-	ret = do_nanosleep(&t, mode);
+	ret = do_nanosleep(&t);
 	if (ret != -ERESTART_RESTARTBLOCK)
 		goto out;
 
-- 
2.17.2

