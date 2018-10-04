Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADDFC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A232084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A232084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeJEECE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:02:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58691 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbeJEECE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:02:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94L6EYI2884942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 14:06:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94L6E4h2884939;
        Thu, 4 Oct 2018 14:06:14 -0700
Date:   Thu, 4 Oct 2018 14:06:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-49116f2081eeaf75316956705d46602b7eb735cc@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, fweimer@redhat.com, sboyd@kernel.org,
        pbonzini@redhat.com, hpa@zytor.com, vkuznets@redhat.com,
        matt@softrans.com.au, arnd@arndb.de, kys@microsoft.com,
        jgross@suse.com, luto@kernel.org, mingo@kernel.org,
        peterz@infradead.org
Reply-To: kys@microsoft.com, luto@kernel.org, jgross@suse.com,
          arnd@arndb.de, peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, fweimer@redhat.com,
          john.stultz@linaro.org, tglx@linutronix.de, matt@softrans.com.au,
          vkuznets@redhat.com, hpa@zytor.com, sboyd@kernel.org,
          pbonzini@redhat.com
In-Reply-To: <20180917130707.324679401@linutronix.de>
References: <20180917130707.324679401@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] x86/vdso: Introduce and use vgtod_ts
Git-Commit-ID: 49116f2081eeaf75316956705d46602b7eb735cc
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

Commit-ID:  49116f2081eeaf75316956705d46602b7eb735cc
Gitweb:     https://git.kernel.org/tip/49116f2081eeaf75316956705d46602b7eb735cc
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 14:45:38 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 4 Oct 2018 23:00:25 +0200

x86/vdso: Introduce and use vgtod_ts

It's desired to support more clocks in the VDSO, e.g. CLOCK_TAI. This
results either in indirect calls due to the larger switch case, which then
requires retpolines or when the compiler is forced to avoid jump tables it
results in even more conditionals.

To avoid both variants which are bad for performance the high resolution
functions and the coarse grained functions will be collapsed into one for
each. That requires to store the clock specific base time in an array.

Introcude struct vgtod_ts for storage and convert the data store, the
update function and the individual clock functions over to use it.

The new storage does not longer use gtod_long_t for seconds depending on 32
or 64 bit compile because this needs to be the full 64bit value even for
32bit when a Y2038 function is added. No point in keeping the distinction
alive in the internal representation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Matt Rickard <matt@softrans.com.au>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: devel@linuxdriverproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Juergen Gross <jgross@suse.com>
Link: https://lkml.kernel.org/r/20180917130707.324679401@linutronix.de

