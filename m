Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06328C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B007820836
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B007820836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeHSTZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 15:25:07 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:52969 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726591AbeHSTZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 15:25:07 -0400
Received: from localhost.localdomain (unknown [110.184.154.248])
        by APP-10 (Coremail) with SMTP id tACowACnr8cHl3lb8r2wAg--.189S2;
        Mon, 20 Aug 2018 00:13:00 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Pu Wen <puwen@hygon.cn>
Subject: [PATCH v4 09/16] x86/bugs: add lfence mitigation to spectre v2 and no meltdown for Hygon
Date:   Mon, 20 Aug 2018 00:12:36 +0800
Message-Id: <9f57cc39e904370924438ea8ddea69e5d3f6cbf1.1534599097.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1534599097.git.puwen@hygon.cn>
References: <cover.1534599097.git.puwen@hygon.cn>
X-CM-TRANSID: tACowACnr8cHl3lb8r2wAg--.189S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF45Wr18Ww1kCr17Wr4fAFb_yoW7XFWkpF
        yIqFW8JFyfAwsay34kXF98XFWfZr1kJ3W29ry5ur95Za1Fyry8WF1Sqr4xXF98Aa1fWr40
        qFn8XFs5JF18t37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUva14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE
        14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
        uYvjfU5nmRUUUUU
X-Originating-IP: [110.184.154.248]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To share codes between AMD and Hygon to mitigate Spectre V2 Retpoline
vulnerability, rename macros SPECTRE_V2_RETPOLINE_MINIMAL_AMD to
SPECTRE_V2_RETPOLINE_MINIMAL_LFENCE, and SPECTRE_V2_CMD_RETPOLINE_AMD
to SPECTRE_V2_CMD_RETPOLINE_LFENCE.

As Hygon processors are not affected by meltdown vulnerability as AMD's,
so add exception in array cpu_no_meltdown[] for Hygon.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/include/asm/nospec-branch.h |  4 ++--
 arch/x86/kernel/cpu/bugs.c           | 28 +++++++++++++++-------------
 arch/x86/kernel/cpu/common.c         |  1 +
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index f6f6c63..aad6b9c 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -211,9 +211,9 @@
 enum spectre_v2_mitigation {
 	SPECTRE_V2_NONE,
 	SPECTRE_V2_RETPOLINE_MINIMAL,
-	SPECTRE_V2_RETPOLINE_MINIMAL_AMD,
+	SPECTRE_V2_RETPOLINE_MINIMAL_LFENCE,
 	SPECTRE_V2_RETPOLINE_GENERIC,
-	SPECTRE_V2_RETPOLINE_AMD,
+	SPECTRE_V2_RETPOLINE_LFENCE,
 	SPECTRE_V2_IBRS,
 };
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 664f161..a663a1b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -132,15 +132,15 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_FORCE,
 	SPECTRE_V2_CMD_RETPOLINE,
 	SPECTRE_V2_CMD_RETPOLINE_GENERIC,
-	SPECTRE_V2_CMD_RETPOLINE_AMD,
+	SPECTRE_V2_CMD_RETPOLINE_LFENCE,
 };
 
 static const char *spectre_v2_strings[] = {
 	[SPECTRE_V2_NONE]			= "Vulnerable",
 	[SPECTRE_V2_RETPOLINE_MINIMAL]		= "Vulnerable: Minimal generic ASM retpoline",
-	[SPECTRE_V2_RETPOLINE_MINIMAL_AMD]	= "Vulnerable: Minimal AMD ASM retpoline",
+	[SPECTRE_V2_RETPOLINE_MINIMAL_LFENCE]	= "Vulnerable: Minimal LFENCE ASM retpoline",
 	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
-	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
+	[SPECTRE_V2_RETPOLINE_LFENCE]		= "Mitigation: Full LFENCE retpoline",
 };
 
 #undef pr_fmt
@@ -271,7 +271,7 @@ static const struct {
 	{ "off",               SPECTRE_V2_CMD_NONE,              false },
 	{ "on",                SPECTRE_V2_CMD_FORCE,             true },
 	{ "retpoline",         SPECTRE_V2_CMD_RETPOLINE,         false },
-	{ "retpoline,amd",     SPECTRE_V2_CMD_RETPOLINE_AMD,     false },
+	{ "retpoline,lfence",     SPECTRE_V2_CMD_RETPOLINE_LFENCE,     false },
 	{ "retpoline,generic", SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
 	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
 };
@@ -303,16 +303,17 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	}
 
 	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
-	     cmd == SPECTRE_V2_CMD_RETPOLINE_AMD ||
+	     cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
 	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC) &&
 	    !IS_ENABLED(CONFIG_RETPOLINE)) {
 		pr_err("%s selected but not compiled in. Switching to AUTO select\n", mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (cmd == SPECTRE_V2_CMD_RETPOLINE_AMD &&
+	if (cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
-		pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
+		pr_err("retpoline,lfence selected but CPU is not AMD or Hygon. Switching to AUTO select\n");
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
@@ -346,9 +347,9 @@ static void __init spectre_v2_select_mitigation(void)
 		if (IS_ENABLED(CONFIG_RETPOLINE))
 			goto retpoline_auto;
 		break;
-	case SPECTRE_V2_CMD_RETPOLINE_AMD:
+	case SPECTRE_V2_CMD_RETPOLINE_LFENCE:
 		if (IS_ENABLED(CONFIG_RETPOLINE))
-			goto retpoline_amd;
+			goto retpoline_lfence;
 		break;
 	case SPECTRE_V2_CMD_RETPOLINE_GENERIC:
 		if (IS_ENABLED(CONFIG_RETPOLINE))
@@ -363,14 +364,15 @@ static void __init spectre_v2_select_mitigation(void)
 	return;
 
 retpoline_auto:
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-	retpoline_amd:
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+	retpoline_lfence:
 		if (!boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
 			pr_err("Spectre mitigation: LFENCE not serializing, switching to generic retpoline\n");
 			goto retpoline_generic;
 		}
-		mode = retp_compiler() ? SPECTRE_V2_RETPOLINE_AMD :
-					 SPECTRE_V2_RETPOLINE_MINIMAL_AMD;
+		mode = retp_compiler() ? SPECTRE_V2_RETPOLINE_LFENCE :
+					 SPECTRE_V2_RETPOLINE_MINIMAL_LFENCE;
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE_AMD);
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 	} else {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b41b72b..6c7a2cd 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -962,6 +962,7 @@ static const __initconst struct x86_cpu_id cpu_no_speculation[] = {
 
 static const __initconst struct x86_cpu_id cpu_no_meltdown[] = {
 	{ X86_VENDOR_AMD },
+	{ X86_VENDOR_HYGON },
 	{}
 };
 
-- 
2.7.4

