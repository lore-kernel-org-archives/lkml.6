Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5C4C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68002184C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfAYVNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:13:51 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:58024 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfAYVNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:13:49 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 686731F453;
        Fri, 25 Jan 2019 21:13:49 +0000 (UTC)
Date:   Fri, 25 Jan 2019 21:13:49 +0000
From:   Eric Wong <e@80x24.org>
To:     Jakub Bogusz <qboosh@pld-linux.org>
Cc:     linux-kernel@vger.kernel.org, mitr@volny.cz,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH][RESEND] wistron_btns needs executable BIOS image
Message-ID: <20190125211349.nfbbcuaip5y6l5dr@dcvr>
References: <20170731182010.GA933@stranger.qboosh.pl>
 <20190125191437.GA25902@stranger.qboosh.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190125191437.GA25902@stranger.qboosh.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Bogusz <qboosh@pld-linux.org> wrote:
> Let's try once again... (take 3)
> 
> First time I sent this patch when I prepared it in 2013 for Linux 3.12,
> the second time after update for Linux 4.12 in 2017...
> And it still applies to Linux 4.20.

Adding Dmitry Torokhov and linux-input to Cc:
(that's what ./scripts/get_maintainer.pl says)

> Actual description in forwarded message.
> 
> 
> -- 
> Jakub Bogusz    http://qboosh.pl/

> From: Jakub Bogusz <qboosh@pld-linux.org>
> To: linux-kernel@vger.kernel.org, mitr@volny.cz
> Subject: [PATCH] wistron_btns needs executable BIOS image
> 
> Hello,
> 
> This patch (originally agains 3.1x, now I updated include to build
> against 4.12.x) fixes winstron_btns module issue with calling BIOS
> functions in non-executable memory.
> 
> Tested (on Linux 3.10.x and few later versions) on F-S Amilo 8210 laptop.
> 
> 
> -- 
> Jakub Bogusz    http://qboosh.pl/

> wistron_btns needs executable BIOS image.
> 
> Signed-off-by: Jakub Bogusz <qboosh@pld-linux.org>
> 
> --- linux-4.12/drivers/input/misc/wistron_btns.c.orig	2013-11-16 09:05:55.612742472 +0100
> +++ linux-4.12/drivers/input/misc/wistron_btns.c	2013-11-16 09:24:37.356028732 +0100
> @@ -33,6 +33,7 @@
>  #include <linux/types.h>
>  #include <linux/platform_device.h>
>  #include <linux/leds.h>
> +#include <asm/set_memory.h>
>  
>  /* How often we poll keys - msecs */
>  #define POLL_INTERVAL_DEFAULT	500 /* when idle */
> @@ -124,6 +125,7 @@
>  	if (entry_point >= 0xF0000) {
>  		bios_code_map_base = base;
>  		bios_entry_point = bios_code_map_base + (entry_point & 0xFFFF);
> +		set_memory_x((unsigned long)bios_code_map_base, 0x10000 >> PAGE_SHIFT);
>  	} else {
>  		iounmap(base);
>  		bios_code_map_base = ioremap(entry_point & ~0x3FFF, 0x4000);
> @@ -134,6 +136,7 @@
>  			goto err;
>  		}
>  		bios_entry_point = bios_code_map_base + (entry_point & 0x3FFF);
> +		set_memory_x((unsigned long)bios_code_map_base, 0x4000 >> PAGE_SHIFT);
>  	}
>  	/* The Windows driver maps 0x10000 bytes, we keep only one page... */
>  	bios_data_map_base = ioremap(0x400, 0xc00);
