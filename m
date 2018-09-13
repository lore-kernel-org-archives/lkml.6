Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3554C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AB62086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AB62086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeINBmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 21:42:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42470 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbeINBmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 21:42:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0YHB-0003UL-N4; Thu, 13 Sep 2018 20:31:45 +0000
Date:   Thu, 13 Sep 2018 21:31:45 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHES] tty ioctls cleanups, compat and not only
Message-ID: <20180913203145.GU19965@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <CAK8P3a2LpC6sw5KQ_6kcXKNfgUXkjsxbFkD30kdMgQjurGgy9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2LpC6sw5KQ_6kcXKNfgUXkjsxbFkD30kdMgQjurGgy9Q@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 01:19:42PM +0200, Arnd Bergmann wrote:
> On Thu, Sep 13, 2018 at 4:31 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         See vfs.git#work.tty-ioctl.  Completely untested, should seriously
> > clean the things up wrt compat.  Remaining problems (aside of the bugs
> > introduced in it, of course):
> >         * TIOCSERGSTRUCT must die; it's present only in amiserial and it's
> > _vile_; look at what it copies out and weep.
> >         * synclink_gt has proper compat handling for its private ioctls;
> > other synclink drivers (with the same ioctls) do not.
> >         * dgnc definitely has buggered ioctls - structs full of longs are
> > bloody bad idea for passing around.  It's in staging, and I'd say that it
> > needs the userland ABI fixed.
> >         * cyclades, rocket, moxa and mxser probably have non-trivial
> > problems with their private ioctls; I hadn't looked into those.
> >         * n_gsm needs ->compat_ioctl(); easy to do, I just hadn't done it
> > yet.
> >         * ipwireless might or might not need compat_ioctl (PPP stuff in it);
> > not sure.
> >         * ldisc private ioctls need more work.  Hadn't gone there yet.
> > Generic ioctls should be fine - they never reach ->compat_ioctl() with this
> > series.
> 
> I looked at all the new patches, looks all good to me. When I did my
> (incomplete) analysis, I found a couple more things that could be
> included in the series if we want to:
> 
> * TIOCSERGWILD/TIOCSERSWILD are obsolete and never do
>    anything useful, but the return code is inconsistent: ENOTTY
>    in compat mode vs 0 in uart_ioctl, plus a printk for amiserial.
>    If we want to keep it around rather than deleting it completely,
>    it should be marked as compatible.

Yes.  Not sure if we want to - the only user is setserial(8), with
       -W     Do wild interrupt initialization and exit.  This  option  is  no
              longer relevant in Linux kernels after version 2.1.

What's more, rc.serial does *not* use it since 2.15 and even in 2.14 it wouldn't
have failed the boot - just whine (truthfully) "Cannot scan for wild interrupts"
on stderr and continue with the rest of the script.  The same goes at least as
far back as setserial-2.02.  That's what MCC had; if you want to check something
earlier, you'll probably have to ask tytso, but I very much doubt that anything
of that vintage will work with the current kernels *or* that anyone cared to
abort the script in question on setserial -W /dev/cua0 failing to start with.

So I'd seriously suggest removing those altogether.  I mean, sure, we can carry
explicit "obsolete, quietly return 0 on those" indefinitely, but that really feels
over the top.  Time to bury the body, unless somebody objects...

> * PPPIOCGCHAN/PPPIOCGUNIT are implemented by multiple
>    ldisc variants, marking them as compatible would save us from
>    implementing a comp_ioctl method for each one separately.
>    These are also used on some things that are not ttys though,
>    so we can't remove them from fs/compat_ioctl.c yet.

Worse - there's ipwireless, which implements it in tty_operations ->ioctl().

> * FIONREAD/TIOCINQ and TIOCOUTQ also appear multiple
>    times and could be added to that list but not removed from
>    fs/compat_ioctl.c (I think the other users are all in sockets, so
>    adding them in both might be sufficient)

Pipes as well.

> * SIOCGIFNAME, SIOCGIFENCAP, SIOCSIFENCAP,
>   SIOCSIFHWADDR, SIOCSKEEPALIVE, SIOCGKEEPALIVE,
>   SIOCSOUTFILL,  and SIOCGOUTFILL  are in the tty_ioctl
>   functions for multiple protocol handlers, comparable to
>   the PPP ones.

Very definitely shared with sockets, and I prefer to handle the tty-side cases
in ldisc ->compat_ioctl().
