Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF2EC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 09:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F78C24B7B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 09:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F78C24B7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeFWJRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 05:17:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43196 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751766AbeFWJRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 05:17:10 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWefI-0003hN-Bs; Sat, 23 Jun 2018 11:17:04 +0200
Date:   Sat, 23 Jun 2018 11:17:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 02/16] x86/split_lock: Handle #AC exception for split
 lock in kernel mode
In-Reply-To: <20180623042033.GF18979@romley-ivt3.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1806231108540.8650@nanos.tec.linutronix.de>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com> <1527435965-202085-3-git-send-email-fenghua.yu@intel.com> <alpine.DEB.2.21.1806212301590.1591@nanos.tec.linutronix.de> <20180623042033.GF18979@romley-ivt3.sc.intel.com>
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

On Fri, 22 Jun 2018, Fenghua Yu wrote:
> On Fri, Jun 22, 2018 at 12:49:00PM +0200, Thomas Gleixner wrote:
> > On Sun, 27 May 2018, Fenghua Yu wrote:
> > > +static void wait_for_reexecution(void)
> > > +{
> > > +	while (time_before(jiffies, disable_split_lock_jiffies +
> > > +			   reenable_split_lock_delay))
> > > +		cpu_relax();
> > > +}
> > > +
> > > +/*
> > > + * TEST_CTL MSR is shared among threads on the same core. To simplify
> > > + * situation, disable_split_lock_jiffies is global instead of per core.
> > 
> > This patch surely earns extra points in the trainwreck engineering contest,
> > but that's not taking place on LKML.
> > 
> > The whole thing is simply:
> > 
> > handle_ac()
> > {
> > 	if (user_mode(regs)) {
> > 		 do_trap(AC, SIGBUS, ...);
> > 	} else {
> > 		disable_ac_on_local_cpu();
> > 		WARN_ONCE(1);
> > 	}
> > }
> 
> Should I add kernel parameter or control knob to opt-out the feature?

A simple command line option 'acoff' or something more sensible should be
ok. No sysfs knobs or whatever please. The Kconfig option is not required
either.

> I'm afraid firmware may hang system after handling split lock if the
> feature is enabled by kernel, e.g. "reboot" hits split lock in firmware
> and firmware hangs the system after handling #AC.

Have you observed the problem in reality? I mean why would 'reboot' be the
critical path? I'd rather expect that EFI callbacks or SMM 'value add'
would trip over it.

Vs. reboot. If that is the only problem then we might just have to clear
#AC enable before issuing it, but that does not need to be part of the
initial patch set. Its an orthogonal issue.

Thanks,

	tglx
