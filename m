Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92858C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F83A21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F83A21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeJRVtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:49:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34615 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeJRVtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:49:02 -0400
Received: from [213.61.215.195] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gD8eK-00014D-De; Thu, 18 Oct 2018 15:47:40 +0200
Date:   Thu, 18 Oct 2018 15:47:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Patch v3 09/13] x86/speculation: Reorganize SPEC_CTRL MSR
 update
In-Reply-To: <23d8ffaac99be49aa163eb16dd131399141fc432.1539798901.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810181537331.1647@nanos.tec.linutronix.de>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com> <23d8ffaac99be49aa163eb16dd131399141fc432.1539798901.git.tim.c.chen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Tim Chen wrote:

> Reorganize the spculation control MSR update code. Currently it is limited
> to only dynamic update of the Speculative Store Bypass Disable bit.
> This patch consolidates the logic to check for AMD CPUs that may or may

# git grep 'This patch' Documentation/process/

> not use this MSR to control SSBD. This prepares us to add logic to update
> other bits in the SPEC_CTRL MSR cleanly.
> 
> Originally-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  arch/x86/kernel/process.c | 39 +++++++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 8aa4960..789f1bada 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -397,25 +397,45 @@ static __always_inline void amd_set_ssb_virt_state(unsigned long tifn)
>  
>  static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
>  {
> -	u64 msr = x86_spec_ctrl_base | ssbd_tif_to_spec_ctrl(tifn);
> +	u64 msr = x86_spec_ctrl_base;
> +
> +	/*
> +	 * If X86_FEATURE_SSBD is not set, the SSBD
> +	 * bit is not to be touched.
> +	 */
> +	if (static_cpu_has(X86_FEATURE_SSBD))
> +		msr |= ssbd_tif_to_spec_ctrl(tifn);
>  
>  	wrmsrl(MSR_IA32_SPEC_CTRL, msr);
>  }
>  
> -static __always_inline void __speculation_ctrl_update(unsigned long tifn)
> +static __always_inline void __speculation_ctrl_update(unsigned long tifp,
> +						      unsigned long tifn)
>  {
> -	if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
> -		amd_set_ssb_virt_state(tifn);
> -	else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
> -		amd_set_core_ssb_state(tifn);
> -	else
> +	bool updmsr = false;
> +
> +	/* Check for AMD cpu to see if it uses SPEC_CTRL MSR for SSBD */

Errm. This checks a TIF bit and nothing AMD. The AMD specific check only
happens when the branch is taken. Please be precise with your comments.

	/* If TIF_SSBD is different, select the proper mitigation method */

Hmm?

> +	if ((tifp ^ tifn) & _TIF_SSBD) {
> +		if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
> +			amd_set_ssb_virt_state(tifn);
> +		else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
> +			amd_set_core_ssb_state(tifn);
> +		else if (static_cpu_has(X86_FEATURE_SSBD))
> +			updmsr  = true;
> +	}
> +
> +	if (updmsr)
>  		spec_ctrl_update_msr(tifn);
>  }
>  
>  void speculation_ctrl_update(unsigned long tif)
>  {
> +	/*
> +	 * On this path we're forcing the update, so use ~tif as the
> +	 * previous flags.
> +	 */

	/* Forced update. Make sure all relevant TIF flags are different */

Hmm?

Thanks,

	tglx
