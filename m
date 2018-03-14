Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbeCNEG0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 00:06:26 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40703 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeCNEGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 00:06:22 -0400
X-Google-Smtp-Source: AG47ELuDBhKDqWyKBUs6vSod+dcyzr5VRA1Cai/4FaOxi/9guSYId66XXDZWFndHCFUisxm9o9EwLQ==
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: arnd@arndb.de, tglx@linutronix.de, john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, y2038@lists.linaro.org
Subject: [PATCH v5 06/10] posix-clocks: Make compat syscalls depend on CONFIG_COMPAT_32BIT_TIME
Date: Tue, 13 Mar 2018 21:03:29 -0700
Message-Id: <20180314040333.3291-7-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314040333.3291-1-deepa.kernel@gmail.com>
References: <20180314040333.3291-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clock_gettime, clock_settime, clock_getres and clock_nanosleep
compat syscalls are also repurposed to provide backward compatibility
to support 32 bit time_t on 32 bit systems.

Note that nanosleep compat syscall will also be treated the same way
as the above syscalls as it shares common handler functions with
clock_nanosleep. But, there is no plan to provide y2038 safe solution
for nanosleep.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 kernel/time/hrtimer.c      |  2 +-
 kernel/time/posix-stubs.c  |  2 ++
 kernel/time/posix-timers.c | 14 ++++++++++++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 23788100e214..6528dec955b8 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1726,7 +1726,7 @@ SYSCALL_DEFINE2(nanosleep, struct timespec __user *, rqtp,
 	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 
 COMPAT_SYSCALL_DEFINE2(nanosleep, struct compat_timespec __user *, rqtp,
 		       struct compat_timespec __user *, rmtp)
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index b258bee13b02..0645cfa93609 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -148,7 +148,9 @@ COMPAT_SYS_NI(timer_settime);
 COMPAT_SYS_NI(timer_gettime);
 COMPAT_SYS_NI(getitimer);
 COMPAT_SYS_NI(setitimer);
+#endif
 
+#ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
 		       struct compat_timespec __user *, tp)
 {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 75043046914e..35b7b08f79f5 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1112,7 +1112,7 @@ SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock,
 	return error;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 
 COMPAT_SYSCALL_DEFINE2(clock_settime, clockid_t, which_clock,
 		       struct compat_timespec __user *, tp)
@@ -1147,6 +1147,10 @@ COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
 	return err;
 }
 
+#endif
+
+#ifdef CONFIG_COMPAT
+
 COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
 		       struct compat_timex __user *, utp)
 {
@@ -1171,6 +1175,10 @@ COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
 	return err;
 }
 
+#endif
+
+#ifdef CONFIG_COMPAT_32BIT_TIME
+
 COMPAT_SYSCALL_DEFINE2(clock_getres, clockid_t, which_clock,
 		       struct compat_timespec __user *, tp)
 {
@@ -1226,7 +1234,8 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 	return kc->nsleep(which_clock, flags, &t);
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
+
 COMPAT_SYSCALL_DEFINE4(clock_nanosleep, clockid_t, which_clock, int, flags,
 		       struct compat_timespec __user *, rqtp,
 		       struct compat_timespec __user *, rmtp)
@@ -1251,6 +1260,7 @@ COMPAT_SYSCALL_DEFINE4(clock_nanosleep, clockid_t, which_clock, int, flags,
 
 	return kc->nsleep(which_clock, flags, &t);
 }
+
 #endif
 
 static const struct k_clock clock_realtime = {
-- 
2.14.1
