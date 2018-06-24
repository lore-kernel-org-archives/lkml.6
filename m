Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DCCC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6B123C03
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6B123C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeFXMni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 08:43:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51007 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeFXMng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 08:43:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5OChVPP829203
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 24 Jun 2018 05:43:31 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5OChVWY829200;
        Sun, 24 Jun 2018 05:43:31 -0700
Date:   Sun, 24 Jun 2018 05:43:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Deepa Dinamani <tipbot@zytor.com>
Message-ID: <tip-afef05cf238cfcecdc5ea9b06f31027b13ce6214@git.kernel.org>
Cc:     deepa.kernel@gmail.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: deepa.kernel@gmail.com, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20180617051144.29756-3-deepa.kernel@gmail.com>
References: <20180617051144.29756-3-deepa.kernel@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] time: Enable get/put_compat_itimerspec64 always
Git-Commit-ID: afef05cf238cfcecdc5ea9b06f31027b13ce6214
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

Commit-ID:  afef05cf238cfcecdc5ea9b06f31027b13ce6214
Gitweb:     https://git.kernel.org/tip/afef05cf238cfcecdc5ea9b06f31027b13ce6214
Author:     Deepa Dinamani <deepa.kernel@gmail.com>
AuthorDate: Sat, 16 Jun 2018 22:11:43 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 24 Jun 2018 14:39:47 +0200

time: Enable get/put_compat_itimerspec64 always

This will aid in enabling the compat syscalls on 32-bit architectures later
on.

Also move compat_itimerspec and related defines to compat_time.h.  The
compat_time.h file will eventually be deleted.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: arnd@arndb.de
Cc: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: y2038@lists.linaro.org
Link: https://lkml.kernel.org/r/20180617051144.29756-3-deepa.kernel@gmail.com

---
 include/linux/compat.h      |  9 ---------
 include/linux/compat_time.h |  9 +++++++++
 kernel/compat.c             | 29 -----------------------------
 kernel/time/time.c          | 21 +++++++++++++++++++++
 4 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index b1a5562b3215..18a13f2df14b 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -109,11 +109,6 @@ typedef	compat_ulong_t		compat_aio_context_t;
 struct compat_sel_arg_struct;
 struct rusage;
 
-struct compat_itimerspec {
-	struct compat_timespec it_interval;
-	struct compat_timespec it_value;
-};
-
 struct compat_utimbuf {
 	compat_time_t		actime;
 	compat_time_t		modtime;
@@ -294,10 +289,6 @@ extern int compat_get_timespec(struct timespec *, const void __user *);
 extern int compat_put_timespec(const struct timespec *, void __user *);
 extern int compat_get_timeval(struct timeval *, const void __user *);
 extern int compat_put_timeval(const struct timeval *, void __user *);
-extern int get_compat_itimerspec64(struct itimerspec64 *its,
-			const struct compat_itimerspec __user *uits);
-extern int put_compat_itimerspec64(const struct itimerspec64 *its,
-			struct compat_itimerspec __user *uits);
 
 struct compat_iovec {
 	compat_uptr_t	iov_base;
diff --git a/include/linux/compat_time.h b/include/linux/compat_time.h
index 31f2774f1994..e70bfd1d2c3f 100644
--- a/include/linux/compat_time.h
+++ b/include/linux/compat_time.h
@@ -17,7 +17,16 @@ struct compat_timeval {
 	s32		tv_usec;
 };
 
+struct compat_itimerspec {
+	struct compat_timespec it_interval;
+	struct compat_timespec it_value;
+};
+
 extern int compat_get_timespec64(struct timespec64 *, const void __user *);
 extern int compat_put_timespec64(const struct timespec64 *, void __user *);
+extern int get_compat_itimerspec64(struct itimerspec64 *its,
+			const struct compat_itimerspec __user *uits);
+extern int put_compat_itimerspec64(const struct itimerspec64 *its,
+			struct compat_itimerspec __user *uits);
 
 #endif /* _LINUX_COMPAT_TIME_H */
diff --git a/kernel/compat.c b/kernel/compat.c
index 702aa846ddac..8e40efc2928a 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -324,35 +324,6 @@ COMPAT_SYSCALL_DEFINE3(sched_getaffinity, compat_pid_t,  pid, unsigned int, len,
 	return ret;
 }
 
-/* Todo: Delete these extern declarations when get/put_compat_itimerspec64()
- * are moved to kernel/time/time.c .
- */
-extern int __compat_get_timespec64(struct timespec64 *ts64,
-				   const struct compat_timespec __user *cts);
-extern int __compat_put_timespec64(const struct timespec64 *ts64,
-				   struct compat_timespec __user *cts);
-
-int get_compat_itimerspec64(struct itimerspec64 *its,
-			const struct compat_itimerspec __user *uits)
-{
-
-	if (__compat_get_timespec64(&its->it_interval, &uits->it_interval) ||
-	    __compat_get_timespec64(&its->it_value, &uits->it_value))
-		return -EFAULT;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(get_compat_itimerspec64);
-
-int put_compat_itimerspec64(const struct itimerspec64 *its,
-			struct compat_itimerspec __user *uits)
-{
-	if (__compat_put_timespec64(&its->it_interval, &uits->it_interval) ||
-	    __compat_put_timespec64(&its->it_value, &uits->it_value))
-		return -EFAULT;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(put_compat_itimerspec64);
-
 /*
  * We currently only need the following fields from the sigevent
  * structure: sigev_value, sigev_signo, sig_notify and (sometimes
diff --git a/kernel/time/time.c b/kernel/time/time.c
index c0195225fdce..72caf051901c 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -955,3 +955,24 @@ int put_itimerspec64(const struct itimerspec64 *it,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(put_itimerspec64);
+
+int get_compat_itimerspec64(struct itimerspec64 *its,
+			const struct compat_itimerspec __user *uits)
+{
+
+	if (__compat_get_timespec64(&its->it_interval, &uits->it_interval) ||
+	    __compat_get_timespec64(&its->it_value, &uits->it_value))
+		return -EFAULT;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(get_compat_itimerspec64);
+
+int put_compat_itimerspec64(const struct itimerspec64 *its,
+			struct compat_itimerspec __user *uits)
+{
+	if (__compat_put_timespec64(&its->it_interval, &uits->it_interval) ||
+	    __compat_put_timespec64(&its->it_value, &uits->it_value))
+		return -EFAULT;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(put_compat_itimerspec64);
