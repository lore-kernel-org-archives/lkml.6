Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC1EC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3A321730
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3A321730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388051AbeHNUNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:13:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51478 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387747AbeHNUNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:13:00 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A41C3CD8;
        Tue, 14 Aug 2018 17:24:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.18 23/79] x86/cpu/topology: Provide detect_extended_topology_early()
Date:   Tue, 14 Aug 2018 19:16:42 +0200
Message-Id: <20180814171337.690977418@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
References: <20180814171336.799314117@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

To support force disabling of SMT it's required to know the number of
thread siblings early. detect_extended_topology() cannot be called before
the APIC driver is selected, so split out the part which initializes
smp_num_siblings.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/cpu.h      |    1 +
 arch/x86/kernel/cpu/topology.c |   31 ++++++++++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -55,6 +55,7 @@ extern void init_intel_cacheinfo(struct
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
 
 extern void detect_num_cpu_cores(struct cpuinfo_x86 *c);
+extern int detect_extended_topology_early(struct cpuinfo_x86 *c);
 extern int detect_extended_topology(struct cpuinfo_x86 *c);
 extern int detect_ht_early(struct cpuinfo_x86 *c);
 extern void detect_ht(struct cpuinfo_x86 *c);
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -22,17 +22,10 @@
 #define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
 #define LEVEL_MAX_SIBLINGS(ebx)		((ebx) & 0xffff)
 
-/*
- * Check for extended topology enumeration cpuid leaf 0xb and if it
- * exists, use it for populating initial_apicid and cpu topology
- * detection.
- */
-int detect_extended_topology(struct cpuinfo_x86 *c)
+int detect_extended_topology_early(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
-	unsigned int eax, ebx, ecx, edx, sub_index;
-	unsigned int ht_mask_width, core_plus_mask_width;
-	unsigned int core_select_mask, core_level_siblings;
+	unsigned int eax, ebx, ecx, edx;
 
 	if (c->cpuid_level < 0xb)
 		return -1;
@@ -51,10 +44,30 @@ int detect_extended_topology(struct cpui
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
+int detect_extended_topology(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_SMP
+	unsigned int eax, ebx, ecx, edx, sub_index;
+	unsigned int ht_mask_width, core_plus_mask_width;
+	unsigned int core_select_mask, core_level_siblings;
+
+	if (detect_extended_topology_early(c) < 0)
+		return -1;
 
 	/*
 	 * Populate HT related information from sub-leaf level 0.
 	 */
+	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
 	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
 	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 


