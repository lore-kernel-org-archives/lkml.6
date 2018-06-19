Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F35C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357672083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357672083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937418AbeFSIJ7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:09:59 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:33697 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1756374AbeFSIJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:09:57 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id AD6C25C2144; Tue, 19 Jun 2018 08:08:34 +0000 (UTC)
Date:   Tue, 19 Jun 2018 08:08:34 +0000
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        natechancellor@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] staging: board: drop refcount in success case
Message-ID: <20180619080834.GA31882@osadl.at>
References: <1529347999-9316-1-git-send-email-hofrat@osadl.org>
 <20180619073709.schatjhjoitfc3fs@mwanda>
 <CAMuHMdVuGAh7rya0CJtALDmjyHpQJv=uHA=-n1fLS7s+CnUoXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVuGAh7rya0CJtALDmjyHpQJv=uHA=-n1fLS7s+CnUoXg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 09:51:44AM +0200, Geert Uytterhoeven wrote:
> On Tue, Jun 19, 2018 at 9:37 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > On Mon, Jun 18, 2018 at 08:53:19PM +0200, Nicholas Mc Guire wrote:
> > >  The call to of_find_compatible_node() returns irqc_node with refcount
> > > incremented thus it must be explicitly decremented here after it was
> > > checked for non-NULL.
> > >
> > > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > > Fixes: commit 72ee8626eeb1 ("staging: board: Add support for translating hwirq to virq numbers")
> > > ---
> > >
> > > Problem located with an experimental coccinelle script
> > >
> > > Patch was compile-tested with: x86_64_defconfig + STAGING=y, STAGING_BOARD=y
> > >
> > > Patch is against 4.18-rc1 (localversion-next is next-20180618)
> > >
> > >  drivers/staging/board/board.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
> > > index cb6feb3..8ee48e5 100644
> > > --- a/drivers/staging/board/board.c
> > > +++ b/drivers/staging/board/board.c
> > > @@ -64,12 +64,13 @@ int __init board_staging_gic_setup_xlate(const char *gic_match,
> > >       irqc_node = of_find_compatible_node(NULL, NULL, gic_match);
> > >
> > >       WARN_ON(!irqc_node);
> > >       if (!irqc_node)
> > >               return -ENOENT;
> > >
> > > +     of_node_put(irqc_node);
> >
> > I don't feel like this is the right thing...  We should keep the
> > reference until we're done with it.  Which apparently is never?
> 
> Indeed. The reference must not be released in this function, as it's stored in
> a global variable, and used later.

yup -  I had simply interpreted this incorrectly as checking only and
overlooked that this was a global variable.

> 
> As all users are __init, it could be released when the init section is freeed,
> in theory, but there's no callback for that.
> 
> Hence:
> NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
thanks for the clarification - sorry for the noise.

thx
hofrat
