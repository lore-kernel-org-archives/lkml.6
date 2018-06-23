Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05539C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 09:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB6624B79
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 09:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB6624B79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbeFWJQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 05:16:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34154 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751766AbeFWJQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 05:16:54 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iJ2hPOTzVLit; Sat, 23 Jun 2018 11:16:53 +0200 (CEST)
Received: from zn.tnic (p200300EC2BDC2300329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bdc:2300:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9BCC1EC0346;
        Sat, 23 Jun 2018 11:16:52 +0200 (CEST)
Date:   Sat, 23 Jun 2018 11:16:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v12 02/11] x86: initialize static branching early
Message-ID: <20180623091648.GA29468@zn.tnic>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-3-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180621212518.19914-3-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 05:25:09PM -0400, Pavel Tatashin wrote:
> static branching is useful to hot-patch branches that are used in hot
> path, but are infrequently changed.
> 
> x86 clock framework is one example that uses static branches to setup
> the best clock during boot and never change it again.
> 
> Since we plan to enable clock early, we need static branching
> functionality early as well.
> 
> static branching requires patching nop instructions, thus, we need
> arch_init_ideal_nops() to be called prior to jump_label_init()
> 
> Here we do all the necessary steps to call arch_init_ideal_nops
> after early_cpu_init().
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> ---
>  arch/x86/kernel/cpu/amd.c    | 13 +++++++-----
>  arch/x86/kernel/cpu/common.c | 38 +++++++++++++++++++-----------------
>  arch/x86/kernel/setup.c      |  4 ++--
>  3 files changed, 30 insertions(+), 25 deletions(-)

Looks ok to me.

Reviewed-by: Borislav Petkov <bp@suse.de>

Also, please take the patch below into your queue and keep it a separate
patch in case we have to revert it later. It should help in keeping the
mess manageable and not let it go completely out of control before we've
done the cleanup.

Thx.

---
From: Borislav Petkov <bp@suse.de>
Date: Sat, 23 Jun 2018 11:04:47 +0200
Subject: [PATCH] x86/CPU: Call detect_nopl() only on the BSP

Make it use the setup_* variants and have it be called only on the BSP
and drop the call in generic_identify() - X86_FEATURE_NOPL will be
replicated to the APs through the forced caps. Helps keep the mess at a
manageable level.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/common.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 952d31f75821..1b5edbd8f6db 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1021,12 +1021,12 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
  * unless we can find a reliable way to detect all the broken cases.
  * Enable it explicitly on 64-bit for non-constant inputs of cpu_has().
  */
-static void detect_nopl(struct cpuinfo_x86 *c)
+static void detect_nopl(void)
 {
 #ifdef CONFIG_X86_32
-	clear_cpu_cap(c, X86_FEATURE_NOPL);
+	setup_clear_cpu_cap(X86_FEATURE_NOPL);
 #else
-	set_cpu_cap(c, X86_FEATURE_NOPL);
+	setup_force_cpu_cap(X86_FEATURE_NOPL);
 #endif
 }
 
@@ -1105,7 +1105,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	if (!pgtable_l5_enabled())
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
 
-	detect_nopl(c);
+	detect_nopl();
 }
 
 void __init early_cpu_init(void)
@@ -1203,8 +1203,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
 
 	get_model_name(c); /* Default name */
 
-	detect_nopl(c);
-
 	detect_null_seg_behavior(c);
 
 	/*
-- 
2.17.0.582.gccdcbd54c

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
