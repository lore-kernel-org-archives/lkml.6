Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeCNTXy convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:23:54 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:38028 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbeCNTXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:23:53 -0400
From: Richard Weinberger <richard@nod.at>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@free-electrons.com,
        marek.vasut@gmail.com, cyrille.pitchen@wedev4u.fr, dedekind1@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtd: ubi: use put_device() if device_register fail
Date: Wed, 14 Mar 2018 20:25:25 +0100
Message-ID: <3619597.KITkZyk1Wv@blindfold>
In-Reply-To: <20180314195652.59b21594@bbrezillon>
References: <cover.1520592440.git.arvind.yadav.cs@gmail.com> <5d9b08afdad2fbc65bac48d8ae22f4925bb80512.1520592440.git.arvind.yadav.cs@gmail.com> <20180314195652.59b21594@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 14. März 2018, 19:56:52 CET schrieb Boris Brezillon:
> On Fri,  9 Mar 2018 16:20:49 +0530
> 
> Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> > if device_register() returned an error! Always use put_device()
> > to give up the reference initialized.
> > 
> > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> > ---
> > 
> >  drivers/mtd/ubi/vmt.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
> > index 3fd8d7f..db85b68 100644
> > --- a/drivers/mtd/ubi/vmt.c
> > +++ b/drivers/mtd/ubi/vmt.c
> > @@ -609,6 +609,7 @@ int ubi_add_volume(struct ubi_device *ubi, struct
> > ubi_volume *vol)> 
> >  	return err;
> >  
> >  out_cdev:
> > +	put_device(&vol->dev);
> > 
> >  	cdev_del(&vol->cdev);
> 
> use-after-free bug here: put_device() has freed the vol obj, and you're
> dereferencing the pointer just after that.

eeek, thanks for looking at more context.
Arvind, while you are right that put_device() is missing, please double check 
that freeing the devices is also correct.

Thanks,
//richard
