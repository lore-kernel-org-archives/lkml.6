Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC08C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CAC217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfBZJOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:14:48 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:53541 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfBZJOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:14:48 -0500
X-IronPort-AV: E=Sophos;i="5.58,415,1544486400"; 
   d="scan'208";a="86450557"
Date:   Tue, 26 Feb 2019 10:14:20 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Julien Grall <julien.grall@arm.com>
CC:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Beulich <JBeulich@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [Xen-devel] xen/evtchn and forced threaded irq
Message-ID: <20190226091420.klgldhotiecezw6h@Air-de-Roger>
References: <20190220000209.GA4091@localhost.localdomain>
 <a872d480-9f1b-6cd7-e507-ac4fcdf705af@arm.com>
 <21214d47-9c68-e6bf-007a-4047cc2b02f9@oracle.com>
 <8f7445d7-fa50-f3e9-44f5-cc2aebd020f4@arm.com>
 <15bc52cb-82d8-4d2c-e5a8-c6ae8de90276@oracle.com>
 <5df8888a-4a29-fccd-bac2-a9c170244029@arm.com>
 <f7e78bf6-6e65-6d6c-c1ad-dca7f1e66b17@gmail.com>
 <fe44917f-bbe9-3e0e-fdda-2eb4db9f25c2@arm.com>
 <13a9616c-2d9a-f90b-3358-f2dcadbbb64d@gmail.com>
 <dbfd87e9-48fc-f641-9e24-ddb6c4f61135@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dbfd87e9-48fc-f641-9e24-ddb6c4f61135@arm.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 01:55:42PM +0000, Julien Grall wrote:
> Hi Oleksandr,
> 
> On 25/02/2019 13:24, Oleksandr Andrushchenko wrote:
> > On 2/22/19 3:33 PM, Julien Grall wrote:
> > > Hi,
> > > 
> > > On 22/02/2019 12:38, Oleksandr Andrushchenko wrote:
> > > > On 2/20/19 10:46 PM, Julien Grall wrote:
> > > > > Discussing with my team, a solution that came up would be to
> > > > > introduce one atomic field per event to record the number of
> > > > > event received. I will explore that solution tomorrow.
> > > > How will this help if events have some payload?
> > > 
> > > What payload? The event channel does not carry any payload. It only
> > > notify you that something happen. Then this is up to the user to
> > > decide what to you with it.
> > Sorry, I was probably not precise enough. I mean that an event might have
> > associated payload in the ring buffer, for example [1]. So, counting events
> > may help somehow, but the ring's data may still be lost
> 
> From my understanding of event channels are edge interrupts. By definition,

IMO event channels are active high level interrupts.

Let's take into account the following situation: you have an event
channel masked and the event channel pending bit (akin to the line on
bare metal) goes from low to high (0 -> 1), then you unmask the
interrupt and you get an event injected. If it was an edge interrupt
you wont get an event injected after unmasking, because you would
have lost the edge. I think the problem here is that Linux treats
event channels as edge interrupts, when they are actually level.

Roger.
