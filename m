Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6879BC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1732086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ho//sV6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1732086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeLLAF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:05:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60798 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbeLLAF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:05:26 -0500
Received: from zn.tnic (p200300EC2BCD2B002DC08A63FFF8C6E5.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:2dc0:8a63:fff8:c6e5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 563981EC09F7;
        Wed, 12 Dec 2018 01:05:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544573125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gqPOJX+Rt6zLjB70ObQSCS9/UCYrIp6DPpfaM5Hq2ho=;
        b=Ho//sV6kasPUtxT5gFHArPRu5XNZqI6taon4/422gPpwepETa6Ajk3H68sOzYsb4d1lvvk
        zO+E88u7ua5ceqBqJeTNPhLK1kEQdcYgEtvLFm3aj719/b0lq161+Xiz9vcVrNgU8BsCQZ
        ljn07HBruFpu0SeJEe5enJVQeCZUShQ=
Date:   Wed, 12 Dec 2018 01:05:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2] x86/speculation: Add support for STIBP always-on
 preferred mode
Message-ID: <20181212000518.GX27375@zn.tnic>
References: <20181211224615.5373.65736.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181211224615.5373.65736.stgit@tlendack-t1.amdoffice.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:46:16PM +0000, Lendacky, Thomas wrote:
> Different AMD processors may have different implementations of STIBP.
> When STIBP is conditionally enabled, some implementations would benefit
> from having STIBP always on instead of toggling the STIBP bit through MSR
> writes. This preference is advertised through a CPUID feature bit.
> 
> When conditional STIBP support is requested at boot and the CPU advertises
> STIBP always-on mode as preferred, switch to STIBP "on" support. Print a
> message to let the user know this occurred. Also, provide a boolean that
> be used in stibp_state() to return a message tailored to the always-on
> support.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
> 
> This patch is against the x86/pti branch of the tip tree:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/pti
> 
> Changes from v1:
> - Removed explicit SPECTRE_V2_USER_STRICT_PREFERRED mode
> - Added a message when switching to always-on mode
> - Set and used a static boolean for the string in stibp_state()
> 
>  arch/x86/include/asm/cpufeatures.h |    1 +
>  arch/x86/kernel/cpu/bugs.c         |   17 ++++++++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 28c4a50..df8e94e2 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -284,6 +284,7 @@
>  #define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
>  #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
>  #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
> +#define X86_FEATURE_AMD_STIBP_ALWAYS_ON	(13*32+17) /* "" Single Thread Indirect Branch Predictors always-on preferred */
>  #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
>  #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
>  #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 58689ac..db156e1 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -61,6 +61,8 @@
>  /* Control unconditional IBPB in switch_mm() */
>  DEFINE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
>  
> +static bool stibp_always_on;
> +
>  void __init check_bugs(void)
>  {
>  	identify_boot_cpu();
> @@ -355,6 +357,18 @@ static void __init spec_v2_user_print_cond(const char *reason, bool secure)
>  		break;
>  	}
>  
> +	/*
> +	 * At this point, an STIBP mode other than "off" has been set.
> +	 * If STIBP support is not being forced, check if STIBP always-on
> +	 * is preferred.
> +	 */
> +	if (mode != SPECTRE_V2_USER_STRICT &&
> +	    boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON)) {
> +		stibp_always_on = true;
> +		mode = SPECTRE_V2_USER_STRICT;
> +		pr_info("mitigation: STIBP always-on is preferred\n");
> +	}
> +
>  	/* Initialize Indirect Branch Prediction Barrier */
>  	if (boot_cpu_has(X86_FEATURE_IBPB)) {
>  		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
> @@ -1088,7 +1102,8 @@ static char *stibp_state(void)
>  	case SPECTRE_V2_USER_NONE:
>  		return ", STIBP: disabled";
>  	case SPECTRE_V2_USER_STRICT:
> -		return ", STIBP: forced";
> +		return stibp_always_on ? ", STIBP: always-on"
> +				       : ", STIBP: forced";

I still don't like that separate stibp_always_on variable when we can do
all the querying just by using mode and X86_FEATURE_AMD_STIBP_ALWAYS_ON.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
