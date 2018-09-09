Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95148C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E9320857
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 20:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E9320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeIJA4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 20:56:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38168 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbeIJA4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 20:56:17 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fz5xM-0003GM-Sh; Sun, 09 Sep 2018 22:05:17 +0200
Date:   Sun, 9 Sep 2018 22:05:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Matt Rickard <matt@softrans.com.au>,
        Florian Weimer <fweimer@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/vdso: Handle clock_gettime(CLOCK_TAI) in vDSO
In-Reply-To: <CALCETrU4PzskO9pE6G4EkXNRRX3Mu7Vvjv1P8XgrfRMdgGDZSg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809092159440.1402@nanos.tec.linutronix.de>
References: <20180901015935.CCF0B18E20A9@virtux64.softrans.com.au> <CALCETrU4PzskO9pE6G4EkXNRRX3Mu7Vvjv1P8XgrfRMdgGDZSg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018, Andy Lutomirski wrote:

> (Hi, Florian!)
> 
> On Fri, Aug 31, 2018 at 6:59 PM, Matt Rickard <matt@softrans.com.au> wrote:
> > Process clock_gettime(CLOCK_TAI) in vDSO.
> > This makes the call about as fast as CLOCK_REALTIME and CLOCK_MONOTONIC:
> >
> >   nanoseconds
> >  before after clockname
> >    ---- ----- ---------
> >     233    87 CLOCK_TAI
> >      96    93 CLOCK_REALTIME
> >      88    87 CLOCK_MONOTONIC
> 
> Are you sure you did this right?  With the clocksource set to TSC
> (which is the only reasonable choice unless KVM has seriously cleaned
> up its act), with retpolines enabled, I get 24ns for CLOCK_MONOTONIC
> without your patch and 32ns with your patch.  And there is indeed a
> retpoline in the disassembled output:
> 
>   e5:   e8 07 00 00 00          callq  f1 <__vdso_clock_gettime+0x31>
>   ea:   f3 90                   pause
>   ec:   0f ae e8                lfence
>   ef:   eb f9                   jmp    ea <__vdso_clock_gettime+0x2a>
>   f1:   48 89 04 24             mov    %rax,(%rsp)
>   f5:   c3                      retq
> 
> You're probably going to have to set -fno-jump-tables or do something
> clever like adding a whole array of (seconds, nsec) in gtod and
> indexing that array by the clock id.

See the patch below. It's integrating TAI without slowing down everything
and it definitely does not result in indirect calls.

On a HSW it slows down clock_gettime() by ~0.5ns. On a SKL I get a speedup
by ~0.5ns. On a AMD Epyc server it's 1.2ns speedup. So it somehow depends
on the uarch and I also observed compiler version dependend variations.

Thanks,

	tglx
----
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -203,39 +203,18 @@ notrace static inline u64 vgetsns(int *m
 	return v * gtod->mult;
 }
 
-/* Code size doesn't matter (vdso is 4k anyway) and this is faster. */
-notrace static int __always_inline do_realtime(struct timespec *ts)
+notrace static int __always_inline do_hres(struct timespec *ts, clockid_t clk)
 {
-	unsigned long seq;
-	u64 ns;
+	struct vgtod_ts *base = &gtod->basetime[clk & VGTOD_HRES_MASK];
+	unsigned int seq;
 	int mode;
-
-	do {
-		seq = gtod_read_begin(gtod);
-		mode = gtod->vclock_mode;
-		ts->tv_sec = gtod->wall_time_sec;
-		ns = gtod->wall_time_snsec;
-		ns += vgetsns(&mode);
-		ns >>= gtod->shift;
-	} while (unlikely(gtod_read_retry(gtod, seq)));
-
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return mode;
-}
-
-notrace static int __always_inline do_monotonic(struct timespec *ts)
-{
-	unsigned long seq;
 	u64 ns;
-	int mode;
 
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
@@ -246,58 +225,50 @@ notrace static int __always_inline do_mo
 	return mode;
 }
 
-notrace static void do_realtime_coarse(struct timespec *ts)
+notrace static void do_coarse(struct timespec *ts, clockid_t clk)
 {
+	struct vgtod_ts *base = &gtod->basetime[clk];
 	unsigned long seq;
-	do {
-		seq = gtod_read_begin(gtod);
-		ts->tv_sec = gtod->wall_time_coarse_sec;
-		ts->tv_nsec = gtod->wall_time_coarse_nsec;
-	} while (unlikely(gtod_read_retry(gtod, seq)));
-}
 
