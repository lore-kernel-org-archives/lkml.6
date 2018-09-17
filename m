Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7FAECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DF4214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DF4214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeIQSge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:36:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54822 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeIQSgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:36:33 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1tHA-0005Ex-A3; Mon, 17 Sep 2018 15:09:16 +0200
Message-Id: <20180917130707.657928937@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 17 Sep 2018 14:45:42 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: [patch V2 09/11] x86/vdso: Simplify the invalid vclock case
References: <20180917124533.329334911@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-vdso--Simplify-the-invalid-vclock-case.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code flow for the vclocks is convoluted as it requires the vclocks
which can be invalidated separately from the vsyscall_gtod_data sequence to
store the fact in a separate variable. That's inefficient.

Restructure the code so the vclock readout returns cycles and the
conversion to nanoseconds is handled at the call site.

If the clock gets invalidated or vclock is already VCLOCK_NONE, return
U64_MAX as the cycle value, which is invalid for all clocks and leave the
sequence loop immediately in that case by calling the fallback function
directly.

This allows to remove the gettimeofday fallback as it now uses the
clock_gettime() fallback and does the nanoseconds to microseconds
conversion in the same way as it does when the vclock is functional. It
does not make a difference whether the division by 1000 happens in the
kernel fallback or in userspace.

Generates way better code and gains a few cycles back.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c |   81 +++++++++--------------------------
 1 file changed, 21 insertions(+), 60 deletions(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -48,16 +48,6 @@ notrace static long vdso_fallback_gettim
 	return ret;
 }
 
-notrace static long vdso_fallback_gtod(struct timeval *tv, struct timezone *tz)
-{
-	long ret;
-
-	asm("syscall" : "=a" (ret) :
-	    "0" (__NR_gettimeofday), "D" (tv), "S" (tz) : "memory");
-	return ret;
-}
-
-
 #else
 
 notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
@@ -75,21 +65,6 @@ notrace static long vdso_fallback_gettim
 	return ret;
 }
 
-notrace static long vdso_fallback_gtod(struct timeval *tv, struct timezone *tz)
-{
-	long ret;
-
-	asm(
-		"mov %%ebx, %%edx \n"
-		"mov %2, %%ebx \n"
-		"call __kernel_vsyscall \n"
-		"mov %%edx, %%ebx \n"
-		: "=a" (ret)
-		: "0" (__NR_gettimeofday), "g" (tv), "c" (tz)
-		: "memory", "edx");
-	return ret;
-}
-
 #endif
 
 #ifdef CONFIG_PARAVIRT_CLOCK
@@ -98,7 +73,7 @@ static notrace const struct pvclock_vsys
 	return (const struct pvclock_vsyscall_time_info *)&pvclock_page;
 }
 
-static notrace u64 vread_pvclock(int *mode)
+static notrace u64 vread_pvclock(void)
 {
 	const struct pvclock_vcpu_time_info *pvti = &get_pvti0()->pvti;
 	u64 ret;
@@ -130,10 +105,8 @@ static notrace u64 vread_pvclock(int *mo
 	do {
 		version = pvclock_read_begin(pvti);
 
-		if (unlikely(!(pvti->flags & PVCLOCK_TSC_STABLE_BIT))) {
-			*mode = VCLOCK_NONE;
-			return 0;
-		}
+		if (unlikely(!(pvti->flags & PVCLOCK_TSC_STABLE_BIT)))
+			return U64_MAX;
 
 		ret = __pvclock_read_cycles(pvti, rdtsc_ordered());
 	} while (pvclock_read_retry(pvti, version));
@@ -148,17 +121,12 @@ static notrace u64 vread_pvclock(int *mo
 }
 #endif
 #ifdef CONFIG_HYPERV_TSCPAGE
-static notrace u64 vread_hvclock(int *mode)
+static notrace u64 vread_hvclock(void)
 {
 	const struct ms_hyperv_tsc_page *tsc_pg =
 		(const struct ms_hyperv_tsc_page *)&hvclock_page;
-	u64 current_tick = hv_read_tsc_page(tsc_pg);
-
-	if (current_tick != U64_MAX)
-		return current_tick;
 
-	*mode = VCLOCK_NONE;
-	return 0;
+	return hv_read_tsc_page(tsc_pg);
 }
 #endif
 
@@ -182,47 +150,42 @@ notrace static u64 vread_tsc(void)
 	return last;
 }
 
-notrace static inline u64 vgetsns(int *mode)
+notrace static inline u64 vgetcyc(int mode)
 {
-	u64 v;
-	cycles_t cycles;
-
-	if (gtod->vclock_mode == VCLOCK_TSC)
-		cycles = vread_tsc();
+	if (mode == VCLOCK_TSC)
+		return vread_tsc();
 #ifdef CONFIG_PARAVIRT_CLOCK
-	else if (gtod->vclock_mode == VCLOCK_PVCLOCK)
-		cycles = vread_pvclock(mode);
+	else if (mode == VCLOCK_PVCLOCK)
+		return vread_pvclock();
 #endif
 #ifdef CONFIG_HYPERV_TSCPAGE
-	else if (gtod->vclock_mode == VCLOCK_HVCLOCK)
-		cycles = vread_hvclock(mode);
+	else if (mode == VCLOCK_HVCLOCK)
+		return vread_hvclock();
 #endif
-	else
-		return 0;
-	v = cycles - gtod->cycle_last;
-	return v * gtod->mult;
+	return U64_MAX;
 }
 
 notrace static int do_hres(clockid_t clk, struct timespec *ts)
 {
 	struct vgtod_ts *base = &gtod->basetime[clk];
 	unsigned int seq;
-	int mode;
-	u64 ns;
+	u64 cycles, ns;
 
 	do {
 		seq = gtod_read_begin(gtod);
-		mode = gtod->vclock_mode;
 		ts->tv_sec = base->sec;
 		ns = base->nsec;
-		ns += vgetsns(&mode);
+		cycles = vgetcyc(gtod->vclock_mode);
+		if (unlikely((s64)cycles < 0))
+			return vdso_fallback_gettime(clk, ts);
+		ns += (cycles - gtod->cycle_last) * gtod->mult;
 		ns >>= gtod->shift;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
 
 	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec = ns;
 
-	return mode;
+	return 0;
 }
 
 notrace static void do_coarse(clockid_t clk, struct timespec *ts)
@@ -251,8 +214,7 @@ notrace int __vdso_clock_gettime(clockid
 	 */
 	msk = 1U << clock;
 	if (likely(msk & VGTOD_HRES)) {
-		if (do_hres(clock, ts) != VCLOCK_NONE)
-			return 0;
+		return do_hres(clock, ts);
 	} else if (msk & VGTOD_COARSE) {
 		do_coarse(clock, ts);
 		return 0;
@@ -268,8 +230,7 @@ notrace int __vdso_gettimeofday(struct t
 	if (likely(tv != NULL)) {
 		struct timespec *ts = (struct timespec *) tv;
 
-		if (unlikely(do_hres(CLOCK_REALTIME, ts) == VCLOCK_NONE))
-			return vdso_fallback_gtod(tv, tz);
+		do_hres(CLOCK_REALTIME, ts);
 		tv->tv_usec /= 1000;
 	}
 	if (unlikely(tz != NULL)) {


