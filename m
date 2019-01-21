Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C76DC2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F66320844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548087267;
	bh=8wqUUJDp1SS+S+URHP1+SBaWxivk10CdTy6Q5Qlauu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=udPn9GvPLWZAu5iR4PLCBjM+iaRO+yURRciIVDQrG8Bwo7Js0UiwKD+eIjNW68fE3
	 oMYgyRZULvhAV844F0hMg0CuO+dbX9wCGhUnXsKquTR40mTEv3dIMPIXGbh+tbFKC5
	 Kien4T3iGyHrHpal9uUl5pLLQmbJf09Xt9hmFGI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfAUQOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:14:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbfAUQOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:14:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2266420844;
        Mon, 21 Jan 2019 16:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548087263;
        bh=8wqUUJDp1SS+S+URHP1+SBaWxivk10CdTy6Q5Qlauu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s7FquU5xW+XrZPR3/Dm+LUtvIqPa15PfrlMGIeEShGV6+ErQ2uxzi9qwlUSwnIrMq
         bX4iflsJYxOUXdJRezTyOy87zGaiWCqAPEMVgAhkVU2pt660FOFfl8I/i16sCKsbyW
         TSbQupWg5krlZGu+lc0qpdEDT/whUqJ4+utL9eaw=
Date:   Mon, 21 Jan 2019 17:14:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [BUG] tiocsti() NULL dereference if ld->ops->receive_buf==NULL
Message-ID: <20190121161421.GB29858@kroah.com>
References: <CAG48ez06mDExELyTYN7MZQ3FjGcLx9ASc5HnxW8NQbfTAPX=Qg@mail.gmail.com>
 <20190119091108.GF10836@kroah.com>
 <20190120095205.GB28267@kroah.com>
 <CAG48ez0=Mcgk15EWBfVw-X7gB2hMJFULRA_w429-uyPZotdqNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0=Mcgk15EWBfVw-X7gB2hMJFULRA_w429-uyPZotdqNA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 04:38:33PM +0100, Jann Horn wrote:
> On Sun, Jan 20, 2019 at 10:52 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Jan 19, 2019 at 10:11:08AM +0100, Greg Kroah-Hartman wrote:
> > > On Fri, Jan 18, 2019 at 08:09:07PM +0100, Jann Horn wrote:
> > > > Hi!
> > > >
> > > > When a line discipline doesn't have a ->receive_buf handler, tiocsti()
> > > > attempts to call a NULL pointer. Both tty_n_tracesink and
> > > > spk_ttyio_ldisc_ops don't have such a handler.
> > > >
> > > > To reproduce, build a kernel with CONFIG_SPEAKUP=y and
> > > > CONFIG_SPEAKUP_SYNTH_SOFT=y, set speakup.synth=soft in the kernel
> > > > command line, and run the following code as root:
> > >
> > > <snip>
> > >
> > > Ugh, thanks for finding this.  I'll look at it later this afternoon...
> >
> > It looks to be a simple change.  We can't really "fail" this ioctl if
> > there's nothing wrong with the structure of the call, so we can just
> > quietly "eat" the character, given that the line discipline doesn't care
> > about it.
> >
> > So, any objections to the patch below?
> 
> No objection from me.
> 
> (spk_ttyio_ldisc_ops has a receive_buf2 handler, but I don't know
> whether that should be invoked here or not.)

No, receive_buf2 can fail, or do a short "receive", which receive_buf()
can't do, and tiocsti can't fail (it's only used to fake input data).

Yeah, the tty layer is strange :(

thanks,

greg k-h
