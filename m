Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF7DC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562AF24ED1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562AF24ED1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeFXMnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 08:43:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36197 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbeFXMnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 08:43:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5OCgsMx829173
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 24 Jun 2018 05:42:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5OCgskc829170;
        Sun, 24 Jun 2018 05:42:54 -0700
Date:   Sun, 24 Jun 2018 05:42:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Deepa Dinamani <tipbot@zytor.com>
Message-ID: <tip-d0dd63a8aee1ef89f2e48e554b796b9f9e4fcadb@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        deepa.kernel@gmail.com, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, deepa.kernel@gmail.com,
          hpa@zytor.com
In-Reply-To: <20180617051144.29756-2-deepa.kernel@gmail.com>
References: <20180617051144.29756-2-deepa.kernel@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] time: Introduce struct __kernel_itimerspec
Git-Commit-ID: d0dd63a8aee1ef89f2e48e554b796b9f9e4fcadb
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

Commit-ID:  d0dd63a8aee1ef89f2e48e554b796b9f9e4fcadb
Gitweb:     https://git.kernel.org/tip/d0dd63a8aee1ef89f2e48e554b796b9f9e4fcadb
Author:     Deepa Dinamani <deepa.kernel@gmail.com>
AuthorDate: Sat, 16 Jun 2018 22:11:42 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 24 Jun 2018 14:39:46 +0200

time: Introduce struct __kernel_itimerspec

struct itimerspec is not y2038-safe.

Introduce a new struct __kernel_itimerspec based on the kernel internal
y2038-safe struct itimerspec64.

The definition of struct __kernel_itimerspec includes two struct
__kernel_timespec.

Since struct __kernel_timespec has the same representation in native and
compat modes, so does struct __kernel_itimerspec. This helps have a common
entry point for syscalls using struct __kernel_itimerspec.

New y2038-safe syscalls will use this new type. Since most of the new
syscalls are just an update to the native syscalls with the type update,
place the new definition under CONFIG_64BIT_TIME. This helps architectures
that do not support the above config to keep using the old definition of
struct itimerspec.

Also change the get/put_itimerspec64 to use struct__kernel_itimerspec.
This will help 32 bit architectures to use the new syscalls when
architectures select CONFIG_64BIT_TIME.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: arnd@arndb.de
Cc: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: y2038@lists.linaro.org
Link: https://lkml.kernel.org/r/20180617051144.29756-2-deepa.kernel@gmail.com

---
 include/linux/time.h      | 4 ++--
 include/linux/time64.h    | 1 +
 include/uapi/linux/time.h | 7 +++++++
 kernel/time/time.c        | 4 ++--
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/time.h b/include/linux/time.h
index aed74463592d..27d83fd2ae61 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -14,9 +14,9 @@ int get_timespec64(struct timespec64 *ts,
 int put_timespec64(const struct timespec64 *ts,
 		struct __kernel_timespec __user *uts);
 int get_itimerspec64(struct itimerspec64 *it,
-			const struct itimerspec __user *uit);
+			const struct __kernel_itimerspec __user *uit);
 int put_itimerspec64(const struct itimerspec64 *it,
-			struct itimerspec __user *uit);
+			struct __kernel_itimerspec __user *uit);
 
 extern time64_t mktime64(const unsigned int year, const unsigned int mon,
 			const unsigned int day, const unsigned int hour,
diff --git a/include/linux/time64.h b/include/linux/time64.h
index 0a7b2f79cec7..05634afba0db 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -12,6 +12,7 @@ typedef __u64 timeu64_t;
  */
 #ifndef CONFIG_64BIT_TIME
 #define __kernel_timespec timespec
+#define __kernel_itimerspec itimerspec
 #endif
 
 #include <uapi/linux/time.h>
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index fcf936656493..6b56a2208be7 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -49,6 +49,13 @@ struct __kernel_timespec {
 };
 #endif
 
+#ifndef __kernel_itimerspec
+struct __kernel_itimerspec {
+	struct __kernel_timespec it_interval;    /* timer period */
+	struct __kernel_timespec it_value;       /* timer expiration */
+};
+#endif
+
 /*
  * legacy timeval structure, only embedded in structures that
  * traditionally used 'timeval' to pass time intervals (not absolute
diff --git a/kernel/time/time.c b/kernel/time/time.c
index b1225db61eb2..c0195225fdce 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -927,7 +927,7 @@ int compat_put_timespec64(const struct timespec64 *ts, void __user *uts)
 EXPORT_SYMBOL_GPL(compat_put_timespec64);
 
 int get_itimerspec64(struct itimerspec64 *it,
-			const struct itimerspec __user *uit)
+			const struct __kernel_itimerspec __user *uit)
 {
 	int ret;
 
@@ -942,7 +942,7 @@ int get_itimerspec64(struct itimerspec64 *it,
 EXPORT_SYMBOL_GPL(get_itimerspec64);
 
 int put_itimerspec64(const struct itimerspec64 *it,
-			struct itimerspec __user *uit)
+			struct __kernel_itimerspec __user *uit)
 {
 	int ret;
 
