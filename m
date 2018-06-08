Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dXt3AHJ0GluITQAAmS7hNA
	; Fri, 08 Jun 2018 12:20:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B25AB6089E; Fri,  8 Jun 2018 12:20:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0F23C605A5;
	Fri,  8 Jun 2018 12:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F23C605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeFHMU2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:20:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751143AbeFHMU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:20:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DF1D8163C5F;
        Fri,  8 Jun 2018 12:20:26 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D58A5ED17B;
        Fri,  8 Jun 2018 12:20:24 +0000 (UTC)
Date: Fri, 8 Jun 2018 14:20:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 2/2] vfio-ccw: support for halt/clear subchannel
Message-ID: <20180608142022.7dd6a658.cohuck@redhat.com>
In-Reply-To: <86d57698-3ea7-a390-2217-07c6d41ca9ed@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
        <20180509154822.23510-3-cohuck@redhat.com>
        <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
        <20180515181006.0cb1dfc2.cohuck@redhat.com>
        <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
        <20180522145208.310143ea.cohuck@redhat.com>
        <4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
        <20180605151449.22aafbfc.cohuck@redhat.com>
        <e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
        <20180606142131.74ea2eb7.cohuck@redhat.com>
        <5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
        <20180607115442.6a779ed9.cohuck@redhat.com>
        <86d57698-3ea7-a390-2217-07c6d41ca9ed@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 08 Jun 2018 12:20:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 08 Jun 2018 12:20:26 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2018 18:37:16 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 07/06/2018 11:54, Cornelia Huck wrote:

> > --------------
> > |   scsw(g)  |  ssch
> > --------------   |
> >                   |                                       guest
> > --------------------------------------------------------------
> >                   |                                        qemu
> > --------------   v
> > |   scsw(q)  | emulate
> > --------------   |
> >                   |
> > --------------   v
> > |   scsw(r)  | pwrite()
> > --------------   |
> >                   |
> > --------------------------------------------------------------
> >                   |                                        vfio
> >                   v
> >                  ssch
> >                   |
> > --------------------------------------------------------------
> >                   |                                    hardware
> > --------------   v
> > |   scsw(h)  | actually do something
> > --------------
> >
> > The guest issues a ssch (which gets intercepted; it won't get control
> > back until ssch finishes with a cc set.) scsw(g) won't change, unless
> > the guest does a stsch for the subchannel on another vcpu, in which
> > case it will get whatever information qemu holds in scsw(q) at that
> > point in time.
> >
> > When qemu starts to emulate the guest's ssch, it will set the start
> > function bit in the fctl field of scsw(q). It then copies scsw(q) to
> > scsw(r) in the vfio region.
> >
> > The vfio code will then proceed to call ssch on the real subchannel.
> > This is the first time we get really asynchronous, as the ssch will
> > return with cc set and the start function will be performed at some
> > point in time. If we would do a stsch on the real subchannel, we would
> > see that scsw(h) now has the start function bit set.
> >
> > Currently, we won't return back up the chain until we get an interrupt
> > from the hardware, at which time we update the scsw(r) from the irb.  
> 
> I do not find where the thread waits for interrupt inside the
> write->fsm_io_request->fsm_io_helper->ssch chain.
> 
> I must have miss it ten times. Can you point it to me?

I'm not surprised you did not find it, because it isn't there :)

I've let myself be confused by the /* Start channel program and wait
for I/O interrupt. */ comment -- it is wrong and should be removed (but
we did have that waiting initially). So we already have the async
situation :)

> 
> > This will propagate into the scsw(q). At the time we finish handling
> > the guest's ssch and return control to it, we're all done and if the
> > guest does a stsch to update its scsw(g), it will get the current
> > scsw(q) which will already contain the scsw from the interrupt's irb
> > (indicating that the start function is already finished).
> >
> > Now let's imagine we have a future implementation that handles actually
> > performing the start on the hardware asynchronously, i.e. it returns
> > control to the guest without the interrupt having been posted (let's
> > say that it is a longer-running I/O request). If the guest now did a
> > stsch to update scsw(g), it would get the current state of scsw(q),
> > which would be "start function set, but not done yet".
> >
> > If the guest now does a hsch, it would trap in the same way as the ssch
> > before. When qemu gets control, it adds the halt bit in scsw(q) (which
> > is in accordance with the architecture).  
> 
> This I agree.
> The scsw(q) is part of the QEMU device.
> 
> >   My proposal is to do the same
> > copying to scsw(r) again, which would mean we get a request with both
> > the halt and the start bit set. The vfio code now needs to do a hsch
> > (instead of a ssch). The real channel subsystem should figure this out,
> > as we can't reliably check whether the start function has concluded
> > already (there's always a race window).  
> 
> This I do not agree scsw(r) is part of the driver.
> The interface here is not a device interface anymore but a driver 
> interface.
> SCSW is a status, it is at its place in QEMU device interface with the 
> guest
> but here pwrite() sends a command.

Hm, I rather consider that "we write a status, and the backend figures
out what to do based on that status".

> 
> 
> Since we do not do a STSCH on each command, scsw(q), should be
> updated by QEMU depending on syscall return value.
> This is not done currently, only the success path is right
> because it is set before the call.
> 
> If I read right and the IRQ is asynchronous, the scsw(q) is not right,
> because not updated, after the interrupt is received from the guest.

Yes, we're probably missing some updates.
