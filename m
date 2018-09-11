Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD6BC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3BA206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3BA206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeILAgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:36:52 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32858 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeILAgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:36:52 -0400
Received: by mail-qt0-f194.google.com with SMTP id r37-v6so29569891qtc.0;
        Tue, 11 Sep 2018 12:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yx16LHdlZnEdNmksQk8cg0yV/agaZAZtEQFRGFwy/rc=;
        b=OH9swE2wyHKk97TxviZb7uZ0ukMJhjR9EA1I6RjtE0AN92fu38uyHgfJRq7UiqkJv6
         d44GytAvajWmuvB8fYZjWMPAgihzPgQr2mthAzBOQLT9JuxWmRst7xoQhsS8iKU3e2ey
         041SDk7uIdRYatd7rKinh3Ot0f5riqd0C7bUNWu6ATnd657jNhxNCv+hVWnBMtaOL967
         q3Y1wWcYFce2r5qS07tKS5m168HcyAK4QVZ3lMNcF1ro8YKbfZV6UVIhU5MswTPclTkF
         66Su9bf6/SFT4qBJ0hKfkynC/Tpc+kckV7VWm9V9GLJVruH0R8VUoscePNr63xD6n/Bn
         4Kmg==
X-Gm-Message-State: APzg51AqQ81crPBUXxbBo5knlisq8brwpDiQo/T9wZCvCzb+JrOaQyrY
        YfClNYFOn0g5FmWWdyVA7EE1Vik3pjayaLEXqpaZZeL0
X-Google-Smtp-Source: ANB0VdY8GooyQM78kzZcRJc8djxSjPrX1SlLn80qrnldR/YohJelLXALhX0XxUn+cAzfEl/IL1GdSICsMpyaLWNTnko=
X-Received: by 2002:ac8:6959:: with SMTP id n25-v6mr21760767qtr.9.1536694564906;
 Tue, 11 Sep 2018 12:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180908142837.2819693-1-arnd@arndb.de> <20180908142837.2819693-3-arnd@arndb.de>
 <20180909041632.GE19965@ZenIV.linux.org.uk>
In-Reply-To: <20180909041632.GE19965@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Sep 2018 21:35:48 +0200
Message-ID: <CAK8P3a2ZPDtFax50joj402H5m-kZG0etu10HqNRjSmo2xU5R5w@mail.gmail.com>
Subject: Re: [PATCH 03/11] compat_ioctl: remove translation for sound ioctls
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 9, 2018 at 6:17 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Sep 08, 2018 at 04:28:09PM +0200, Arnd Bergmann wrote:
> > The SNDCTL_* and SOUND_* commands are the old OSS user interface.
> >
> > I checked all the sound ioctl commands listed in fs/compat_ioctl.c
> > to see if we still need the translation handlers. Here is what I
> > found:
> >
> > - sound/oss/ is (almost) gone from the kernel, this is what actually
> >   needed all the translations
> > - The ALSA emulation for OSS correctly handles all compat_ioctl
> >   commands already.
> > - sound/oss/dmasound/ is the last holdout of the original OSS code,
> >   this is only used on arch/m68k, which has no 64-bit mode and
> >   hence needs no compat handlers
> > - arch/um/drivers/hostaudio_kern.c may run in 64-bit mode with
> >   32-bit x86 user space underneath it. This rare corner case is
> >   the only one that still needs the compat handlers.
> >
> > By adding a simple redirect of .compat_ioctl to .unlocked_ioctl in the
> > UML driver, we can remove all the COMPATIBLE_IOCTL() annotations without
> > a change in functionality. For completeness, I'm adding the same thing
> > to the dmasound file, knowing that it makes no difference.
>
> > diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
> > index 7f9dbdbc4eb7..0278a642a622 100644
> > --- a/arch/um/drivers/hostaudio_kern.c
> > +++ b/arch/um/drivers/hostaudio_kern.c
> > @@ -298,6 +298,7 @@ static const struct file_operations hostaudio_fops = {
> >       .write          = hostaudio_write,
> >       .poll           = hostaudio_poll,
> >       .unlocked_ioctl = hostaudio_ioctl,
> > +     .compat_ioctl   = hostaudio_ioctl,
>
> Umm...  OK, seeing that it's not going to be used on s390...  It's still
> not quite right, though, and I'm afraid that places where we have the
> same ->unlocked_ioctl and ->compat_ioctl need an audit - there probably
> had been other folks who'd stepped into the same.

It turns out that it's actually much more common to have the same
pointer for ioctl handlers that thake pointer arguments than to have
the wrapper. I found 16 instances of trivial wrappers to do compat_ptr()
for file_operations, 4 instances that have a wrapper but skip the
compat_ptr() and around 40 (depending on how you count) that use
the same pointer for both when they only use pointers and should
go through compat_ptr(). This includes a couple that don't use
the argument at all, so they are fine either way.

I've created patches to change all of the above to a new
generic_compat_ioctl_ptrarg() helper I added.

loop_control_ioctl(), kcov_ioctl(), proc_bus_pci_ioctl(), and nbd_ioctl() seem
to be ones that are correct because,  the argument is always an integer.
fs3270_ioctl() has a is_compat_task() check to deal with the problem.

inotify_ioctl(),  vsoc_ioctl(), and usblp_ioctl() are somethat uses both integer
and pointer arguments and may need special handling for s390.

I did not touch those so far.

       Arnd
