Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEE8C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35059204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35059204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeJPAtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:49:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33818 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbeJPAtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:49:39 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WS24LUrsrCtq; Mon, 15 Oct 2018 19:03:33 +0200 (CEST)
Received: from zn.tnic (p200300EC2BDC0500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bdc:500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7CFF91EC02C1;
        Mon, 15 Oct 2018 19:03:33 +0200 (CEST)
Date:   Mon, 15 Oct 2018 19:03:20 +0200
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
        Eugene Syromiatnikov <esyr@redhat.com>,
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
Subject: Re: [PATCH v5 02/27] x86/fpu/xstate: Change names to separate XSAVES
 system and user states
Message-ID: <20181015170320.GF11434@zn.tnic>
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
 <20181011151523.27101-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181011151523.27101-3-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 08:14:58AM -0700, Yu-cheng Yu wrote:
> Control Flow Enforcement (CET) MSRs are XSAVES system/supervisor
> states.  To support CET, we introduce XSAVES system states first.
> 
> XSAVES is a "supervisor" instruction and, comparing to XSAVE, saves
> additional "supervisor" states that can be modified only from CPL 0.
> However, these states are per-task and not kernel's own.  Rename
> "supervisor" states to "system" states to clearly separate them from
> "user" states.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/fpu/internal.h |  4 +-
>  arch/x86/include/asm/fpu/xstate.h   | 20 +++----
>  arch/x86/kernel/fpu/core.c          |  4 +-
>  arch/x86/kernel/fpu/init.c          |  2 +-
>  arch/x86/kernel/fpu/signal.c        |  6 +--
>  arch/x86/kernel/fpu/xstate.c        | 82 ++++++++++++++---------------
>  6 files changed, 57 insertions(+), 61 deletions(-)

...

> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 87a57b7642d3..e7cbaed12ef1 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -51,13 +51,14 @@ static short xsave_cpuid_features[] __initdata = {
>  };
>  
>  /*
> - * Mask of xstate features supported by the CPU and the kernel:
> + * Mask of supported 'user' xstate features derived from boot_cpu_has() and
> + * SUPPORTED_XFEATURES_MASK.

<--- This comment here looks like a good place to put some blurb about
user and system states, what they are, what the distinction is and so
on.

>   */
> -u64 xfeatures_mask __read_mostly;
> +u64 xfeatures_mask_user __read_mostly;
>  
>  static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
>  static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
> -static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask)*8];
> +static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask_user)*8];
>  
>  /*
>   * The XSAVE area of kernel can be in standard or compacted format;
> @@ -82,7 +83,7 @@ void fpu__xstate_clear_all_cpu_caps(void)
>   */
>  int cpu_has_xfeatures(u64 xfeatures_needed, const char **feature_name)
>  {
> -	u64 xfeatures_missing = xfeatures_needed & ~xfeatures_mask;
> +	u64 xfeatures_missing = xfeatures_needed & ~xfeatures_mask_user;
>  
>  	if (unlikely(feature_name)) {
>  		long xfeature_idx, max_idx;
> @@ -113,14 +114,11 @@ int cpu_has_xfeatures(u64 xfeatures_needed, const char **feature_name)
>  }
>  EXPORT_SYMBOL_GPL(cpu_has_xfeatures);
>  
> -static int xfeature_is_supervisor(int xfeature_nr)
> +static int xfeature_is_system(int xfeature_nr)
>  {
>  	/*
> -	 * We currently do not support supervisor states, but if
> -	 * we did, we could find out like this.
> -	 *
>  	 * SDM says: If state component 'i' is a user state component,
> -	 * ECX[0] return 0; if state component i is a supervisor
> +	 * ECX[0] return 0; if state component i is a system

		  is 0

>  	 * state component, ECX[0] returns 1.

				   is 1.

>  	 */
>  	u32 eax, ebx, ecx, edx;

...

> @@ -242,7 +238,7 @@ void fpu__init_cpu_xstate(void)
>   */
>  static int xfeature_enabled(enum xfeature xfeature)
>  {
> -	return !!(xfeatures_mask & (1UL << xfeature));
> +	return !!(xfeatures_mask_user & BIT_ULL(xfeature));
>  }
>  
>  /*
> @@ -272,7 +268,7 @@ static void __init setup_xstate_features(void)
>  		cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
>  
>  		/*
> -		 * If an xfeature is supervisor state, the offset
> +		 * If an xfeature is system state, the offset

				is a system state, ...

>  		 * in EBX is invalid. We leave it to -1.
>  		 */
>  		if (xfeature_is_user(i))

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
