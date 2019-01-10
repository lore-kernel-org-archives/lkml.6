Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9793CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8A7206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="cXpL/EkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfAJQBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:01:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49928 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfAJQBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:01:04 -0500
Received: from zn.tnic (p200300EC2BC5CF00BC5292658C5BA6FB.dip0.t-ipconnect.de [IPv6:2003:ec:2bc5:cf00:bc52:9265:8c5b:a6fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB1221EC03DB;
        Thu, 10 Jan 2019 17:01:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547136062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+BCZTtPzyPQ67B6tIP7ZdBnKfXjJSILMm5Flh7Hs7Nk=;
        b=cXpL/EkL3U5EWmWQMTXCLVaCWoK8DprSK+KDpbkExxAu7AWoDuxqMqVvhUkKzU2i0YNoiD
        GtSbHdOXlfYHzCDEmdYm5Y6OKWyg4rCgd8lSTb19RApA8rLupr57aAeSKPTed9PWYTJaGm
        Dsx4fmyv/McKhM0A9kJUdJdP+fZuafk=
Date:   Thu, 10 Jan 2019 17:00:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jikos@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: General protection fault in `switch_mm_irqs_off()`
Message-ID: <20190110160054.GD17621@zn.tnic>
References: <alpine.LRH.2.00.1901041737290.28043@gjva.wvxbf.pm>
 <cb7ba667-562b-1e4c-f16e-7c11804bc98a@molgen.mpg.de>
 <alpine.DEB.2.21.1901091410500.1755@nanos.tec.linutronix.de>
 <5c38f377-f088-5684-91a5-c2cc2d64dbbd@molgen.mpg.de>
 <ea49acb9-8165-80a3-e6fe-b29123ad5795@amd.com>
 <206f4322-c15e-6f0b-733d-fd19cd9c24a7@molgen.mpg.de>
 <98ed83c0-3077-848b-9de4-add70e9b417a@amd.com>
 <9bca3e26-1dfc-6e86-cf28-90cadd983ff4@molgen.mpg.de>
 <20190109211104.GG15665@zn.tnic>
 <9bbcbaa7-b164-fcef-0588-7c5f25aa2440@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bbcbaa7-b164-fcef-0588-7c5f25aa2440@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 02:57:40PM +0100, Paul Menzel wrote:
> Thank you very much. Indeed, the machine does not crash. I used Linus’
> master branch for testing, and applied your patch on top. Please find
> the full log attached.

> 80.649: [    3.197107] Spectre V2 : spectre_v2_user_select_mitigation: set X86_FEATURE_USE_IBPB

This is amazing.

Ok, next diff, same exercise. Thx.

---
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index dad12b767ba0..528ef8336f5f 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -284,6 +284,12 @@ static inline void indirect_branch_prediction_barrier(void)
 {
 	u64 val = PRED_CMD_IBPB;
 
+	if (WARN_ON(boot_cpu_has(X86_FEATURE_USE_IBPB))) {
+		pr_info("%s: c: %px, array: 0x%x\n",
+			__func__, &boot_cpu_data, boot_cpu_data.x86_capability[7]);
+		return;
+	}
+
 	alternative_msr_write(MSR_IA32_PRED_CMD, val, X86_FEATURE_USE_IBPB);
 }
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 8654b8b0c848..e818e5abe611 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -371,6 +371,9 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
 
+		pr_err("%s: set X86_FEATURE_USE_IBPB, c: %px, array: 0x%x\n",
+			__func__, &boot_cpu_data, boot_cpu_data.x86_capability[7]);
+
 		switch (cmd) {
 		case SPECTRE_V2_USER_CMD_FORCE:
 		case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cb28e98a0659..8566737fa500 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -765,6 +765,9 @@ static void apply_forced_caps(struct cpuinfo_x86 *c)
 		c->x86_capability[i] &= ~cpu_caps_cleared[i];
 		c->x86_capability[i] |= cpu_caps_set[i];
 	}
+
+	if (c == &boot_cpu_data)
+		pr_info("%s: c: %px, array: 0x%x\n", __func__, c, c->x86_capability[7]);
 }
 
 static void init_speculation_control(struct cpuinfo_x86 *c)
@@ -778,6 +781,10 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
 		set_cpu_cap(c, X86_FEATURE_IBRS);
 		set_cpu_cap(c, X86_FEATURE_IBPB);
+
+		pr_info("%s: X86_FEATURE_SPEC_CTRL: c: %px, array: 0x%x, CPUID: 0x%x\n",
+			__func__, c, c->x86_capability[7], cpuid_edx(7));
+
 		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
 	}
 
@@ -793,9 +800,13 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
 		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
 	}
 
-	if (cpu_has(c, X86_FEATURE_AMD_IBPB))
+	if (cpu_has(c, X86_FEATURE_AMD_IBPB)) {
 		set_cpu_cap(c, X86_FEATURE_IBPB);
 
+		pr_info("%s: X86_FEATURE_AMD_IBPB: c: %px, array: 0x%x, CPUID: 0x%x\n",
+			__func__, c, c->x86_capability[7], cpuid_ebx(0x80000008));
+	}
+
 	if (cpu_has(c, X86_FEATURE_AMD_STIBP)) {
 		set_cpu_cap(c, X86_FEATURE_STIBP);
 		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
