Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92E9C04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9968220866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9968220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeINCIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:08:16 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44917 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeINCIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:08:16 -0400
Received: by mail-qk1-f195.google.com with SMTP id d131-v6so4000761qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 13:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6HrdPoCsWDnxTQB7KTpMUY6bIsTNH8Lt+tPuo6DWa8=;
        b=oroRfAOxuWTqB7NPMmi1953T19twMNpHXA+3e+MrZtvYon5B2h3PqiRtPeuZNeKVpB
         SY3aNbTok68ZNxxI6j2Th0HrgqqmXQjiGlfvJoMl05GHE2BBelyNz0gPwfdx7haBQ0mp
         R7ELSq+2Ney3T9ornwf1/rewdPD+o1Gbu3PaVQrOA4CiOO5TmfAlXEy2UgPV8ro0j7ru
         2fgmqQtPQCpKZsqJRfCFu4CPzcGRTinghMd0443e6POKUjf7y7AK7SFp3t037fn8Ul92
         /Sol8JYDgJFy+lnCBgmfi4pCfLJ8keShJzf8R4cLGIq3dRMMnZsnebmMZ2wJSNQwTdum
         0c7A==
X-Gm-Message-State: APzg51AOiZh41b9N04ABVlFrjcjoGUydFcKH4ME4sGaaiBixKwydu2Ws
        RvM8atBa3Ya2v9tDuzopIlmRToLDUsRhym44FBG52Q==
X-Google-Smtp-Source: ANB0VdaX37lEvU8HCzPJRpayUVsFVygsZfvfRBxeM0LvAEKcRKRDfqkfRIoW3BN2D6jpvNay2ZlVqQYSWb7M2TLESRE=
X-Received: by 2002:a37:1b91:: with SMTP id m17-v6mr6500574qkh.173.1536872225041;
 Thu, 13 Sep 2018 13:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180913023119.GQ19965@ZenIV.linux.org.uk> <CAK8P3a2LpC6sw5KQ_6kcXKNfgUXkjsxbFkD30kdMgQjurGgy9Q@mail.gmail.com>
 <20180913203145.GU19965@ZenIV.linux.org.uk>
In-Reply-To: <20180913203145.GU19965@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Sep 2018 22:56:48 +0200
Message-ID: <CAK8P3a3LD58jnwP38OpnEWHMzAAfrqtfjHamWVU5PwaKoWyKjg@mail.gmail.com>
Subject: Re: [PATCHES] tty ioctls cleanups, compat and not only
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 10:31 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Sep 13, 2018 at 01:19:42PM +0200, Arnd Bergmann wrote:
> > On Thu, Sep 13, 2018 at 4:31 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > * TIOCSERGWILD/TIOCSERSWILD are obsolete and never do
> >    anything useful, but the return code is inconsistent: ENOTTY
> >    in compat mode vs 0 in uart_ioctl, plus a printk for amiserial.
> >    If we want to keep it around rather than deleting it completely,
> >    it should be marked as compatible.
>
> Yes.  Not sure if we want to - the only user is setserial(8), with
>        -W     Do wild interrupt initialization and exit.  This  option  is  no
>               longer relevant in Linux kernels after version 2.1.
>
> What's more, rc.serial does *not* use it since 2.15 and even in 2.14 it wouldn't
> have failed the boot - just whine (truthfully) "Cannot scan for wild interrupts"
> on stderr and continue with the rest of the script.  The same goes at least as
> far back as setserial-2.02.  That's what MCC had; if you want to check something
> earlier, you'll probably have to ask tytso, but I very much doubt that anything
> of that vintage will work with the current kernels *or* that anyone cared to
> abort the script in question on setserial -W /dev/cua0 failing to start with.
>
> So I'd seriously suggest removing those altogether.  I mean, sure, we can carry
> explicit "obsolete, quietly return 0 on those" indefinitely, but that really feels
> over the top.  Time to bury the body, unless somebody objects...

Sounds good to me.

> > * PPPIOCGCHAN/PPPIOCGUNIT are implemented by multiple
> >    ldisc variants, marking them as compatible would save us from
> >    implementing a comp_ioctl method for each one separately.
> >    These are also used on some things that are not ttys though,
> >    so we can't remove them from fs/compat_ioctl.c yet.
>
> Worse - there's ipwireless, which implements it in tty_operations ->ioctl().

Yes, I saw that too, but couldn't figure out exactly what ipwireless
does. I suppose it is some serial port driver that comes with a
hardcoded ppp implementation instead of a switchable ldisc?

> > * SIOCGIFNAME, SIOCGIFENCAP, SIOCSIFENCAP,
> >   SIOCSIFHWADDR, SIOCSKEEPALIVE, SIOCGKEEPALIVE,
> >   SIOCSOUTFILL,  and SIOCGOUTFILL  are in the tty_ioctl
> >   functions for multiple protocol handlers, comparable to
> >   the PPP ones.
>
> Very definitely shared with sockets, and I prefer to handle the tty-side cases
> in ldisc ->compat_ioctl().

Fair enough.

        Arnd
