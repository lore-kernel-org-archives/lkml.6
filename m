Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A502C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5180620867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5180620867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbeIYRA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:00:27 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36871 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeIYRA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:00:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id n6-v6so12763897qtl.4;
        Tue, 25 Sep 2018 03:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LNzj7J700cFcTyK6CgjyUCylxc1RxBkWxi5pRTvopY=;
        b=B5TetMOFDKx/VkYPY7e3hU91zNt3tNEPsA99cWf1Fep8Gt62DJIOKP9LPxaJCxiPL9
         vJSi8cVcQraZzYh6RT/EcCkvG0KLi+/bBP8Vu2daLwSaF7ZB+cRPS3bg6BeyGbYVZhJA
         gU/mdCGodyDOVBX54TWSJI0F9RdyLbMUe+t4tI+Bf4C/3WRCg9GMFUSI9pd2hIzr7yOd
         QR0h+tP9JgOQKUXiD0bnQIZzcFbGuSsxeVVzfDrx1K9opCLRyA6ieF4c8beiuqNUyz1j
         EFk521tsrdBEMRSWK3M+638aRPdSUeA2/coFHVeTeVeCZJ+kdnGXmT82MwPrzZPI0BVG
         VYlQ==
X-Gm-Message-State: ABuFfoiVk1zXqF7mP8J5zbldK6Kt43JFuFrtOShekTtFpcTNczyF55CV
        WVzuS78wau/PAjJoRJIEMvP3FkTr5vVdsDeE8Yk=
X-Google-Smtp-Source: ACcGV63MyOgn6wgWiKy5dcxjHliGoiSmGy7Iym2rjZK1KKSVou9WC7WJKjtRscIak7chN+rmZZv4tKWT6ZA4ix0gmEc=
X-Received: by 2002:aed:2bc6:: with SMTP id e64-v6mr300366qtd.132.1537872808535;
 Tue, 25 Sep 2018 03:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180913160010.905798-1-arnd@arndb.de> <de79d285-7cbc-e547-547b-cf3e0627950d@gmx.de>
In-Reply-To: <de79d285-7cbc-e547-547b-cf3e0627950d@gmx.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 25 Sep 2018 12:53:11 +0200
Message-ID: <CAK8P3a1WT87CFyz7457R_cx=ueVjG+xUWXAA6SSw+C4ZnaZHVw@mail.gmail.com>
Subject: Re: [RFC] parisc64: change __kernel_suseconds_t to match glibc
To:     Helge Deller <deller@gmx.de>
Cc:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 9:46 PM Helge Deller <deller@gmx.de> wrote:
> On 13.09.2018 17:59, Arnd Bergmann wrote:
> > There are only two 64-bit architecture ports that have a 32-bit
> > suseconds_t: sparc64 and parisc64. I've encountered a number of problems
> > with this, while trying to get a proper 64-bit time_t working on 32-bit
> > architectures. Having a 32-bit suseconds_t combined with a 64-bit time_t
> > means that we get extra padding in data structures that may leak kernel
> > stack data to user space, and it breaks all code that assumes that
> > timespec and timeval have the same layout.
> >
> > While we can't change sparc64, it seems that glibc on parisc64 has always
> > set suseconds_t to 'long', and the current version would give incorrect
> > results for gettimeofday() and many other interfaces: timestamps passed
> > from user space into the kernel result in tv_usec being always zero
> > (the lower bits contain the intended value but are ignored) while data
> > passed from the kernel to user space contains either zeroes or random
> > data in tv_usec.

[back from traveling now, sorry for the delay in replying]

> Should this wrong behavior be visible with 32-bit userspace or
> with 64-bit userspace (or both)?
> I didn't noticed such wrong behavior yet.

Only 64-bit user space.

> Can you suggest some test programs to verify?
> LTP seems to be correct.

A simple 64-bit gettimeofday() should report incorrect
nanoseconds using the upstream glibc implementation.

> > Based on that, it seems best to change the user API in the kernel in
> > an incompatible way to match what glibc expects.
>
> Basically that sounds the right way to go, but as said before,
> I didn't see such issues.
>
> > Note that the distros I could find (gentoo and debian) all just
> > have 32-bit user space, which does not suffer from this problem.
>
> That's correct.
> Kernel can be 32- or 64-bit, but userspace is currentl 32-bit only.
>
> So, breaking any 64-bit userspace is OK, since we don't have it yet.
> Breaking 32-bit userspace needs some thoughts...

Ok.

     Arnd
