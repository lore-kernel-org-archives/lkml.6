Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08DEC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F3F20BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2dr8RbOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F3F20BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391073AbeGLAOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:14:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56988 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390956AbeGLANL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:13:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6C04UWK147370;
        Thu, 12 Jul 2018 00:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=r7SXJWkozyYrojFxuysUT6TzwtpLaVe7lrT+lSNKJPQ=;
 b=2dr8RbOwhTkNYwNjU2crP1VDIXCJlnUd+GvRCdUVA1Ng79cPPeQENPE+X9lrNvvyNFHv
 +7Y4YtYh86XvVvWVMpaCDoT+4LebFHsVsaX2ftEzgMrD4fAUKwJhDFqmMhYjsU4DJe1Q
 xrVeHAK9FgcC3tHh8DBAU3+RZWFhH7La0LtqGTMl5rZ3llfDTM4rlhj0ZXHJ2F+h1tiN
 VaqeubL0jrbCAgCy02jlUYQ1EUQxQq8/ZwZ6Y+nmP1KpYW8pNR4dygY6/pjSLznjBqya
 E88mIiXsr3xFGfBXCOjIcVUdqlK+3NcvsATCVUEBwEuc5irjWSEP09jF7Csv77+JR7Cr Ng== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2k2p7vg837-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 00:04:30 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6C04TvN012847
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 00:04:29 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6C04S7H031913;
        Thu, 12 Jul 2018 00:04:29 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 17:04:28 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, pasha.tatashin@oracle.com,
        boris.ostrovsky@oracle.com, jgross@suse.com
Subject: [PATCH v13 02/18] x86: initialize static branching early
Date:   Wed, 11 Jul 2018 20:04:03 -0400
Message-Id: <20180712000419.5165-3-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712000419.5165-1-pasha.tatashin@oracle.com>
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

static branching is useful to hot-patch branches that are used in hot
path, but are infrequently changed.

x86 clock framework is one example that uses static branches to setup
the best clock during boot and never change it again.

Since we plan to enable clock early, we need static branching
functionality early as well.

static branching requires patching nop instructions, thus, we need
arch_init_ideal_nops() to be called prior to jump_label_init()

Here we do all the necessary steps to call arch_init_ideal_nops
after early_cpu_init().

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/amd.c    | 13 +++++++-----
 arch/x86/kernel/cpu/common.c | 38 +++++++++++++++++++-----------------
 arch/x86/kernel/setup.c      |  4 ++--
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 38915fbfae73..b732438c1a1e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -232,8 +232,6 @@ static void init_amd_k7(struct cpuinfo_x86 *c)
 		}
 	}
 
-	set_cpu_cap(c, X86_FEATURE_K7);
-
 	/* calling is from identify_secondary_cpu() ? */
 	if (!c->cpu_index)
 		return;
@@ -617,6 +615,14 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 
 	early_init_amd_mc(c);
 
+#ifdef CONFIG_X86_32
+	if (c->x86 == 6)
+		set_cpu_cap(c, X86_FEATURE_K7);
+#endif
+
+	if (c->x86 >= 0xf)
+		set_cpu_cap(c, X86_FEATURE_K8);
+
 	rdmsr_safe(MSR_AMD64_PATCH_LEVEL, &c->microcode, &dummy);
 
 	/*
@@ -863,9 +869,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 
 	init_amd_cacheinfo(c);
 
-	if (c->x86 >= 0xf)
-		set_cpu_cap(c, X86_FEATURE_K8);
-
 	if (cpu_has(c, X86_FEATURE_XMM2)) {
 		unsigned long long val;
 		int ret;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index eb4cb3efd20e..71281ac43b15 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1015,6 +1015,24 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
 }
 
+/*
+ * The NOPL instruction is supposed to exist on all CPUs of family >= 6;
+ * unfortunately, that's not true in practice because of early VIA
+ * chips and (more importantly) broken virtualizers that are not easy
+ * to detect. In the latter case it doesn't even *fail* reliably, so
+ * probing for it doesn't even work. Disable it completely on 32-bit
+ * unless we can find a reliable way to detect all the broken cases.
+ * Enable it explicitly on 64-bit for non-constant inputs of cpu_has().
+ */
+static void detect_nopl(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_X86_32
+	clear_cpu_cap(c, X86_FEATURE_NOPL);
+#else
+	set_cpu_cap(c, X86_FEATURE_NOPL);
+#endif
+}
+
 /*
  * Do minimum CPU detection early.
  * Fields really needed: vendor, cpuid_level, family, model, mask,
@@ -1089,6 +1107,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	 */
 	if (!pgtable_l5_enabled())
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
+
+	detect_nopl(c);
 }
 
 void __init early_cpu_init(void)
@@ -1124,24 +1144,6 @@ void __init early_cpu_init(void)
 	early_identify_cpu(&boot_cpu_data);
 }
 
-/*
- * The NOPL instruction is supposed to exist on all CPUs of family >= 6;
- * unfortunately, that's not true in practice because of early VIA
- * chips and (more importantly) broken virtualizers that are not easy
- * to detect. In the latter case it doesn't even *fail* reliably, so
- * probing for it doesn't even work. Disable it completely on 32-bit
- * unless we can find a reliable way to detect all the broken cases.
- * Enable it explicitly on 64-bit for non-constant inputs of cpu_has().
- */
-static void detect_nopl(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_X86_32
-	clear_cpu_cap(c, X86_FEATURE_NOPL);
-#else
-	set_cpu_cap(c, X86_FEATURE_NOPL);
-#endif
-}
-
 static void detect_null_seg_behavior(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 2f86d883dd95..403b2d2c31d2 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -866,6 +866,8 @@ void __init setup_arch(char **cmdline_p)
 
 	idt_setup_early_traps();
 	early_cpu_init();
+	arch_init_ideal_nops();
+	jump_label_init();
 	early_ioremap_init();
 
 	setup_olpc_ofw_pgd();
@@ -1272,8 +1274,6 @@ void __init setup_arch(char **cmdline_p)
 
 	mcheck_init();
 
-	arch_init_ideal_nops();
-
 	register_refined_jiffies(CLOCK_TICK_RATE);
 
 #ifdef CONFIG_EFI
-- 
2.18.0

