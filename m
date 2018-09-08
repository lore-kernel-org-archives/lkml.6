Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB39BC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFA920652
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFA920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeIHNuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 09:50:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37399 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIHNuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 09:50:25 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyZAy-0005I3-8g; Sat, 08 Sep 2018 11:05:08 +0200
Date:   Sat, 8 Sep 2018 11:05:07 +0200 (CEST)
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
In-Reply-To: <alpine.DEB.2.21.1809080839110.1402@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1809081058410.1402@nanos.tec.linutronix.de>
References: <nycvar.YFH.7.76.1809061013160.15880@cbobk.fhfr.pm> <alpine.LRH.2.00.1809061032540.3446@gjva.wvxbf.pm> <alpine.DEB.2.21.1809072222430.1402@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1809072322230.15880@cbobk.fhfr.pm>
 <alpine.DEB.2.21.1809080839110.1402@nanos.tec.linutronix.de>
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

On Sat, 8 Sep 2018, Thomas Gleixner wrote:
> On Fri, 7 Sep 2018, Jiri Kosina wrote:
> > So I will go through the whole codepath again, but I fear your suggestion 
> > would not work -- see the check for cpu_smt_control in stibp_needed(). We 
> > need to see the old (or new, depending on the direction of the transition) 
> > value of cpu_smt_contol, which will break if we move 
> > arch_smt_enable_errata() (and thus the check).
> 
> That's bogus. The arch_smt_control(enable) function does not need to look
> at the SMT control state at all. The caller hands the not yet populated new
> state in and that's enough to make the decision whether to set or clear the
> bit in x86_spec_ctrl_base.

And thinking more about it, the function does not even need an argument.

smt_disable()

	res = shut_down_siblings();
	if (!res) {
		state = disabled;
		arch_smt_update();
	}

smt_enable()

	state = enabled;
	arch_smt_update();
	bringup_siblings();

So the update function has the correct state in both cases and then does:

	if (!cpu_is_trainwreck() || !cpu_has(stibp))
       		return;

	lock();
	ctrl = spec_ctrl_base;
	if (smt_disabled())
		ctrl &= ~STIPB;
	else
		ctrl |= STIPB;
	if (ctrl != spec_ctrl_base) {
		spec_ctrl_base = ctrl;
		on_each_cpu(write_spec_msr);
	}
	unlock();

See?

Thanks,

	tglx


