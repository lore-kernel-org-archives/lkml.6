Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6359BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E93F204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E93F204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeIMQ3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:29:00 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35658 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeIMQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:29:00 -0400
Received: by mail-qt0-f170.google.com with SMTP id j7-v6so4956887qtp.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 04:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Jn1wgzV952ldxiFVEE2JirMK4DB9kUK8oCGfZJtVIE=;
        b=XkpK0R1P37XSuIliodl8oskznAdE8Vv9tOo+KbeQPKicxzSgqrX9byj3UyBDzb9jIo
         eYafFJHCeWCk7knQQprgy48+nKZqufk0/K2avlsefMlYd4Y9fOF/tGYVTRy5t3YRExhK
         Ci8p5U9qv8h3cHrDglRgZiio6sqAQOZsdTzG/psRjsY8fEjjy2FbyXqudr3rn8rr5gv9
         EYG4mgEL+qB3QMQoiJc8x2m6O+gUcMk/siprMtPM0FB0KfPjZNQejN/j6RzEibXSc8w7
         nh3PVlhe0jRBqOsCooPpPLvhRxBYn1eSwbrfPdaWCdJAECLr7R1rUEy11Nch1sb72Enk
         WLXg==
X-Gm-Message-State: APzg51C3hMeJrpzvWRlBrPpl6q+9W5J6lxCp2nLB4+Q0fcgHCJtDF708
        +dE32GQMOrjb8QMhpdgaXboDedr9Gcm8+NfmLG4CkhiH
X-Google-Smtp-Source: ANB0VdauA72eGz7dWosmgXRePkfOOPBW/zKUGjKc7oAaUFdM93DHOUWbUluNV/ej1CT1QorzWqQLilHPu8a38x3rHAI=
X-Received: by 2002:a0c:8b67:: with SMTP id d39-v6mr4633871qvc.180.1536837598654;
 Thu, 13 Sep 2018 04:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
In-Reply-To: <20180913023119.GQ19965@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Sep 2018 13:19:42 +0200
Message-ID: <CAK8P3a2LpC6sw5KQ_6kcXKNfgUXkjsxbFkD30kdMgQjurGgy9Q@mail.gmail.com>
Subject: Re: [PATCHES] tty ioctls cleanups, compat and not only
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 4:31 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         See vfs.git#work.tty-ioctl.  Completely untested, should seriously
> clean the things up wrt compat.  Remaining problems (aside of the bugs
> introduced in it, of course):
>         * TIOCSERGSTRUCT must die; it's present only in amiserial and it's
> _vile_; look at what it copies out and weep.
>         * synclink_gt has proper compat handling for its private ioctls;
> other synclink drivers (with the same ioctls) do not.
>         * dgnc definitely has buggered ioctls - structs full of longs are
> bloody bad idea for passing around.  It's in staging, and I'd say that it
> needs the userland ABI fixed.
>         * cyclades, rocket, moxa and mxser probably have non-trivial
> problems with their private ioctls; I hadn't looked into those.
>         * n_gsm needs ->compat_ioctl(); easy to do, I just hadn't done it
> yet.
>         * ipwireless might or might not need compat_ioctl (PPP stuff in it);
> not sure.
>         * ldisc private ioctls need more work.  Hadn't gone there yet.
> Generic ioctls should be fine - they never reach ->compat_ioctl() with this
> series.

I looked at all the new patches, looks all good to me. When I did my
(incomplete) analysis, I found a couple more things that could be
included in the series if we want to:

* TIOCSERGWILD/TIOCSERSWILD are obsolete and never do
   anything useful, but the return code is inconsistent: ENOTTY
   in compat mode vs 0 in uart_ioctl, plus a printk for amiserial.
   If we want to keep it around rather than deleting it completely,
   it should be marked as compatible.

* PPPIOCGCHAN/PPPIOCGUNIT are implemented by multiple
   ldisc variants, marking them as compatible would save us from
   implementing a comp_ioctl method for each one separately.
   These are also used on some things that are not ttys though,
   so we can't remove them from fs/compat_ioctl.c yet.

* FIONREAD/TIOCINQ and TIOCOUTQ also appear multiple
   times and could be added to that list but not removed from
   fs/compat_ioctl.c (I think the other users are all in sockets, so
   adding them in both might be sufficient)

* SIOCGIFNAME, SIOCGIFENCAP, SIOCSIFENCAP,
  SIOCSIFHWADDR, SIOCSKEEPALIVE, SIOCGKEEPALIVE,
  SIOCSOUTFILL,  and SIOCGOUTFILL  are in the tty_ioctl
  functions for multiple protocol handlers, comparable to
  the PPP ones.

>         There's some overlap with patches posted earlier - e.g. I'm fairly
> sure that keyboard ioctl "remove from fs/compat_ioctl.c" part duplicates
> one of yours; I'll be glad to drop and replace such duplicates with already
> posted variants.

Ok, don't worry about the order if you decide to apply yours first,
you can just drop mine.

        Arnd
