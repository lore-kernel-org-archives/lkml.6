Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E239C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381102146E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381102146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeHSTVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 15:21:30 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:46040 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbeHSTV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 15:21:29 -0400
Received: from localhost.localdomain (unknown [110.184.154.248])
        by APP-10 (Coremail) with SMTP id tACowAB3f2MolnlbJHmwAg--.225S2;
        Mon, 20 Aug 2018 00:09:21 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Pu Wen <puwen@hygon.cn>
Subject: [PATCH v4 02/16] x86/cache: get cache size/leaves and setup cache cpumap for Dhyana
Date:   Mon, 20 Aug 2018 00:09:07 +0800
Message-Id: <aea8935182661bc5ceff9239823c137d5f852d35.1534599097.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1534599097.git.puwen@hygon.cn>
References: <cover.1534599097.git.puwen@hygon.cn>
X-CM-TRANSID: tACowAB3f2MolnlbJHmwAg--.225S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurWrAr4DtFykWFyxCr43trb_yoWrtry3pr
        W29w4rJF4xWFyfC3s8Ar4kXw4fZrykKa1xK347Ga4rAanrZr18Xrs8tw13Ar98Zw4rCw4S
        qF40gw1xKF1rJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
        W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
        LZ23UUUUU==
X-Originating-IP: [110.184.154.248]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hygon Dhyana processor has the topology extensions bit in CPUID.
With this bit kernel can get the cache info. So add support
in cpuid4_cache_lookup_regs() to get the correct cache size.

Dhyana also find num_cache_leaves via CPUID leaf 0x8000001d, so
add Hygon support in find_num_cache_leaves().

Also add cacheinfo_hygon_init_llc_id() and init_hygon_cacheinfo()
functions to initialize Dhyana cache info. Setup cache cpumap in
the same way as AMD does.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/include/asm/cacheinfo.h |  1 +
 arch/x86/kernel/cpu/cacheinfo.c  | 31 +++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/cpu.h        |  1 +
 arch/x86/kernel/cpu/hygon.c      |  3 +++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index e958e28..86b63c7 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -3,5 +3,6 @@
 #define _ASM_X86_CACHEINFO_H
 
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
+void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
 
 #endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 0c5fcbd..dc1b934 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -602,6 +602,10 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *this_leaf)
 		else
 			amd_cpuid4(index, &eax, &ebx, &ecx);
 		amd_init_l3_cache(this_leaf, index);
+	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+		cpuid_count(0x8000001d, index, &eax.full,
+			    &ebx.full, &ecx.full, &edx);
+		amd_init_l3_cache(this_leaf, index);
 	} else {
 		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &edx);
 	}
@@ -625,7 +629,8 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	union _cpuid4_leaf_eax	cache_eax;
 	int 			i = -1;
 
-	if (c->x86_vendor == X86_VENDOR_AMD)
+	if (c->x86_vendor == X86_VENDOR_AMD ||
+	    c->x86_vendor == X86_VENDOR_HYGON)
 		op = 0x8000001d;
 	else
 		op = 4;
@@ -678,6 +683,22 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
 	}
 }
 
+void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
+{
+	/*
+	 * We may have multiple LLCs if L3 caches exist, so check if we
+	 * have an L3 cache by looking at the L3 cache CPUID leaf.
+	 */
+	if (!cpuid_edx(0x80000006))
+		return;
+
+	/*
+	 * LLC is at the core complex level.
+	 * Core complex ID is ApicId[3] for these processors.
+	 */
+	per_cpu(cpu_llc_id, cpu) = c->apicid >> 3;
+}
+
 void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 {
 
@@ -691,6 +712,11 @@ void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 	}
 }
 
+void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
+{
+	num_cache_leaves = find_num_cache_leaves(c);
+}
+
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	/* Cache sizes */
@@ -913,7 +939,8 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 	int index_msb, i;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 
-	if (c->x86_vendor == X86_VENDOR_AMD) {
+	if (c->x86_vendor == X86_VENDOR_AMD ||
+	    c->x86_vendor == X86_VENDOR_HYGON) {
 		if (__cache_amd_cpumap_setup(cpu, index, base))
 			return;
 	}
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 7b229af..da5446a 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -54,6 +54,7 @@ extern u32 get_scattered_cpuid_leaf(unsigned int level,
 				    enum cpuid_regs_idx reg);
 extern void init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
+extern void init_hygon_cacheinfo(struct cpuinfo_x86 *c);
 
 extern void detect_num_cpu_cores(struct cpuinfo_x86 *c);
 extern int detect_extended_topology_early(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 50bdce5..4e6d64e 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -90,6 +90,7 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
+		cacheinfo_amd_init_llc_id(c, cpu, node_id);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
@@ -320,6 +321,8 @@ static void init_hygon(struct cpuinfo_x86 *c)
 	hygon_get_topology(c);
 	srat_detect_node(c);
 
+	init_hygon_cacheinfo(c);
+
 	set_cpu_cap(c, X86_FEATURE_K8);
 
 	if (cpu_has(c, X86_FEATURE_XMM2)) {
-- 
2.7.4

