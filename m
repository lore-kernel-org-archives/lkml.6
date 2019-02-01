Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC065C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F89820B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfBAFax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:30:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:44928 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfBAFax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:30:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 21:30:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,547,1539673200"; 
   d="scan'208";a="123071861"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga003.jf.intel.com with ESMTP; 31 Jan 2019 21:30:50 -0800
Subject: Re: [PATCH v8 1/3] x86/fpu: track AVX-512 usage of tasks
To:     Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <20190117183822.31333-1-aubrey.li@intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <53e48662-b865-fef8-3666-c26c0b8fa280@linux.intel.com>
Date:   Fri, 1 Feb 2019 13:30:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20190117183822.31333-1-aubrey.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Just a soft reminder in case you didn't get a chance to look at this version.

To address your concern about jiffies_64 on 32bit kernel, I use jiffies here
instead. And to address jiffies wrap around issue, I use the trick from kernel
micro time_before/after, that is, as long as the time difference <= LONG_MAX
(num of jiffies), no wrap around issue. And if time difference > LONG_MAX, 
then capped to LONG_MAX (24 days if HZ=1000). This should be long enough to 
determine how to schedule the tasks.

If this is not acceptable, I'll try to limit this feature on 64bit kernel.
Looking forward to your response.

Thanks,
-Aubrey

On 2019/1/18 2:38, Aubrey Li wrote:
> User space tools which do automated task placement need information
> about AVX-512 usage of tasks, because AVX-512 usage could cause core
> turbo frequency drop and impact the running task on the sibling CPU.
> 
> The XSAVE hardware structure has bits that indicate when valid state
> is present in registers unique to AVX-512 use.  Use these bits to
> indicate when AVX-512 has been in use and add per-task AVX-512 state
> timestamp tracking to context switch.
> 
> Well-written AVX-512 applications are expected to clear the AVX-512
> state when not actively using AVX-512 registers, so the tracking
> mechanism is imprecise and can theoretically miss AVX-512 usage during
> context switch. But it has been measured to be precise enough to be
> useful under real-world workloads like tensorflow and linpack.
> 
> If higher precision is required, suggest user space tools to use the
> PMU-based mechanisms in combination.
> 
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  arch/x86/include/asm/fpu/internal.h | 7 +++++++
>  arch/x86/include/asm/fpu/types.h    | 7 +++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 69dcdf195b61..c74f7b5f6886 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -411,6 +411,13 @@ static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
>  {
>  	if (likely(use_xsave())) {
>  		copy_xregs_to_kernel(&fpu->state.xsave);
> +
> +		/*
> +		 * AVX512 state is tracked here because its use is
> +		 * known to slow the max clock speed of the core.
> +		 */
> +		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
> +			fpu->avx512_timestamp = jiffies;
>  		return 1;
>  	}
>  
> diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
> index 202c53918ecf..2e32e178e064 100644
> --- a/arch/x86/include/asm/fpu/types.h
> +++ b/arch/x86/include/asm/fpu/types.h
> @@ -302,6 +302,13 @@ struct fpu {
>  	 */
>  	unsigned char			initialized;
>  
> +	/*
> +	 * @avx512_timestamp:
> +	 *
> +	 * Records the timestamp of AVX512 use during last context switch.
> +	 */
> +	unsigned long			avx512_timestamp;
> +
>  	/*
>  	 * @state:
>  	 *
> 

