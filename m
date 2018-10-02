Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B2DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828E5208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828E5208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbeJCAAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:00:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35956 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbeJCAAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:00:19 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FOclop3Z8WOr; Tue,  2 Oct 2018 19:15:52 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC64F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:4f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C38B1EC02D1;
        Tue,  2 Oct 2018 19:15:52 +0200 (CEST)
Date:   Tue, 2 Oct 2018 19:15:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v4 03/27] x86/fpu/xstate: Enable XSAVES system states
Message-ID: <20181002171554.GE29601@zn.tnic>
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
 <20180921150351.20898-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180921150351.20898-4-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 08:03:27AM -0700, Yu-cheng Yu wrote:
> XSAVES saves both system and user states.  The Linux kernel
> currently does not save/restore any system states.  This patch
> creates the framework for supporting system states.

... and needs a lot more text explaining *why* it is doing that.

> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/fpu/internal.h |   3 +-
>  arch/x86/include/asm/fpu/xstate.h   |   9 ++-
>  arch/x86/kernel/fpu/core.c          |   7 +-
>  arch/x86/kernel/fpu/init.c          |  10 ---
>  arch/x86/kernel/fpu/xstate.c        | 112 +++++++++++++++++-----------
>  5 files changed, 80 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index f1f9bf91a0ab..1f447865db3a 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -45,7 +45,6 @@ extern void fpu__init_cpu_xstate(void);
>  extern void fpu__init_system(struct cpuinfo_x86 *c);
>  extern void fpu__init_check_bugs(void);
>  extern void fpu__resume_cpu(void);
> -extern u64 fpu__get_supported_xfeatures_mask(void);
>  
>  /*
>   * Debugging facility:
> @@ -94,7 +93,7 @@ static inline void fpstate_init_xstate(struct xregs_state *xsave)
>  	 * trigger #GP:
>  	 */
>  	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT |
> -			xfeatures_mask_user;
> +			xfeatures_mask_all;
>  }
>  
>  static inline void fpstate_init_fxstate(struct fxregs_state *fx)
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index 9b382e5157ed..a32dc5f8c963 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -19,10 +19,10 @@
>  #define XSAVE_YMM_SIZE	    256
>  #define XSAVE_YMM_OFFSET    (XSAVE_HDR_SIZE + XSAVE_HDR_OFFSET)
>  
> -/* System features */
> -#define XFEATURE_MASK_SYSTEM (XFEATURE_MASK_PT)

Previous patch renames it, this patch deletes it. Why do we need all
that unnecessary churn?

Also, this patch is trying to do a couple of things at once and
reviewing it is not trivial. Please split the changes logically.

> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 19f8df54c72a..dd2c561c4544 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -51,13 +51,16 @@ static short xsave_cpuid_features[] __initdata = {
>  };
>  
>  /*
> - * Mask of xstate features supported by the CPU and the kernel:
> + * Mask of xstate features supported by the CPU and the kernel.
> + * This is the result from CPUID query, SUPPORTED_XFEATURES_MASK,
> + * and boot_cpu_has().
>   */

This needs to explain what both masks are - user and system. "CPU" and
"kernel" is not "user" and "all".

>  u64 xfeatures_mask_user __read_mostly;
> +u64 xfeatures_mask_all __read_mostly;



> @@ -219,30 +222,31 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
>   */
>  void fpu__init_cpu_xstate(void)
>  {
> -	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask_user)
> +	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask_all)
>  		return;
> +
> +	cr4_set_bits(X86_CR4_OSXSAVE);
> +
>  	/*
> -	 * Make it clear that XSAVES system states are not yet
> -	 * implemented should anyone expect it to work by changing
> -	 * bits in XFEATURE_MASK_* macros and XCR0.
> +	 * XCR_XFEATURE_ENABLED_MASK sets the features that are managed
> +	 * by XSAVE{C, OPT} and XRSTOR.  Only XSAVE user states can be
> +	 * set here.
>  	 */
> -	WARN_ONCE((xfeatures_mask_user & XFEATURE_MASK_SYSTEM),
> -		"x86/fpu: XSAVES system states are not yet implemented.\n");
> +	xsetbv(XCR_XFEATURE_ENABLED_MASK,
> +	       xfeatures_mask_user);

No need to break the line here.

Also, you have a couple more places in your patches where you
unnecessarily break lines. Please don't do that, even if it exceeds 80
cols by a couple of chars.

>  
> -	xfeatures_mask_user &= ~XFEATURE_MASK_SYSTEM;
> -
> -	cr4_set_bits(X86_CR4_OSXSAVE);
> -	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user);
> +	/*
> +	 * MSR_IA32_XSS sets which XSAVES system states to be managed by
> +	 * XSAVES.  Only XSAVES system states can be set here.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_XSAVES))
> +		wrmsrl(MSR_IA32_XSS,
> +		       xfeatures_mask_all & ~xfeatures_mask_user);

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
