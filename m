Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE5CC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 00:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60D324D5E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 00:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60D324D5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeFXAzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 20:55:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44125 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbeFXAzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 20:55:23 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWtJ6-0000aa-PS; Sun, 24 Jun 2018 02:55:08 +0200
Date:   Sun, 24 Jun 2018 02:55:08 +0200 (CEST)
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
In-Reply-To: <20180623150521.GG18979@romley-ivt3.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1806240245160.8650@nanos.tec.linutronix.de>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com> <1527435965-202085-3-git-send-email-fenghua.yu@intel.com> <alpine.DEB.2.21.1806212301590.1591@nanos.tec.linutronix.de> <20180623042033.GF18979@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806231108540.8650@nanos.tec.linutronix.de> <20180623150521.GG18979@romley-ivt3.sc.intel.com>
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

On Sat, 23 Jun 2018, Fenghua Yu wrote:
> On Sat, Jun 23, 2018 at 11:17:03AM +0200, Thomas Gleixner wrote:
> > On Fri, 22 Jun 2018, Fenghua Yu wrote:
> > > Should I add kernel parameter or control knob to opt-out the feature?
> > 
> > A simple command line option 'acoff' or something more sensible should be
> > ok. No sysfs knobs or whatever please. The Kconfig option is not required
> > either.
> 
> Ok. I will have a command line option.
> 
> BTW, I have a Kconfig option to enable split lock test in kernel mode in
> patch #15. Are the Kconfig option and the kernel test code still needed
> in next version?

Unless you do not trust #AC to work everywhere where it is advertised it's
pretty much pointless.

Btw, please get also rid of these bloated control_ac() stuff. We have
msr_set/clear_bit() so no need to reinvent the wheel.

> > > I'm afraid firmware may hang system after handling split lock if the
> > > feature is enabled by kernel, e.g. "reboot" hits split lock in firmware
> > > and firmware hangs the system after handling #AC.
> > 
> > Have you observed the problem in reality? I mean why would 'reboot' be the
> > critical path? I'd rather expect that EFI callbacks or SMM 'value add'
> > would trip over it.
> > 
> > Vs. reboot. If that is the only problem then we might just have to clear
> > #AC enable before issuing it, but that does not need to be part of the
> > initial patch set. Its an orthogonal issue.
> 
> Yes, I do see a real firmware hang after hitting and handling a split lock
> in firmware during "reboot" in one simulation test environment. Apprantly
> the split lock (and alignment access) is treated as a failure in firmware.

It's not treated as failure. The firmware simply does not have an handler
for #AC installed and dies. I hope you yelled at the firmware people
already.

> This real case triggered my concern that split lock in any future
> firmware may happen in any path including run time service, S3/S4/S5,
> hotplug. If we don't have opt-out option or something similar, system hang
> from split lock in firmware can be a blocking issue on some platforms. If
> that happens, bisect always finds the split lock patch to blame.

That's fine. The changelog will hopefully explain it along with the text
that people should use the commandline option and yell at their firmware
supplier. So what? Move on....

If that is a real wide spread issue in practice, then we might have to go
for some ugly workarounds, but we won't find out when we add them
upfront. So testing will show what's wrong in firmware land and we can
handle it from there. It's a completely orthogonal issue and has nothing to
do with the core functionality.

Thanks,

	tglx


