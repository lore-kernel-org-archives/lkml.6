Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 46C3AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C5A2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C5A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933466AbeFLSuf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:50:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932343AbeFLSuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:50:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C3C787A73;
        Tue, 12 Jun 2018 18:50:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F24EC111CA18;
        Tue, 12 Jun 2018 18:50:29 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5CIoTNw028373;
        Tue, 12 Jun 2018 14:50:29 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5CIoTL4028369;
        Tue, 12 Jun 2018 14:50:29 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 12 Jun 2018 14:50:29 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Alan Stern <stern@rowland.harvard.edu>,
        Ming Lei <ming.lei@redhat.com>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: don't offload isochronous urb completions to
 ksoftirq
In-Reply-To: <20180612175242.GA12855@kroah.com>
Message-ID: <alpine.LRH.2.02.1806121403260.14879@file01.intranet.prod.int.rdu2.redhat.com>
References: <Pine.LNX.4.44L0.1806121232460.1582-100000@iolanthe.rowland.org> <alpine.LRH.2.02.1806121304530.1848@file01.intranet.prod.int.rdu2.redhat.com> <20180612175242.GA12855@kroah.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 12 Jun 2018 18:50:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 12 Jun 2018 18:50:32 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Jun 2018, Greg Kroah-Hartman wrote:

> On Tue, Jun 12, 2018 at 01:19:28PM -0400, Mikulas Patocka wrote:
> > 
> > 
> > On Tue, 12 Jun 2018, Alan Stern wrote:
> > 
> > > On Tue, 12 Jun 2018, Mikulas Patocka wrote:
> > > 
> > > > > How about making the softirq thread's priority adjustable?
> > > > 
> > > > But you would have to argue with softirq maintainers about it - and you 
> > > > say that you don't have time for that.
> > > 
> > > But maybe _you_ do...
> > 
> > ksoftirqd has priority 0 - it is not suitable for real-time tasks, such as 
> > audio.
> > 
> > In my opinion, it is much easier to fix this in the ehci driver (by not 
> > offloading isochronous completions), than to design a new 
> > real-time-capable ksoftirqd.
> 
> Ok, but what happens when you plug your device into a xhci controller?
> Do we also need to change that?  Only touching a specific host
> controller is not good, you will be playing "whack a mole" for forever.

xhci doesn't set the HCD_BH flag, so it doesn't offload callbacks to 
softirq and doesn't suffer from this problem. Neither ohci and uhci do.

> Isoc packets are, by definition, not supposed to be guaranteed at all.
> So if they are "slow" or dropped or delayed somehow, that's fine.  The
> sound protocol should be fine with it.

The sound USB protocol doesn't provide any redundancy - so a missed packet 
means audible clipping.

There are crappy USB controllers that skip an isochronous packet when they 
encounter too high memory latency - they are unuseable for audio - but 
this is not the problem here.

The USB specification doesn't allow re-sending failed isochronous packets.

> Now yes, in reality, as you have found out, things can be "tight" on
> low-powered processors under heavy load.  But what you are doing here is
> a priority inversion.  You do not solve such a thing by going around and
> raising everything else up as well, this is supposed to be a "general
> purpose" kernel.  You can tune a specific machine/device just fine this
> way, but not by messing with the kernel for the most part.
> 
> > snd_complete_urb is doing nothing but submitting the same urb again. Is 
> > resubmitting the urb really causing so much latency that you can't do it 
> > in the interrupt handler?
> 
> snd_complete_urb() does much more than just submition of the same urb.

How is snd_complete_urb() different from a hard-irq handler of a PCI sound 
card? AFAIK sound irq handlers just set the current position in the ring 
and wake up a process that wants to read or write to the ring. This is so 
simple task, that there's no reason to offload it to softirq.

> Perhaps if this is a real problem, the sound driver should have more
> than one urb pending?  Is there a pool here that is somehow getting used
> up?

It has 12 urbs - but it means that 12ms scheduling latency (which is 
common) means sound skipping.

Games or proffesional sound applications need bounded sound latency, so 
you can't just increase the number of urbs arbitrarily.

> thanks,
> 
> greg k-h

Mikulas
