Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33539C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1AD2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1AD2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeIZM4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:56:18 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48472 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeIZM4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:56:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 6DD35299C9;
        Wed, 26 Sep 2018 02:44:51 -0400 (EDT)
Date:   Wed, 26 Sep 2018 16:45:28 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Leonardo Bras <leobras.c@gmail.com>
cc:     lkcamp@lists.libreplanetbr.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/7] drivers: nubus: Avoids building driver if CONFIG_NUBUS
 is disabled
In-Reply-To: <20180926015218.GA14964@WindFlash>
Message-ID: <alpine.LNX.2.21.1809261515090.639@nippy.intranet>
References: <20180926015218.GA14964@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018, Leonardo Bras wrote:

> Avoids building driver if 'make drivers/nubus/' is called and
> CONFIG_NUBUS is disabled.
> Avoids building proc.o if CONFIG_PROC_FS is enabled but
> CONFIG_NUBUS is disabled.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> ---
>  drivers/nubus/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nubus/Makefile b/drivers/nubus/Makefile
> index 6d063cde39d1..827301c4a84f 100644
> --- a/drivers/nubus/Makefile
> +++ b/drivers/nubus/Makefile
> @@ -2,6 +2,6 @@
>  # Makefile for the nubus specific drivers.
>  #
>  
> -obj-y := nubus.o bus.o
> -
> -obj-$(CONFIG_PROC_FS) += proc.o
> +obj-$(CONFIG_NUBUS) := nubus.o
> +nubus-y := bus.o
> +nubus-$(CONFIG_PROC_FS) += proc.o
> 

Did you build this for m68k? It doesn't link for me.

  MODPOST vmlinux.o
drivers/nubus/bus.o: In function `nubus_device_release':
bus.c:(.text+0xd0): undefined reference to `nubus_func_rsrcs'
bus.c:(.text+0xe0): undefined reference to `nubus_func_rsrcs'
bus.c:(.text+0x118): undefined reference to `nubus_func_rsrcs'
bus.c:(.text+0xc2): undefined reference to `nubus_func_rsrcs'
drivers/nubus/proc.o: In function `nubus_devices_proc_show':
proc.c:(.text+0xa): undefined reference to `nubus_first_rsrc_or_null'
proc.c:(.text+0x1c): undefined reference to `nubus_next_rsrc_or_null'
drivers/nubus/proc.o: In function `nubus_proc_rsrc_show':
proc.c:(.text+0x190): undefined reference to `nubus_seq_write_rsrc_mem'
drivers/nubus/proc.o: In function `nubus_proc_add_rsrc_mem':
proc.c:(.text+0x24c): undefined reference to `nubus_dirptr'

Patch 4/7 (drivers/zorro) also causes 'undefined reference' errors. I 
didn't test the others.

-- 
