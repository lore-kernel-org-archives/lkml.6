Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CE6ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 18:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32142083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 18:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32142083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeIPALN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 20:11:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeIPALN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 20:11:13 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 844CDC97;
        Sat, 15 Sep 2018 18:51:14 +0000 (UTC)
Date:   Sat, 15 Sep 2018 20:51:11 +0200
From:   gregkh <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/50] move compat handling of tty ioctls to
 tty_compat_ioctl()
Message-ID: <20180915185111.GC25288@kroah.com>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-2-viro@ZenIV.linux.org.uk>
 <CAK8P3a1feqfJOTvQEC+tmdYToGzL0zmKLQmGzPe-UQry0AuW-g@mail.gmail.com>
 <20180914181656.GB20521@kroah.com>
 <CAK8P3a1T6e9tQPES3f-Lh=HLpy8RXBfmwh6in20XXkgGa8612Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1T6e9tQPES3f-Lh=HLpy8RXBfmwh6in20XXkgGa8612Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 09:38:52PM +0200, Arnd Bergmann wrote:
> On Fri, Sep 14, 2018 at 8:17 PM gregkh <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Sep 14, 2018 at 05:15:52PM +0200, Arnd Bergmann wrote:
> > > On Thu, Sep 13, 2018 at 4:40 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > > +       case TCSETX:
> > > +       case TCSETXF:
> > > +       case TCSETXW:
> > > +       case TIOCGETC:
> > > +       case TIOCGETP:
> > > +       case TIOCGPTPEER:
> > > +       case TIOCSERCONFIG:
> > > +       case TIOCSETC:
> > > +       case TIOCSETN:
> > > +       case TIOCSETP:
> > > +       case TIOCVHANGUP:
> > >
> > > Should these all be added in a stable backport patch?
> >
> > Why?  What is being "fixed" here that anyone has noticed before that is
> > causing problems in those old kernels?  If no one has complained about
> > the lack of compat fixups, well...  :)
> 
> Most of the individual ones don't matter:
> 
> TCSETX/TCSETXF/TCSETXW/TCGETX never did anything,
> we don't care about them.
> 
> TIOCSERCONFIG has always been broken in compat mode,
> not sure who calls it in practice. This is 'setserial autoconfig'.
> 
> TIOCGETC/TIOCGETP/TIOCSETC/TIOCSETN/TIOCSETP
> are only defined on alpha, mips, powerpc and sparc to start
> with. They seem to only be there for compatibility with some
> Unix version for those architectures but were never part of
> the normal Linux API or the compat set, so I guess they
> also don't matter.
> 
> The two that I think we may care about are:
> 
> TIOCGPTPEER is a fairly recent regression from commit
> 311fc65c9fb9 ("pty: Repair TIOCGPTPEER") in 4.14 after it was
> added in 4.13.
> 
> TIOCVHANGUP was introduced to be used by systemd in
> commit 3c95c985fa91 ("tty: add TIOCVHANGUP to allow clean tty
> shutdown of all ttys").
> https://raspberrypi.stackexchange.com/questions/54143
> has a bug report noting a problem with Raspbian systemd
> that was related to TIOCVHANGUP. I don't think it's the
> missing compat line that caused it, but the same system
> would try to run TIOCVHANGUP in compat mode on
> Raspberry Pi3 when using a 64-bit kernel with raspbian,
> so there are definitely callers.

Ah, ok, that makes sense, I forgot about the new ioctls and didn't
realize it was a regression.

greg k-h
