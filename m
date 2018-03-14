Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeCNS5A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:57:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38120 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751379AbeCNS47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:56:59 -0400
Date: Wed, 14 Mar 2018 19:56:52 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@free-electrons.com, marek.vasut@gmail.com,
        richard@nod.at, cyrille.pitchen@wedev4u.fr, dedekind1@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtd: ubi: use put_device() if device_register fail
Message-ID: <20180314195652.59b21594@bbrezillon>
In-Reply-To: <5d9b08afdad2fbc65bac48d8ae22f4925bb80512.1520592440.git.arvind.yadav.cs@gmail.com>
References: <cover.1520592440.git.arvind.yadav.cs@gmail.com>
        <5d9b08afdad2fbc65bac48d8ae22f4925bb80512.1520592440.git.arvind.yadav.cs@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Mar 2018 16:20:49 +0530
Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> if device_register() returned an error! Always use put_device()
> to give up the reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/mtd/ubi/vmt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
> index 3fd8d7f..db85b68 100644
> --- a/drivers/mtd/ubi/vmt.c
> +++ b/drivers/mtd/ubi/vmt.c
> @@ -609,6 +609,7 @@ int ubi_add_volume(struct ubi_device *ubi, struct ubi_volume *vol)
>  	return err;
>  
>  out_cdev:
> +	put_device(&vol->dev);
>  	cdev_del(&vol->cdev);

use-after-free bug here: put_device() has freed the vol obj, and you're
dereferencing the pointer just after that.

>  	return err;
>  }



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
