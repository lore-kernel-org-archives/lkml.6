Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB8AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC22F20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC22F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbeG3Whe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 18:37:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57456 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbeG3Whd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 18:37:33 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkFHU-0006x1-3h; Mon, 30 Jul 2018 23:00:40 +0200
Date:   Mon, 30 Jul 2018 23:00:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH V2] x86/speculation: Support Enhanced IBRS on future
 CPUs
In-Reply-To: <1532978396-2197-1-git-send-email-sai.praneeth.prakhya@intel.com>
Message-ID: <alpine.DEB.2.21.1807302153570.1725@nanos.tec.linutronix.de>
References: <1532978396-2197-1-git-send-email-sai.praneeth.prakhya@intel.com>
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

On Mon, 30 Jul 2018, Sai Praneeth Prakhya wrote:
> Some future Intel processors may support "Enhanced IBRS" which is an

Future Intel processors will support ...

> "always on" mode i.e. IBRS bit in SPEC_CTRL MSR is enabled once and
> never disabled.
> 
> [With enhanced IBRS, the predicted targets of indirect branches executed
> cannot be controlled by software that was executed in a less privileged
> predictor mode or on another logical processor. As a result, software
> operating on a processor with enhanced IBRS need not use WRMSR to set
> IA32_SPEC_CTRL.IBRS after every transition to a more privileged
> predictor mode. Software can isolate predictor modes effectively simply
> by setting the bit once. Software need not disable enhanced IBRS prior
> to entering a sleep state such as MWAIT or HLT.] - Specification [1]

There is no reason not to use indentation and quotation marks in a
changelog. Squeezing it into square brackets does not really improve
readability.

 From the specification [1]:

  "With enhanced IBRS, the predicted targets of indirect branches executed
   cannot be controlled by software that was executed in a less privileged
   ....
   to entering a sleep state such as MWAIT or HLT."

Hmm?

> Even with enhanced IBRS, we still need to make sure that IBRS bit in

Why even?

> SPEC_CTRL MSR is always set i.e. while booting, if we detect support for
> Enhanced IBRS, we enable IBRS bit in SPEC_CTRL MSR and we should also
> make sure that it remains set always. In other words, if the guest has
> cleared IBRS bit, upon VMEXIT the bit should still be set.
> 
> Fortunately, kernel already has the infrastructure ready. kvm/vmx.c does
> x86_spec_ctrl_set_guest() before entering guest and
> x86_spec_ctrl_restore_host() after leaving guest. So, the guest view of
> SPEC_CTRL MSR is restored before entering guest and the host view of
> SPEC_CTRL MSR is restored before entering host and hence IBRS will be
> set after VMEXIT.

What you are trying to say here is:

 If Enhanced IBRS is selected as mitigation mechanism the IBRS bit is set
 once at boot time and never cleared. This also has to be ensured after a
 VMEXIT because the guest might have cleared the bit. This is already
 covered by the existing x86_spec_ctrl_set_guest() and
 x86_spec_ctrl_restore_host() speculation control functions.

Hmm?

> Intel's white paper on Retpoline [2] says that "Retpoline is known to be
> an effective branch target injection (Spectre variant 2) mitigation on
> Intel processors belonging to family 6 (enumerated by the CPUID
> instruction) that do not have support for enhanced IBRS. On processors
> that support enhanced IBRS, it should be used for mitigation instead of
> retpoline."
> 
> This means, Intel recommends using Enhanced IBRS over Retpoline where
> available and it also means that retpoline provides less mitigation on
> processors with enhanced IBRS compared to those without.

The cited part of the white paper does not say that its a broader
mitigation than what Retpoline covers. It merely recommends to use enhanced
IBRS without providing a reason.

But chapter 4.3 contains the real reason for using Emhanced IBRS: The
processors which support it also support CET and CET does not work well
with Retpoline.

Please provide facts and not interpretations. If you have additional
knowledge about a broader mitigation scope, then clearly say so:

 Aside of that Enhanced IBRS provides broader mitigation scope than
 Retpoline according to Intel internal information.

That makes it clear that it's a fact and not what you think the cited
paragraph means.

> Hence, on processors that support Enhanced IBRS, this patch makes
> Enhanced IBRS as

Please search Documentation/process/submitting-patches.rst for 'This patch' ....

> the default Spectre V2 mitigation technique instead of retpoline. Also,
> we still need IBPB even with enhanced IBRS.

