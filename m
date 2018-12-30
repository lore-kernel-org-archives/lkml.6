Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11BAC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 07:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B21521019
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 07:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeL3HZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 02:25:46 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52436 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeL3HZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 02:25:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id CCF2021FEF;
        Sun, 30 Dec 2018 02:25:41 -0500 (EST)
Date:   Sun, 30 Dec 2018 18:25:38 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v8 18/25] powerpc: Implement nvram sync ioctl
In-Reply-To: <CAK8P3a0-4vGuCR4aCq0=D1Du1K=f5MtnB9fyCBnOsF+4Na5dMg@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1812301744540.424@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au> <3ba1dd965c1097e00463eafe7c7d5fd93bbed836.1545784679.git.fthain@telegraphics.com.au> <CAK8P3a0-4vGuCR4aCq0=D1Du1K=f5MtnB9fyCBnOsF+4Na5dMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2018, Arnd Bergmann wrote:

> > --- a/drivers/char/nvram.c
> > +++ b/drivers/char/nvram.c
> > @@ -48,6 +48,10 @@
> >  #include <linux/mutex.h>
> >  #include <linux/pagemap.h>
> >
> > +#ifdef CONFIG_PPC
> > +#include <asm/nvram.h>
> > +#include <asm/machdep.h>
> > +#endif
> >
> >  static DEFINE_MUTEX(nvram_mutex);
> >  static DEFINE_SPINLOCK(nvram_state_lock);
> > @@ -331,6 +335,37 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
> >         long ret = -ENOTTY;
> >
> >         switch (cmd) {
> > +#ifdef CONFIG_PPC
> > +       case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
> > +               pr_warn("nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n");
> > +               /* fall through */
> > +       case IOC_NVRAM_GET_OFFSET:
> > +               ret = -EINVAL;
> > +#ifdef CONFIG_PPC_PMAC
> 
> I think it would make be nicer here to keep the ppc bits in arch/ppc,
> and instead add a .ioctl() callback to nvram_ops.
> 

The problem with having an nvram_ops.ioctl() method is the code in the 
!PPC branch. That code would get duplicated because it's needed by both 
X86 and M68K, to implement the checksum ioctls.

> > @@ -369,12 +405,14 @@ static int nvram_misc_open(struct inode *inode, struct file *file)
> >                 return -EBUSY;
> >         }
> >
> > +#ifndef CONFIG_PPC
> >         /* Prevent multiple writers if the set_checksum ioctl is implemented. */
> >         if ((arch_nvram_ops.set_checksum != NULL) &&
> >             (file->f_mode & FMODE_WRITE) && (nvram_open_mode & NVRAM_WRITE)) {
> >                 spin_unlock(&nvram_state_lock);
> >                 return -EBUSY;
> >         }
> > +#endif
> >
> > diff --git a/include/linux/nvram.h b/include/linux/nvram.h
> > index b7bfaec60a43..24a57675dba1 100644
> > --- a/include/linux/nvram.h
> > +++ b/include/linux/nvram.h
> > @@ -18,8 +18,12 @@ struct nvram_ops {
> >         unsigned char   (*read_byte)(int);
> >         void            (*write_byte)(unsigned char, int);
> >         ssize_t         (*get_size)(void);
> > +#ifdef CONFIG_PPC
> > +       long            (*sync)(void);
> > +#else
> >         long            (*set_checksum)(void);
> >         long            (*initialize)(void);
> > +#endif
> >  };
> 
> Maybe just leave all entries visible here, and avoid the above #ifdef checks.
> 

The #ifdef isn't there just to save a few bytes, though it does do that. 
It's really meant to cause a build failure when I mess up somewhere. But 
I'm happy to change it if you can see a reason to do so (?)

-- 

>        Arnd
> 
