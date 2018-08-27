Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E71C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD6D208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD6D208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeH0Xdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:33:46 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:45271 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0Xdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:33:45 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M3C4d-1fcZQF0p8B-00szIC; Mon, 27 Aug 2018 21:45:36 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     tglx@linutronix.de
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, deepa.kernel@gmail.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 02/14] y2038: Make do_gettimeofday() and get_seconds() inline
Date:   Mon, 27 Aug 2018 21:45:19 +0200
Message-Id: <20180827194531.3796559-3-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827194531.3796559-1-arnd@arndb.de>
References: <20180827194531.3796559-1-arnd@arndb.de>
X-Provags-ID: V03:K1:ZKEuasSY6qBIJl4zp5+4KIsKGtK2ldyYHmcFAwK4NsZcBWRneDq
 TCRRFam+NkSbu5cVboFYQdk9iO/8ixZz2Q+neyUrL8aNm1o57NYoQKEjC6vSHQk8tZlWLxz
 j/HeQAdMbD0+t4hkjvMfJX3rpqi+14nZDELzD+Ge4mceN153aZTP4frxbiyy8YUT5DK4uUn
 M+yf2SJp7IiCu4ZqHm4KA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Kplm45ZfzPY=:iyPj1VALJCMelqM4mSLnmk
 zGRAs+FyDkRSnyOZD+J+htlMsUWcFLcuSPSzouqtcPCQE5P/64/CEt2IZWztYG0TZdS2fFb+b
 ccbnwptjuo1rGxieeOOPAh5xs28yZRmKMHWY2mepheAER8G9EsdSJ5l4MUryWCLxhtVmqYM70
 NGmTvd4PZt8GK0vXI55ayFJFTmOyG2q6ryPpKGhLU2SRGOHXtsP/OhcF0CJXkT5UQQtyb5t3N
 MjVrzrtcGuuwr9m5yROTEAjGPK6uNZU3JNk6tpTs+lXDKfc9ULTG+dW6r+Vt8tDDGrU/7oziG
 vPmv6wn7ClN3pjjyAYnDlZiNV0DQRzRK6icN+vABR2Gw+DV7jCfa9A67aYLu3b7ph4v9MMV8i
 3RPD8F3ht7xw5ZVBTcDp746ig2wc3KHVrsgORvglXztWYcljqDoU21Qe7JXbEsuNeRLKHZc0J
 b2t6LyyUB8/0cO+Cdu/9K4nq4lL9eQRhyz33osC4mHPPIB5rAUiejAV+UDL/dc3WsFVa3ec07
 lR9VQsJAUpy3yfajKVurSycXVTl+zncoMMq4YgblDXkngKBRWyagZUOx8pd1ZWMLhgROEX3bb
 +14JG2XVsyHaW3x/+aO33QWnWT82uKva359AHB99t2AjRbxBOtyzbLTYslrRnuuuopNwIuXVU
 8vFLNcLhckaSKvxhr4SuN0dq1GKcEEToJnFZwCpIVTbijEV8faLW/axN8K17mLzihnJ8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_seconds() and do_gettimeofday() are only used by a few modules now any
more (waiting for the respective patches to get accepted), and they are
among the last holdouts of code that is not y2038 safe in the core kernel.

Move the implementation into the timekeeping32.h header to clean up
the core kernel and isolate the old interfaces further.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/timekeeping32.h | 15 +++++++++++++--
 kernel/time/time.c            | 15 +++++++++------
 kernel/time/timekeeping.c     | 24 ------------------------
 3 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
index a4a4991160fb..a502616f7e1c 100644
--- a/include/linux/timekeeping32.h
+++ b/include/linux/timekeeping32.h
@@ -6,8 +6,19 @@
  * over time so we can remove the file here.
  */
 
-extern void do_gettimeofday(struct timeval *tv);
-unsigned long get_seconds(void);
+static inline void do_gettimeofday(struct timeval *tv)
+{
+	struct timespec64 now;
+
+	ktime_get_real_ts64(&now);
+	tv->tv_sec = now.tv_sec;
+	tv->tv_usec = now.tv_nsec/1000;
+}
+
+static inline unsigned long get_seconds(void)
+{
+	return ktime_get_real_seconds();
+}
 
 static inline void getnstimeofday(struct timespec *ts)
 {
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 712543011106..de332250d6fa 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -144,9 +144,11 @@ SYSCALL_DEFINE2(gettimeofday, struct timeval __user *, tv,
 		struct timezone __user *, tz)
 {
 	if (likely(tv != NULL)) {
-		struct timeval ktv;
-		do_gettimeofday(&ktv);
-		if (copy_to_user(tv, &ktv, sizeof(ktv)))
+		struct timespec64 ts;
+
+		ktime_get_real_ts64(&ts);
+		if (put_user(ts.tv_sec, &tv->tv_sec) ||
+		    put_user(ts.tv_nsec / 1000, &tv->tv_usec))
 			return -EFAULT;
 	}
 	if (unlikely(tz != NULL)) {
@@ -227,10 +229,11 @@ COMPAT_SYSCALL_DEFINE2(gettimeofday, struct compat_timeval __user *, tv,
 		       struct timezone __user *, tz)
 {
 	if (tv) {
-		struct timeval ktv;
+		struct timespec64 ts;
 
-		do_gettimeofday(&ktv);
-		if (compat_put_timeval(&ktv, tv))
+		ktime_get_real_ts64(&ts);
+		if (put_user(ts.tv_sec, &tv->tv_sec) ||
+		    put_user(ts.tv_nsec / 1000, &tv->tv_usec))
 			return -EFAULT;
 	}
 	if (tz) {
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f3b22f456fac..2d110c948805 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1211,22 +1211,6 @@ int get_device_system_crosststamp(int (*get_time_fn)
 }
 EXPORT_SYMBOL_GPL(get_device_system_crosststamp);
 
-/**
- * do_gettimeofday - Returns the time of day in a timeval
- * @tv:		pointer to the timeval to be set
- *
- * NOTE: Users should be converted to using getnstimeofday()
- */
-void do_gettimeofday(struct timeval *tv)
-{
-	struct timespec64 now;
-
-	getnstimeofday64(&now);
-	tv->tv_sec = now.tv_sec;
-	tv->tv_usec = now.tv_nsec/1000;
-}
-EXPORT_SYMBOL(do_gettimeofday);
-
 /**
  * do_settimeofday64 - Sets the time of day.
  * @ts:     pointer to the timespec64 variable containing the new time
@@ -2174,14 +2158,6 @@ void getboottime64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL_GPL(getboottime64);
 
-unsigned long get_seconds(void)
-{
-	struct timekeeper *tk = &tk_core.timekeeper;
-
-	return tk->xtime_sec;
-}
-EXPORT_SYMBOL(get_seconds);
-
 void ktime_get_coarse_real_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-- 
2.18.0

