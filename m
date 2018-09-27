Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858ABC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E82521566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E82521566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeI0XVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:21:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeI0XU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:20:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RH1aTU099852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 10:01:36 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RH1a10099849;
        Thu, 27 Sep 2018 10:01:36 -0700
Date:   Thu, 27 Sep 2018 10:01:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pu Wen <tipbot@zytor.com>
Message-ID: <tip-d4f7423efdd1419b17524d090ff9ff4024bcf09b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, bp@suse.de, hpa@zytor.com,
        puwen@hygon.cn, tglx@linutronix.de, mingo@kernel.org
Reply-To: hpa@zytor.com, bp@suse.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, tglx@linutronix.de, puwen@hygon.cn
In-Reply-To: <2a686b2ac0e2f5a1f2f5f101124d9dd44f949731.1537533369.git.puwen@hygon.cn>
References: <2a686b2ac0e2f5a1f2f5f101124d9dd44f949731.1537533369.git.puwen@hygon.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpu: Get cache info and setup cache cpumap for
 Hygon Dhyana
Git-Commit-ID: d4f7423efdd1419b17524d090ff9ff4024bcf09b
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

Commit-ID:  d4f7423efdd1419b17524d090ff9ff4024bcf09b
Gitweb:     https://git.kernel.org/tip/d4f7423efdd1419b17524d090ff9ff4024bcf09b
Author:     Pu Wen <puwen@hygon.cn>
AuthorDate: Sun, 23 Sep 2018 17:33:44 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 27 Sep 2018 18:28:57 +0200

x86/cpu: Get cache info and setup cache cpumap for Hygon Dhyana

The Hygon Dhyana CPU has a topology extensions bit in CPUID. With
this bit, the kernel can get the cache information. So add support in
cpuid4_cache_lookup_regs() to get the correct cache size.

The Hygon Dhyana CPU also discovers num_cache_leaves via CPUID leaf
0x8000001d, so add support to it in find_num_cache_leaves().

Also add cacheinfo_hygon_init_llc_id() and init_hygon_cacheinfo()
functions to initialize Dhyana cache info. Setup cache cpumap in the
same way as AMD does.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: bp@alien8.de
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: x86@kernel.org
Cc: thomas.lendacky@amd.com
Link: https://lkml.kernel.org/r/2a686b2ac0e2f5a1f2f5f101124d9dd44f949731.1537533369.git.puwen@hygon.cn
---
 arch/x86/include/asm/cacheinfo.h |  1 +
 arch/x86/kernel/cpu/cacheinfo.c  | 31 +++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/cpu.h        |  1 +
 arch/x86/kernel/cpu/hygon.c      |  3 +++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index e958e28f7ab5..86b63c7feab7 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -3,5 +3,6 @@
 #define _ASM_X86_CACHEINFO_H
 
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
+void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
 
 #endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 0c5fcbd998cf..dc1b9342e9c4 100644
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
index 7b229afa0a37..da5446acc241 100644
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
index a43d5f1f8b41..cf25405444ab 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -87,6 +87,7 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
+		cacheinfo_hygon_init_llc_id(c, cpu, node_id);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
@@ -321,6 +322,8 @@ static void init_hygon(struct cpuinfo_x86 *c)
 	hygon_get_topology(c);
 	srat_detect_node(c);
 
+	init_hygon_cacheinfo(c);
+
 	if (cpu_has(c, X86_FEATURE_XMM2)) {
 		unsigned long long val;
 		int ret;
