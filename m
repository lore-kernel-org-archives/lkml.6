Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DD3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9DB2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfBUIIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:08:06 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:26454 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfBUIIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:08:05 -0500
X-IronPort-AV: E=Sophos;i="5.58,394,1544486400"; 
   d="scan'208";a="86246065"
Date:   Thu, 21 Feb 2019 09:07:52 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Julien Grall <julien.grall@arm.com>
CC:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Beulich <JBeulich@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Dave P Martin <dave.martin@arm.com>
Subject: Re: [Xen-devel] xen/evtchn and forced threaded irq
Message-ID: <20190221080752.zy2qlzb4vi7tbu3p@Air-de-Roger>
References: <5e256d9a-572c-e01e-7706-407f99245b00@arm.com>
 <20190220000209.GA4091@localhost.localdomain>
 <a872d480-9f1b-6cd7-e507-ac4fcdf705af@arm.com>
 <21214d47-9c68-e6bf-007a-4047cc2b02f9@oracle.com>
 <8f7445d7-fa50-f3e9-44f5-cc2aebd020f4@arm.com>
 <15bc52cb-82d8-4d2c-e5a8-c6ae8de90276@oracle.com>
 <5df8888a-4a29-fccd-bac2-a9c170244029@arm.com>
 <1574a7fe-a5ac-4bc2-d3f0-967d8d01e5f1@oracle.com>
 <1100e6b1-6fa8-06f0-8ecc-b0699a2ce5f4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1100e6b1-6fa8-06f0-8ecc-b0699a2ce5f4@arm.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:03:57PM +0000, Julien Grall wrote:
