Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D11C43444
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819AC20874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfADOzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 09:55:35 -0500
Received: from foss.arm.com ([217.140.101.70]:43930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbfADOze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 09:55:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF60B15AD;
        Fri,  4 Jan 2019 06:55:33 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB5293F575;
        Fri,  4 Jan 2019 06:55:33 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 514091AE0C63; Fri,  4 Jan 2019 14:55:34 +0000 (GMT)
Date:   Fri, 4 Jan 2019 14:55:34 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>, mark.rutland@arm.com,
        David Woodhouse <dwmw@amazon.co.uk>, mlangsdo@redhat.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, Dave Hansen <dave.hansen@intel.com>,
        julien.thierry@arm.com, linux-kernel@vger.kernel.org,
        steven.price@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, shankerd@codeaurora.org,
        ykaukab@suse.de, Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/7] sysfs/cpu: Add "Unknown" vulnerability state
Message-ID: <20190104145533.GA30743@edgewater-inn.cambridge.arm.com>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
 <20190103004921.1928921-2-jeremy.linton@arm.com>
 <20190103093858.GA10794@kroah.com>
 <c9e08010-3ca0-cb03-e5ad-ab19342ff63b@arm.com>
 <20190103164831.GF14994@kroah.com>
 <20190104140832.GC3571@e103592.cambridge.arm.com>
 <20190104141805.GA15939@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104141805.GA15939@kroah.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 03:18:05PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Jan 04, 2019 at 02:08:32PM +0000, Dave Martin wrote:
> > On Thu, Jan 03, 2019 at 05:48:31PM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Jan 03, 2019 at 10:38:16AM -0600, Jeremy Linton wrote:
> > > > On 01/03/2019 03:38 AM, Greg Kroah-Hartman wrote:
> > > > > On Wed, Jan 02, 2019 at 06:49:15PM -0600, Jeremy Linton wrote:
> > > > > > There is a lot of variation in the Arm ecosystem. Because of this,
> > > > > > there exist possible cases where the kernel cannot authoritatively
> > > > > > determine if a machine is vulnerable.
> > > > > 
> > > > > Really?  Why not?  What keeps you from "knowing" this?  Can't the
> > > > > developer of the chip tell you?
> > > > 
> > > > There tends to be a few cases, possibly incomplete white/black lists,
> > > 
> > > Then fix the lists :)
> > > 
> > > > firmware that isn't responding correctly, or the user didn't build in the
> > > > code to check the mitigation (possibly because its an embedded system and
> > > > they know its not vulnerable?).
> > > 
> > > If the firmware doesn't respond, that would imply it is vulnerable :)
> > > 
> > > And if the code isn't built in, again, it's vulnerable.
> > > 
> > > > I would hope that it is an exceptional case.
> > > 
> > > Then have the default be vulnerable, don't give people false hope.
> > > 
> > > > > > Rather than guess the vulnerability status in cases where
> > > > > > the mitigation is disabled or the firmware isn't responding
> > > > > > correctly, we need to display an "Unknown" state.
> > > > > 
> > > > > Shouldn't "Unknown" really be the same thing as "Vulnerable"?  A user
> > > > > should treat it the same way, "Unknown" makes it feel like "maybe I can
> > > > > just ignore this and hope I really am safe", which is not a good idea at
> > > > > all.
> > > > 
> > > > I tend to agree its not clear what to do with "unknown".
> > > > 
> > > > OTOH, I think there is a hesitation to declare something vulnerable when it
> > > > isn't. Meltdown for example, is fairly rare given that it currently only
> > > > affects a few arm parts, so declaring someone vulnerable when they likely
> > > > aren't is going to be just as difficult to explain.
> > > 
> > > If you know it is rare, then you know how to properly detect it so
> > > "unknown" is not needed, correct?
> > > 
> > > Again, "unknown" is not going to help anyone out here, please don't do
> > > it.
> > 
> > Thinking about it, "unknown" is actually the common case.
> > 
> > Kernels that predate the sysfs vulnerabilities interface effectively
> > report this for all vulnerabilities by omitting the sysfs entries
> > entirely.
> > 
> > Current kernels also don't know anything about future vulnerabilities
> > that may be added in sysfs later on (but which may nevertheless be
> > discovered subsequently to affect current hardware).
> > 
> > So, can we simply omit the sysfs entries for which we can't provide a
> > good answer?
> 
> As you say, we already do this for older systems.
> 
> But don't add new logic to explicitly not create the files just because
> we "can not figure it out".  For those systems, I would default to
> "vulnerable" as I think that's what we do today, right?

Nope: currently the vulnerabilities directory doesn't even exist for arm64
because we don't select GENERIC_CPU_VULNERABILITIES.

There are also a few other things to consider here:

  1. The action to take as an end-user is slightly different in the case
     that you know for sure that your system is vulnerable, as opposed to
     the case that you don't know whether your system is vulnerable or not.
     The former needs a firmware update; the second needs a statement about
     the CPU, which could result in a simple whitelist update in Linux.

  2. There's an unfortunate political angle to this. Whilst the Arm website
     [1] provides information for all of the Arm-designed CPUs (i.e.
     Cortex-A*), it doesn't comment on partner implementations. I'm not at
     all keen to be seen as branding them all as vulnerable in the Linux
     kernel, as this is likely to cause more problems than it solves.
     If we had complete whitelist information available in public, that
     would be ideal, but it's not the case.

  3. The architecture has added some ID registers to determine if a CPU
     is affected by Spectre and Meltdown, so a whitelist only needs to
     cover existing CPUs.

So I agree with Dave that continuing to omit the files when we don't know
whether or not the system is affected is the right thing to do.

Will

[1] https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability
