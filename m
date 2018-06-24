Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FEBC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC0B23F08
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC0B23F08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeFXMoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 08:44:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50961 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbeFXMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 08:44:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5OCi5L8830677
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 24 Jun 2018 05:44:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5OCi5j8830674;
        Sun, 24 Jun 2018 05:44:05 -0700
Date:   Sun, 24 Jun 2018 05:44:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Deepa Dinamani <tipbot@zytor.com>
Message-ID: <tip-6ff84735070276d72af716e21c3214ee20d60e70@git.kernel.org>
Cc:     deepa.kernel@gmail.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          deepa.kernel@gmail.com
In-Reply-To: <20180617051144.29756-4-deepa.kernel@gmail.com>
References: <20180617051144.29756-4-deepa.kernel@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] time: Change types to new y2038 safe
 __kernel_itimerspec
Git-Commit-ID: 6ff84735070276d72af716e21c3214ee20d60e70
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6ff84735070276d72af716e21c3214ee20d60e70
Gitweb:     https://git.kernel.org/tip/6ff84735070276d72af716e21c3214ee20d60e70
Author:     Deepa Dinamani <deepa.kernel@gmail.com>
AuthorDate: Sat, 16 Jun 2018 22:11:44 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 24 Jun 2018 14:39:47 +0200

time: Change types to new y2038 safe __kernel_itimerspec

timer_set/gettime and timerfd_set/get apis use struct itimerspec at the
user interface layer.  struct itimerspec is not y2038-safe.  Change these
interfaces to use y2038-safe struct __kernel_itimerspec instead.  This will
help define new syscalls when 32bit architectures select CONFIG_64BIT_TIME.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: arnd@arndb.de
Cc: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: y2038@lists.linaro.org
Link: https://lkml.kernel.org/r/20180617051144.29756-4-deepa.kernel@gmail.com

---
 fs/timerfd.c               |  8 ++++----
 include/linux/syscalls.h   | 10 +++++-----
 kernel/time/posix-timers.c | 12 +++++++-----
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index d84a2bee4f82..8bb926253f88 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -533,8 +533,8 @@ static int do_timerfd_gettime(int ufd, struct itimerspec64 *t)
 }
 
 SYSCALL_DEFINE4(timerfd_settime, int, ufd, int, flags,
-		const struct itimerspec __user *, utmr,
-		struct itimerspec __user *, otmr)
+		const struct __kernel_itimerspec __user *, utmr,
+		struct __kernel_itimerspec __user *, otmr)
 {
 	struct itimerspec64 new, old;
 	int ret;
@@ -550,7 +550,7 @@ SYSCALL_DEFINE4(timerfd_settime, int, ufd, int, flags,
 	return ret;
 }
 
-SYSCALL_DEFINE2(timerfd_gettime, int, ufd, struct itimerspec __user *, otmr)
+SYSCALL_DEFINE2(timerfd_gettime, int, ufd, struct __kernel_itimerspec __user *, otmr)
 {
 	struct itimerspec64 kotmr;
 	int ret = do_timerfd_gettime(ufd, &kotmr);
@@ -559,7 +559,7 @@ SYSCALL_DEFINE2(timerfd_gettime, int, ufd, struct itimerspec __user *, otmr)
 	return put_itimerspec64(&kotmr, otmr) ? -EFAULT : 0;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE4(timerfd_settime, int, ufd, int, flags,
 		const struct compat_itimerspec __user *, utmr,
 		struct compat_itimerspec __user *, otmr)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 73810808cdf2..38b9ec152024 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -501,9 +501,9 @@ asmlinkage long sys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 /* fs/timerfd.c */
 asmlinkage long sys_timerfd_create(int clockid, int flags);
 asmlinkage long sys_timerfd_settime(int ufd, int flags,
-				    const struct itimerspec __user *utmr,
-				    struct itimerspec __user *otmr);
-asmlinkage long sys_timerfd_gettime(int ufd, struct itimerspec __user *otmr);
+				    const struct __kernel_itimerspec __user *utmr,
+				    struct __kernel_itimerspec __user *otmr);
+asmlinkage long sys_timerfd_gettime(int ufd, struct __kernel_itimerspec __user *otmr);
 
 /* fs/utimes.c */
 asmlinkage long sys_utimensat(int dfd, const char __user *filename,
@@ -568,10 +568,10 @@ asmlinkage long sys_timer_create(clockid_t which_clock,
 				 struct sigevent __user *timer_event_spec,
 				 timer_t __user * created_timer_id);
 asmlinkage long sys_timer_gettime(timer_t timer_id,
-				struct itimerspec __user *setting);
+				struct __kernel_itimerspec __user *setting);
 asmlinkage long sys_timer_getoverrun(timer_t timer_id);
 asmlinkage long sys_timer_settime(timer_t timer_id, int flags,
-				const struct itimerspec __user *new_setting,
+				const struct __kernel_itimerspec __user *new_setting,
 				struct itimerspec __user *old_setting);
 asmlinkage long sys_timer_delete(timer_t timer_id);
 asmlinkage long sys_clock_settime(clockid_t which_clock,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index fcf90a10c43a..80d59333c76e 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -743,7 +743,7 @@ static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 
 /* Get the time remaining on a POSIX.1b interval timer. */
 SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
-		struct itimerspec __user *, setting)
+		struct __kernel_itimerspec __user *, setting)
 {
 	struct itimerspec64 cur_setting;
 
@@ -755,7 +755,8 @@ SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
+
 COMPAT_SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
 		       struct compat_itimerspec __user *, setting)
 {
@@ -768,6 +769,7 @@ COMPAT_SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
 	}
 	return ret;
 }
+
 #endif
 
 /*
@@ -906,8 +908,8 @@ retry:
 
 /* Set a POSIX.1b interval timer */
 SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, flags,
-		const struct itimerspec __user *, new_setting,
-		struct itimerspec __user *, old_setting)
+		const struct __kernel_itimerspec __user *, new_setting,
+		struct __kernel_itimerspec __user *, old_setting)
 {
 	struct itimerspec64 new_spec, old_spec;
 	struct itimerspec64 *rtn = old_setting ? &old_spec : NULL;
@@ -927,7 +929,7 @@ SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, flags,
 	return error;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, flags,
 		       struct compat_itimerspec __user *, new,
 		       struct compat_itimerspec __user *, old)
