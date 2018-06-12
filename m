Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6973EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1190620891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghBD451V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1190620891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754378AbeFLRxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754056AbeFLRxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:53:04 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 198C220891;
        Tue, 12 Jun 2018 17:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528825983;
        bh=aAERSOix1p8OcjwrDDU6VsLhS/tV9+fgqFMBu11b3gM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ghBD451VimzzB+fTV1vTZEZXnxdX9ECopmCIW2HwKcoVaWV+Wla9Vua6jE9skwfef
         5oVL3Zv/5E43XN6OHpMILaVi32v72/rL3EawH9G7utxCSac8eL3vosHN1iJ5Y03EmT
         t1I45w6I9dsk8DO4P2s1dJprzpEEfW2GLcz8G1Ao=
Date:   Tue, 12 Jun 2018 19:52:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Ming Lei <ming.lei@redhat.com>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: don't offload isochronous urb completions to
 ksoftirq
Message-ID: <20180612175242.GA12855@kroah.com>
References: <Pine.LNX.4.44L0.1806121232460.1582-100000@iolanthe.rowland.org>
 <alpine.LRH.2.02.1806121304530.1848@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1806121304530.1848@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 01:19:28PM -0400, Mikulas Patocka wrote:
> 
> 
> On Tue, 12 Jun 2018, Alan Stern wrote:
> 
> > On Tue, 12 Jun 2018, Mikulas Patocka wrote:
> > 
> > > > How about making the softirq thread's priority adjustable?
> > > 
> > > But you would have to argue with softirq maintainers about it - and you 
> > > say that you don't have time for that.
> > 
> > But maybe _you_ do...
> 
> ksoftirqd has priority 0 - it is not suitable for real-time tasks, such as 
> audio.
> 
> In my opinion, it is much easier to fix this in the ehci driver (by not 
> offloading isochronous completions), than to design a new 
> real-time-capable ksoftirqd.

Ok, but what happens when you plug your device into a xhci controller?
Do we also need to change that?  Only touching a specific host
controller is not good, you will be playing "whack a mole" for forever.

Isoc packets are, by definition, not supposed to be guaranteed at all.
So if they are "slow" or dropped or delayed somehow, that's fine.  The
sound protocol should be fine with it.

Now yes, in reality, as you have found out, things can be "tight" on
low-powered processors under heavy load.  But what you are doing here is
a priority inversion.  You do not solve such a thing by going around and
raising everything else up as well, this is supposed to be a "general
purpose" kernel.  You can tune a specific machine/device just fine this
way, but not by messing with the kernel for the most part.

> > > > As for coordinating with the softirq maintainers -- whether I want to 
> > > > or not isn't the issue.  Right now I don't have _time_ to do it.
> > > > 
> > > > Alan Stern
> > > 
> > > I am wondering - whats the purpose of that patch 
> > > 428aac8a81058e2303677a8fbf26670229e51d3a at all? The patch shows some 
> > > performance difference, but they are minor, about 1%.
> > > 
> > > If you want to call the urb callback as soon as possible - why don't you 
> > > just call it? Why do you need to offload the callback to a softirq thread?
> > 
> > Please read the Changelog entry for commit 94dfd7edfd5c.  Basically the 
> > idea was to reduce overall latency by not doing as much work in an 
> > interrupt handler.
> > 
> > Alan Stern
> 
> snd_complete_urb is doing nothing but submitting the same urb again. Is 
> resubmitting the urb really causing so much latency that you can't do it 
> in the interrupt handler?

snd_complete_urb() does much more than just submition of the same urb.
Perhaps if this is a real problem, the sound driver should have more
than one urb pending?  Is there a pool here that is somehow getting used
up?

thanks,

greg k-h
