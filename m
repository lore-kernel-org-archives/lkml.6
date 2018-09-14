Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC99FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98CE20833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98CE20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeINXci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:32:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53420 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeINXci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:32:38 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 78F6BBBF;
        Fri, 14 Sep 2018 18:16:58 +0000 (UTC)
Date:   Fri, 14 Sep 2018 20:16:56 +0200
From:   gregkh <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/50] move compat handling of tty ioctls to
 tty_compat_ioctl()
Message-ID: <20180914181656.GB20521@kroah.com>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-2-viro@ZenIV.linux.org.uk>
 <CAK8P3a1feqfJOTvQEC+tmdYToGzL0zmKLQmGzPe-UQry0AuW-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1feqfJOTvQEC+tmdYToGzL0zmKLQmGzPe-UQry0AuW-g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 05:15:52PM +0200, Arnd Bergmann wrote:
> On Thu, Sep 13, 2018 at 4:40 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > From: Al Viro <viro@zeniv.linux.org.uk>
> >
> > ioctls that are
> >         * callable only via tty_ioctl()
> >         * not driver-specific
> >         * not demand data structure conversions
> >         * either always need passing arg as is or always demand compat_ptr()
> > get intercepted in tty_compat_ioctl() from the very beginning and
> > redirecter to tty_ioctl().  As the result, their entries in fs/compat_ioctl.c
> > (some of those had been missing, BTW) got removed, as well as
> > n_tty_compat_ioctl_helper() (now it's never called with any cmd it would accept).
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> One more thing I just remembered when looking at my obsolete patches:
> Your patch is fixing a couple of ioctl commands (I had identified only
> TIOCVHANGUP and TIOCGPTPEER, you found a couple more)
> 
> It would be good to mark those as cc:stable@vger.kernel.org so we
> can also get the fixes into older kernels. Looking through the
> series again, I did not spot anything else that we need in stable,
> in particular I would not bother with the compat_ptr() fixups there,
> and the many cleanups of dead code and setserial wouldn't
> be stable material anyway, but missing translation seems important
> enough.
> 
> Looking at the changes in your patches, these are the ones
> that you add in tty_compat_ioctl() that did not have a corresponding
> entry in fs/compat_ioctl.c:
> 
> +       case TCSETX:
> +       case TCSETXF:
> +       case TCSETXW:
> +       case TIOCGETC:
> +       case TIOCGETP:
> +       case TIOCGPTPEER:
> +       case TIOCSERCONFIG:
> +       case TIOCSETC:
> +       case TIOCSETN:
> +       case TIOCSETP:
> +       case TIOCVHANGUP:
> 
> Should these all be added in a stable backport patch?

Why?  What is being "fixed" here that anyone has noticed before that is
causing problems in those old kernels?  If no one has complained about
the lack of compat fixups, well...  :)

thanks,

greg k-h
