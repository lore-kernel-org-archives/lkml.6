Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F80C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B950A20870
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B950A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392332AbeIVGQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:16:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44159 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391935AbeIVGKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:45 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdv-0008BR-Af; Sat, 22 Sep 2018 01:19:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdp-0000uW-88; Sat, 22 Sep 2018 01:19:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Sherry Hurwitz" <sherry.hurwitz@amd.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.705254652@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 60/63] x86/cpu/AMD: Fix erratum 1076 (CPB bit)
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit f7f3dc00f61261cdc9ccd8b886f21bc4dffd6fd9 upstream.

CPUID Fn8000_0007_EDX[CPB] is wrongly 0 on models up to B1. But they do
support CPB (AMD's Core Performance Boosting cpufreq CPU feature), so fix that.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170907170821.16021-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - Change the added case into an if-statement
 - s/x86_stepping/x86_mask/]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/amd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -533,6 +533,16 @@ static void init_amd_ln(struct cpuinfo_x
 	msr_set_bit(MSR_AMD64_DE_CFG, 31);
 }
 
+static void init_amd_zn(struct cpuinfo_x86 *c)
+{
+	/*
+	 * Fix erratum 1076: CPB feature bit not being set in CPUID. It affects
+	 * all up to and including B1.
+	 */
+	if (c->x86_model <= 1 && c->x86_mask <= 1)
+		set_cpu_cap(c, X86_FEATURE_CPB);
+}
+
 static void init_amd(struct cpuinfo_x86 *c)
 {
 	u32 dummy;
@@ -611,6 +621,9 @@ static void init_amd(struct cpuinfo_x86
 		clear_cpu_cap(c, X86_FEATURE_MCE);
 #endif
 
+	if (c->x86 == 0x17)
+		init_amd_zn(c);
+
 	/* Enable workaround for FXSAVE leak */
 	if (c->x86 >= 6)
 		set_cpu_cap(c, X86_FEATURE_FXSAVE_LEAK);

