Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1282C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AA42146D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KRlc58UW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AA42146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeKUJj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:39:28 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11324 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeKUJj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 04:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542755272; x=1574291272;
  h=from:to:cc:subject:date:message-id;
  bh=gWNVaT5q2FRSp5GUYA68hoc8M4aM1LrstfAQE97W0LA=;
  b=KRlc58UWMfiy+OIHzeBTbo3qLt8348AMwMiyfGJ137E/EeKAp/4/g/lK
   x2SuxPxgzJkDpeirXZ+XrpBiSqCARgR2c4tjIU+8pFjPca7EIGHsONYQH
   hdaUuCocntv5C0qu5kL2a1qRcBq0AyxLuVvq6QxUEcT6dPD4FRkcfomEe
   MZIE4A8gZRyHVHAB4l3nYN2jo0bxCe0M4Uu4ZUc2tqzmxieil9IYXwPdc
   Tb/NvZWyoVeCytBMrXTyl7nks7LDKVNoyirrluB8/i3AKa9ApHSfXou/U
   Bu7O/azrT+65uAeTvtUNL7DoYWIl6gFKrZAPUl1mShk7bjBeZeiHkEKsM
   g==;
X-IronPort-AV: E=Sophos;i="5.56,258,1539619200"; 
   d="scan'208";a="94745438"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2018 07:07:52 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 20 Nov 2018 14:50:37 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Nov 2018 15:07:52 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     palmer@sifive.com, linux-kernel@vger.kernel.org,
        atish.patra@wdc.com, anup@brainfault.org, jeremy.linton@arm.com,
        sudeep.holla@arm.com, schwab@suse.de
Subject: [PATCH] RISC-V: Fix of_node_* refcount
Date:   Tue, 20 Nov 2018 15:07:50 -0800
Message-Id: <1542755270-10433-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix of_node* refcount at various places by using of_node_put.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/cacheinfo.c  | 11 +++++++++++
 arch/riscv/kernel/cpu.c        |  1 +
 arch/riscv/kernel/cpufeature.c |  2 ++
 arch/riscv/kernel/perf_event.c |  1 +
 arch/riscv/kernel/smpboot.c    |  6 +++++-
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index cb35ffd8..638dee3f 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -28,6 +28,7 @@ static int __init_cache_level(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct device_node *np = of_cpu_device_node_get(cpu);
+	struct device_node *prev = NULL;
 	int levels = 0, leaves = 0, level;
 
 	if (of_property_read_bool(np, "cache-size"))
@@ -39,7 +40,10 @@ static int __init_cache_level(unsigned int cpu)
 	if (leaves > 0)
 		levels = 1;
 
+	prev = np;
 	while ((np = of_find_next_cache_node(np))) {
+		of_node_put(prev);
+		prev = np;
 		if (!of_device_is_compatible(np, "cache"))
 			break;
 		if (of_property_read_u32(np, "cache-level", &level))
@@ -55,8 +59,10 @@ static int __init_cache_level(unsigned int cpu)
 		levels = level;
 	}
 
+	of_node_put(np);
 	this_cpu_ci->num_levels = levels;
 	this_cpu_ci->num_leaves = leaves;
+
 	return 0;
 }
 
@@ -65,6 +71,7 @@ static int __populate_cache_leaves(unsigned int cpu)
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
 	struct device_node *np = of_cpu_device_node_get(cpu);
+	struct device_node *prev = NULL;
 	int levels = 1, level = 1;
 
 	if (of_property_read_bool(np, "cache-size"))
@@ -74,7 +81,10 @@ static int __populate_cache_leaves(unsigned int cpu)
 	if (of_property_read_bool(np, "d-cache-size"))
 		ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
 
+	prev = np;
 	while ((np = of_find_next_cache_node(np))) {
+		of_node_put(prev);
+		prev = np;
 		if (!of_device_is_compatible(np, "cache"))
 			break;
 		if (of_property_read_u32(np, "cache-level", &level))
@@ -89,6 +99,7 @@ static int __populate_cache_leaves(unsigned int cpu)
 			ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
 		levels = level;
 	}
+	of_node_put(np);
 
 	return 0;
 }
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 3a5a2ee3..7b3eb970 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -155,6 +155,7 @@ static int c_show(struct seq_file *m, void *v)
 	    && strcmp(compat, "riscv"))
 		seq_printf(m, "uarch\t\t: %s\n", compat);
 	seq_puts(m, "\n");
+	of_node_put(node);
 
 	return 0;
 }
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 0339087a..a6e369ed 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -56,8 +56,10 @@ void riscv_fill_hwcap(void)
 
 	if (of_property_read_string(node, "riscv,isa", &isa)) {
 		pr_warning("Unable to find \"riscv,isa\" devicetree entry");
+		of_node_put(node);
 		return;
 	}
+	of_node_put(node);
 
 	for (i = 0; i < strlen(isa); ++i)
 		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
index a243fae1..667ee70d 100644
--- a/arch/riscv/kernel/perf_event.c
+++ b/arch/riscv/kernel/perf_event.c
@@ -476,6 +476,7 @@ int __init init_hw_perf_events(void)
 
 		if (of_id)
 			riscv_pmu = of_id->data;
+		of_node_put(node);
 	}
 
 	perf_pmu_register(riscv_pmu->pmu, "cpu", PERF_TYPE_RAW);
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 18cda0e8..fc185eca 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -57,12 +57,15 @@ void __init setup_smp(void)
 
 	while ((dn = of_find_node_by_type(dn, "cpu"))) {
 		hart = riscv_of_processor_hartid(dn);
-		if (hart < 0)
+		if (hart < 0) {
+			of_node_put(dn);
 			continue;
+		}
 
 		if (hart == cpuid_to_hartid_map(0)) {
 			BUG_ON(found_boot_cpu);
 			found_boot_cpu = 1;
+			of_node_put(dn);
 			continue;
 		}
 
@@ -70,6 +73,7 @@ void __init setup_smp(void)
 		set_cpu_possible(cpuid, true);
 		set_cpu_present(cpuid, true);
 		cpuid++;
+		of_node_put(dn);
 	}
 
 	BUG_ON(!found_boot_cpu);
-- 
2.7.4

