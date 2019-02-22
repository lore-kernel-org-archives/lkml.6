Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3695C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AD720838
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfBVAHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:07:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:16234 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfBVAHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:07:33 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 16:07:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,397,1544515200"; 
   d="scan'208";a="145517897"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga002.fm.intel.com with ESMTP; 21 Feb 2019 16:07:31 -0800
Date:   Thu, 21 Feb 2019 16:07:31 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v3 03/20] x86/mm: Save DRs when loading a temporary mm
Message-ID: <20190222000731.GE7224@linux.intel.com>
References: <20190221234451.17632-1-rick.p.edgecombe@intel.com>
 <20190221234451.17632-4-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221234451.17632-4-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:44:34PM -0800, Rick Edgecombe wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Prevent user watchpoints from mistakenly firing while the temporary mm
> is being used. As the addresses that of the temporary mm might overlap
> those of the user-process, this is necessary to prevent wrong signals
> or worse things from happening.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/include/asm/mmu_context.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index d684b954f3c0..0d6c72ece750 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -13,6 +13,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/paravirt.h>
>  #include <asm/mpx.h>
> +#include <asm/debugreg.h>
>  
>  extern atomic64_t last_mm_ctx_id;
>  
> @@ -358,6 +359,7 @@ static inline unsigned long __get_current_cr3_fast(void)
>  
>  typedef struct {
>  	struct mm_struct *prev;
> +	unsigned short bp_enabled : 1;
>  } temp_mm_state_t;
>  
>  /*
> @@ -380,6 +382,22 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
>  	lockdep_assert_irqs_disabled();
>  	state.prev = this_cpu_read(cpu_tlbstate.loaded_mm);
>  	switch_mm_irqs_off(NULL, mm, current);
> +
> +	/*
> +	 * If breakpoints are enabled, disable them while the temporary mm is
> +	 * used. Userspace might set up watchpoints on addresses that are used
> +	 * in the temporary mm, which would lead to wrong signals being sent or
> +	 * crashes.
> +	 *
> +	 * Note that breakpoints are not disabled selectively, which also causes
> +	 * kernel breakpoints (e.g., perf's) to be disabled. This might be
> +	 * undesirable, but still seems reasonable as the code that runs in the
> +	 * temporary mm should be short.
> +	 */
> +	state.bp_enabled = hw_breakpoint_active();

Pretty sure caching hw_breakpoint_active() is unnecessary.  It queries a
per-cpu value, not hardware's DR7 register, and that same value is
consumed by hw_breakpoint_restore().  No idea if breakpoints can be
disabled while using a temp mm, but even if that can happen, there's no
need to restore breakpoints if they've all been disabled, i.e. if
hw_breakpoint_active() returns false in unuse_temporary_mm().

> +	if (state.bp_enabled)
> +		hw_breakpoint_disable();
> +
>  	return state;
>  }
>  
> @@ -387,6 +405,13 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev)
>  {
>  	lockdep_assert_irqs_disabled();
>  	switch_mm_irqs_off(NULL, prev.prev, current);
> +
> +	/*
> +	 * Restore the breakpoints if they were disabled before the temporary mm
> +	 * was loaded.
> +	 */
> +	if (prev.bp_enabled)
> +		hw_breakpoint_restore();
>  }
>  
>  #endif /* _ASM_X86_MMU_CONTEXT_H */
> -- 
> 2.17.1
> 
