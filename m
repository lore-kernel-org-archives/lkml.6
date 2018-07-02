Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366E1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE4621EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE4621EB5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932646AbeGBGyU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 02:54:20 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:42214 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932453AbeGBGyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 02:54:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 91E80608D739;
        Mon,  2 Jul 2018 08:54:17 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jdzw5xRWxUgb; Mon,  2 Jul 2018 08:54:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3C82A60A359C;
        Mon,  2 Jul 2018 08:54:17 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SZV_Ke_lHsWt; Mon,  2 Jul 2018 08:54:17 +0200 (CEST)
Received: from blindfold.localnet (089144195003.atnat0004.highway.a1.net [89.144.195.3])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 15A0560A3593;
        Mon,  2 Jul 2018 08:54:17 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>, dedekind1@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v3 2/2] ubi: expose the volume CRC check skip flag
Date:   Mon, 02 Jul 2018 08:54:09 +0200
Message-ID: <2109705.Xvz1DYdJuj@blindfold>
In-Reply-To: <20180702085227.2b418264@bbrezillon>
References: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com> <20180702064433.kvxcacdhuenzk5j3@qschulz> <20180702085227.2b418264@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 2. Juli 2018, 08:52:27 CEST schrieb Boris Brezillon:
> On Mon, 2 Jul 2018 08:44:33 +0200
> Quentin Schulz <quentin.schulz@bootlin.com> wrote:
> 
> > Hi Richard, Boris,
> > 
> > On Sun, Jul 01, 2018 at 10:50:41PM +0200, Richard Weinberger wrote:
> > > Am Sonntag, 1. Juli 2018, 22:33:47 CEST schrieb Boris Brezillon:  
> > > > On Sun, 01 Jul 2018 21:35:57 +0200
> > > > Richard Weinberger <richard@nod.at> wrote:
> > > >   
> > > > > Quentin,
> > > > > 
> > > > > Am Donnerstag, 28. Juni 2018, 09:40:53 CEST schrieb Quentin Schulz:  
> > > > > > Now that we have the logic for skipping CRC check for static UBI volumes
> > > > > > in the core, let's expose it to users.
> > > > > > 
> > > > > > This makes use of a padding byte in the volume description data
> > > > > > structure as a flag. This flag only tell for now whether we should skip
> > > > > > the CRC check of a volume.
> > > > > > 
> > > > > > This checks the UBI volume for which we are trying to skip the CRC check
> > > > > > is static.
> > > > > > 
> > > > > > Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > > > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > > > > > Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > > > ---
> > > > > >  drivers/mtd/ubi/cdev.c      |  4 ++++
> > > > > >  drivers/mtd/ubi/vmt.c       |  3 +++
> > > > > >  include/uapi/mtd/ubi-user.h | 16 ++++++++++++++--
> > > > > >  3 files changed, 21 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
> > > > > > index 45c3296..3eea1df 100644
> > > > > > --- a/drivers/mtd/ubi/cdev.c
> > > > > > +++ b/drivers/mtd/ubi/cdev.c
> > > > > > @@ -622,6 +622,10 @@ static int verify_mkvol_req(const struct ubi_device *ubi,
> > > > > >  	    req->vol_type != UBI_STATIC_VOLUME)
> > > > > >  		goto bad;
> > > > > >  
> > > > > > +	if (req->flags & UBI_VOL_SKIP_CRC_CHECK_FLG &&  
> > > > 
> > > > Oops, missed that req->flags & UBI_VOL_SKIP_CRC_CHECK_FLG check was
> > > > missing parens (checkpatch --strict should complain about that).  
> > > 
> > > Latest when building my local branch or in linux-next we had noticed.
> > > No need to worry.
> > >    
> > > > > > +	    req->vol_type != UBI_STATIC_VOLUME)
> > > > > > +		goto bad;    
> > > > > 
> > > > > We should also reject unknown flags here.  
> > > > 
> > > > I agree.  
> > 
> > Should I send another version of my patches for it?

Yes. Please.

> Yes please, respin your series with this additional check. Just define
> 
> #define UBI_VOL_VALID_FLGS	(UBI_VOL_SKIP_CRC_CHECK_FLG)
> 
> and then, in verify_mkvol_req() add
> 
> 	if (req->flags & ~UBI_VOL_VALID_FLGS)
> 		goto bad;

Yep.
 
> > Same for
> > parenthesis around the flags masking above?
> 
> No need to fix that one (unless Richard cares), as it seems I had it
> wrong.

Nah. If both gcc and checkpatch don't complain, let's keep it as-is.

Thanks,
//richard
