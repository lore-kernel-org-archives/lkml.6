Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932572AbeCISnI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:43:08 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33476 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932267AbeCISnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:43:02 -0500
X-Google-Smtp-Source: AG47ELsNgzbtFual4/IrEahkk3fJIYb6BOXPEybs0PKnJyEVxZ+g673J0ejmRnLYus1IZrUcr6cSXQ==
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 3/4] y2038: time: Introduce struct __kernel_old_timeval
Date: Fri,  9 Mar 2018 10:42:49 -0800
Message-Id: <1520620971-9567-4-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520620971-9567-1-git-send-email-john.stultz@linaro.org>
References: <1520620971-9567-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Dealing with 'struct timeval' users in the y2038 series is a bit tricky:

We have two definitions of timeval that are visible to user space,
one comes from glibc (or some other C library), the other comes from
linux/time.h. The kernel copy is what we want to be used for a number of
structures defined by the kernel itself, e.g. elf_prstatus (used it core
dumps), sysinfo and rusage (used in system calls).  These generally tend
to be used for passing time intervals rather than absolute (epoch-based)
times, so they do not suffer from the y2038 overflow. Some of them
could be changed to use 64-bit timestamps by creating new system calls,
others like the core files cannot easily be changed.

An application using these interfaces likely also uses gettimeofday()
or other interfaces that use absolute times, and pass 'struct timeval'
pointers directly into kernel interfaces, so glibc must redefine their
timeval based on a 64-bit time_t when they introduce their y2038-safe
interfaces.

The only reasonable way forward I see is to remove the 'timeval'
definition from the kernel's uapi headers, and change the interfaces
that we do not want to (or cannot) duplicate for 64-bit times to use a
new __kernel_old_timeval definition instead. This type should be avoided
for all new interfaces (those can use 64-bit nanoseconds, or the 64-bit
version of timespec instead), and should be used with great care when
converting existing interfaces from timeval, to be sure they don't suffer
from the y2038 overflow, and only with consensus for the particular user
that using __kernel_old_timeval is better than moving to a 64-bit based
interface. The structure name is intentionally chosen to not conflict
with user space types, and to be ugly enough to discourage its use.

Note that ioctl based interfaces that pass a bare 'timeval' pointer
cannot change to '__kernel_old_timeval' because the user space source
code refers to 'timeval' instead, and we don't want to modify the user
space sources if possible. However, any application that relies on a
structure to contain an embedded 'timeval' (e.g. by passing a pointer
to the member into a function call that expects a timeval pointer) is
broken when that structure gets converted to __kernel_old_timeval. I
don't see any way around that, and we have to rely on the compiler to
produce a warning or compile failure that will alert users when they
recompile their sources against a new libc.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 include/linux/time32.h    |  1 +
 include/uapi/linux/time.h | 12 ++++++++++++
 kernel/time/time.c        | 12 ++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/linux/time32.h b/include/linux/time32.h
index 65b1de2..3febcaf 100644
--- a/include/linux/time32.h
+++ b/include/linux/time32.h
@@ -217,5 +217,6 @@ static inline s64 timeval_to_ns(const struct timeval *tv)
  * Returns the timeval representation of the nsec parameter.
  */
 extern struct timeval ns_to_timeval(const s64 nsec);
+extern struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec);
 
 #endif
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 53f8dd8..888da62 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -43,6 +43,18 @@ struct itimerval {
 };
 
 /*
+ * legacy timeval structure, only embedded in structures that
+ * traditionally used 'timeval' to pass time intervals (not absolute
+ * times). Do not add new users. If user space fails to compile
+ * here, this is probably because it is not y2038 safe and needs to
+ * be changed to use another interface.
+ */
+struct __kernel_old_timeval {
+	__kernel_long_t tv_sec;			/* seconds */
+	__kernel_long_t tv_usec;		/* seconds */
+};
+
+/*
  * The IDs of the various system clocks (for POSIX.1b interval timers):
  */
 #define CLOCK_REALTIME			0
diff --git a/kernel/time/time.c b/kernel/time/time.c
index bd4e6c7..cbb3c71 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -488,6 +488,18 @@ struct timeval ns_to_timeval(const s64 nsec)
 }
 EXPORT_SYMBOL(ns_to_timeval);
 
+struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)
+{
+	struct timespec64 ts = ns_to_timespec64(nsec);
+	struct __kernel_old_timeval tv;
+
+	tv.tv_sec = ts.tv_sec;
+	tv.tv_usec = (suseconds_t) ts.tv_nsec / 1000;
+
+	return tv;
+}
+EXPORT_SYMBOL(ns_to_kernel_old_timeval);
+
 /**
  * set_normalized_timespec - set timespec sec and nsec parts and normalize
  *
-- 
2.7.4
