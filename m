Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C571ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F215C208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F215C208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbeGPLLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:11:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35764 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeGPLLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:11:04 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EF2D989B;
        Mon, 16 Jul 2018 10:44:13 +0000 (UTC)
Date:   Mon, 16 Jul 2018 12:44:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tty: support CIBAUD without BOTHER
Message-ID: <20180716104411.GA11023@kroah.com>
References: <20180715133935.24964-1-johan@kernel.org>
 <20180715133935.24964-4-johan@kernel.org>
 <20180716100028.GA20101@kroah.com>
 <20180716101824.GK10204@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716101824.GK10204@localhost>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:18:24PM +0200, Johan Hovold wrote:
> On Mon, Jul 16, 2018 at 12:00:28PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Jul 15, 2018 at 03:39:35PM +0200, Johan Hovold wrote:
> > > Since commit edc6afc54968 ("[PATCH] tty: switch to ktermios and new
> > > framework") arbitrary baud rates can be requested using BOTHER and input
> > > rates can be requested using the termios CIBAUD bits (CBAUD shifted
> > > IBSHIFT bits).
> > > 
> > > This functionality has been conditionally compiled depending on whether
> > > an architecture defines BOTHER and IBSHIFT respectively, but would in
> > > fact fail to compile unless both symbols were defined due to cross
> > > dependencies.
> > > 
> > > Relax the IBSHIFT => BOTHER dependency so that an architecture could
> > > theoretically support CIBAUD without the Linux-specific BOTHER, while
> > > hopefully making the current conditional-compilation directives a bit
> > > less confusing.
> > > 
> > > Note that the long-term goal is still to have all architectures support
> > > both features, so an alternative could just be to have the lot depend on
> > > BOTHER.
> > 
> > I thought we had all arches converted to use BOTHER already, what ones
> > are not yet done?  It's hard to unwind the asm-generic use of termbits.h
> > to obviously see which ones are not doing this yet, any ideas?
> 
> It looks like alpha does not yet define BOTHER at least.

Someday we will get to delete alpha and many people will be happy :)

> > Oh, and thanks for fixing this all up, odd that no one has noticed it
> > before.
> 
> Probably due to there being no in-tree drivers that support separate
> input rates. And with no glibc support for BOTHER (still), it's somewhat
> less likely that people will trigger the bug that could end up setting
> CIBAUD for them.

Ugh, I thought glibc got support for it, I guess everyone just
hand-codes it in their applications for now.  Sad.

Anyway, thanks for the patches, all now applied.

greg k-h
