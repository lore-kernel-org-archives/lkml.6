Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7103EC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 12:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270D12089B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 12:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270D12089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933021AbeGHMp5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 08:45:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34264 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932843AbeGHMp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 08:45:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6BC5920737; Sun,  8 Jul 2018 14:45:53 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1C8A1203B4;
        Sun,  8 Jul 2018 14:45:53 +0200 (CEST)
Date:   Sun, 8 Jul 2018 14:45:53 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Jann Horn <jannh@google.com>
Cc:     richard@nod.at, kernel list <linux-kernel@vger.kernel.org>,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        Linux API <linux-api@vger.kernel.org>,
        computersforpeace@gmail.com, dwmw2@infradead.org
Subject: Re: [PATCH] mtdchar: fix overflows in adjustment of `count`
Message-ID: <20180708144553.4cfac318@bbrezillon>
In-Reply-To: <CAG48ez3MUm=0iJSY21BNOFBJt=gWgGAQTwM8cz5d_wNwpMyQeg@mail.gmail.com>
References: <20180707033722.219468-1-jannh@google.com>
        <20180707104412.1580a285@bbrezillon>
        <CAG48ez3MUm=0iJSY21BNOFBJt=gWgGAQTwM8cz5d_wNwpMyQeg@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jul 2018 11:03:00 +0200
Jann Horn <jannh@google.com> wrote:

> +cc linux-api
> 
> On Sat, Jul 7, 2018 at 10:44 AM Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> >
> > On Sat,  7 Jul 2018 05:37:22 +0200
> > Jann Horn <jannh@google.com> wrote:
> >  
> > > The first checks in mtdchar_read() and mtdchar_write() attempt to limit
> > > `count` such that `*ppos + count <= mtd->size`. However, they ignore the
> > > possibility of `*ppos > mtd->size`, allowing the calculation of `count` to
> > > wrap around. `mtdchar_lseek()` prevents seeking beyond mtd->size, but the
> > > pread/pwrite syscalls bypass this.
> > >
> > > I haven't found any codepath on which this actually causes dangerous
> > > behavior, but it seems like a sensible change anyway.
> > >
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > >  drivers/mtd/mtdchar.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> > > index cd67c85cc87d..02389528f622 100644
> > > --- a/drivers/mtd/mtdchar.c
> > > +++ b/drivers/mtd/mtdchar.c
> > > @@ -160,8 +160,12 @@ static ssize_t mtdchar_read(struct file *file, char __user *buf, size_t count,
> > >
> > >       pr_debug("MTD_read\n");
> > >
> > > -     if (*ppos + count > mtd->size)
> > > -             count = mtd->size - *ppos;
> > > +     if (*ppos + count > mtd->size) {
> > > +             if (*ppos < mtd->size)
> > > +                     count = mtd->size - *ppos;
> > > +             else
> > > +                     count = 0;
> > > +     }  
> >
> > Hm, shouldn't we return -ERANGE or -EINVAL if *ppos >= mtd->size?  
> 
> Hmm, good question.
> The pread() manpage says that pread() can return the same errors as
> lseek(), and the lseek() manpage says that -EINVAL is for when you're
> trying to seek beyond the end of a seekable device. So from the
> documentation, it sounds as if you're right.
> But testing pread() beyond end of file for various things on my
> machine seems to just return 0:
> 
> # cat pread.c
> #include <unistd.h>
> #include <stdlib.h>
> int main(int argc, char **argv) {
>   char buf[0x1000];
>   off_t off = strtoul(argv[1], NULL, 0);
>   pread(0, buf, 0x1000, off);
> }
> # gcc -o pread pread.c
> # strace -e trace=pread64 ./pread 200000000 < /dev/sda1
> pread64(0, "", 4096, 200000000)         = 0
> +++ exited with 0 +++
> # strace -e trace=pread64 ./pread 100000 <
> /sys/kernel/debug/x86/tlb_single_page_flush_ceiling
> pread64(0, "", 4096, 100000)            = 0
> +++ exited with 0 +++
> # strace -e trace=pread64 ./pread 20000000000 < /dev/dm-2
> pread64(0, "", 4096, 20000000000)       = 0
> +++ exited with 0 +++
> 
> Do you know of precedent for returning -EINVAL if *ppos is beyond the
> end of the device?

Nope, it just made more sense to me than returning 0. Anyway, let's
keep the most common behavior, even if it's not documented this way ;-).

> 
> > >
> > >       if (!count)
> > >               return 0;
> > > @@ -246,7 +250,7 @@ static ssize_t mtdchar_write(struct file *file, const char __user *buf, size_t c
> > >
> > >       pr_debug("MTD_write\n");
> > >
> > > -     if (*ppos == mtd->size)
> > > +     if (*ppos >= mtd->size)
> > >               return -ENOSPC;
> > >
> > >       if (*ppos + count > mtd->size)  
> >  
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

