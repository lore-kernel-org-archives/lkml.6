Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E529ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A798B2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A798B2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeGMIpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:45:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47162 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeGMIpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:45:33 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A8756AEF;
        Fri, 13 Jul 2018 08:31:56 +0000 (UTC)
Date:   Fri, 13 Jul 2018 10:31:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, devel@driverdev.osuosl.org,
        kirk@reisers.ca, speakup@linux-speakup.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Christopher Brannon <chris@the-brannons.com>
Subject: Re: [PATCH] staging: speakup: fix wraparound in uaccess length check
Message-ID: <20180713083154.GA21160@kroah.com>
References: <20180712222935.257776-1-jannh@google.com>
 <20180712224753.GE30522@ZenIV.linux.org.uk>
 <CAG48ez0ZLzh1L8HieUJ+UmbQewRMc_0hwJG7-MB=WR1h=VagZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0ZLzh1L8HieUJ+UmbQewRMc_0hwJG7-MB=WR1h=VagZA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 04:12:39PM -0700, Jann Horn wrote:
> On Thu, Jul 12, 2018 at 3:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Fri, Jul 13, 2018 at 12:29:36AM +0200, Jann Horn wrote:
> > > From: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > >
> > > From: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > >
> > > If softsynthx_read() is called with `count < 3`, `count - 3` wraps, causing
> > > the loop to copy as much data as available to the provided buffer. If
> > > softsynthx_read() is invoked through sys_splice(), this causes an
> > > unbounded kernel write; but even when userspace just reads from it
> > > normally, a small size could cause userspace crashes.
> >
> > Or you could try this (completely untested, though):
> 
> I think this has the same problem as my original buggy patch: At the
> point where you notice that you'd overflow the buffer, you've already
> consumed a character from the synth buffer. You'd have to put it back,
> and since the spinlock protecting it has been dropped, that's a bit
> weird.
> 
> Also, I'm not sure whether Greg prefers fixes for stable kernels that
> don't also contain cleanup?

For staging code, I really don't care, as long as it's fixing an issue :)

thanks,

greg k-h
