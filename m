Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C75ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3F620882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3F620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeINUd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:33:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35632 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINUdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:33:55 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0pry-0008Jg-Mv; Fri, 14 Sep 2018 15:18:54 +0000
Date:   Fri, 14 Sep 2018 16:18:54 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Johan Hovold <johan@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/50] tty_ioctl(): start taking TIOC[SG]SERIAL into
 separate methods
Message-ID: <20180914151854.GA19965@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-5-viro@ZenIV.linux.org.uk>
 <20180914132216.GC1362@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914132216.GC1362@localhost>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 03:22:16PM +0200, Johan Hovold wrote:
> On Thu, Sep 13, 2018 at 03:40:04AM +0100, Al Viro wrote:
> > From: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > ->set_serial() and ->get_serial() resp., both taking tty and
> > a kernel pointer to serial_struct.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  drivers/tty/tty_io.c       | 36 ++++++++++++++++++++++++++++++------
> >  include/linux/tty_driver.h |  3 +++
> >  2 files changed, 33 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> > index 2b34ccf269e0..91d73732e11c 100644
> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -97,6 +97,7 @@
> >  #include <linux/seq_file.h>
> >  #include <linux/serial.h>
> >  #include <linux/ratelimit.h>
> > +#include <linux/compat.h>
> 
> Looks like you don't need this (just yet anyway).

Actually, that should've been added several commits earlier ;-)

> >  #include <linux/uaccess.h>
> >  
> > @@ -2455,22 +2456,40 @@ static int tty_tiocgicount(struct tty_struct *tty, void __user *arg)
> >  	return 0;
> >  }
> 
> [...]
> 
> > +static int tty_tiocgserial(struct tty_struct *tty, struct serial_struct __user *ss)
> > +{
> > +	struct serial_struct v;
> > +	int err;
> 
> Missing newline.

Umm...  Matter of taste, but since you work in that area more often than
I do...  Note, BTW, that tty_tiocgicount() just a bit above that place also
doesn't follow that style.  Anyway, I don't care either way - if you want
an empty line in that, no problem.

> > +	memset(&v, 0, sizeof(struct serial_struct));
> > +
> > +	if (!tty->ops->set_serial)
> 
> You want get_serial here.

Nice catch.  Fixed.

> > +		return -ENOIOCTLCMD;
> > +	err = tty->ops->get_serial(tty, &v);
> > +	if (!err && copy_to_user(ss, &v, sizeof(struct serial_struct)))
> > +		err = -EFAULT;
> > +	return err;
> >  }
> >  
> >  /*
> > @@ -2602,8 +2621,13 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >  		}
> >  		break;
> >  	case TIOCSSERIAL:
> > -		tty_warn_deprecated_flags(p);
> > -		break;
> > +		retval = tty_tiocsserial(tty, p);
> > +		if (retval != -ENOIOCTLCMD)
> > +			return retval;
> 
> Missing break.

*blink*
Right you are... that's a bisect hazard (in the end of the series returns
become unconditional anyway).  Fixed.