-notrace static void do_monotonic_coarse(struct timespec *ts)
-{
-	unsigned long seq;
 	do {
 		seq = gtod_read_begin(gtod);
-		ts->tv_sec = gtod->monotonic_time_coarse_sec;
-		ts->tv_nsec = gtod->monotonic_time_coarse_nsec;
+		ts->tv_sec = base->sec;
+		ts->tv_nsec = base->nsec;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
 }
 
 notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 {
-	switch (clock) {
-	case CLOCK_REALTIME:
-		if (do_realtime(ts) == VCLOCK_NONE)
-			goto fallback;
-		break;
-	case CLOCK_MONOTONIC:
-		if (do_monotonic(ts) == VCLOCK_NONE)
-			goto fallback;
-		break;
-	case CLOCK_REALTIME_COARSE:
-		do_realtime_coarse(ts);
-		break;
-	case CLOCK_MONOTONIC_COARSE:
-		do_monotonic_coarse(ts);
-		break;
-	default:
-		goto fallback;
-	}
+	unsigned int msk;
 
-	return 0;
-fallback:
+	/* Sort out negative (CPU/FD) and invalid clocks */
+	if (unlikely((unsigned int) clock >= MAX_CLOCKS))
+		return vdso_fallback_gettime(clock, ts);
+
+	/*
+	 * Convert the clockid to a bitmask and use it to check which
+	 * clocks are handled in the VDSO directly.
+	 */
+	msk = 1U << clock;
+	if (likely(msk & VGTOD_HRES)) {
+		if (do_hres(ts, clock) != VCLOCK_NONE)
+			return 0;
+	} else if (msk & VGTOD_COARSE) {
+		do_coarse(ts, clock);
+		return 0;
+	}
 	return vdso_fallback_gettime(clock, ts);
 }
+
 int clock_gettime(clockid_t, struct timespec *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
 notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
 	if (likely(tv != NULL)) {
-		if (unlikely(do_realtime((struct timespec *)tv) == VCLOCK_NONE))
+		struct timespec *ts = (struct timespec *) tv;
+
+		if (unlikely(do_hres(ts, CLOCK_REALTIME) == VCLOCK_NONE))
 			return vdso_fallback_gtod(tv, tz);
 		tv->tv_usec /= 1000;
 	}
@@ -318,7 +289,7 @@ int gettimeofday(struct timeval *, struc
 notrace time_t __vdso_time(time_t *t)
 {
 	/* This is atomic on x86 so we don't need any locks. */
-	time_t result = READ_ONCE(gtod->wall_time_sec);
+	time_t result = READ_ONCE(gtod->basetime[CLOCK_REALTIME].sec);
 
 	if (t)
 		*t = result;
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -31,6 +31,8 @@ void update_vsyscall(struct timekeeper *
 {
 	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
 	struct vsyscall_gtod_data *vdata = &vsyscall_gtod_data;
+	struct vgtod_ts *base;
+	u64 nsec;
 
 	/* Mark the new vclock used. */
 	BUILD_BUG_ON(VCLOCK_MAX >= 32);
@@ -45,34 +47,37 @@ void update_vsyscall(struct timekeeper *
 	vdata->mult		= tk->tkr_mono.mult;
 	vdata->shift		= tk->tkr_mono.shift;
 
-	vdata->wall_time_sec		= tk->xtime_sec;
-	vdata->wall_time_snsec		= tk->tkr_mono.xtime_nsec;
-
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
+	base = &vdata->basetime[CLOCK_REALTIME];
+	base->sec = (gtod_long_t)tk->xtime_sec;
+	base->nsec = tk->tkr_mono.xtime_nsec;
+
+	base = &vdata->basetime[VGTOD_TAI];
+	base->sec = (gtod_long_t)(tk->xtime_sec + (s64)tk->tai_offset);
+	base->nsec = tk->tkr_mono.xtime_nsec;
+
+	base = &vdata->basetime[CLOCK_MONOTONIC];
+	base->sec = (gtod_long_t)(tk->xtime_sec + tk->wall_to_monotonic.tv_sec);
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
-
-	vdata->monotonic_time_coarse_sec =
-		vdata->wall_time_coarse_sec + tk->wall_to_monotonic.tv_sec;
-	vdata->monotonic_time_coarse_nsec =
-		vdata->wall_time_coarse_nsec + tk->wall_to_monotonic.tv_nsec;
-
-	while (vdata->monotonic_time_coarse_nsec >= NSEC_PER_SEC) {
-		vdata->monotonic_time_coarse_nsec -= NSEC_PER_SEC;
-		vdata->monotonic_time_coarse_sec++;
+	base = &vdata->basetime[CLOCK_REALTIME_COARSE];
+	base->sec = (gtod_long_t)tk->xtime_sec;
+	base->nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+
+	base = &vdata->basetime[CLOCK_MONOTONIC_COARSE];
+	base->sec = (gtod_long_t)(tk->xtime_sec + tk->wall_to_monotonic.tv_sec);
+	nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+	nsec += tk->wall_to_monotonic.tv_nsec;
+	while (nsec >= NSEC_PER_SEC) {
+		nsec -= NSEC_PER_SEC;
+		base->sec++;
 	}
+	base->nsec = nsec;
 
 	gtod_write_end(vdata);
 }
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -5,33 +5,41 @@
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
+	gtod_long_t	sec;
+	u64		nsec;
+};
+
+#define VGTOD_BASES	(CLOCK_MONOTONIC_COARSE + 1)
+#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC) | BIT(CLOCK_TAI))
+#define VGTOD_COARSE	(BIT(CLOCK_REALTIME_COARSE) | BIT(CLOCK_MONOTONIC_COARSE))
+
+/* Abuse CLOCK_THREAD_CPUTIME_ID for VGTOD CLOCK TAI */
+#define VGTOD_HRES_MASK	0x3
+#define VGTOD_TAI	(CLOCK_TAI & VGTOD_HRES_MASK)
+
 /*
  * vsyscall_gtod_data will be accessed by 32 and 64 bit code at the same time
  * so be carefull by modifying this structure.
  */
 struct vsyscall_gtod_data {
-	unsigned seq;
+	unsigned int	seq;
+
+	int		vclock_mode;
+	u64		cycle_last;
+	u64		mask;
+	u32		mult;
+	u32		shift;
 
-	int vclock_mode;
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
+	struct vgtod_ts	basetime[VGTOD_BASES];
 
 	int		tz_minuteswest;
 	int		tz_dsttime;
@@ -44,9 +52,9 @@ static inline bool vclock_was_used(int v
 	return READ_ONCE(vclocks_used) & (1 << vclock);
 }
 
-static inline unsigned gtod_read_begin(const struct vsyscall_gtod_data *s)
+static inline unsigned int gtod_read_begin(const struct vsyscall_gtod_data *s)
 {
-	unsigned ret;
+	unsigned int ret;
 
 repeat:
 	ret = READ_ONCE(s->seq);
