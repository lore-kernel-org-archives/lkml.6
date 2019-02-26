Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB6FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2460320842
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfBZLDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:03:24 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:58469 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfBZLDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:03:23 -0500
X-IronPort-AV: E=Sophos;i="5.58,415,1544486400"; 
   d="scan'208";a="86455114"
Date:   Tue, 26 Feb 2019 12:02:31 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Julien Grall <julien.grall@arm.com>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Beulich <JBeulich@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [Xen-devel] xen/evtchn and forced threaded irq
Message-ID: <20190226110231.46luhevhlmefdldo@Air-de-Roger>
References: <f7e78bf6-6e65-6d6c-c1ad-dca7f1e66b17@gmail.com>
 <fe44917f-bbe9-3e0e-fdda-2eb4db9f25c2@arm.com>
 <13a9616c-2d9a-f90b-3358-f2dcadbbb64d@gmail.com>
 <dbfd87e9-48fc-f641-9e24-ddb6c4f61135@arm.com>
 <20190226091420.klgldhotiecezw6h@Air-de-Roger>
 <038b837c-63c0-afb7-ca7b-75f61af7518e@citrix.com>
 <20190226094459.33y2ygrjei3sf3gk@Air-de-Roger>
 <21c331d5-0cfa-6f7e-3db4-40b7ece45bc8@arm.com>
 <20190226101721.kh5vbrqdlnrtvhwh@Air-de-Roger>
 <cdd5781c-3a60-b9f7-205f-fadeee88206e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdd5781c-3a60-b9f7-205f-fadeee88206e@arm.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:26:21AM +0000, Julien Grall wrote:
> Hi,
> 
> On 26/02/2019 10:17, Roger Pau Monné wrote:
> > On Tue, Feb 26, 2019 at 10:03:38AM +0000, Julien Grall wrote:
> > > Hi Roger,
> > > 
> > > On 26/02/2019 09:44, Roger Pau Monné wrote:
> > > > On Tue, Feb 26, 2019 at 09:30:07AM +0000, Andrew Cooper wrote:
> > > > > On 26/02/2019 09:14, Roger Pau Monné wrote:
> > > > > > On Mon, Feb 25, 2019 at 01:55:42PM +0000, Julien Grall wrote:
> > > > > > > Hi Oleksandr,
> > > > > > > 
> > > > > > > On 25/02/2019 13:24, Oleksandr Andrushchenko wrote:
> > > > > > > > On 2/22/19 3:33 PM, Julien Grall wrote:
> > > > > > > > > Hi,
> > > > > > > > > 
> > > > > > > > > On 22/02/2019 12:38, Oleksandr Andrushchenko wrote:
> > > > > > > > > > On 2/20/19 10:46 PM, Julien Grall wrote:
> > > > > > > > > > > Discussing with my team, a solution that came up would be to
> > > > > > > > > > > introduce one atomic field per event to record the number of
> > > > > > > > > > > event received. I will explore that solution tomorrow.
> > > > > > > > > > How will this help if events have some payload?
> > > > > > > > > What payload? The event channel does not carry any payload. It only
> > > > > > > > > notify you that something happen. Then this is up to the user to
> > > > > > > > > decide what to you with it.
> > > > > > > > Sorry, I was probably not precise enough. I mean that an event might have
> > > > > > > > associated payload in the ring buffer, for example [1]. So, counting events
> > > > > > > > may help somehow, but the ring's data may still be lost
> > > > > > >   From my understanding of event channels are edge interrupts. By definition,
> > > > > > IMO event channels are active high level interrupts.
> > > > > > 
> > > > > > Let's take into account the following situation: you have an event
> > > > > > channel masked and the event channel pending bit (akin to the line on
> > > > > > bare metal) goes from low to high (0 -> 1), then you unmask the
> > > > > > interrupt and you get an event injected. If it was an edge interrupt
> > > > > > you wont get an event injected after unmasking, because you would
> > > > > > have lost the edge. I think the problem here is that Linux treats
> > > > > > event channels as edge interrupts, when they are actually level.
> > > > > 
> > > > > Event channels are edge interrupts.  There are several very subtle bugs
> > > > > to be had by software which treats them as line interrupts.
> > > > > 
> > > > > Most critically, if you fail to ack them, rebind them to a new vcpu, and
> > > > > reenable interrupts, you don't get a new interrupt notification.  This
> > > > > was the source of a 4 month bug when XenServer was moving from
> > > > > classic-xen to PVOps where using irqbalance would cause dom0 to
> > > > > occasionally lose interrupts.
> > > > 
> > > > I would argue that you need to mask them first, rebind to a new vcpu
> > > > and unmask, and then you will get an interrupt notification, or this
> > > > should be fixed in Xen to work as you expect: trigger an interrupt
> > > > notification when moving an asserted event channel between CPUs.
> > > > 
> > > > Is there any document that describes how such non trivial things (like
> > > > moving between CPUs) work for event/level interrupts?
> > > > 
> > > > Maybe I'm being obtuse, but from the example I gave above it's quite
> > > > clear to me event channels don't get triggered based on edge changes,
> > > > but rather on the line level.
> > > 
> > > Your example above is not enough to give the semantics of level. You would
> > > only use the MASK bit if your interrupt handler is threaded to avoid the
> > > interrupt coming up again.
> > > 
> > > So if you remove the mask from the equation, then the interrupt flow should be:
> > > 
> > > 1) handle interrupt
> > > 2) EOI
> > 
> > This is bogus if you don't mask the interrupt source. You should
> > instead do
> > 
> > 1) EOI
> > 2) Handle interrupt
> > 
> > And loop over this.
> So that's not a level semantics. It is a edge one :). In the level case, you
> would clear the state once you are done with the interrupt.
> 
> Also, it would be ACK and not EOI.

For level triggered interrupts you have to somehow signal the device
to stop asserting the line, which doesn't happen for Xen devices
because they just signal interrupts to Xen, but don't have a way to
keep event channels asserted, so I agree that this is different from
traditional level interrupts because devices using event channels
don't have a way to keep lines asserted.

I guess the most similar native interrupt is MSI with masking
support?

Roger.
