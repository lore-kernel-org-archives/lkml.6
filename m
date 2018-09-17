Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13087ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0FD214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0FD214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeIQSgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:36:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54828 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbeIQSgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:36:35 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1tHB-0005FK-BB; Mon, 17 Sep 2018 15:09:17 +0200
Message-Id: <20180917130707.741440803@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 17 Sep 2018 14:45:43 +0200
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
Subject: [patch V2 10/11] x86/vdso: Move cycle_last handling into the caller
References: <20180917124533.329334911@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-vdso--Move-cycle_last-handling-into-the-caller.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dereferencing gtod->cycle_last all over the place and foing the cycles <
last comparison in the vclock read functions generates horrible code. Doing
it at the call site is much better and gains a few cycles both for TSC and
pvclock.

Caveat: This adds the comparison to the hyperv vclock as well, but I have
no way to test that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c |   39 ++++++-----------------------------
 1 file changed, 7 insertions(+), 32 deletions(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -76,9 +76,8 @@ static notrace const struct pvclock_vsys
 static notrace u64 vread_pvclock(void)
 {
 	const struct pvclock_vcpu_time_info *pvti = &get_pvti0()->pvti;
-	u64 ret;
-	u64 last;
 	u32 version;
+	u64 ret;
 
 	/*
 	 * Note: The kernel and hypervisor must guarantee that cpu ID
@@ -111,13 +110,7 @@ static notrace u64 vread_pvclock(void)
 		ret = __pvclock_read_cycles(pvti, rdtsc_ordered());
 	} while (pvclock_read_retry(pvti, version));
 
-	/* refer to vread_tsc() comment for rationale */
-	last = gtod->cycle_last;
-
-	if (likely(ret >= last))
-		return ret;
-
-	return last;
+	return ret;
 }
 #endif
 #ifdef CONFIG_HYPERV_TSCPAGE
@@ -130,30 +123,10 @@ static notrace u64 vread_hvclock(void)
 }
 #endif
 
-notrace static u64 vread_tsc(void)
-{
-	u64 ret = (u64)rdtsc_ordered();
-	u64 last = gtod->cycle_last;
-
-	if (likely(ret >= last))
-		return ret;
-
-	/*
-	 * GCC likes to generate cmov here, but this branch is extremely
-	 * predictable (it's just a function of time and the likely is
-	 * very likely) and there's a data dependence, so force GCC
-	 * to generate a branch instead.  I don't barrier() because
-	 * we don't actually need a barrier, and if this function
-	 * ever gets inlined it will generate worse code.
-	 */
-	asm volatile ("");
-	return last;
-}
-
 notrace static inline u64 vgetcyc(int mode)
 {
 	if (mode == VCLOCK_TSC)
-		return vread_tsc();
+		return (u64)rdtsc_ordered();
 #ifdef CONFIG_PARAVIRT_CLOCK
 	else if (mode == VCLOCK_PVCLOCK)
 		return vread_pvclock();
@@ -168,17 +141,19 @@ notrace static inline u64 vgetcyc(int mo
 notrace static int do_hres(clockid_t clk, struct timespec *ts)
 {
 	struct vgtod_ts *base = &gtod->basetime[clk];
+	u64 cycles, last, ns;
 	unsigned int seq;
-	u64 cycles, ns;
 
 	do {
 		seq = gtod_read_begin(gtod);
 		ts->tv_sec = base->sec;
 		ns = base->nsec;
+		last = gtod->cycle_last;
 		cycles = vgetcyc(gtod->vclock_mode);
 		if (unlikely((s64)cycles < 0))
 			return vdso_fallback_gettime(clk, ts);
-		ns += (cycles - gtod->cycle_last) * gtod->mult;
+		if (cycles > last)
+			ns += (cycles - last) * gtod->mult;
 		ns >>= gtod->shift;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
 


