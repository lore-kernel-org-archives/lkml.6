Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61235C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE4222419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE4222419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeKOHdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:33:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49990 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbeKOHds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 02:33:48 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zwVPnZ7XVVvI; Wed, 14 Nov 2018 22:28:52 +0100 (CET)
Received: from zn.tnic (p200300EC2BD0D200D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:d200:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C06ED1EC00EB;
        Wed, 14 Nov 2018 22:28:52 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] x86/cpuid: Get vendor ID on the BSP
Date:   Wed, 14 Nov 2018 22:28:42 +0100
Message-Id: <20181114212843.16954-3-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114212843.16954-1-bp@alien8.de>
References: <20181114212843.16954-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

No need to do it on each CPU. Read max base CPUID level on each CPU for
now so that the check in cpu_detect() works.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/common.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8a6071614652..f77ca116fba7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -732,15 +732,21 @@ static void get_cpu_vendor(struct cpuinfo_x86 *c)
 	this_cpu = &default_cpu;
 }
 
-void cpu_detect(struct cpuinfo_x86 *c)
+static void cpu_get_vendor_name(void)
 {
-	/* Get vendor name */
-	cpuid(0x00000000, (unsigned int *)&c->cpuid_level,
+	u32 dummy;
+
+	cpuid(0x00000000, &dummy,
 	      (unsigned int *)&x86_vendor_id[0],
 	      (unsigned int *)&x86_vendor_id[8],
 	      (unsigned int *)&x86_vendor_id[4]);
+}
 
+void cpu_detect(struct cpuinfo_x86 *c)
+{
+	c->cpuid_level = cpuid_eax(0);
 	c->x86 = 4;
+
 	/* Intel-defined flags: level 0x00000001 */
 	if (c->cpuid_level >= 0x00000001) {
 		u32 junk, tfms, cap0, misc;
@@ -1082,6 +1088,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	/* cyrix could have cpuid enabled via c_identify()*/
 	if (have_cpuid_p()) {
+		cpu_get_vendor_name();
 		cpu_detect(c);
 		get_cpu_vendor(c);
 		get_cpu_cap(c);
-- 
2.19.1

