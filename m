Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383BBC46470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE42821749
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE42821749
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389382AbeHNUSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:18:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53062 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388383AbeHNUSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:18:07 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CDA31BDB;
        Tue, 14 Aug 2018 17:29:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.17 37/97] x86/cpu: Remove the pointless CPU printout
Date:   Tue, 14 Aug 2018 19:16:49 +0200
Message-Id: <20180814171434.582765956@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171433.160434170@linuxfoundation.org>
References: <20180814171433.160434170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 55e6d279abd92cfd7576bba031e7589be8475edb upstream

The value of this printout is dubious at best and there is no point in
having it in two different places along with convoluted ways to reach it.

Remove it completely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/common.c   |   20 +++++---------------
 arch/x86/kernel/cpu/topology.c |   11 -----------
 2 files changed, 5 insertions(+), 26 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -643,13 +643,12 @@ void detect_ht(struct cpuinfo_x86 *c)
 #ifdef CONFIG_SMP
 	u32 eax, ebx, ecx, edx;
 	int index_msb, core_bits;
-	static bool printed;
 
 	if (!cpu_has(c, X86_FEATURE_HT))
 		return;
 
 	if (cpu_has(c, X86_FEATURE_CMP_LEGACY))
-		goto out;
+		return;
 
 	if (cpu_has(c, X86_FEATURE_XTOPOLOGY))
 		return;
@@ -658,14 +657,14 @@ void detect_ht(struct cpuinfo_x86 *c)
 
 	smp_num_siblings = (ebx & 0xff0000) >> 16;
 
+	if (!smp_num_siblings)
+		smp_num_siblings = 1;
+
 	if (smp_num_siblings == 1) {
 		pr_info_once("CPU0: Hyper-Threading is disabled\n");
-		goto out;
+		return;
 	}
 
-	if (smp_num_siblings <= 1)
-		goto out;
-
 	index_msb = get_count_order(smp_num_siblings);
 	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid, index_msb);
 
@@ -677,15 +676,6 @@ void detect_ht(struct cpuinfo_x86 *c)
 
 	c->cpu_core_id = apic->phys_pkg_id(c->initial_apicid, index_msb) &
 				       ((1 << core_bits) - 1);
-
-out:
-	if (!printed && (c->x86_max_cores * smp_num_siblings) > 1) {
-		pr_info("CPU: Physical Processor ID: %d\n",
-			c->phys_proc_id);
-		pr_info("CPU: Processor Core ID: %d\n",
-			c->cpu_core_id);
-		printed = 1;
-	}
 #endif
 }
 
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -33,7 +33,6 @@ void detect_extended_topology(struct cpu
 	unsigned int eax, ebx, ecx, edx, sub_index;
 	unsigned int ht_mask_width, core_plus_mask_width;
 	unsigned int core_select_mask, core_level_siblings;
-	static bool printed;
 
 	if (c->cpuid_level < 0xb)
 		return;
@@ -86,15 +85,5 @@ void detect_extended_topology(struct cpu
 	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
 
 	c->x86_max_cores = (core_level_siblings / smp_num_siblings);
-
-	if (!printed) {
-		pr_info("CPU: Physical Processor ID: %d\n",
-		       c->phys_proc_id);
-		if (c->x86_max_cores > 1)
-			pr_info("CPU: Processor Core ID: %d\n",
-			       c->cpu_core_id);
-		printed = 1;
-	}
-	return;
 #endif
 }


