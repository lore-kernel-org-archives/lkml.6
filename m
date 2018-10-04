Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB3CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D10B2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D10B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeJEEER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:04:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33759 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725758AbeJEEER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:04:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94L8UvE2885129
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 14:08:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94L8TBR2885126;
        Thu, 4 Oct 2018 14:08:29 -0700
Date:   Thu, 4 Oct 2018 14:08:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-4f72adc5068294268387a81a6bf91d9bb07ecc5c@git.kernel.org>
Cc:     fweimer@redhat.com, sboyd@kernel.org, kys@microsoft.com,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, pbonzini@redhat.com, jgross@suse.com,
        arnd@arndb.de, luto@kernel.org, mingo@kernel.org,
        john.stultz@linaro.org, matt@softrans.com.au, peterz@infradead.org
Reply-To: fweimer@redhat.com, kys@microsoft.com,
          linux-kernel@vger.kernel.org, sboyd@kernel.org,
          vkuznets@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          pbonzini@redhat.com, jgross@suse.com, luto@kernel.org,
          mingo@kernel.org, arnd@arndb.de, peterz@infradead.org,
          matt@softrans.com.au, john.stultz@linaro.org
In-Reply-To: <20180917130707.657928937@linutronix.de>
References: <20180917130707.657928937@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] x86/vdso: Simplify the invalid vclock case
Git-Commit-ID: 4f72adc5068294268387a81a6bf91d9bb07ecc5c
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

Commit-ID:  4f72adc5068294268387a81a6bf91d9bb07ecc5c
Gitweb:     https://git.kernel.org/tip/4f72adc5068294268387a81a6bf91d9bb07ecc5c
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 14:45:42 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 4 Oct 2018 23:00:26 +0200

x86/vdso: Simplify the invalid vclock case

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
Link: https://lkml.kernel.org/r/20180917130707.657928937@linutronix.de

---
 arch/x86/entry/vdso/vclock_gettime.c | 82 +++++++++---------------------------
 1 file changed, 21 insertions(+), 61 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 672e50e35d6c..40105024a210 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -49,17 +49,6 @@ notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
 	return ret;
 }
 
-notrace static long vdso_fallback_gtod(struct timeval *tv, struct timezone *tz)
-{
-	long ret;
-
-	asm ("syscall" : "=a" (ret), "=m" (*tv), "=m" (*tz) :
-	     "0" (__NR_gettimeofday), "D" (tv), "S" (tz) :
-	     "memory", "rcx", "r11");
-	return ret;
-}
-
-
 #else
 
 notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
@@ -77,21 +66,6 @@ notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
 	return ret;
 }
 
-notrace static long vdso_fallback_gtod(struct timeval *tv, struct timezone *tz)
-{
-	long ret;
-
-	asm (
-		"mov %%ebx, %%edx \n"
-		"mov %[tv], %%ebx \n"
-		"call __kernel_vsyscall \n"
-		"mov %%edx, %%ebx \n"
-		: "=a" (ret), "=m" (*tv), "=m" (*tz)
-		: "0" (__NR_gettimeofday), [tv] "g" (tv), "c" (tz)
-		: "memory", "edx");
-	return ret;
-}
-
 #endif
 
 #ifdef CONFIG_PARAVIRT_CLOCK
@@ -100,7 +74,7 @@ static notrace const struct pvclock_vsyscall_time_info *get_pvti0(void)
 	return (const struct pvclock_vsyscall_time_info *)&pvclock_page;
 }
 
-static notrace u64 vread_pvclock(int *mode)
+static notrace u64 vread_pvclock(void)
 {
 	const struct pvclock_vcpu_time_info *pvti = &get_pvti0()->pvti;
 	u64 ret;
@@ -132,10 +106,8 @@ static notrace u64 vread_pvclock(int *mode)
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
@@ -150,17 +122,12 @@ static notrace u64 vread_pvclock(int *mode)
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
 
@@ -184,47 +151,42 @@ notrace static u64 vread_tsc(void)
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
@@ -253,8 +215,7 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 	 */
 	msk = 1U << clock;
 	if (likely(msk & VGTOD_HRES)) {
-		if (do_hres(clock, ts) != VCLOCK_NONE)
-			return 0;
+		return do_hres(clock, ts);
 	} else if (msk & VGTOD_COARSE) {
 		do_coarse(clock, ts);
 		return 0;
@@ -270,8 +231,7 @@ notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 	if (likely(tv != NULL)) {
 		struct timespec *ts = (struct timespec *) tv;
 
-		if (unlikely(do_hres(CLOCK_REALTIME, ts) == VCLOCK_NONE))
-			return vdso_fallback_gtod(tv, tz);
+		do_hres(CLOCK_REALTIME, ts);
 		tv->tv_usec /= 1000;
 	}
 	if (unlikely(tz != NULL)) {
