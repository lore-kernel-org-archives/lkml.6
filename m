Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F6DC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 06:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5FE20652
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 06:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5FE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbeIHLaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 07:30:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37355 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeIHLaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 07:30:00 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyWzW-0003qo-0G; Sat, 08 Sep 2018 08:45:10 +0200
Date:   Sat, 8 Sep 2018 08:45:09 +0200 (CEST)
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
In-Reply-To: <nycvar.YFH.7.76.1809072322230.15880@cbobk.fhfr.pm>
Message-ID: <alpine.DEB.2.21.1809080839110.1402@nanos.tec.linutronix.de>
References: <nycvar.YFH.7.76.1809061013160.15880@cbobk.fhfr.pm> <alpine.LRH.2.00.1809061032540.3446@gjva.wvxbf.pm> <alpine.DEB.2.21.1809072222430.1402@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1809072322230.15880@cbobk.fhfr.pm>
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

On Fri, 7 Sep 2018, Jiri Kosina wrote:

> On Fri, 7 Sep 2018, Thomas Gleixner wrote:
> 
> > > + * The read-modify-write of the MSR doesn't need any race protection here,
> > > + * as we're running in atomic context.
> > > + */
> > > +static void enable_stibp(void *info)
> > > +{
> > > +	u64 mask;
> > > +	rdmsrl(MSR_IA32_SPEC_CTRL, mask);
> > > +	mask |= SPEC_CTRL_STIBP;
> > > +	wrmsrl(MSR_IA32_SPEC_CTRL, mask);
> > > +}
> > 
> > You need to write x86_spec_ctrl_base 
> 
> Agreed (Josh pointed that out as well) -- otherwise this gets lost during 
> VMEXIT at least.

It's not only virt. The firmware crap as well.

> > so again. x86_spec_ctrl_base needs the STIPB bit update when the
> > enable/disable changes.
> 
> Agreed, but that's not sufficient. We need to update the MSR value on 
> primary threads as well (which we do in sysfs store path), so this is 
> merely an optimization so that we don't do it pointlessly twice on 
> siblings.

No. It's an correctness issue. If after changing the SMT to enable a normal
hotplug operation happens then you need to update the MSR as well.

> > If you do that _before_ the loop then you spare 50% IPIs again because the
> > siblings will do the right thing via x86_spec_ctrl_base.
> 
> So I will go through the whole codepath again, but I fear your suggestion 
> would not work -- see the check for cpu_smt_control in stibp_needed(). We 
> need to see the old (or new, depending on the direction of the transition) 
> value of cpu_smt_contol, which will break if we move 
> arch_smt_enable_errata() (and thus the check).

That's bogus. The arch_smt_control(enable) function does not need to look
at the SMT control state at all. The caller hands the not yet populated new
state in and that's enough to make the decision whether to set or clear the
bit in x86_spec_ctrl_base.

Thanks,

	tglx
