Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E119FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD60320811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PxPYNOM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbeLTQR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:17:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45922 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730483AbeLTQR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:17:28 -0500
Received: from zn.tnic (p200300EC2BCCE3000CA99317B30BD475.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:e300:ca9:9317:b30b:d475])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCB721EC0913;
        Thu, 20 Dec 2018 17:17:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545322647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dhL8U6YzJbW9zeMeF+DGkHC3QDeGYKCpHgjxnDZXm/c=;
        b=PxPYNOM2HRoobC1YQZ7NIeC2DnHWbhbpM/n4tsZM/BvEOE6fTdQfMxI9Unu5Tn+aStGTjl
        ITWAesMXFTH1gpJ6XX0e0h4SOg0aUYtQK14AZBYjqKKk3rhjqLHl8JD6xYBnBcXyW+aBIB
        mLRBgr+UToPX/pufbXMD/8Xu2oPW4K0=
Date:   Thu, 20 Dec 2018 17:17:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <Babu.Moger@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jan H =?utf-8?B?LiBTY2jDtm5oZXJy?= <jschoenh@amazon.de>,
        David Duncan <davdunc@amazon.com>
Subject: Re: [PATCH] x86/intel_rdt: use rdmsr_safe() to workaround AWS host
 issue
Message-ID: <20181220161722.GD31403@zn.tnic>
References: <20181220134046.7916-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181220134046.7916-1-vkuznets@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 02:40:46PM +0100, Vitaly Kuznetsov wrote:
> It was found that AWS x1 instances (Xen-based) lack xen.git commit
> 1f1d183d4900 (x86/HVM: don't give the wrong impression of WRMSR succeeding)
> and because of that the wrmsr_safe() check in cache_alloc_hsw_probe()
> doesn't help: the consequent rdmsr() blows up with
> 
>  unchecked MSR access error: RDMSR from 0xc90 at rIP:
>    0xffffffff88c5bba3 (native_read_msr+0x3/0x30)
> 
> The issue should definitely get fixed on AWS side. We can, however, simply
> workaround this in Linux and live happily after.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kernel/cpu/intel_rdt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
> index 44272b7107ad..0acee6cd07a8 100644
> --- a/arch/x86/kernel/cpu/intel_rdt.c
> +++ b/arch/x86/kernel/cpu/intel_rdt.c
> @@ -213,7 +213,8 @@ static inline void cache_alloc_hsw_probe(void)
>  
>  	if (wrmsr_safe(IA32_L3_CBM_BASE, max_cbm, 0))
>  		return;
> -	rdmsr(IA32_L3_CBM_BASE, l, h);
> +	if (rdmsr_safe(IA32_L3_CBM_BASE, &l, &h))
> +		return;
>  
>  	/* If all the bits were set in MSR, return success */
>  	if (l != max_cbm)
> -- 

Does the below hunk work too?

Reinette, Babu: is there any reason for rdt_init_res_defs() and
check_quirks() to run before get_rdt_resources() which looks at CPUID
bits?

If not, we need to do something like below, for guests.

Thx.

---
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index c3a9dc63edf2..64cb0fb31862 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -969,17 +969,13 @@ static int __init resctrl_late_init(void)
 	struct rdt_resource *r;
 	int state, ret;
 
-	/*
-	 * Initialize functions(or definitions) that are different
-	 * between vendors here.
-	 */
+	if (!get_rdt_resources())
+		return -ENODEV;
+
 	rdt_init_res_defs();
 
 	check_quirks();
 
-	if (!get_rdt_resources())
-		return -ENODEV;
-
 	rdt_init_padding();
 
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,



-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
