Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537BCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AE520645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AE520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeIHCKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:10:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:53734 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728187AbeIHCKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:10:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 202FCAD68;
        Fri,  7 Sep 2018 21:27:47 +0000 (UTC)
Date:   Fri, 7 Sep 2018 23:27:45 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
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
In-Reply-To: <alpine.DEB.2.21.1809072222430.1402@nanos.tec.linutronix.de>
Message-ID: <nycvar.YFH.7.76.1809072322230.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1809061013160.15880@cbobk.fhfr.pm> <alpine.LRH.2.00.1809061032540.3446@gjva.wvxbf.pm> <alpine.DEB.2.21.1809072222430.1402@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2018, Thomas Gleixner wrote:

> > + * The read-modify-write of the MSR doesn't need any race protection here,
> > + * as we're running in atomic context.
> > + */
> > +static void enable_stibp(void *info)
> > +{
> > +	u64 mask;
> > +	rdmsrl(MSR_IA32_SPEC_CTRL, mask);
> > +	mask |= SPEC_CTRL_STIBP;
> > +	wrmsrl(MSR_IA32_SPEC_CTRL, mask);
> > +}
> 
> You need to write x86_spec_ctrl_base 

Agreed (Josh pointed that out as well) -- otherwise this gets lost during 
VMEXIT at least.

> >  #undef pr_fmt
> > @@ -655,6 +708,16 @@ void x86_spec_ctrl_setup_ap(void)
> >  
> >  	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
> >  		x86_amd_ssb_disable();
> > +
> > +	/*
> > +	 * If we are here during system bootup, enable STIBP.
> > +	 *
> > +	 * If we are here because of SMT hotplug, STIBP will be enabled by the
> > +	 * SMT control code (enabling here would not be sufficient, as it
> > +	 * needs to happen on primary threads as well).
> > +	 */
> > +	if (stibp_needed() && system_state < SYSTEM_RUNNING)
> > +		enable_stibp(NULL);
> 
> That's broken and pointless. If a CPU is hotplugged for whatever reason,
> then it needs the update of the IA32_SPEC_CTRL msr and it's already there:
> 
> void x86_spec_ctrl_setup_ap(void)
> {
>         if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
>                 wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> 
> so again. x86_spec_ctrl_base needs the STIPB bit update when the
> enable/disable changes.

Agreed, but that's not sufficient. We need to update the MSR value on 
primary threads as well (which we do in sysfs store path), so this is 
merely an optimization so that we don't do it pointlessly twice on 
siblings.

> > +/*
> > + * Architectures that need SMT-specific errata handling during SMT hotplug
> > + * should override these.
> > + */
> > +void __weak arch_smt_enable_errata(void) { };
> > +void __weak arch_smt_disable_errata(void) { };
> > +
> >  static int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
> >  {
> >  	int cpu, ret = 0;
> >  
> >  	cpu_maps_update_begin();
> > +	arch_smt_disable_errata();
> >  	for_each_online_cpu(cpu) {
> >  		if (topology_is_primary_thread(cpu))
> >  			continue;
> >  		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
> > -		if (ret)
> > +		if (ret) {
> > +			arch_smt_enable_errata();
> >  			break;
> > +		}
> 
> Why don't you do the disable_errata call _after_ the loop and only on
> success? That's more logical and spares 50% IPIs
> 
> > @@ -2073,6 +2083,7 @@ static int cpuhp_smt_enable(void)
> >                /* See comment in cpuhp_smt_disable() */
> >                cpuhp_online_cpu_device(cpu);
> >        }
> > +       arch_smt_enable_errata();
> >         cpu_maps_update_done();
> >        return ret;
> 
> If you do that _before_ the loop then you spare 50% IPIs again because the
> siblings will do the right thing via x86_spec_ctrl_base.

So I will go through the whole codepath again, but I fear your suggestion 
would not work -- see the check for cpu_smt_control in stibp_needed(). We 
need to see the old (or new, depending on the direction of the transition) 
value of cpu_smt_contol, which will break if we move 
arch_smt_enable_errata() (and thus the check).

But I am not 100% sure about this now, will double-check it tomorrow.

Thanks,

-- 
Jiri Kosina
SUSE Labs

