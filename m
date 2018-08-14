Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B88DC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42B021728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42B021728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbeHNUXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:23:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57266 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbeHNUXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:23:35 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D40FADE0;
        Tue, 14 Aug 2018 17:35:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 043/104] x86/cpu/common: Provide detect_ht_early()
Date:   Tue, 14 Aug 2018 19:16:57 +0200
Message-Id: <20180814171518.077293024@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 545401f4448a807b963ff17b575e0a393e68b523 upstream

To support force disabling of SMT it's required to know the number of
thread siblings early. detect_ht() cannot be called before the APIC driver
is selected, so split out the part which initializes smp_num_siblings.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/common.c |   24 ++++++++++++++----------
 arch/x86/kernel/cpu/cpu.h    |    1 +
 2 files changed, 15 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -614,32 +614,36 @@ static void cpu_detect_tlb(struct cpuinf
 		tlb_lld_4m[ENTRIES], tlb_lld_1g[ENTRIES]);
 }
 
-void detect_ht(struct cpuinfo_x86 *c)
+int detect_ht_early(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
 	u32 eax, ebx, ecx, edx;
-	int index_msb, core_bits;
 
 	if (!cpu_has(c, X86_FEATURE_HT))
-		return;
+		return -1;
 
 	if (cpu_has(c, X86_FEATURE_CMP_LEGACY))
-		return;
+		return -1;
 
 	if (cpu_has(c, X86_FEATURE_XTOPOLOGY))
-		return;
+		return -1;
 
 	cpuid(1, &eax, &ebx, &ecx, &edx);
 
 	smp_num_siblings = (ebx & 0xff0000) >> 16;
+	if (smp_num_siblings == 1)
+		pr_info_once("CPU0: Hyper-Threading is disabled\n");
+#endif
+	return 0;
+}
 
-	if (!smp_num_siblings)
-		smp_num_siblings = 1;
+void detect_ht(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_SMP
+	int index_msb, core_bits;
 
-	if (smp_num_siblings == 1) {
-		pr_info_once("CPU0: Hyper-Threading is disabled\n");
+	if (detect_ht_early(c) < 0)
 		return;
-	}
 
 	index_msb = get_count_order(smp_num_siblings);
 	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid, index_msb);
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -47,6 +47,7 @@ extern const struct cpu_dev *const __x86
 
 extern void get_cpu_cap(struct cpuinfo_x86 *c);
 extern void cpu_detect_cache_sizes(struct cpuinfo_x86 *c);
+extern int detect_ht_early(struct cpuinfo_x86 *c);
 
 unsigned int aperfmperf_get_khz(int cpu);
 


