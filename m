Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B00C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB9C20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB9C20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbeGXGyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 02:54:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45505 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388140AbeGXGyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 02:54:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3C0E6207B0; Tue, 24 Jul 2018 07:49:52 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id C7579206F6;
        Tue, 24 Jul 2018 07:49:51 +0200 (CEST)
Date:   Tue, 24 Jul 2018 07:49:51 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] mtd/maps: fix solutionengine.c printk format
 warnings
Message-ID: <20180724074951.62c49935@bbrezillon>
In-Reply-To: <0ca72308-0551-97dc-dc74-11e1d8dac5b1@infradead.org>
References: <0ca72308-0551-97dc-dc74-11e1d8dac5b1@infradead.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jul 2018 16:28:52 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix 2 printk format warnings (this driver is currently only used by
> arch/sh/) by using "%pap" instead of "%lx".
> (or we could just cast the physical addresses to unsigned int)
> 
> Fixes these build warnings:
> 
> ../drivers/mtd/maps/solutionengine.c: In function 'init_soleng_maps':
> ../include/linux/kern_levels.h:5:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
> ../drivers/mtd/maps/solutionengine.c:62:54: note: format string is defined here
>   printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n",
>                                                   ~~~~^
>                                                   %08x
> ../include/linux/kern_levels.h:5:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
> ../drivers/mtd/maps/solutionengine.c:62:72: note: format string is defined here
>   printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n",
>                                                                     ~~~~^
>                                                                     %08x
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-mtd@lists.infradead.org
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: indent all lines inside the new block
> 
>  drivers/mtd/maps/solutionengine.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> --- linux-next-20180717.orig/drivers/mtd/maps/solutionengine.c
> +++ linux-next-20180717/drivers/mtd/maps/solutionengine.c
> @@ -59,9 +59,14 @@ static int __init init_soleng_maps(void)
>  			return -ENXIO;
>  		}
>  	}
> -	printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n",
> -	       soleng_flash_map.phys & 0x1fffffff,
> -	       soleng_eprom_map.phys & 0x1fffffff);

Hm, not sure why masking with 0x1fffffff is required. It seems .phys is
either 0 or 0x1000000, so maybe we should just go for 

	printk(KERN_NOTICE "Solution Engine: Flash at 0x%pap, EPROM at 0x%pap\n",
	       &soleng_flash_map.phys, &soleng_eprom_map.phys);


> +	{
> +		resource_size_t fl_phys = soleng_flash_map.phys & 0x1fffffff;
> +		resource_size_t ep_phys = soleng_eprom_map.phys & 0x1fffffff;
> +
> +		printk(KERN_NOTICE
> +		       "Solution Engine: Flash at 0x%pap, EPROM at 0x%pap\n",
> +	       	       &fl_phys, &ep_phys);
> +	}
>  	flash_mtd->owner = THIS_MODULE;
>  
>  	eprom_mtd = do_map_probe("map_rom", &soleng_eprom_map);
> 
> 

