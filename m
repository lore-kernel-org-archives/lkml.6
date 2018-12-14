Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D584C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E57F206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Owk5wntK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbeLNUud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:50:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33900 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730822AbeLNUud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:50:33 -0500
Received: from zn.tnic (p200300EC2BCFEF006DA1B19390C695FF.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:ef00:6da1:b193:90c6:95ff])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C9AAF1EC0BE1;
        Fri, 14 Dec 2018 21:50:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544820632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sLnbk5UGQnKmWHIISghc80ciweUo0kju6QHbwoEfotE=;
        b=Owk5wntK+DA3ithE9IyYxxSU8kXE6ZvsoXkKZ+dROF9BAB2mIXXOq2JDq28LjALzamCTFv
        l5W4BFDykfiGJ8euDFFLR6e10Za/O6tHqBusryU8pMOE87N7Q1+gKdknUBUjMIRfIyeBOF
        by6M1WHKJXvLzvwacypDMd0Wle5fQeE=
Date:   Fri, 14 Dec 2018 21:50:23 +0100
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
Subject: Re: [PATCH v3] x86/speculation: Add support for STIBP always-on
 preferred mode
Message-ID: <20181214205023.GJ11710@zn.tnic>
References: <20181213230352.6937.74943.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181213230352.6937.74943.stgit@tlendack-t1.amdoffice.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 11:03:54PM +0000, Lendacky, Thomas wrote:
> Different AMD processors may have different implementations of STIBP.
> When STIBP is conditionally enabled, some implementations would benefit
> from having STIBP always on instead of toggling the STIBP bit through MSR
> writes. This preference is advertised through a CPUID feature bit.
> 
> When conditional STIBP support is requested at boot and the CPU advertises
> STIBP always-on mode as preferred, switch to STIBP "on" support. To show
> that this transition has occurred, create a new spectre_v2_user_mitigation
> value and a new spectre_v2_user_strings message. The new mitigation value
> is used in spectre_v2_user_select_mitigation() to print the new mitigation
> message as well as to return a new string from stibp_state().
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
> 
> This patch is against the x86/pti branch of the tip tree:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/pti
> 
> Changes from v2:
> - Reverted back to original version of the patch
> - Updated the messages that are issued. I'm not terribly happy with the
>   wording, so if there are any suggestions...
> 
> Changes from v1:
> - Removed explicit SPECTRE_V2_USER_STRICT_PREFERRED mode
> - Added a message when switching to always-on mode
> - Set and used a static boolean for the string in stibp_state()
> 
>  arch/x86/include/asm/cpufeatures.h   |    1 +
>  arch/x86/include/asm/nospec-branch.h |    1 +
>  arch/x86/kernel/cpu/bugs.c           |   28 ++++++++++++++++++++++------
>  3 files changed, 24 insertions(+), 6 deletions(-)
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
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 032b600..dad12b7 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -232,6 +232,7 @@ enum spectre_v2_mitigation {
>  enum spectre_v2_user_mitigation {
>  	SPECTRE_V2_USER_NONE,
>  	SPECTRE_V2_USER_STRICT,
> +	SPECTRE_V2_USER_STRICT_PREFERRED,
>  	SPECTRE_V2_USER_PRCTL,
>  	SPECTRE_V2_USER_SECCOMP,
>  };
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 58689ac..77bf225 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -262,10 +262,11 @@ enum spectre_v2_user_cmd {
>  };
>  
>  static const char * const spectre_v2_user_strings[] = {
> -	[SPECTRE_V2_USER_NONE]		= "User space: Vulnerable",
> -	[SPECTRE_V2_USER_STRICT]	= "User space: Mitigation: STIBP protection",
> -	[SPECTRE_V2_USER_PRCTL]		= "User space: Mitigation: STIBP via prctl",
> -	[SPECTRE_V2_USER_SECCOMP]	= "User space: Mitigation: STIBP via seccomp and prctl",
> +	[SPECTRE_V2_USER_NONE]			= "User space: Vulnerable",
> +	[SPECTRE_V2_USER_STRICT]		= "User space: Mitigation: STIBP protection",
> +	[SPECTRE_V2_USER_STRICT_PREFERRED]	= "User space: Mitigation: STIBP always-on protection",

Barring the "preferred" vs "always-on" bikeshed controversy :-P, I don't
see anything wrong with this version.

The only thing that could be improved maybe is having the mode name
and the user visible string match for ease of code staring during bug
hunting...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
