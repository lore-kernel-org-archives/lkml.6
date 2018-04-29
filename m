Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753769AbeD2P6d (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 11:58:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44624 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753501AbeD2P6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 11:58:32 -0400
Date: Sun, 29 Apr 2018 17:58:29 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux mtd <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] mtd: nftl: Remove VLA usage
Message-ID: <20180429175829.0266b7f4@bbrezillon>
In-Reply-To: <CAGXu5jJJDF-3E_rt-16B-0CwjcF+52LPNGefD-KP+qz1JwM=6g@mail.gmail.com>
References: <20180423203500.GA36488@beast>
        <20180429111605.4cdf5ab2@bbrezillon>
        <CAGXu5jJJDF-3E_rt-16B-0CwjcF+52LPNGefD-KP+qz1JwM=6g@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Apr 2018 07:31:15 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Sun, Apr 29, 2018 at 2:16 AM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > Hi Kees,
> >
> > On Mon, 23 Apr 2018 13:35:00 -0700
> > Kees Cook <keescook@chromium.org> wrote:
> >  
> >> On the quest to remove all VLAs from the kernel[1] this changes the
> >> check_free_sectors() routine to use the same stack buffer for both
> >> data byte checks (SECTORSIZE) and oob byte checks (oobsize). Since
> >> these regions aren't needed at the same time, they don't need to be
> >> consecutively allocated. Additionally, while it's possible for oobsize
> >> to be large, it is unlikely to be larger than the actual SECTORSIZE. As
> >> such, remove the VLA, adjust offsets and add a sanity check to make sure
> >> we never get a pathological oobsize.
> >>
> >> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> >>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >> ---
> >>  drivers/mtd/inftlmount.c | 11 ++++++++---
> >>  drivers/mtd/nftlmount.c  | 11 ++++++++---
> >>  2 files changed, 16 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/mtd/inftlmount.c b/drivers/mtd/inftlmount.c
> >> index aab4f68bd36f..9cdae7f0fc2e 100644
> >> --- a/drivers/mtd/inftlmount.c
> >> +++ b/drivers/mtd/inftlmount.c
> >> @@ -334,7 +334,7 @@ static int memcmpb(void *a, int c, int n)
> >>  static int check_free_sectors(struct INFTLrecord *inftl, unsigned int address,
> >>       int len, int check_oob)
> >>  {
> >> -     u8 buf[SECTORSIZE + inftl->mbd.mtd->oobsize];
> >> +     u8 buf[SECTORSIZE];  
> >
> > Could we instead move to dynamic allocation. I mean, SECTORSIZE is 512
> > bytes, so only with this function we consume 1/16 of the stack. Not to
> > mention that some MTD drivers might want to do DMA on buffer passed by
> > the MTD user, and if the buffer is on the stack they'll have to use a
> > bounce buffer instead.  
> 
> Sure! I can rework it to do that. Is GFP_KERNEL okay for that, or does
> it need something else?

Just had a quick look, and I think GFP_KERNEL is good.
