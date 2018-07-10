Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117DDC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A7F208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A7F208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbeGJTsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:48:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37655 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbeGJTsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:48:19 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fcybf-0007GC-B9; Tue, 10 Jul 2018 21:47:27 +0200
Date:   Tue, 10 Jul 2018 21:47:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v2 1/4] x86/split_lock: Enumerate #AC exception for split
 locked access feature
In-Reply-To: <ea23cde0-f999-0ed8-a3bc-e798511467bd@intel.com>
Message-ID: <alpine.DEB.2.21.1807102140050.1588@nanos.tec.linutronix.de>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com> <1530282807-66555-2-git-send-email-fenghua.yu@intel.com> <b0267bb2-7d1f-c1d6-cff8-addf358009b3@intel.com> <alpine.DEB.2.21.1806291813570.1595@nanos.tec.linutronix.de>
 <20180704200742.GD7451@localhost.localdomain> <20180710184506.GA37857@romley-ivt3.sc.intel.com> <ea23cde0-f999-0ed8-a3bc-e798511467bd@intel.com>
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

On Tue, 10 Jul 2018, Dave Hansen wrote:
> On 07/10/2018 11:45 AM, Fenghua Yu wrote:
> > On Wed, Jul 04, 2018 at 05:07:42PM -0300, Eduardo Habkost wrote:
> >> On Fri, Jun 29, 2018 at 06:23:35PM +0200, Thomas Gleixner wrote:
> >>> On Fri, 29 Jun 2018, Dave Hansen wrote:
> >>>> Is this MSR not really model-specific?  Is it OK to go poking at it on
> >>>> all x86 variants?  Or, do we at _least_ need a check for Intel cpus in here?
> >>>
> >>> That definitely needs a vendor check. Also the whole code needs to be
> >>> compiled out if CONFIG_INTEL=n.
> >>>
> >>> Aside of that this wants to be enumerated. CPUID or MISC_FEATURES and not
> >>> this guess work detection logic. Why do I have to ask for that for every
> >>> other new feature thingy?
> >>
> >> Yes, please.  KVM hosts normally expect guests to not touch MSRs
> >> unless we explicitly tell them the MSR is available (normally
> >> through CPUID).  This is important to ensure live migration
> >> between different host kernel versions works reliably.
> > 
> > The problem is the hardware design for the feature is complete. The
> > hardware designer cannot change the feature enumeration to CPUID or
> > MISC_FEATURES.

Setting a fricking bit in a CPUID leaf or in a MSR cannot be done anymore?
That's just hilarious.

> Let's be honest, though.  That's not *hardware* design; that is a
> microcode update.  We've seen what microcode updates can do _very_
> clearly with all the security issues.  We (Intel) can surely fix this if
> sufficiently motivated.  No?

Amen to that.

And please tell your hardware people that they should stop creating
features which are not enumerated in one way or the other. That's just a
pain all over the place. Boot code, kernel, virt, tools ....

Thanks,

	tglx
