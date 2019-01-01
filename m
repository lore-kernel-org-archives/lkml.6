Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48B9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BB720828
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfAABG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 20:06:26 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58528 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbfAABG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 20:06:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 4624B29C55;
        Mon, 31 Dec 2018 20:06:21 -0500 (EST)
Date:   Tue, 1 Jan 2019 12:06:18 +1100 (AEDT)
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
In-Reply-To: <CAK8P3a1rkdMXGOt90SDhBkVvFeNsqdoMKQAu4nLfk_Eg+_CB6g@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1901011206010.574@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au> <3ba1dd965c1097e00463eafe7c7d5fd93bbed836.1545784679.git.fthain@telegraphics.com.au> <CAK8P3a0-4vGuCR4aCq0=D1Du1K=f5MtnB9fyCBnOsF+4Na5dMg@mail.gmail.com> <alpine.LNX.2.21.1812301744540.424@nippy.intranet>
 <CAK8P3a1rkdMXGOt90SDhBkVvFeNsqdoMKQAu4nLfk_Eg+_CB6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2018, Arnd Bergmann wrote:

> On Sun, Dec 30, 2018 at 8:25 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> >
> > On Sat, 29 Dec 2018, Arnd Bergmann wrote:
> >
> > > > --- a/drivers/char/nvram.c
> > > > +++ b/drivers/char/nvram.c
> > > > @@ -48,6 +48,10 @@
> > > >  #include <linux/mutex.h>
> > > >  #include <linux/pagemap.h>
> > > >
> > > > +#ifdef CONFIG_PPC
> > > > +#include <asm/nvram.h>
> > > > +#include <asm/machdep.h>
> > > > +#endif
> > > >
> > > >  static DEFINE_MUTEX(nvram_mutex);
> > > >  static DEFINE_SPINLOCK(nvram_state_lock);
> > > > @@ -331,6 +335,37 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
> > > >         long ret = -ENOTTY;
> > > >
> > > >         switch (cmd) {
> > > > +#ifdef CONFIG_PPC
> > > > +       case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
> > > > +               pr_warn("nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n");
> > > > +               /* fall through */
> > > > +       case IOC_NVRAM_GET_OFFSET:
> > > > +               ret = -EINVAL;
> > > > +#ifdef CONFIG_PPC_PMAC
> > >
> > > I think it would make be nicer here to keep the ppc bits in arch/ppc,
> > > and instead add a .ioctl() callback to nvram_ops.
> > >
> >
> > The problem with having an nvram_ops.ioctl() method is the code in the 
> > !PPC branch. That code would get duplicated because it's needed by 
> > both X86 and M68K, to implement the checksum ioctls.
> 
> I was thinking you'd just have a common ioctl function that falls back 
> to the .ioctl callback for any unhandled commands like
> 
>     switch (cmd) {
>     case NVRAM_INIT:
>          ...
>          break;
>     case ...:
>          break;
>     default:
>          if (ops->ioctl)
>                  return ops->ioctl(...);
>          return -EINVAL;
>     }
> 
> Would that work?
> 

There are no ioctls common to all architectures. So your example becomes,

static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
                             unsigned long arg)
{
     if (ops->ioctl)
          return ops->ioctl(file, cmd, arg);
     return -ENOTTY;
}

And then my objection is the same: m68k and x86 now have to duplicate 
their common ops->ioctl() implementation.

Here's a compromise that avoids some code duplication.

     switch (cmd) {
#if defined(CONFIG_X86) || defined(CONFIG_M68K)
     case NVRAM_INIT:
          ...
          break;
     case NVRAM_SETCKS:
          ...
          break;
#endif
     default:
          if (ops->ioctl)
                  return ops->ioctl(...);
          return -EINVAL;
     }

But PPC64 and PPC32 also need to share their ops->ioctl() implementation. 
It's not clear to me where that code would go.

Personally, I prefer the present patch series, or something similar, with 
it's symmetry between nvram.c and nvram.h:

static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
                             unsigned long arg)
{
    long ret = -ENOTTY;

    switch (cmd) {
#if defined(CONFIG_PPC)
    case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
        ...
    case IOC_NVRAM_GET_OFFSET:
        ...
        break;
    case IOC_NVRAM_SYNC:
        ...
        break;
#elif defined(CONFIG_X86) || defined(CONFIG_M68K)
    case NVRAM_INIT:
        ...
        break;
    case NVRAM_SETCKS:
        ...
        break;
#endif
    }
    return ret;
}

... versus the struct definition in nvram.h,

struct nvram_ops {
        ssize_t         (*read)(char *, size_t, loff_t *);
        ssize_t         (*write)(char *, size_t, loff_t *);
        unsigned char   (*read_byte)(int);
        void            (*write_byte)(unsigned char, int);
        ssize_t         (*get_size)(void);
#if defined(CONFIG_PPC)
        long            (*sync)(void);
        int             (*get_partition)(int);
#elif defined(CONFIG_X86) || defined(CONFIG_M68K)
        long            (*set_checksum)(void);
        long            (*initialize)(void);
#endif
};

Which of these alternatives do you prefer? Is there a better way?

-- 


>        Arnd
> 
