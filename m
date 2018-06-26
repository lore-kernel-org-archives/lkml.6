Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA09C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4453926809
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4453926809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933677AbeFZJlB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:41:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49277 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932206AbeFZJlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:41:00 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fXkSw-0005p3-GY; Tue, 26 Jun 2018 11:40:50 +0200
Date:   Tue, 26 Jun 2018 11:40:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Alan Cox <alan@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 06/16] x86/split_lock: Save #AC setting for split
 lock in firmware in boot time and restore the setting in reboot
In-Reply-To: <20180626090521.GF2494@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1806261115480.2204@nanos.tec.linutronix.de>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com> <1527435965-202085-7-git-send-email-fenghua.yu@intel.com> <20180621195823.GD13636@worktop.programming.kicks-ass.net> <1529680267.4364.50.camel@linux.intel.com>
 <20180626090521.GF2494@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018, Peter Zijlstra wrote:
> On Fri, Jun 22, 2018 at 04:11:07PM +0100, Alan Cox wrote:
> > On Thu, 2018-06-21 at 21:58 +0200, Peter Zijlstra wrote:
> > > On Sun, May 27, 2018 at 08:45:55AM -0700, Fenghua Yu wrote:
> > > > Firmware may contain split locked instructions.
> > > 
> > > I think that's the wrong attitude. You should mandate in your BIOS
> > > development guide that Firmware _MUST_NOT_ contain unaligned LOCK
> > > prefixed instructions.
> > > 
> > 
> > In the longer term I would agree entirely with that sentiment.
> 
> But then how do we deal with SMIs ? The firmware people will at least
> need to know about this, and the quick fix is to make the SMI handler
> save/restore the MSR, but since they're aware and already changing their
> code, they might as well fix the actual problem -- which is likely
> trivial.
> 
> So no, I don't buy it. Just fix the firmware instead of allowing them to
> fester and grow layers of ducttape.
> 
> Because even for SMM WRMSR is 100s of cycles, and why would they want to
> make every single SMI more expensive.
> 
> Also, as mentioned earlier, what are we going to do about SMIs in
> general? They're a _far_ _FAR_ bigger problem for RT workloads than a
> sporadic split atomic. Esp. with some vendors thinking they can run
> bitcoin miners in SMI (or whatever else it is that is taking miliseconds
> of compute time).
> 
> Split atomics are an insignificant problem compared to the nightmare
> trainwreck that is SMM.

Aside of that, the split lock detection is only available for not yet
released silicon. So there is absolutely _ZERO_ reason to force the kernel
to deal with broken BIOSes. This would be a different story if the feature
would break gazillion of shipped systems.

So there is no 'In the longer term'. It's still enough time to fix the BIOS
hackery _before_ any of this hits a production line.

Ergo. This is not going to go anywhere near the x86 kernel code ever. We
are not fostering completely avoidable engineering trainwrecks.

To be honest, this part of the patch set should have never seen the light
of LKML and we neither should have that discussion in the first place.

Thanks,

	tglx
