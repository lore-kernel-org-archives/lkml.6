Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729F4C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BB52150B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BB52150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390382AbeHNUab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:30:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59622 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388923AbeHNUaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:30:30 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E48F1CA5;
        Tue, 14 Aug 2018 17:42:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 052/107] x86/CPU/AMD: Move TOPOEXT reenablement before reading smp_num_siblings
Date:   Tue, 14 Aug 2018 19:17:15 +0200
Message-Id: <20180814171524.347051225@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 7ce2f0393ea2396142b7faf6ee9b1f3676d08a5f upstream

The TOPOEXT reenablement is a workaround for broken BIOSen which didn't
enable the CPUID bit. amd_get_topology_early(), however, relies on
that bit being set so that it can read out the CPUID leaf and set
smp_num_siblings properly.

Move the reenablement up to early_init_amd(). While at it, simplify
amd_get_topology_early().

[dwmw2: Backport to 4.9]

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/amd.c |   39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -300,12 +300,8 @@ static int nearby_node(int apicid)
 
 static void amd_get_topology_early(struct cpuinfo_x86 *c)
 {
-	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
-		u32 eax, ebx, ecx, edx;
-
-		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
-		smp_num_siblings = ((ebx >> 8) & 0xff) + 1;
-	}
+	if (cpu_has(c, X86_FEATURE_TOPOEXT))
+		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
 }
 
 /*
@@ -326,7 +322,6 @@ static void amd_get_topology(struct cpui
 		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
 
 		node_id  = ecx & 0xff;
-		smp_num_siblings = ((ebx >> 8) & 0xff) + 1;
 
 		if (c->x86 == 0x15)
 			c->cu_id = ebx & 0xff;
@@ -578,6 +573,8 @@ static void bsp_init_amd(struct cpuinfo_
 
 static void early_init_amd(struct cpuinfo_x86 *c)
 {
+	u64 value;
+
 	early_init_amd_mc(c);
 
 	/*
@@ -645,6 +642,21 @@ static void early_init_amd(struct cpuinf
 	if (cpu_has_amd_erratum(c, amd_erratum_400))
 		set_cpu_bug(c, X86_BUG_AMD_E400);
 
+
+	/* Re-enable TopologyExtensions if switched off by BIOS */
+	if (c->x86 == 0x15 &&
+	    (c->x86_model >= 0x10 && c->x86_model <= 0x6f) &&
+	    !cpu_has(c, X86_FEATURE_TOPOEXT)) {
+
+		if (msr_set_bit(0xc0011005, 54) > 0) {
+			rdmsrl(0xc0011005, value);
+			if (value & BIT_64(54)) {
+				set_cpu_cap(c, X86_FEATURE_TOPOEXT);
+				pr_info_once(FW_INFO "CPU: Re-enabling disabled Topology Extensions Support.\n");
+			}
+		}
+	}
+
 	amd_get_topology_early(c);
 }
 
@@ -737,19 +749,6 @@ static void init_amd_bd(struct cpuinfo_x
 {
 	u64 value;
 
-	/* re-enable TopologyExtensions if switched off by BIOS */
-	if ((c->x86_model >= 0x10) && (c->x86_model <= 0x6f) &&
-	    !cpu_has(c, X86_FEATURE_TOPOEXT)) {
-
-		if (msr_set_bit(0xc0011005, 54) > 0) {
-			rdmsrl(0xc0011005, value);
-			if (value & BIT_64(54)) {
-				set_cpu_cap(c, X86_FEATURE_TOPOEXT);
-				pr_info_once(FW_INFO "CPU: Re-enabling disabled Topology Extensions Support.\n");
-			}
-		}
-	}
-
 	/*
 	 * The way access filter has a performance penalty on some workloads.
 	 * Disable it on the affected CPUs.


