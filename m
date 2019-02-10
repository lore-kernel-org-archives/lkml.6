Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A57C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 19:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A542D2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 19:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfBJTUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 14:20:39 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37285 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfBJTUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 14:20:38 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gsueL-00005g-Cm; Sun, 10 Feb 2019 20:20:21 +0100
Date:   Sun, 10 Feb 2019 20:20:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
In-Reply-To: <20190205170415.GG17550@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1902102012520.8784@nanos.tec.linutronix.de>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com> <1549084491-57808-9-git-send-email-fenghua.yu@intel.com> <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de> <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com> <20190204195704.GJ29639@zn.tnic>
 <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com> <20190205084857.GK17528@hirez.programming.kicks-ass.net> <ec193a66-b395-ed1a-e39c-40fa1ece3f56@intel.com> <20190205170415.GG17550@hirez.programming.kicks-ass.net>
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

On Tue, 5 Feb 2019, Peter Zijlstra wrote:
> On Tue, Feb 05, 2019 at 07:19:16AM -0800, Dave Hansen wrote:
> > On 2/5/19 12:48 AM, Peter Zijlstra wrote:
> > This isn't something we want everybody and their grandma to turn on;
> > it's a rather specialized feature.  It's really only for folks that care
> > about the latency incurred across the entire system on split lock
> > operations.
> 
> That really should be everyone. That split lock stuff is horrible. There
> is no real down-side to having it always enabled. Code that breaks is
> bad code you want fixed anyway.
> 
> Like I said elsewhere, I wish it would #AC for any unaligned LOCK
> prefix, not just cross-line. I see why we'd not want to traditional RISC
> #AC for every load/store, but atomics really had better be aligned.

Right, we should really make this default enabled.

> > > Is this some transient state; where a few (early) models will not have
> > > the enumeration sorted but all later models will have it all neat and
> > > tidy?
> > 
> > From my understanding, it's not just an early stepping.  It's a
> > generational thing.  The current generation lacks the enumeration and
> > the next generation will get it.  Both have the silicon to implement the
> > feature itself.
> 
> I never said stepping, in fact I explicitly said model.
> 
> > > If so, we can easily do the FMS solution for this.
> > 
> > Yeah, we can.  I honestly forget why we didn't do FMS. :)
> 
> Right so FMS is fairly horrible; but when it is a stop-gap for a limited
> number of models it's waaay better than dodgy cmdline things.

One or two is fine. And _IF_ we get the enumeration sorted before we merge
that, then we can declare the FM list as immutable :)
 
> We could of course try to wrmsr_safe() detect the feature; but that
> might be a problem is the MSR exists on any other models and has a
> different meaning.

Well, yes, but that would be pretty stupid.

Thanks,

	tglx