Something like this perhaps:

 If Enhanced IBRS is supported by the processor then use it as the
 preferred mitigation mechanism instead of Retpoline. Intel's Retpoline
 white paper [2] states:

   "Retpoline is known to be an effective branch target injection (Spectre
    variant 2) mitigation on Intel processors belonging to family 6
    (enumerated by the CPUID instruction) that do not have support for
    enhanced IBRS. On processors that support enhanced IBRS, it should be
    used for mitigation instead of retpoline."

 The reason why 'Enhanced IBRS is the recommended mitigation on processors
 which support it is that these processors also support CET which provides
 a defense against ROP attacks. Retpoline is very similar to ROP techniques
 and might trigger false positives in the CET defense.

 Enhanced IBRS still requires IBPB for full mitigation.

See? You might have noticed that aside of restructuring and enhancing the
information I also got rid of all 'we' instances. Using 'we' is a form of
impersonation which IMO blurs the technicality of a changelog.

 
> [1] https://software.intel.com/sites/default/files/managed/c5/63/336996-Speculative-Execution-Side-Channel-Mitigations.pdf
> [2] https://software.intel.com/sites/default/files/managed/1d/46/Retpoline-A-Branch-Target-Injection-Mitigation.pdf

These links are not really useful as sooner than later they are going to be
invalid. We recently started to put copies of such documents into the
kernel.org bugzilla and I'm pretty sure we have at least one of them
already in one of the speculation mess related BZs. Could you please track
that down and make sure that both files are available there in the latest
version. Then provide links to the BZ entry which are more likely to
survive than content on a corporate website.

> @@ -219,6 +219,7 @@
>  #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
>  #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
>  #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
> +#define X86_FEATURE_IBRS_ENHANCED		( 7*32+29) /* "ibrs_enhanced" Use Enhanced IBRS in kernel */

That "ibrs_enhanced" part is not needed. And 'Use' is also wrong. The
feature merily reflects the availability of Enhanced IBRS and not its
usage.

> @@ -349,6 +350,8 @@ static void __init spectre_v2_select_mitigation(void)
>  
>  	case SPECTRE_V2_CMD_FORCE:
>  	case SPECTRE_V2_CMD_AUTO:
> +		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED))
> +			goto skip_retpoline_enable_ibrs;
>  		if (IS_ENABLED(CONFIG_RETPOLINE))
>  			goto retpoline_auto;
>  		break;
> @@ -385,7 +388,22 @@ static void __init spectre_v2_select_mitigation(void)
>  					 SPECTRE_V2_RETPOLINE_MINIMAL;
>  		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
>  	}
> +	goto enable_other_mitigations;
>  
> +skip_retpoline_enable_ibrs:
> +	mode = SPECTRE_V2_IBRS_ENHANCED;
> +
> +	/*
> +	 * As we don't use IBRS in kernel, nobody should have set
> +	 * SPEC_CTRL_IBRS until now. Shout loud if somebody did enable
> +	 * SPEC_CTRL_IBRS before us.
> +	 */

This comment does not make sense. What prevents the BIOS/bootloader or the
hypervisor from setting it?

> +	WARN_ON_ONCE(x86_spec_ctrl_base & SPEC_CTRL_IBRS);
> +
> +	/* Ensure SPEC_CTRL_IBRS is set after VMEXIT from a guest */
> +	x86_spec_ctrl_base |= SPEC_CTRL_IBRS;

And what exactly writes the MSR?

> +enable_other_mitigations:
>  	spectre_v2_enabled = mode;
>  	pr_info("%s\n", spectre_v2_strings[mode]);
>  
> @@ -415,9 +433,16 @@ static void __init spectre_v2_select_mitigation(void)
>  
>  	/*
>  	 * Retpoline means the kernel is safe because it has no indirect
> -	 * branches. But firmware isn't, so use IBRS to protect that.
> +	 * branches. Enhanced IBRS protects firmware too, so, enable restricted
> +	 * speculation around firmware calls only when Enhanced IBRS isn't
> +	 * supported.
> +	 *
> +	 * Use "mode" to check Enhanced IBRS instead of boot_cpu_has(), because
> +	 * user might select retpoline on command line and if CPU supports

the user ... on the kernel command line and if the CPU .....

> +	 * Enhanced IBRS, we might un-intentionally not enable IBRS around
> +	 * firmware calls.
>  	 */

Thanks,

	tglx
