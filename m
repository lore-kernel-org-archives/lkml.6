Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBE2C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433A720647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433A720647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbeGZVCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:02:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44944 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730989AbeGZVCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:02:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8FD1F2093C; Thu, 26 Jul 2018 21:43:45 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 30DB420740;
        Thu, 26 Jul 2018 21:43:35 +0200 (CEST)
Date:   Thu, 26 Jul 2018 21:43:35 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org,
        linux-mtd@lists.infradead.org, Rich Felker <dalias@libc.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3] mtd/maps: fix solutionengine.c printk format
 warnings
Message-ID: <20180726214335.047e877e@bbrezillon>
In-Reply-To: <578dd079-80d0-939a-fbfd-ae101da1dc29@infradead.org>
References: <578dd079-80d0-939a-fbfd-ae101da1dc29@infradead.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 11:29:01 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix 2 printk format warnings (this driver is currently only used by
> arch/sh/) by using "%pap" instead of "%lx".
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

Applied.

Thanks,

Boris

> ---
> v3: drop anding the phys addresses with 0x1fffffff since the only
>     phys addresses are 0 or 0x01000000.
> 
>  drivers/mtd/maps/solutionengine.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-next-20180717.orig/drivers/mtd/maps/solutionengine.c
> +++ linux-next-20180717/drivers/mtd/maps/solutionengine.c
> @@ -59,9 +59,9 @@ static int __init init_soleng_maps(void)
>  			return -ENXIO;
>  		}
>  	}
> -	printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n",
> -	       soleng_flash_map.phys & 0x1fffffff,
> -	       soleng_eprom_map.phys & 0x1fffffff);
> +	printk(KERN_NOTICE "Solution Engine: Flash at 0x%pap, EPROM at 0x%pap\n",
> +	       &soleng_flash_map.phys,
> +	       &soleng_eprom_map.phys);
>  	flash_mtd->owner = THIS_MODULE;
>  
>  	eprom_mtd = do_map_probe("map_rom", &soleng_eprom_map);
> 
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

