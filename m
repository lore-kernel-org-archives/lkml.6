Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38861C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5DB2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5DB2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeJ3CPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:15:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:11357 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbeJ3CPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:15:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 10:26:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,441,1534834800"; 
   d="scan'208";a="269744565"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.193])
  by orsmga005.jf.intel.com with ESMTP; 29 Oct 2018 10:26:08 -0700
Date:   Mon, 29 Oct 2018 10:26:08 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Julian Stecklina <jsteckli@amazon.de>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Julian Stecklina <js@alien8.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] kvm, vmx: move register clearing out of assembly
 path
Message-ID: <20181029172608.GB27762@linux.intel.com>
References: <74fa3809ea293cc05d37b1449b16e08480c4ddbd.1540822350.git.jsteckli@amazon.de>
 <33085f6c98496ed8094ce68855b49851abb86406.1540822350.git.jsteckli@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33085f6c98496ed8094ce68855b49851abb86406.1540822350.git.jsteckli@amazon.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 04:40:43PM +0100, Julian Stecklina wrote:
> Split the security related register clearing out of the large inline
> assembly VM entry path. This results in two slightly less complicated
> inline assembly statements, where it is clearer what each one does.
> 
> Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
> Reviewed-by: Jan H. Schönherr <jschoenh@amazon.de>
> Reviewed-by: Konrad Jan Miller <kjm@amazon.de>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/vmx.c | 45 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index a6e5a5c..29a2ee7 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -11281,24 +11281,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  		"mov %%r13, %c[r13](%0) \n\t"
>  		"mov %%r14, %c[r14](%0) \n\t"
>  		"mov %%r15, %c[r15](%0) \n\t"
> -		/*
> -		* Clear host registers marked as clobbered to prevent
> -		* speculative use.
> -		*/
> -		"xor %%r8d,  %%r8d \n\t"
> -		"xor %%r9d,  %%r9d \n\t"
> -		"xor %%r10d, %%r10d \n\t"
> -		"xor %%r11d, %%r11d \n\t"
> -		"xor %%r12d, %%r12d \n\t"
> -		"xor %%r13d, %%r13d \n\t"
> -		"xor %%r14d, %%r14d \n\t"
> -		"xor %%r15d, %%r15d \n\t"
>  #endif
> -
> -		"xor %%eax, %%eax \n\t"
> -		"xor %%ebx, %%ebx \n\t"
> -		"xor %%esi, %%esi \n\t"
> -		"xor %%edi, %%edi \n\t"
>  		"pop  %%" _ASM_BP "; pop  %%" _ASM_DX " \n\t"
>  		".pushsection .rodata \n\t"
>  		".global vmx_return \n\t"
> @@ -11336,6 +11319,34 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  	      );
>  
>  	/*
> +	 * Don't let guest register values survive. Registers that cannot
> +	 * contain guest values anymore are not touched.

I think it's a good idea to explicitly call out that clearing the GPRs
is done to prevent speculative use.  Simply stating that we don't want
to let guest register values survive doesn't explain *why*.

What about:

	/*
	 * Explicitly clear (in addition to marking them as clobbered) all GPRs
	 * that have not been loaded with host state to prevent speculatively
	 * using the guest's values.
	 */

> +	 */
> +	asm volatile (
> +		"xor %%eax, %%eax \n\t"
> +		"xor %%ebx, %%ebx \n\t"
> +		"xor %%esi, %%esi \n\t"
> +		"xor %%edi, %%edi \n\t"
> +#ifdef CONFIG_X86_64
> +		"xor %%r8d,  %%r8d \n\t"
> +		"xor %%r9d,  %%r9d \n\t"
> +		"xor %%r10d, %%r10d \n\t"
> +		"xor %%r11d, %%r11d \n\t"
> +		"xor %%r12d, %%r12d \n\t"
> +		"xor %%r13d, %%r13d \n\t"
> +		"xor %%r14d, %%r14d \n\t"
> +		"xor %%r15d, %%r15d \n\t"
> +#endif
> +		::: "cc"
> +#ifdef CONFIG_X86_64
> +		 , "rax", "rbx", "rsi", "rdi"
> +		 , "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"
> +#else
> +		 , "eax", "ebx", "esi", "edi"
> +#endif
> +		);
> +
> +	/*
>  	 * We do not use IBRS in the kernel. If this vCPU has used the
>  	 * SPEC_CTRL MSR it may have left it on; save the value and
>  	 * turn it off. This is much more efficient than blindly adding
> -- 
> 2.7.4
> 
