Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4A6C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D615C21473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D615C21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeJCBsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:48:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60830 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeJCBsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:48:05 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7Pwh-0001YL-QZ; Tue, 02 Oct 2018 21:03:00 +0200
Date:   Tue, 2 Oct 2018 21:02:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
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
Subject: Re: [Patch v2 3/4] x86/speculation: Extend per process STIBP to AMD
 cpus.
In-Reply-To: <705b51cba5b5e7805aeb08af7f7d21e6ec897a17.1537920575.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810022000000.1435@nanos.tec.linutronix.de>
References: <cover.1537920575.git.tim.c.chen@linux.intel.com> <705b51cba5b5e7805aeb08af7f7d21e6ec897a17.1537920575.git.tim.c.chen@linux.intel.com>
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

On Tue, 25 Sep 2018, Tim Chen wrote:
> From: Thomas Lendacky <Thomas.Lendacky@amd.com>
> 
> We extend the app to app spectre v2 mitigation using STIBP
> to the AMD cpus. We need to take care of special
> cases for AMD cpu's update of SPEC_CTRL MSR to avoid double
> writing of MSRs from update to SSBD and STIBP.

According to documentation changelogs want to be written in imperative
mood.

> Originally-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  arch/x86/kernel/process.c | 48 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index cb24014..4a3a672 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -399,6 +399,10 @@ static __always_inline void set_spec_ctrl_state(unsigned long tifn)
>  {
>  	u64 msr = x86_spec_ctrl_base;
>  
> +	/*
> +	 * AMD cpu may have used a different method to update SSBD, so
> +	 * we need to be sure we are using the SPEC_CTRL MSR for SSBD.

This has nothing to do with AMD. If X86_FEATURE_SSBD is not set, the SSBD
bit is not to be touched.

> +	 */
>  	if (static_cpu_has(X86_FEATURE_SSBD))
>  		msr |= ssbd_tif_to_spec_ctrl(tifn);
>  
> @@ -408,20 +412,45 @@ static __always_inline void set_spec_ctrl_state(unsigned long tifn)
>  	wrmsrl(MSR_IA32_SPEC_CTRL, msr);
>  }
>  
> -static __always_inline void __speculative_store_bypass_update(unsigned long tifn)
> +static __always_inline void __speculative_store_bypass_update(unsigned long tifp,
> +							      unsigned long tifn)
>  {
> -	if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
> -		amd_set_ssb_virt_state(tifn);
> -	else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
> -		amd_set_core_ssb_state(tifn);
> -	else
> -		set_spec_ctrl_state(tifn);
> +	bool stibp = !!((tifp ^ tifn) & _TIF_STIBP);
> +	bool ssbd = !!((tifp ^ tifn) & _TIF_SSBD);
> +
> +	if (!ssbd && !stibp)
> +		return;
> +
> +	if (ssbd) {
> +		/*
> +		 * For AMD, try these methods first.  The ssbd variable will
> +		 * reflect if the SPEC_CTRL MSR method is needed.
> +		 */
> +		ssbd = false;
> +
> +		if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
> +			amd_set_ssb_virt_state(tifn);
> +		else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
> +			amd_set_core_ssb_state(tifn);
> +		else
> +			ssbd = true;
> +	}
> +
> +	/* Avoid a possible extra MSR write, recheck the flags */
> +	if (!ssbd && !stibp)
> +		return;
> +
> +	set_spec_ctrl_state(tifn);

Uuurgh. This is context switch code and it results in a horrible assembly
maze. Also the function name is bogus now. It's not only dealing with SSB
anymore. Please stop glueing stuff into the code as you see fit.

Something like the below creates halfways sensible code.

static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
{
	u64 msr = x86_spec_ctrl_base;

	if (static_cpu_has(X86_FEATURE_SSBD))
		msr |= ssbd_tif_to_spec_ctrl(tifn);

	wrmsrl(MSR_IA32_SPEC_CTRL, msr);
}

static __always_inline void spec_ctrl_update(unsigned long tifp,
					     unsigned long tifn)
{
	bool updmsr = !!((tifp ^ tifn) & _TIF_STIBP);

	if ((tifp ^ tifn) & _TIF_SSBD) {
		if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
			amd_set_ssb_virt_state(tifn);
		else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
			amd_set_core_ssb_state(tifn);
		else if (static_cpu_has(X86_FEATURE_SSBD))
			updmsr	= true;
	}

	if (updmsr)
		spec_ctrl_update_msr(tifn);
}

void speculation_ctrl_update(unsigned long tif)
{
	preempt_disable();
	spec_ctrl_update(~tif, tif);
	preempt_enable();
}

Hmm?

Thanks,

	tglx
