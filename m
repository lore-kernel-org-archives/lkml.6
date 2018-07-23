Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59C8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F63520856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F63520856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbeGWObM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:31:12 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:52028 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388087AbeGWO3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:29:35 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-01 (Coremail) with SMTP id qwCowAD3_5sl1lVbkm7cEA--.63S11;
        Mon, 23 Jul 2018 21:21:25 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com,
        mingo@redhat.com, hpa@zytor.com, peterz@infradead.org,
        tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net,
        lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org,
        trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2 09/17] x86/bugs: add lfence mitigation to spectre v2 and no meltdown for Hygon
Date:   Mon, 23 Jul 2018 21:20:29 +0800
Message-Id: <1532352037-7151-10-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
X-CM-TRANSID: qwCowAD3_5sl1lVbkm7cEA--.63S11
X-Coremail-Antispam: 1UD129KBjvJXoW3WrW7AF18uF1UAw1xCrW7urg_yoW7XFW5pF
        yIqFW8JryfAwsay34kXF98XFWrZr1kJ3W7uryUur98ZayFyry8WF1Sqr4xXF98Aa1fWr40
        qFn8XFs5GF10q37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4UJVWx
        Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2
        IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU5hX
        o3UUUUU==
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To share codes between AMD and Hygon to mitigate Spectre V2 Retpoline
vulnerability, rename macros SPECTRE_V2_RETPOLINE_MINIMAL_AMD to
SPECTRE_V2_RETPOLINE_MINIMAL_LFENCE, and SPECTRE_V2_CMD_RETPOLINE_AMD
to SPECTRE_V2_CMD_RETPOLINE_LFENCE.

As Hygon processors is not affected by meltdown vulnerability as AMD's,
so add exception in array cpu_no_meltdown[] for it.

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
index 5c0ea39..5d0ba61 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -121,15 +121,15 @@ enum spectre_v2_mitigation_cmd {
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
@@ -260,7 +260,7 @@ static const struct {
 	{ "off",               SPECTRE_V2_CMD_NONE,              false },
 	{ "on",                SPECTRE_V2_CMD_FORCE,             true },
 	{ "retpoline",         SPECTRE_V2_CMD_RETPOLINE,         false },
-	{ "retpoline,amd",     SPECTRE_V2_CMD_RETPOLINE_AMD,     false },
+	{ "retpoline,lfence",     SPECTRE_V2_CMD_RETPOLINE_LFENCE,     false },
 	{ "retpoline,generic", SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
 	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
 };
@@ -292,16 +292,17 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
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
+		pr_err("retpoline,amd selected but CPU is not AMD or Hygon. Switching to AUTO select\n");
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
@@ -352,9 +353,9 @@ static void __init spectre_v2_select_mitigation(void)
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
@@ -369,14 +370,15 @@ static void __init spectre_v2_select_mitigation(void)
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
index eb4cb3e..06b3168 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -968,6 +968,7 @@ static const __initconst struct x86_cpu_id cpu_no_speculation[] = {
 
 static const __initconst struct x86_cpu_id cpu_no_meltdown[] = {
 	{ X86_VENDOR_AMD },
+	{ X86_VENDOR_HYGON },
 	{}
 };
 
-- 
2.7.4

