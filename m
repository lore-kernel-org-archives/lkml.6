Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B28C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E65124C39
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E65124C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeFWPFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 11:05:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:3700 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751474AbeFWPFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 11:05:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2018 08:05:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,262,1526367600"; 
   d="scan'208";a="59605619"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2018 08:05:52 -0700
Date:   Sat, 23 Jun 2018 08:05:21 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@elte.hu>,
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
Message-ID: <20180623150521.GG18979@romley-ivt3.sc.intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <1527435965-202085-3-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1806212301590.1591@nanos.tec.linutronix.de>
 <20180623042033.GF18979@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806231108540.8650@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806231108540.8650@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 11:17:03AM +0200, Thomas Gleixner wrote:
> On Fri, 22 Jun 2018, Fenghua Yu wrote:
> > On Fri, Jun 22, 2018 at 12:49:00PM +0200, Thomas Gleixner wrote:
> > > On Sun, 27 May 2018, Fenghua Yu wrote:
> > > > +static void wait_for_reexecution(void)
> > > > +{
> > > > +	while (time_before(jiffies, disable_split_lock_jiffies +
> > > > +			   reenable_split_lock_delay))
> > > > +		cpu_relax();
> > > > +}
> > > > +
> > > > +/*
> > > > + * TEST_CTL MSR is shared among threads on the same core. To simplify
> > > > + * situation, disable_split_lock_jiffies is global instead of per core.
> > > 
> > > This patch surely earns extra points in the trainwreck engineering contest,
> > > but that's not taking place on LKML.
> > > 
> > > The whole thing is simply:
> > > 
> > > handle_ac()
> > > {
> > > 	if (user_mode(regs)) {
> > > 		 do_trap(AC, SIGBUS, ...);
> > > 	} else {
> > > 		disable_ac_on_local_cpu();
> > > 		WARN_ONCE(1);
> > > 	}
> > > }
> > 
> > Should I add kernel parameter or control knob to opt-out the feature?
> 
> A simple command line option 'acoff' or something more sensible should be
> ok. No sysfs knobs or whatever please. The Kconfig option is not required
> either.

Ok. I will have a command line option.

BTW, I have a Kconfig option to enable split lock test in kernel mode in
patch #15. Are the Kconfig option and the kernel test code still needed
in next version?

> 
> > I'm afraid firmware may hang system after handling split lock if the
> > feature is enabled by kernel, e.g. "reboot" hits split lock in firmware
> > and firmware hangs the system after handling #AC.
> 
> Have you observed the problem in reality? I mean why would 'reboot' be the
> critical path? I'd rather expect that EFI callbacks or SMM 'value add'
> would trip over it.
> 
> Vs. reboot. If that is the only problem then we might just have to clear
> #AC enable before issuing it, but that does not need to be part of the
> initial patch set. Its an orthogonal issue.

Yes, I do see a real firmware hang after hitting and handling a split lock
in firmware during "reboot" in one simulation test environment. Apprantly
the split lock (and alignment access) is treated as a failure in firmware.

This real case triggered my concern that split lock in any future
firmware may happen in any path including run time service, S3/S4/S5,
hotplug. If we don't have opt-out option or something similar, system hang
from split lock in firmware can be a blocking issue on some platforms. If
that happens, bisect always finds the split lock patch to blame.

Thanks.

-Fenghua