> Hi Boris,
> 
> On 2/20/19 9:46 PM, Boris Ostrovsky wrote:
> > On 2/20/19 3:46 PM, Julien Grall wrote:
> > > (+ Andrew and Jan for feedback on the event channel interrupt)
> > > 
> > > Hi Boris,
> > > 
> > > Thank you for the your feedback.
> > > 
> > > On 2/20/19 8:04 PM, Boris Ostrovsky wrote:
> > > > On 2/20/19 1:05 PM, Julien Grall wrote:
> > > > > Hi,
> > > > > 
> > > > > On 20/02/2019 17:07, Boris Ostrovsky wrote:
> > > > > > On 2/20/19 9:15 AM, Julien Grall wrote:
> > > > > > > Hi Boris,
> > > > > > > 
> > > > > > > Thank you for your answer.
> > > > > > > 
> > > > > > > On 20/02/2019 00:02, Boris Ostrovsky wrote:
> > > > > > > > On Tue, Feb 19, 2019 at 05:31:10PM +0000, Julien Grall wrote:
> > > > > > > > > Hi all,
> > > > > > > > > 
> > > > > > > > > I have been looking at using Linux RT in Dom0. Once the guest is
> > > > > > > > > started,
> > > > > > > > > the console is ending to have a lot of warning (see trace below).
> > > > > > > > > 
> > > > > > > > > After some investigation, this is because the irq handler will now
> > > > > > > > > be threaded.
> > > > > > > > > I can reproduce the same error with the vanilla Linux when passing
> > > > > > > > > the option
> > > > > > > > > 'threadirqs' on the command line (the trace below is from 5.0.0-rc7
> > > > > > > > > that has
> > > > > > > > > not RT support).
> > > > > > > > > 
> > > > > > > > > FWIW, the interrupt for port 6 is used to for the guest to
> > > > > > > > > communicate with
> > > > > > > > > xenstore.
> > > > > > > > > 
> > > > > > > > >     From my understanding, this is happening because the interrupt
> > > > > > > > > handler is now
> > > > > > > > > run in a thread. So we can have the following happening.
> > > > > > > > > 
> > > > > > > > >        Interrupt context            |     Interrupt thread
> > > > > > > > >                                     |
> > > > > > > > >        receive interrupt port 6     |
> > > > > > > > >        clear the evtchn port        |
> > > > > > > > >        set IRQF_RUNTHREAD            |
> > > > > > > > >        kick interrupt thread        |
> > > > > > > > >                                     |    clear IRQF_RUNTHREAD
> > > > > > > > >                                     |    call evtchn_interrupt
> > > > > > > > >        receive interrupt port 6     |
> > > > > > > > >        clear the evtchn port        |
> > > > > > > > >        set IRQF_RUNTHREAD           |
> > > > > > > > >        kick interrupt thread        |
> > > > > > > > >                                     |    disable interrupt port 6
> > > > > > > > >                                     |    evtchn->enabled = false
> > > > > > > > >                                     |    [....]
> > > > > > > > >                                     |
> > > > > > > > >                                     |    *** Handling the second
> > > > > > > > > interrupt ***
> > > > > > > > >                                     |    clear IRQF_RUNTHREAD
> > > > > > > > >                                     |    call evtchn_interrupt
> > > > > > > > >                                     |    WARN(...)
> > > > > > > > > 
> > > > > > > > > I am not entirely sure how to fix this. I have two solutions in
> > > > > > > > > mind:
> > > > > > > > > 
> > > > > > > > > 1) Prevent the interrupt handler to be threaded. We would also
> > > > > > > > > need to
> > > > > > > > > switch from spin_lock to raw_spin_lock as the former may sleep on
> > > > > > > > > RT-Linux.
> > > > > > > > > 
> > > > > > > > > 2) Remove the warning
> > > > > > > > 
> > > > > > > > I think access to evtchn->enabled is racy so (with or without the
> > > > > > > > warning) we can't use it reliably.
> > > > > > > 
> > > > > > > Thinking about it, it would not be the only issue. The ring is sized
> > > > > > > to contain only one instance of the same event. So if you receive
> > > > > > > twice the event, you may overflow the ring.
> > > > > > 
> > > > > > Hm... That's another argument in favor of "unthreading" the handler.
> > > > > 
> > > > > I first thought it would be possible to unthread it. However,
> > > > > wake_up_interruptible is using a spin_lock. On RT spin_lock can sleep,
> > > > > so this cannot be used in an interrupt context.
> > > > > 
> > > > > So I think "unthreading" the handler is not an option here.
> > > > 
> > > > That sounds like a different problem. I.e. there are two issues:
> > > > * threaded interrupts don't work properly (races, ring overflow)
> > > > * evtchn_interrupt() (threaded or not) has spin_lock(), which is not
> > > > going to work for RT
> > > 
> > > I am afraid that's not correct, you can use spin_lock() in threaded
> > > interrupt handler.
> > 
> > In non-RT handler -- yes, but not in an RT one (in fact, isn't this what
> > you yourself said above?)
> 
> In RT-linux, interrupt handlers are threaded by default. So the handler will
> not run in the interrupt context. Hence, it will be safe to call spin_lock.
> 
> However, if you force the handler to not be threaded (IRQF_NO_THREAD), it
> will run in interrupt context.
> 
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > Another alternative could be to queue the irq if !evtchn->enabled
> > > > > > > > and
> > > > > > > > handle it in evtchn_write() (which is where irq is supposed to be
> > > > > > > > re-enabled).
> > > > > > > What do you mean by queue? Is it queueing in the ring?
> > > > > > 
> > > > > > 
> > > > > > No, I was thinking about having a new structure for deferred
> > > > > > interrupts.
> > > > > 
> > > > > Hmmm, I am not entirely sure what would be the structure here. Could
> > > > > you expand your thinking?
> > > > 
> > > > Some sort of a FIFO that stores {irq, data} tuple. It could obviously be
> > > > implemented as a ring but not necessarily as Xen shared ring (if that's
> > > > what you were referring to).
> > > 
> > > The underlying question is what happen if you miss an interrupt. Is it
> > > going to be ok?
> > 
> > This I am not sure about. I thought yes since we are signaling the
> > process only once.
> 
> I have CCed Andrew and Jan to see if they can help here.

FWIW, you can also mask the interrupt while waiting for the thread to
execute the interrupt handler. Ie:

1. Interrupt injected
2. Execute guest event channel callback
3. Scan for pending interrupts
4. Mask interrupt
5. Clear pending field
6. Queue threaded handler
7. Go to 3 until all interrupts are drained
[...]
8. Execute interrupt handler in thread
9. Unmask interrupt

That should prevent you from stacking interrupts?

Roger.
