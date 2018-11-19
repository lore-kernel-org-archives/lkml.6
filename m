Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FCEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C832075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fwovF6z5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C832075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeKTFKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:10:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36954 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbeKTFKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:10:54 -0500
Received: from zn.tnic (p200300EC2BE2B700F95221CD056129B8.dip0.t-ipconnect.de [IPv6:2003:ec:2be2:b700:f952:21cd:561:29b8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07B921EC02D1;
        Mon, 19 Nov 2018 19:46:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542653165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=c1vUmjebieo0f66OSYpCdJu7dflVcIWXzdt8nwuWMBw=;
        b=fwovF6z5uR4sDLZp+o+oj+NePWRjka388Wxxbs54l7dUMA7O5GZJLwyV/BMQWDcw4tHvHd
        +dLdoMsoEUZ1qYbvm850g/nJU05031do78U8vatYjLIG7QcBOsd81l29570+9jVNUYV0z3
        UlKwln3J4XVwaYaXZWEHAPWpWzYoAgg=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: [PATCH] x86/TSC: Use RDTSCP
Date:   Mon, 19 Nov 2018 19:45:56 +0100
Message-Id: <20181119184556.11479-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Currently, the kernel uses

  [LM]FENCE; RDTSC

in the timekeeping code, to guarantee monotonicity of time where the
*FENCE is selected based on vendor.

Replace that sequence with RDTSCP which is faster or on-par and gives
the same guarantees.

A microbenchmark on Intel shows that the change is on-par.

On AMD, the change is either on-par with the current LFENCE-prefixed
RDTSC and some are slightly better with RDTSCP.

The comparison is done with the LFENCE-prefixed RDTSC (and not with the
MFENCE-prefixed one, as one would normally expect) because all modern
AMD families make LFENCE serializing and thus avoid the heavy MFENCE by
effectively enabling X86_FEATURE_LFENCE_RDTSC.

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: x86@kernel.org
---
 arch/x86/include/asm/msr.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 91e4cf189914..f00f2b61d326 100644
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
@@ -227,9 +229,18 @@ static __always_inline unsigned long long rdtsc_ordered(void)
 	 * ordering guarantees as reading from a global memory location
 	 * that some other imaginary CPU is updating continuously with a
 	 * time stamp.
+	 *
+	 * Thus, use the preferred barrier on the respective CPU, aiming for
+	 * RDTSCP as the default.
 	 */
-	barrier_nospec();
-	return rdtsc();
+	asm volatile(ALTERNATIVE_2("mfence; rdtsc",
+				   "lfence; rdtsc", X86_FEATURE_LFENCE_RDTSC,
+				   "rdtscp", X86_FEATURE_RDTSCP)
+			: EAX_EDX_RET(val, low, high)
+			/* RDTSCP clobbers ECX with MSR_TSC_AUX. */
+			:: "ecx");
+
+	return EAX_EDX_VAL(val, low, high);
 }
 
 static inline unsigned long long native_read_pmc(int counter)
-- 
2.19.1

