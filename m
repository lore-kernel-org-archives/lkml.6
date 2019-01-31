Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A23DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326E921916
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NHfrC9Gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbfAaLaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:30:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40126 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfAaL37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:29:59 -0500
Received: from zn.tnic (p200300EC2BCC59000D578CD19F54A2D7.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:5900:d57:8cd1:9f54:a2d7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D60D21EC027A;
        Thu, 31 Jan 2019 12:29:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548934198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pvDZBEHQP9vEk/hY31YWkOL84S0x4lR9x18fyrSrNy8=;
        b=NHfrC9Gx67nJi72GBFrjjsajVk7iywdi9/1xXraMGshYnbZwj/M+fXSJuZxh3AnaO9YLSJ
        PmdofcbVTIUGyqKBzoG590SOH3jmmyXkVl6AmHHrBD/62Ycau58bTvK1OAIXACqc1j0u1c
        urCYlYRfeLIgCEq6K6EWd3pXc+F34vs=
Date:   Thu, 31 Jan 2019 12:29:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v2 03/20] x86/mm: temporary mm struct
Message-ID: <20190131112948.GE6749@zn.tnic>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-4-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190129003422.9328-4-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v2 03/20] x86/mm: temporary mm struct

Subject needs a verb: "Add a temporary... "

On Mon, Jan 28, 2019 at 04:34:05PM -0800, Rick Edgecombe wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> Sometimes we want to set a temporary page-table entries (PTEs) in one of

s/a //

Also, drop the "we" and make it impartial and passive:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

> the cores, without allowing other cores to use - even speculatively -
> these mappings. There are two benefits for doing so:
> 
> (1) Security: if sensitive PTEs are set, temporary mm prevents their use
> in other cores. This hardens the security as it prevents exploding a

exploding or exploiting? Or exposing? :)

> dangling pointer to overwrite sensitive data using the sensitive PTE.
> 
> (2) Avoiding TLB shootdowns: the PTEs do not need to be flushed in
> remote page-tables.

Those belong in the code comments below, explaining what it is going to
be used for.

> To do so a temporary mm_struct can be used. Mappings which are private
> for this mm can be set in the userspace part of the address-space.
> During the whole time in which the temporary mm is loaded, interrupts
> must be disabled.
> 
> The first use-case for temporary PTEs, which will follow, is for poking
> the kernel text.
> 
> [ Commit message was written by Nadav ]
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/include/asm/mmu_context.h | 32 ++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index 19d18fae6ec6..cd0c29e494a6 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -356,4 +356,36 @@ static inline unsigned long __get_current_cr3_fast(void)
>  	return cr3;
>  }
>  
> +typedef struct {

Why does it have to be a typedef?

That prev.prev below looks unnecessary, instead of just using prev.

> +	struct mm_struct *prev;

Why "prev"?

> +} temporary_mm_state_t;

That's kinda long - it is longer than the function name below.
temp_mm_state_t not enough?

> +
> +/*
> + * Using a temporary mm allows to set temporary mappings that are not accessible
> + * by other cores. Such mappings are needed to perform sensitive memory writes
> + * that override the kernel memory protections (e.g., W^X), without exposing the
> + * temporary page-table mappings that are required for these write operations to
> + * other cores.
> + *
> + * Context: The temporary mm needs to be used exclusively by a single core. To
> + *          harden security IRQs must be disabled while the temporary mm is
			      ^
			      ,

> + *          loaded, thereby preventing interrupt handler bugs from override the

s/override/overriding/

> + *          kernel memory protection.
> + */
> +static inline temporary_mm_state_t use_temporary_mm(struct mm_struct *mm)
> +{
> +	temporary_mm_state_t state;
> +
> +	lockdep_assert_irqs_disabled();
> +	state.prev = this_cpu_read(cpu_tlbstate.loaded_mm);
> +	switch_mm_irqs_off(NULL, mm, current);
> +	return state;
> +}
> +
> +static inline void unuse_temporary_mm(temporary_mm_state_t prev)
> +{
> +	lockdep_assert_irqs_disabled();
> +	switch_mm_irqs_off(NULL, prev.prev, current);
> +}
> +
>  #endif /* _ASM_X86_MMU_CONTEXT_H */
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
