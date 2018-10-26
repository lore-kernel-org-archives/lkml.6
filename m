Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBF4C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5CE20665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5CE20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJ0AXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:23:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:31218 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbeJ0AXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:23:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 08:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,428,1534834800"; 
   d="scan'208";a="84404096"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.193])
  by orsmga007.jf.intel.com with ESMTP; 26 Oct 2018 08:46:17 -0700
Date:   Fri, 26 Oct 2018 08:46:17 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Julian Stecklina <jsteckli@amazon.de>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        js@alien8.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] kvm, vmx: move register clearing out of assembly path
Message-ID: <20181026154617.GA23663@linux.intel.com>
References: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
 <558fea0b4df498eefcaea5ae07a089ad9706c1a2.1540369608.git.jsteckli@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <558fea0b4df498eefcaea5ae07a089ad9706c1a2.1540369608.git.jsteckli@amazon.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 10:28:57AM +0200, Julian Stecklina wrote:
> Split the security related register clearing out of the large inline
> assembly VM entry path. This results in two slightly less complicated
> inline assembly statements, where it is clearer what each one does.
> 
> Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
> Reviewed-by: Jan H. Schönherr <jschoenh@amazon.de>
> Reviewed-by: Konrad Jan Miller <kjm@amazon.de>
> ---
>  arch/x86/kvm/vmx.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 93562d5..9225099 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -10797,20 +10797,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  		"mov %%r13, %c[r13](%0) \n\t"
>  		"mov %%r14, %c[r14](%0) \n\t"
>  		"mov %%r15, %c[r15](%0) \n\t"
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
> @@ -10847,6 +10834,26 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  #endif
>  	      );
>  
> +	/* Don't let guest register values survive. */
> +	asm volatile (
> +		""
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
> +		:: "a" (0), "b" (0), "S" (0), "D" (0)

Since clearing the GPRs exists to mitigate speculation junk, I think
we should keep the explicit XOR zeroing instead of deferring to the
compiler.  Explicit XORs will ensure the resulting assembly is the
same regardless of compiler, version, target arch, etc..., whereas the
compiler could theoretically use different zeroing methods[1], e.g. on
my system it generates "mov r32,r32" for EBX, ESI and EDI (loading
from EAX after EAX is zeroed).

And FWIW, I find the original code to be more readable since all GRPs
are zeroed with the same method.


[1] As an aside, I was expecting gcc to generate "xor r32,r32" with
    -mtune=sandybridge as sandybridge can do mov elimination on xors
    that explicitly zero a register but not on generic reg-to-reg mov,
    but I was unable to coerce gcc into using xor.

> +		: "cc"
> +#ifdef CONFIG_X86_64
> +		  , "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"
> +#endif
> +		);
> +
>  	/*
>  	 * We do not use IBRS in the kernel. If this vCPU has used the
>  	 * SPEC_CTRL MSR it may have left it on; save the value and
> -- 
> 2.7.4
> 
