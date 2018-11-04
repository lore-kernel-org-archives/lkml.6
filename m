Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108D1C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 19:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C264020854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 19:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C264020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbeKEFFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 00:05:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33335 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeKEFFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 00:05:53 -0500
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJOOf-0001qS-DW; Sun, 04 Nov 2018 20:49:21 +0100
Date:   Sun, 4 Nov 2018 20:49:20 +0100 (CET)
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
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [Patch v4 17/18] x86/speculation: Update SPEC_CTRL MSRs of remote
 CPUs
In-Reply-To: <a14236d8b56dafe6988ce1b266a6e929be5296a8.1540923609.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811042042060.10744@nanos.tec.linutronix.de>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com> <a14236d8b56dafe6988ce1b266a6e929be5296a8.1540923609.git.tim.c.chen@linux.intel.com>
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

Tim,

On Tue, 30 Oct 2018, Tim Chen wrote:
>  void arch_set_security(struct task_struct *tsk, unsigned int value)
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 943e90d..048b7f4b 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -426,7 +426,19 @@ static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
>  static __always_inline void __speculation_ctrl_update(unsigned long tifp,
>  						      unsigned long tifn)
>  {
> -	bool updmsr = !!((tifp ^ tifn) & _TIF_STIBP);
> +	/*
> +	 * If TIF_UPDATE_SPEC_CTRL bit is set in tifp, speculation related
> +	 * TIF flags have changed when previous task was running, but
> +	 * SPEC_CTRL MSR has not been synchronized with TIF flag changes.
> +	 * SPEC_CTRL MSR value can be out of date.
> +	 *
> +	 * Need to force update SPEC_CTRL MSR if TIF_UPDATE_SPEC_CTRL
> +	 * bit in tifp is set.
> +	 *
> +	 * The TIF_UPDATE_SPEC_CTRL bit in tifn was cleared before calling
> +	 * this function.
> +	 */
> +	bool updmsr = !!((tifp ^ tifn) & (_TIF_STIBP|_TIF_UPDATE_SPEC_CTRL));
>  
>  	/* If TIF_SSBD is different, select the proper mitigation method */
>  	if ((tifp ^ tifn) & _TIF_SSBD) {
> @@ -482,6 +494,14 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
>  	if ((tifp ^ tifn) & _TIF_NOCPUID)
>  		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
>  
> +	if (tifp & _TIF_UPDATE_SPEC_CTRL)
> +		clear_tsk_thread_flag(prev_p, TIF_UPDATE_SPEC_CTRL);
> +
> +	if (tifn & _TIF_UPDATE_SPEC_CTRL) {
> +		clear_tsk_thread_flag(next_p, TIF_UPDATE_SPEC_CTRL);
> +		tifn &= ~_TIF_UPDATE_SPEC_CTRL;
> +	}

I'm really unhappy about adding yet more conditionals into this code
path. We really need to find some better solution for that.

There are basically two options:

 1) Restrict the PRCTL control so it is only possible to modify it at the
    point where the application is still single threaded.

 2) Add _TIF_UPDATE_SPEC_CTRL to the SYSCALL_EXIT_WORK_FLAGS and handle it
    in the slow work path.

    The KVM side can be handled in x86_virt_spec_ctrl().

Thanks,

	tglx
