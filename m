Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E8CECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60E820853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60E820853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeIOAzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 20:55:03 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44866 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeIOAzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 20:55:03 -0400
Received: by mail-qt0-f195.google.com with SMTP id k38-v6so9804175qtk.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 12:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HndDO06tb+5BxLh2jAhw232nm81i/jroaV/gKOTMN1Q=;
        b=itNpEJkFim84zMo4WwnKK0/ccS9Iios+jooQWYfLKH9Y8fA4UB9021K0CyACDDzqJ2
         oRbzCQ1IeP/oMnrMoanh1AcV3ns5zt6yCjqP6bxgaK8GzmIWLh1fQQsjJAKkw5KhITsp
         XtO2Buc0CgOMAcbQVWXsxK4ZQYE9yOmiPz/mSqJ2Z/7XQLCFDsVo8FWnZIVL7hgRFBfa
         8yTGrgY0r2qATCmsEyYvgD1rd5ImR1s0s/3HtRTlsAYGpoa/mPtYqOnIwrzOdMPbx+m2
         Gcrnk8Fk0oAMfQXFP4oyk2Jx/rWreowQNTIgvNeOGJKH5cTGkxbGUfzoOwU/GGLyQ4ud
         y4Sw==
X-Gm-Message-State: APzg51AaBunCrl8o0aut4VhFePJkWamj+HRBiGazv8m68614zXABomMz
        Nv9t26hf6xqB/ScOKr1OnwaCm/iM6OtVrMh99H0by84D
X-Google-Smtp-Source: ANB0Vda6L5XS36VRocsmntQe5wwdVSeyKobbNF7DVEseJP7Vfj5LgZPJvl1/P1M2OS9hiEusN25e+WOpsLiQG+82cjA=
X-Received: by 2002:aed:3f22:: with SMTP id p31-v6mr9705554qtf.185.1536953948836;
 Fri, 14 Sep 2018 12:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180913023119.GQ19965@ZenIV.linux.org.uk> <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-2-viro@ZenIV.linux.org.uk> <CAK8P3a1feqfJOTvQEC+tmdYToGzL0zmKLQmGzPe-UQry0AuW-g@mail.gmail.com>
 <20180914181656.GB20521@kroah.com>
In-Reply-To: <20180914181656.GB20521@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Sep 2018 21:38:52 +0200
Message-ID: <CAK8P3a1T6e9tQPES3f-Lh=HLpy8RXBfmwh6in20XXkgGa8612Q@mail.gmail.com>
Subject: Re: [PATCH 02/50] move compat handling of tty ioctls to tty_compat_ioctl()
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 8:17 PM gregkh <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Sep 14, 2018 at 05:15:52PM +0200, Arnd Bergmann wrote:
> > On Thu, Sep 13, 2018 at 4:40 AM Al Viro <viro@zeniv.linux.org.uk> wrote:

> > +       case TCSETX:
> > +       case TCSETXF:
> > +       case TCSETXW:
> > +       case TIOCGETC:
> > +       case TIOCGETP:
> > +       case TIOCGPTPEER:
> > +       case TIOCSERCONFIG:
> > +       case TIOCSETC:
> > +       case TIOCSETN:
> > +       case TIOCSETP:
> > +       case TIOCVHANGUP:
> >
> > Should these all be added in a stable backport patch?
>
> Why?  What is being "fixed" here that anyone has noticed before that is
> causing problems in those old kernels?  If no one has complained about
> the lack of compat fixups, well...  :)

Most of the individual ones don't matter:

TCSETX/TCSETXF/TCSETXW/TCGETX never did anything,
we don't care about them.

TIOCSERCONFIG has always been broken in compat mode,
not sure who calls it in practice. This is 'setserial autoconfig'.

TIOCGETC/TIOCGETP/TIOCSETC/TIOCSETN/TIOCSETP
are only defined on alpha, mips, powerpc and sparc to start
with. They seem to only be there for compatibility with some
Unix version for those architectures but were never part of
the normal Linux API or the compat set, so I guess they
also don't matter.

The two that I think we may care about are:

TIOCGPTPEER is a fairly recent regression from commit
311fc65c9fb9 ("pty: Repair TIOCGPTPEER") in 4.14 after it was
added in 4.13.

TIOCVHANGUP was introduced to be used by systemd in
commit 3c95c985fa91 ("tty: add TIOCVHANGUP to allow clean tty
shutdown of all ttys").
https://raspberrypi.stackexchange.com/questions/54143
has a bug report noting a problem with Raspbian systemd
that was related to TIOCVHANGUP. I don't think it's the
missing compat line that caused it, but the same system
would try to run TIOCVHANGUP in compat mode on
Raspberry Pi3 when using a 64-bit kernel with raspbian,
so there are definitely callers.

        Arnd
