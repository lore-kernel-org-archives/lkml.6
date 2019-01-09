Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA7BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74BC206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NoPZixy+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfAIVLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:11:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34280 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfAIVLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:11:20 -0500
Received: from zn.tnic (p200300EC2BEA10006802B5941DDA3DDE.dip0.t-ipconnect.de [IPv6:2003:ec:2bea:1000:6802:b594:1dda:3dde])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 224F31EC0432;
        Wed,  9 Jan 2019 22:11:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547068278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EmBMA6GO+6Uc8NSnev8KQ6avqe9/TIz0RFFXmES3pPA=;
        b=NoPZixy+X72CO1FsDBO6iq+W9n5NbaYOM6jhz+MWpZbpFXNC+hXqL4we7ENh3FL+FBCJje
        R91phJIiFrZFSAxAcA8AZE9GrDyJFE8U2bWJYuHZcXlgnIlHwjfPpkf1+pLNZDwc0pA7o3
        2zIdvPsgDLV46ZTVQhqHpPSd2VGBw44=
Date:   Wed, 9 Jan 2019 22:11:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jikos@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: General protection fault in `switch_mm_irqs_off()`
Message-ID: <20190109211104.GG15665@zn.tnic>
References: <784ab00e-ed72-c1bc-bc0c-31264deb7726@molgen.mpg.de>
 <alpine.LRH.2.00.1901041737290.28043@gjva.wvxbf.pm>
 <cb7ba667-562b-1e4c-f16e-7c11804bc98a@molgen.mpg.de>
 <alpine.DEB.2.21.1901091410500.1755@nanos.tec.linutronix.de>
 <5c38f377-f088-5684-91a5-c2cc2d64dbbd@molgen.mpg.de>
 <ea49acb9-8165-80a3-e6fe-b29123ad5795@amd.com>
 <206f4322-c15e-6f0b-733d-fd19cd9c24a7@molgen.mpg.de>
 <98ed83c0-3077-848b-9de4-add70e9b417a@amd.com>
 <9bca3e26-1dfc-6e86-cf28-90cadd983ff4@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9bca3e26-1dfc-6e86-cf28-90cadd983ff4@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 05:34:11PM +0100, Paul Menzel wrote:
> Is there a way to trace the value of `boot_cpu_data` from
> `arch/x86/include/asm/cpufeature.h` with some Linux Kernel magic?
> 
>     #define boot_cpu_has(bit)       cpu_has(&boot_cpu_data, bit)
> 
> Or is rebuilding with print statements the only solution?

Yes. Just apply this and catch output. It is a wild guess anyway as
this whole deal looks really strange but at least it should not #GP the
machine.

---
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index dad12b767ba0..ec4688779900 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -284,6 +284,9 @@ static inline void indirect_branch_prediction_barrier(void)
 {
 	u64 val = PRED_CMD_IBPB;
 
+	if (WARN_ON(boot_cpu_has(X86_FEATURE_USE_IBPB)))
+		return;
+
 	alternative_msr_write(MSR_IA32_PRED_CMD, val, X86_FEATURE_USE_IBPB);
 }
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1de0f4170178..4ed4cc99a2c0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -371,6 +371,8 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
 
+		pr_err("%s: set X86_FEATURE_USE_IBPB\n", __func__);
+
 		switch (cmd) {
 		case SPECTRE_V2_USER_CMD_FORCE:
 		case SPECTRE_V2_USER_CMD_PRCTL_IBPB:

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
