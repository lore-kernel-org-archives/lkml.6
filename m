Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940E2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9BF20989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9BF20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbeK0SKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:10:49 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56660 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeK0SKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:10:49 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gRXZ6-00084q-Ot; Tue, 27 Nov 2018 08:13:48 +0100
Date:   Tue, 27 Nov 2018 08:13:48 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jiri Kosina <jikos@kernel.org>
cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 20/24] x86/speculation: Split out TIF update
In-Reply-To: <nycvar.YFH.7.76.1811270800090.21108@cbobk.fhfr.pm>
Message-ID: <alpine.DEB.2.21.1811270809450.1682@nanos.tec.linutronix.de>
References: <20181121201430.559770965@linutronix.de> <20181121201724.227260385@linutronix.de> <f976eb35-5dcd-387e-eb29-f7c6636fd17b@linux.intel.com> <alpine.DEB.2.21.1811222352340.1665@nanos.tec.linutronix.de> <20181123073735.GA12959@gmail.com>
 <c51dd20a-2cea-1bd1-bee7-48ca25f9bdb9@linux.intel.com> <alpine.DEB.2.21.1811262244510.1682@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1811270800090.21108@cbobk.fhfr.pm>
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

On Tue, 27 Nov 2018, Jiri Kosina wrote:
> On Mon, 26 Nov 2018, Thomas Gleixner wrote:
> 
> How about the minimalistic aproach below? (only compile tested so far, 
> applies on top of your latest WIP.x86/pti branch). The downside of course 
> is wasting another TIF bit.

We need to waste another TIF bit in any case.

>  	 *
>  	 * This can only happen for SECCOMP mitigation. For PRCTL it's
>  	 * always the current task.
> +	 *
> +	 * If we are updating non-current task, set a flag for it to always
> +	 * perform the MSR sync on a first context switch, to make sure
> +	 * the TIF_SPEC_IB above is not out of sync with the MSR value during
> +	 * task's runtime.
>  	 */
>  	if (tsk == current && update)
>  		speculation_ctrl_update_current();
> +	else
> +		set_tsk_thread_flag(tsk, TIF_SPEC_UPDATE);
> +
>  }
>  
>  static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 3f5e351bdd37..78208234e63e 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -449,8 +449,20 @@ static __always_inline void __speculation_ctrl_update(unsigned long tifp,
>  	 * otherwise avoid the MSR write.
>  	 */
>  	if (IS_ENABLED(CONFIG_SMP) &&
> -	    static_branch_unlikely(&switch_to_cond_stibp))
> +	    static_branch_unlikely(&switch_to_cond_stibp)) {
>  		updmsr |= !!(tif_diff & _TIF_SPEC_IB);
> +		/*
> +		 * We need to update the MSR if remote task did set
> +		 * TIF_SPEC_UPDATE on us, and therefore MSR value and
> +		 * the TIF_SPEC_IB values might be out of sync.
> +		 *
> +		 * This can only happen if seccomp task has updated
> +		 * one of its remote threads.
> +		 */
> +		if (IS_ENABLED(CONFIG_SECCOMP) && !updmsr &&
> +				(tifn & TIF_SPEC_UPDATE))
> +			updmsr = true;
> +	}
>  
>  	if (updmsr)
>  		spec_ctrl_update_msr(tifn);
> @@ -496,6 +508,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
>  		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
>  
>  	__speculation_ctrl_update(tifp, tifn);
> +	if (IS_ENABLED(CONFIG_SECCOMP))
> +		clear_tsk_thread_flag(next_p, TIF_SPEC_UPDATE);

That's racy and does not prevent the situation because the TIF flags are
updated befor the UPDATE bit is set. So __speculation_ctrl_update() might
see the new bits, but not TIF_SPEC_UPDATE. You really need shadow storage
to avoid that.

Thanks,

	tglx
