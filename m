Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3A5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EE82075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18EE82075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeIHBvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:51:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37095 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeIHBvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:51:17 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyNzH-0003dG-TL; Fri, 07 Sep 2018 23:08:20 +0200
Date:   Fri, 7 Sep 2018 23:08:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jiri Kosina <jikos@kernel.org>
cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 2/2] x86/speculation: Enable cross-hyperthread spectre
 v2 STIBP mitigation
In-Reply-To: <alpine.LRH.2.00.1809061032540.3446@gjva.wvxbf.pm>
Message-ID: <alpine.DEB.2.21.1809072222430.1402@nanos.tec.linutronix.de>
References: <nycvar.YFH.7.76.1809061013160.15880@cbobk.fhfr.pm> <alpine.LRH.2.00.1809061032540.3446@gjva.wvxbf.pm>
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

On Thu, 6 Sep 2018, Jiri Kosina wrote:
> +/*
> + * The read-modify-write of the MSR doesn't need any race protection here,
> + * as we're running in atomic context.
> + */
> +static void enable_stibp(void *info)
> +{
> +	u64 mask;
> +	rdmsrl(MSR_IA32_SPEC_CTRL, mask);
> +	mask |= SPEC_CTRL_STIBP;
> +	wrmsrl(MSR_IA32_SPEC_CTRL, mask);
> +}

You need to write x86_spec_ctrl_base and you have to set/clear the STIBP
bit before issuing the IPIs, i.e. you only need a single function

static void update_specctrl_msr(void *unused)
{
	wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
}

If you don't update x86_spec_ctrl_base then any consecutive update of the
MSR will clear it. It's written in various nospec() functions and on
vmexit.

Right now the variable is ro_after_init because it's only modified during
init when the mitigations are selected. So that needs to be removed.

For the case at hand we could just rely on the hotplug serialization, but I
fear that's going to break sooner than later. I rather prefer to have some
local protection here right away.

void arch_smt_control(bool enable)
{
	mutex_lock(&spec_ctrl_mutex);
	if (enable)
		x86_spec_ctrl_base |= SPEC_CTRL_STIBP;
	else
		x86_spec_ctrl_base &= ~SPEC_CTRL_STIBP;

	on_each_cpu(update_specctrl_msr, NULL, 1);
	mutex_unlock(&spec_ctrl_mutex);
}

or something like that.

>  #undef pr_fmt
> @@ -655,6 +708,16 @@ void x86_spec_ctrl_setup_ap(void)
>  
>  	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
>  		x86_amd_ssb_disable();
> +
> +	/*
> +	 * If we are here during system bootup, enable STIBP.
> +	 *
> +	 * If we are here because of SMT hotplug, STIBP will be enabled by the
> +	 * SMT control code (enabling here would not be sufficient, as it
> +	 * needs to happen on primary threads as well).
> +	 */
> +	if (stibp_needed() && system_state < SYSTEM_RUNNING)
> +		enable_stibp(NULL);

That's broken and pointless. If a CPU is hotplugged for whatever reason,
then it needs the update of the IA32_SPEC_CTRL msr and it's already there:

void x86_spec_ctrl_setup_ap(void)
{
        if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
                wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);

so again. x86_spec_ctrl_base needs the STIPB bit update when the
enable/disable changes.

> +/*
> + * Architectures that need SMT-specific errata handling during SMT hotplug
> + * should override these.
> + */
> +void __weak arch_smt_enable_errata(void) { };
> +void __weak arch_smt_disable_errata(void) { };
> +
>  static int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>  {
>  	int cpu, ret = 0;
>  
>  	cpu_maps_update_begin();
> +	arch_smt_disable_errata();
>  	for_each_online_cpu(cpu) {
>  		if (topology_is_primary_thread(cpu))
>  			continue;
>  		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
> -		if (ret)
> +		if (ret) {
> +			arch_smt_enable_errata();
>  			break;
> +		}

Why don't you do the disable_errata call _after_ the loop and only on
success? That's more logical and spares 50% IPIs

> @@ -2073,6 +2083,7 @@ static int cpuhp_smt_enable(void)
>                /* See comment in cpuhp_smt_disable() */
>                cpuhp_online_cpu_device(cpu);
>        }
> +       arch_smt_enable_errata();
>         cpu_maps_update_done();
>        return ret;

If you do that _before_ the loop then you spare 50% IPIs again because the
siblings will do the right thing via x86_spec_ctrl_base.

Thanks,

	tglx
