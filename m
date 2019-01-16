Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80FAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9837D20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389937AbfAPMAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:00:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49979 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389800AbfAPL77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:59:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0GBxpNU253067
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 16 Jan 2019 03:59:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0GBxosF253064;
        Wed, 16 Jan 2019 03:59:50 -0800
Date:   Wed, 16 Jan 2019 03:59:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-093ae8f9a86a974c920b613860f1f7fd5bbd70ab@git.kernel.org>
Cc:     mingo@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, john.stultz@linaro.org, hpa@zytor.com,
        tglx@linutronix.de, bp@suse.de
Reply-To: luto@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
          thomas.lendacky@amd.com, john.stultz@linaro.org, hpa@zytor.com,
          bp@suse.de, tglx@linutronix.de
In-Reply-To: <20181119184556.11479-1-bp@alien8.de>
References: <20181119184556.11479-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/alternatives] x86/TSC: Use RDTSCP
Git-Commit-ID: 093ae8f9a86a974c920b613860f1f7fd5bbd70ab
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

Commit-ID:  093ae8f9a86a974c920b613860f1f7fd5bbd70ab
Gitweb:     https://git.kernel.org/tip/093ae8f9a86a974c920b613860f1f7fd5bbd70ab
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Thu, 12 Apr 2018 13:11:36 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 16 Jan 2019 12:43:08 +0100

x86/TSC: Use RDTSCP

Currently, the kernel uses

  [LM]FENCE; RDTSC

in the timekeeping code, to guarantee monotonicity of time where the
*FENCE is selected based on vendor.

Replace that sequence with RDTSCP which is faster or on-par and gives
the same guarantees.

A microbenchmark on Intel shows that the change is on-par.

On AMD, the change is either on-par with the current LFENCE-prefixed
RDTSC or slightly better with RDTSCP.

The comparison is done with the LFENCE-prefixed RDTSC (and not with the
MFENCE-prefixed one, as one would normally expect) because all modern
AMD families make LFENCE serializing and thus avoid the heavy MFENCE by
effectively enabling X86_FEATURE_LFENCE_RDTSC.

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20181119184556.11479-1-bp@alien8.de
---
 arch/x86/include/asm/msr.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 91e4cf189914..5cc3930cb465 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -217,6 +217,8 @@ static __always_inline unsigned long long rdtsc(void)
  */
 static __always_inline unsigned long long rdtsc_ordered(void)
 {
+	DECLARE_ARGS(val, low, high);
+
 	/*
 	 * The RDTSC instruction is not ordered relative to memory
 	 * access.  The Intel SDM and the AMD APM are both vague on this
@@ -227,9 +229,19 @@ static __always_inline unsigned long long rdtsc_ordered(void)
 	 * ordering guarantees as reading from a global memory location
 	 * that some other imaginary CPU is updating continuously with a
 	 * time stamp.
+	 *
+	 * Thus, use the preferred barrier on the respective CPU, aiming for
+	 * RDTSCP as the default.
 	 */
-	barrier_nospec();
-	return rdtsc();
+	asm volatile(ALTERNATIVE_3("rdtsc",
+				   "mfence; rdtsc", X86_FEATURE_MFENCE_RDTSC,
+				   "lfence; rdtsc", X86_FEATURE_LFENCE_RDTSC,
+				   "rdtscp", X86_FEATURE_RDTSCP)
+			: EAX_EDX_RET(val, low, high)
+			/* RDTSCP clobbers ECX with MSR_TSC_AUX. */
+			:: "ecx");
+
+	return EAX_EDX_VAL(val, low, high);
 }
 
 static inline unsigned long long native_read_pmc(int counter)
