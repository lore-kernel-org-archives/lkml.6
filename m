Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82209C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4441F206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c08PxAGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4441F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbeLEKFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:05:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:42074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728776AbeLEKFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:05:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3C5D214E0;
        Wed,  5 Dec 2018 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544004348;
        bh=zmI3xgVUHVO0bw3kVraysC3RJPzNCNM27uR/IBfVrgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c08PxAGcNHneCgS20jVxrsb0oeH68DRH3/KbKcDxEU+cslMb+STs19FTPnb5htrFg
         duAr09gGY4p4qdXLpsmwKi+UxhRxYID0KzvkMJaTYg15dvOiOB4hkk7YS1Qc5Vc08a
         FCEL0dUyL4GShOC8rejhNavj62PZ+4/3FOi+v38I=
Date:   Wed, 5 Dec 2018 11:05:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-usb@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Florian Zumbiehl <florz@florz.de>
Subject: Re: [PATCH] USB: serial: console: fix reported terminal settings
Message-ID: <20181205100545.GA23483@kroah.com>
References: <20181204155904.GC18087@localhost>
 <20181204160036.24625-1-johan@kernel.org>
 <20181204161518.GA17941@kroah.com>
 <20181204163155.GD18087@localhost>
 <4e395eb4-739a-05df-e14d-e32f9cfefdd3@linux.intel.com>
 <20181205095049.GA15689@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205095049.GA15689@localhost>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:50:49AM +0100, Johan Hovold wrote:
> On Wed, Dec 05, 2018 at 11:36:52AM +0200, Jarkko Nikula wrote:
> > On 12/4/18 6:31 PM, Johan Hovold wrote:
> > > On Tue, Dec 04, 2018 at 05:15:18PM +0100, Greg Kroah-Hartman wrote:
> > >> On Tue, Dec 04, 2018 at 05:00:36PM +0100, Johan Hovold wrote:
> > >>> The USB-serial console implementation has never reported the actual
> > >>> terminal settings used. Despite storing the corresponding cflags in its
> > >>> struct console, this was never honoured on later tty open() where the
> > >>> tty termios would be left initialised to the driver defaults.
> > >>>
> > >>> Unlike the serial console implementation, the USB-serial code calls
> > >>> subdriver open() already at console setup. While calling set_termios()
> > >>> before open() looks like it could work for some USB-serial drivers,
> > >>> others definitely do not expect this, so modelling this after serial
> > >>> core is going to be intrusive, if at all possible.
> 
> > >>> This specifically fixes a regression that was triggered by a recent
> > >>> change adding software flow control to the pl2303 driver: a getty trying
> > >>> to disable flow control while leaving the baud rate unchanged would now
> > >>> also set the baud rate to the driver default (prior to the flow-control
> > >>> change this had been a noop).
> > >>>
> > >>> Fixes: 7041d9c3f01b ("USB: serial: pl2303: add support for tx xon/xoff flow control")
> > >>> Cc: stable <stable@vger.kernel.org>	# 4.18
> > >>> Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > >>> Cc: Florian Zumbiehl <florz@florz.de>
> > >>> Signed-off-by: Johan Hovold <johan@kernel.org>
> > >>> ---
> > >>>   drivers/tty/tty_io.c         | 11 +++++++++--
> > >>>   drivers/usb/serial/console.c |  2 +-
> > >>>   include/linux/tty.h          |  1 +
> > >>>   3 files changed, 11 insertions(+), 3 deletions(-)
> > >>
> > >> Ah, messy :)
> > >>
> > >> Want me to take this through my tty tree?
> > > 
> > > If you prefer. I was planning on including this in a USB-serial pull
> > > request for -rc6 since it fixes a user-reported regression, but perhaps
> > > taking this through your tty-linus branch (which already holds a console
> > > fix) is easier/faster.
> > > 
> > > We should wait for Jarkko to confirm that this fixes the problem he
> > > reported first, though.
> > > 
> > Great, this fixed the issue for both pl2303 based adapters I reported.
> > 
> > Tested on top of 0072a0c14d5b ("Merge tag 'media/v4.20-4' of 
> > git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media")
> > 
> > Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> 
> Great, thanks for testing.
> 
> Greg, I noticed I left out the part about subdrivers not expecting
> *write()* to be called before open() so I'll amend the commit message
> when applying and include this one in a pull-request tomorrow, if that's
> ok with you?

Sure, that's fine.

> Note that the changes to tty are trivial; I'm just renaming and
> exporting an existing helper.

Yeah, I have no objections to them.  We can take them in my usb tree.

thanks,

greg k-h
