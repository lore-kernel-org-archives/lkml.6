Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933620AbeCSO2R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:28:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46829 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932708AbeCSO2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:28:14 -0400
Date: Mon, 19 Mar 2018 07:27:58 -0700
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-a84d1169164b274f13b97a23ff235c000efe3b49@git.kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        arnd@arndb.de, mingo@kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, viro@zeniv.linux.org.uk
Reply-To: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        arnd@arndb.de, john.stultz@linaro.org, mingo@kernel.org,
        sboyd@kernel.org, viro@zeniv.linux.org.uk
In-Reply-To: <20180315161739.576085-1-arnd@arndb.de>
References: <20180315161739.576085-1-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] y2038: Introduce struct __kernel_old_timeval
Git-Commit-ID: a84d1169164b274f13b97a23ff235c000efe3b49
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a84d1169164b274f13b97a23ff235c000efe3b49
Gitweb:     https://git.kernel.org/tip/a84d1169164b274f13b97a23ff235c000efe3b49
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Thu, 15 Mar 2018 17:12:40 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 19 Mar 2018 15:23:03 +0100

y2038: Introduce struct __kernel_old_timeval

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
definion from the kernel's uapi headers, and change the interfaces that
we do not want to (or cannot) duplicate for 64-bit times to use a new
__kernel_old_timeval definition instead. This type should be avoided
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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lkml.kernel.org/r/20180315161739.576085-1-arnd@arndb.de

---
 include/linux/time32.h    |  1 +
 include/uapi/linux/time.h | 12 ++++++++++++
 kernel/time/time.c        | 12 ++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/linux/time32.h b/include/linux/time32.h
index 65b1de25198d..d2bcd4377b56 100644
--- a/include/linux/time32.h
+++ b/include/linux/time32.h
@@ -217,5 +217,6 @@ static inline s64 timeval_to_ns(const struct timeval *tv)
  * Returns the timeval representation of the nsec parameter.
  */
 extern struct timeval ns_to_timeval(const s64 nsec);
+extern struct __kernel_old_timeval ns_to_kernel_old_timeval(s64 nsec);
 
 #endif
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 61a187df8da2..16a296612ba4 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -42,6 +42,18 @@ struct itimerval {
 	struct timeval it_value;	/* current value */
 };
 
+/*
+ * legacy timeval structure, only embedded in structures that
+ * traditionally used 'timeval' to pass time intervals (not absolute
+ * times). Do not add new users. If user space fails to compile
+ * here, this is probably because it is not y2038 safe and needs to
+ * be changed to use another interface.
+ */
+struct __kernel_old_timeval {
+	__kernel_long_t tv_sec;
+	__kernel_long_t tv_usec;
+};
+
 /*
  * The IDs of the various system clocks (for POSIX.1b interval timers):
  */
diff --git a/kernel/time/time.c b/kernel/time/time.c
index bd4e6c7dd689..3044d48ebe56 100644
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
+	tv.tv_usec = (suseconds_t)ts.tv_nsec / 1000;
+
+	return tv;
+}
+EXPORT_SYMBOL(ns_to_kernel_old_timeval);
+
 /**
  * set_normalized_timespec - set timespec sec and nsec parts and normalize
  *
