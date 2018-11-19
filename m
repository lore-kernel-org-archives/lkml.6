Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39350C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0771F20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0771F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbeKSXMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:12:08 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38320 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbeKSXMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:12:07 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gOiyP-0006hP-1R; Mon, 19 Nov 2018 13:48:17 +0100
Date:   Mon, 19 Nov 2018 13:48:16 +0100 (CET)
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
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Patch v5 09/16] x86/smt: Convert cpu_smt_control check to
 cpu_smt_enabled static key
In-Reply-To: <ff3d60388c52043b477a16100b76114c6d8fbaee.1542418937.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811191340270.1537@nanos.tec.linutronix.de>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <ff3d60388c52043b477a16100b76114c6d8fbaee.1542418937.git.tim.c.chen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim,

On Fri, 16 Nov 2018, Tim Chen wrote:
>  
> +static char *l1tf_show_smt_vulnerable(void)
> +{
> +	if (static_branch_likely(&cpu_smt_enabled))
> +		return "vulnerable";
> +	else
> +		return "disabled";

so an UP kernel will now report vulnerable.

> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -11607,7 +11607,7 @@ static int vmx_vm_init(struct kvm *kvm)
>  			 * Warn upon starting the first VM in a potentially
>  			 * insecure environment.
>  			 */
> -			if (cpu_smt_control == CPU_SMT_ENABLED)
> +			if (static_branch_likely(&cpu_smt_enabled))
>  				pr_warn_once(L1TF_MSG_SMT);

Ditto.

>  #if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
> -extern enum cpuhp_smt_control cpu_smt_control;
>  extern void cpu_smt_disable(bool force);
>  extern void cpu_smt_check_topology_early(void);
>  extern void cpu_smt_check_topology(void);

What about the same thing in the else path?

> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index e216154..54cf3f6 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -368,8 +368,15 @@ static void lockdep_release_cpus_lock(void)
>  #endif	/* CONFIG_HOTPLUG_CPU */
>  
>  #ifdef CONFIG_HOTPLUG_SMT
> +
> +enum cpuhp_smt_control {
> +        CPU_SMT_ENABLED,
> +        CPU_SMT_DISABLED,
> +        CPU_SMT_FORCE_DISABLED,
> +        CPU_SMT_NOT_SUPPORTED,
> +};
> +
>  enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;

And this needs to be global because?

> -EXPORT_SYMBOL_GPL(cpu_smt_control);

Thanks,

	tglx
