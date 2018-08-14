Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D50C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1A02154F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1A02154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389576AbeHNU3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:29:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59018 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730587AbeHNU3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:29:43 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0EBC7D20;
        Tue, 14 Aug 2018 17:41:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 045/107] x86/cpu/topology: Provide detect_extended_topology_early()
Date:   Tue, 14 Aug 2018 19:17:08 +0200
Message-Id: <20180814171523.808733626@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit 95f3d39ccf7aaea79d1ffdac1c887c2e100ec1b6 upstream

To support force disabling of SMT it's required to know the number of
thread siblings early. detect_extended_topology() cannot be called before
the APIC driver is selected, so split out the part which initializes
smp_num_siblings.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/cpu.h      |    1 +
 arch/x86/kernel/cpu/topology.c |   30 ++++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -46,6 +46,7 @@ extern const struct cpu_dev *const __x86
 
 extern void get_cpu_cap(struct cpuinfo_x86 *c);
 extern void cpu_detect_cache_sizes(struct cpuinfo_x86 *c);
+extern int detect_extended_topology_early(struct cpuinfo_x86 *c);
 extern int detect_ht_early(struct cpuinfo_x86 *c);
 
 extern void x86_spec_ctrl_setup_ap(void);
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -26,15 +26,13 @@
  * exists, use it for populating initial_apicid and cpu topology
  * detection.
  */
-void detect_extended_topology(struct cpuinfo_x86 *c)
+int detect_extended_topology_early(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
-	unsigned int eax, ebx, ecx, edx, sub_index;
-	unsigned int ht_mask_width, core_plus_mask_width;
-	unsigned int core_select_mask, core_level_siblings;
+	unsigned int eax, ebx, ecx, edx;
 
 	if (c->cpuid_level < 0xb)
-		return;
+		return -1;
 
 	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
 
@@ -42,7 +40,7 @@ void detect_extended_topology(struct cpu
 	 * check if the cpuid leaf 0xb is actually implemented.
 	 */
 	if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE))
-		return;
+		return -1;
 
 	set_cpu_cap(c, X86_FEATURE_XTOPOLOGY);
 
@@ -50,10 +48,30 @@ void detect_extended_topology(struct cpu
 	 * initial apic id, which also represents 32-bit extended x2apic id.
 	 */
 	c->initial_apicid = edx;
+	smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
+#endif
+	return 0;
+}
+
+/*
+ * Check for extended topology enumeration cpuid leaf 0xb and if it
+ * exists, use it for populating initial_apicid and cpu topology
+ * detection.
+ */
+void detect_extended_topology(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_SMP
+	unsigned int eax, ebx, ecx, edx, sub_index;
+	unsigned int ht_mask_width, core_plus_mask_width;
+	unsigned int core_select_mask, core_level_siblings;
+
+	if (detect_extended_topology_early(c) < 0)
+		return;
 
 	/*
 	 * Populate HT related information from sub-leaf level 0.
 	 */
+	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
 	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
 	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 