---
 arch/x86/entry/vdso/vclock_gettime.c    | 24 ++++++++++-------
 arch/x86/entry/vsyscall/vsyscall_gtod.c | 47 +++++++++++++++++----------------
 arch/x86/include/asm/vgtod.h            | 38 ++++++++++++++------------
 3 files changed, 60 insertions(+), 49 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index b50ee064beff..2c73e7f57316 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -208,6 +208,7 @@ notrace static inline u64 vgetsns(int *mode)
 /* Code size doesn't matter (vdso is 4k anyway) and this is faster. */
 notrace static int __always_inline do_realtime(struct timespec *ts)
 {
+	struct vgtod_ts *base = &gtod->basetime[CLOCK_REALTIME];
 	unsigned int seq;
 	u64 ns;
 	int mode;
@@ -215,8 +216,8 @@ notrace static int __always_inline do_realtime(struct timespec *ts)
 	do {
 		seq = gtod_read_begin(gtod);
 		mode = gtod->vclock_mode;
-		ts->tv_sec = gtod->wall_time_sec;
-		ns = gtod->wall_time_snsec;
+		ts->tv_sec = base->sec;
+		ns = base->nsec;
 		ns += vgetsns(&mode);
 		ns >>= gtod->shift;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
@@ -229,6 +230,7 @@ notrace static int __always_inline do_realtime(struct timespec *ts)
 
 notrace static int __always_inline do_monotonic(struct timespec *ts)
 {
+	struct vgtod_ts *base = &gtod->basetime[CLOCK_MONOTONIC];
 	unsigned int seq;
 	u64 ns;
 	int mode;
@@ -236,8 +238,8 @@ notrace static int __always_inline do_monotonic(struct timespec *ts)
 	do {
 		seq = gtod_read_begin(gtod);
 		mode = gtod->vclock_mode;
-		ts->tv_sec = gtod->monotonic_time_sec;
-		ns = gtod->monotonic_time_snsec;
+		ts->tv_sec = base->sec;
+		ns = base->nsec;
 		ns += vgetsns(&mode);
 		ns >>= gtod->shift;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
@@ -250,21 +252,25 @@ notrace static int __always_inline do_monotonic(struct timespec *ts)
 
 notrace static void do_realtime_coarse(struct timespec *ts)
 {
+	struct vgtod_ts *base = &gtod->basetime[CLOCK_REALTIME_COARSE];
 	unsigned int seq;
+
 	do {
 		seq = gtod_read_begin(gtod);
-		ts->tv_sec = gtod->wall_time_coarse_sec;
-		ts->tv_nsec = gtod->wall_time_coarse_nsec;
+		ts->tv_sec = base->sec;
+		ts->tv_nsec = base->nsec;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
 }
 
 notrace static void do_monotonic_coarse(struct timespec *ts)
 {
+	struct vgtod_ts *base = &gtod->basetime[CLOCK_MONOTONIC_COARSE];
 	unsigned int seq;
+
 	do {
 		seq = gtod_read_begin(gtod);
-		ts->tv_sec = gtod->monotonic_time_coarse_sec;
-		ts->tv_nsec = gtod->monotonic_time_coarse_nsec;
+		ts->tv_sec = base->sec;
+		ts->tv_nsec = base->nsec;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
 }
 
@@ -320,7 +326,7 @@ int gettimeofday(struct timeval *, struct timezone *)
 notrace time_t __vdso_time(time_t *t)
 {
 	/* This is atomic on x86 so we don't need any locks. */
-	time_t result = READ_ONCE(gtod->wall_time_sec);
+	time_t result = READ_ONCE(gtod->basetime[CLOCK_REALTIME].sec);
 
 	if (t)
 		*t = result;
diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
index e1216dd95c04..31b9e5e0cfdf 100644
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -31,6 +31,8 @@ void update_vsyscall(struct timekeeper *tk)
 {
 	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
 	struct vsyscall_gtod_data *vdata = &vsyscall_gtod_data;
+	struct vgtod_ts *base;
+	u64 nsec;
 
 	/* Mark the new vclock used. */
 	BUILD_BUG_ON(VCLOCK_MAX >= 32);
@@ -45,34 +47,33 @@ void update_vsyscall(struct timekeeper *tk)
 	vdata->mult		= tk->tkr_mono.mult;
 	vdata->shift		= tk->tkr_mono.shift;
 
-	vdata->wall_time_sec		= tk->xtime_sec;
-	vdata->wall_time_snsec		= tk->tkr_mono.xtime_nsec;
+	base = &vdata->basetime[CLOCK_REALTIME];
+	base->sec = tk->xtime_sec;
+	base->nsec = tk->tkr_mono.xtime_nsec;
 
-	vdata->monotonic_time_sec	= tk->xtime_sec
-					+ tk->wall_to_monotonic.tv_sec;
-	vdata->monotonic_time_snsec	= tk->tkr_mono.xtime_nsec
-					+ ((u64)tk->wall_to_monotonic.tv_nsec
-						<< tk->tkr_mono.shift);
-	while (vdata->monotonic_time_snsec >=
-					(((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
-		vdata->monotonic_time_snsec -=
-					((u64)NSEC_PER_SEC) << tk->tkr_mono.shift;
-		vdata->monotonic_time_sec++;
+	base = &vdata->basetime[CLOCK_MONOTONIC];
+	base->sec = tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
+	nsec = tk->tkr_mono.xtime_nsec;
+	nsec +=	((u64)tk->wall_to_monotonic.tv_nsec << tk->tkr_mono.shift);
+	while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
+		nsec -= ((u64)NSEC_PER_SEC) << tk->tkr_mono.shift;
+		base->sec++;
 	}
+	base->nsec = nsec;
 
-	vdata->wall_time_coarse_sec	= tk->xtime_sec;
-	vdata->wall_time_coarse_nsec	= (long)(tk->tkr_mono.xtime_nsec >>
-						 tk->tkr_mono.shift);
+	base = &vdata->basetime[CLOCK_REALTIME_COARSE];
+	base->sec = tk->xtime_sec;
+	base->nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
 
-	vdata->monotonic_time_coarse_sec =
-		vdata->wall_time_coarse_sec + tk->wall_to_monotonic.tv_sec;
-	vdata->monotonic_time_coarse_nsec =
-		vdata->wall_time_coarse_nsec + tk->wall_to_monotonic.tv_nsec;
-
-	while (vdata->monotonic_time_coarse_nsec >= NSEC_PER_SEC) {
-		vdata->monotonic_time_coarse_nsec -= NSEC_PER_SEC;
-		vdata->monotonic_time_coarse_sec++;
+	base = &vdata->basetime[CLOCK_MONOTONIC_COARSE];
+	base->sec = tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
+	nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+	nsec += tk->wall_to_monotonic.tv_nsec;
+	while (nsec >= NSEC_PER_SEC) {
+		nsec -= NSEC_PER_SEC;
+		base->sec++;
 	}
+	base->nsec = nsec;
 
 	gtod_write_end(vdata);
 }
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 91cad1f01027..10e534a1a51a 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -5,33 +5,37 @@
 #include <linux/compiler.h>
 #include <linux/clocksource.h>
 
+#include <uapi/linux/time.h>
+
 #ifdef BUILD_VDSO32_64
 typedef u64 gtod_long_t;
 #else
 typedef unsigned long gtod_long_t;
 #endif
+
+struct vgtod_ts {
+	u64		sec;
+	u64		nsec;
+};
+
+#define VGTOD_BASES	(CLOCK_MONOTONIC_COARSE + 1)
+#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC))
+#define VGTOD_COARSE	(BIT(CLOCK_REALTIME_COARSE) | BIT(CLOCK_MONOTONIC_COARSE))
+
 /*
  * vsyscall_gtod_data will be accessed by 32 and 64 bit code at the same time
  * so be carefull by modifying this structure.
  */
 struct vsyscall_gtod_data {
-	unsigned int seq;
-
-	int	vclock_mode;
-	u64	cycle_last;
-	u64	mask;
-	u32	mult;
-	u32	shift;
-
-	/* open coded 'struct timespec' */
-	u64		wall_time_snsec;
-	gtod_long_t	wall_time_sec;
-	gtod_long_t	monotonic_time_sec;
-	u64		monotonic_time_snsec;
-	gtod_long_t	wall_time_coarse_sec;
-	gtod_long_t	wall_time_coarse_nsec;
-	gtod_long_t	monotonic_time_coarse_sec;
-	gtod_long_t	monotonic_time_coarse_nsec;
+	unsigned int	seq;
+
+	int		vclock_mode;
+	u64		cycle_last;
+	u64		mask;
+	u32		mult;
+	u32		shift;
+
+	struct vgtod_ts	basetime[VGTOD_BASES];
 
 	int		tz_minuteswest;
 	int		tz_dsttime;
