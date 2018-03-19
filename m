Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936801AbeCSWn0 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:43:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53057 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933160AbeCSWnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 18:43:03 -0400
Date: Mon, 19 Mar 2018 23:42:50 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: boris.brezillon@free-electrons.com, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, miquel.raynal@free-electrons.com,
        alexandre.belloni@free-electrons.com, wens@csie.org,
        cyrille.pitchen@wedev4u.fr
Subject: Re: [PATCH v2 1/2] mtd: maps: Remove print after allocation failure
Message-ID: <20180319234250.18aa0826@xps13>
In-Reply-To: <1521390796-13715-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1521390796-13715-1-git-send-email-arushisinghal19971997@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arushi,

On Sun, 18 Mar 2018 22:03:15 +0530, Arushi Singhal
<arushisinghal19971997@gmail.com> wrote:

> The prints after [k|v][m|z|c]alloc() functions are not needed, because
> in case of failure, allocator will print their internal error prints
> anyway.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
> changes in v2
> * done changes in all the other files.
> 
>  drivers/mtd/maps/amd76xrom.c  | 6 ++----
>  drivers/mtd/maps/ck804xrom.c  | 4 +---
>  drivers/mtd/maps/esb2rom.c    | 4 +---
>  drivers/mtd/maps/ichxrom.c    | 6 ++----
>  drivers/mtd/maps/sun_uflash.c | 4 +---
>  drivers/mtd/maps/vmu-flash.c  | 3 ---
>  6 files changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mtd/maps/amd76xrom.c b/drivers/mtd/maps/amd76xrom.c
> index 26de0a1..406a8d3 100644
> --- a/drivers/mtd/maps/amd76xrom.c
> +++ b/drivers/mtd/maps/amd76xrom.c
> @@ -188,10 +188,8 @@ static int amd76xrom_init_one(struct pci_dev *pdev,
>  
>  		if (!map) {
>  			map = kmalloc(sizeof(*map), GFP_KERNEL);
> -		}
> -		if (!map) {
> -			printk(KERN_ERR MOD_NAME ": kmalloc failed");
> -			goto out;
> +			if (!map)
> +				goto out;
>  		}
>  		memset(map, 0, sizeof(*map));
>  		INIT_LIST_HEAD(&map->list);
> diff --git a/drivers/mtd/maps/ck804xrom.c b/drivers/mtd/maps/ck804xrom.c
> index 584962e..2529d1b 100644
> --- a/drivers/mtd/maps/ck804xrom.c
> +++ b/drivers/mtd/maps/ck804xrom.c
> @@ -219,10 +219,8 @@ static int __init ck804xrom_init_one(struct pci_dev *pdev,
>  		if (!map)
>  			map = kmalloc(sizeof(*map), GFP_KERNEL);
>  
> -		if (!map) {
> -			printk(KERN_ERR MOD_NAME ": kmalloc failed");
> +		if (!map)
>  			goto out;
> -		}

This is a personal feeling but I prefer the first version:

        if (!map) {
                map = kmalloc();
                if (!map)
                        err;
        }

than

        if (!map)
                map = kmalloc();

        if (!map)
                err;

Same below of course.


Thanks,
Miquèl

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
