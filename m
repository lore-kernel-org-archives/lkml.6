Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31C7C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC292087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC292087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeJEEE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:04:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50709 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725758AbeJEEEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:04:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94L94RE2885324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 14:09:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94L94qt2885321;
        Thu, 4 Oct 2018 14:09:04 -0700
Date:   Thu, 4 Oct 2018 14:09:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-3e89bf35ebf59c12e8c1476f6681fae0ebdcb2a7@git.kernel.org>
Cc:     pbonzini@redhat.com, vkuznets@redhat.com,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        matt@softrans.com.au, mingo@kernel.org, fweimer@redhat.com,
        arnd@arndb.de, hpa@zytor.com, sboyd@kernel.org, kys@microsoft.com,
        tglx@linutronix.de, john.stultz@linaro.org, peterz@infradead.org,
        luto@kernel.org
Reply-To: arnd@arndb.de, fweimer@redhat.com, mingo@kernel.org,
          matt@softrans.com.au, vkuznets@redhat.com,
          linux-kernel@vger.kernel.org, jgross@suse.com,
          pbonzini@redhat.com, tglx@linutronix.de, kys@microsoft.com,
          sboyd@kernel.org, hpa@zytor.com, peterz@infradead.org,
          john.stultz@linaro.org, luto@kernel.org
In-Reply-To: <20180917130707.741440803@linutronix.de>
References: <20180917130707.741440803@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] x86/vdso: Move cycle_last handling into the caller
Git-Commit-ID: 3e89bf35ebf59c12e8c1476f6681fae0ebdcb2a7
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

Commit-ID:  3e89bf35ebf59c12e8c1476f6681fae0ebdcb2a7
Gitweb:     https://git.kernel.org/tip/3e89bf35ebf59c12e8c1476f6681fae0ebdcb2a7
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 14:45:43 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 4 Oct 2018 23:00:27 +0200

x86/vdso: Move cycle_last handling into the caller

Dereferencing gtod->cycle_last all over the place and foing the cycles <
last comparison in the vclock read functions generates horrible code. Doing
it at the call site is much better and gains a few cycles both for TSC and
pvclock.

Caveat: This adds the comparison to the hyperv vclock as well, but I have
no way to test that.

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
Link: https://lkml.kernel.org/r/20180917130707.741440803@linutronix.de

---
 arch/x86/entry/vdso/vclock_gettime.c | 39 +++++++-----------------------------
 1 file changed, 7 insertions(+), 32 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 40105024a210..b7ccbff26a3f 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -77,9 +77,8 @@ static notrace const struct pvclock_vsyscall_time_info *get_pvti0(void)
 static notrace u64 vread_pvclock(void)
 {
 	const struct pvclock_vcpu_time_info *pvti = &get_pvti0()->pvti;
-	u64 ret;
-	u64 last;
 	u32 version;
+	u64 ret;
 
 	/*
 	 * Note: The kernel and hypervisor must guarantee that cpu ID
@@ -112,13 +111,7 @@ static notrace u64 vread_pvclock(void)
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
@@ -131,30 +124,10 @@ static notrace u64 vread_hvclock(void)
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
@@ -169,17 +142,19 @@ notrace static inline u64 vgetcyc(int mode)
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
 
