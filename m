Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9021BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CC2255A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CC2255A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932339AbeGBGwa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 02:52:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46291 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753216AbeGBGw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 02:52:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 269872082B; Mon,  2 Jul 2018 08:52:27 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id CD1DD2079C;
        Mon,  2 Jul 2018 08:52:26 +0200 (CEST)
Date:   Mon, 2 Jul 2018 08:52:27 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>, dedekind1@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v3 2/2] ubi: expose the volume CRC check skip flag
Message-ID: <20180702085227.2b418264@bbrezillon>
In-Reply-To: <20180702064433.kvxcacdhuenzk5j3@qschulz>
References: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com>
        <382648641.QZzOm4Mo72@blindfold>
        <20180701223347.2cef133b@bbrezillon>
        <3709236.JAAyN4mQyL@blindfold>
        <20180702064433.kvxcacdhuenzk5j3@qschulz>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 08:44:33 +0200
Quentin Schulz <quentin.schulz@bootlin.com> wrote:

> Hi Richard, Boris,
> 
> On Sun, Jul 01, 2018 at 10:50:41PM +0200, Richard Weinberger wrote:
> > Am Sonntag, 1. Juli 2018, 22:33:47 CEST schrieb Boris Brezillon:  
> > > On Sun, 01 Jul 2018 21:35:57 +0200
> > > Richard Weinberger <richard@nod.at> wrote:
> > >   
> > > > Quentin,
> > > > 
> > > > Am Donnerstag, 28. Juni 2018, 09:40:53 CEST schrieb Quentin Schulz:  
> > > > > Now that we have the logic for skipping CRC check for static UBI volumes
> > > > > in the core, let's expose it to users.
> > > > > 
> > > > > This makes use of a padding byte in the volume description data
> > > > > structure as a flag. This flag only tell for now whether we should skip
> > > > > the CRC check of a volume.
> > > > > 
> > > > > This checks the UBI volume for which we are trying to skip the CRC check
> > > > > is static.
> > > > > 
> > > > > Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > > > > Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > > ---
> > > > >  drivers/mtd/ubi/cdev.c      |  4 ++++
> > > > >  drivers/mtd/ubi/vmt.c       |  3 +++
> > > > >  include/uapi/mtd/ubi-user.h | 16 ++++++++++++++--
> > > > >  3 files changed, 21 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
> > > > > index 45c3296..3eea1df 100644
> > > > > --- a/drivers/mtd/ubi/cdev.c
> > > > > +++ b/drivers/mtd/ubi/cdev.c
> > > > > @@ -622,6 +622,10 @@ static int verify_mkvol_req(const struct ubi_device *ubi,
> > > > >  	    req->vol_type != UBI_STATIC_VOLUME)
> > > > >  		goto bad;
> > > > >  
> > > > > +	if (req->flags & UBI_VOL_SKIP_CRC_CHECK_FLG &&  
> > > 
> > > Oops, missed that req->flags & UBI_VOL_SKIP_CRC_CHECK_FLG check was
> > > missing parens (checkpatch --strict should complain about that).  
> > 
> > Latest when building my local branch or in linux-next we had noticed.
> > No need to worry.
> >    
> > > > > +	    req->vol_type != UBI_STATIC_VOLUME)
> > > > > +		goto bad;    
> > > > 
> > > > We should also reject unknown flags here.  
> > > 
> > > I agree.  
> 
> Should I send another version of my patches for it?

Yes please, respin your series with this additional check. Just define

#define UBI_VOL_VALID_FLGS	(UBI_VOL_SKIP_CRC_CHECK_FLG)

and then, in verify_mkvol_req() add

	if (req->flags & ~UBI_VOL_VALID_FLGS)
		goto bad;

> Same for
> parenthesis around the flags masking above?

No need to fix that one (unless Richard cares), as it seems I had it
wrong.
