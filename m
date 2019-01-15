Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160FFC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E502D20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfAOP5C convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:57:02 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56808 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbfAOP5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:57:01 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C503F20A7D; Tue, 15 Jan 2019 16:56:58 +0100 (CET)
Received: from localhost (build.bootlin.com [163.172.53.213])
        by mail.bootlin.com (Postfix) with ESMTPSA id 92A82209BC;
        Tue, 15 Jan 2019 16:56:48 +0100 (CET)
Date:   Tue, 15 Jan 2019 09:23:33 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pinctrl: sunxi: Correct number of IRQ banks on H6 main
 pin controller
Message-ID: <20190115082333.be4rbnviczkujnt4@flea>
References: <20190115024543.12928-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190115024543.12928-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:45:43AM +0800, Chen-Yu Tsai wrote:
> The H6 main pin controller has four banks of interrupt-triggering pins.
> The driver as originally submitted only specified three, but had pin
> descriptions referencing a fourth bank. This results in a out-of-bounds
> access into .irq_array of struct sunxi_pinctrl. This however did not
> result in a crash until v4.20, with commit a66d972465d1 ("devres: Align
> data[] to ARCH_KMALLOC_MINALIGN"), which changed the alignment of memory
> region returned by devm_kcalloc(). The increase likely moved the
> out-of-bounds access into the next, unmapped page.
> 
> With KASAN on, the bug is quite clear:
> 
>     BUG: KASAN: slab-out-of-bounds in sunxi_pinctrl_init_with_variant+0x49c/0x12b8
>     Write of size 4 at addr ffff80002c680280 by task swapper/0/1
> 
>     CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc1-00016-gc480a5e6a077 #3
>     Hardware name: OrangePi Lite2 (DT)
>     Call trace:
>      dump_backtrace+0x0/0x220
>      show_stack+0x14/0x20
>      dump_stack+0xac/0xd4
>      print_address_description+0x60/0x25c
>      kasan_report+0x14c/0x1ac
>      __asan_store4+0x80/0xa0
>      sunxi_pinctrl_init_with_variant+0x49c/0x12b8
>      h6_pinctrl_probe+0x18/0x20
>      platform_drv_probe+0x6c/0xc8
>      really_probe+0x244/0x4b0
>      driver_probe_device.part.4+0x11c/0x164
>      __driver_attach+0x120/0x190
>      bus_for_each_dev+0xe8/0x158
>      driver_attach+0x30/0x40
>      bus_add_driver+0x308/0x318
>      driver_register+0xbc/0x1d0
>      __platform_driver_register+0x7c/0x88
>      h6_pinctrl_driver_init+0x18/0x20
>      do_one_initcall+0xd4/0x208
>      kernel_init_freeable+0x230/0x2c8
>      kernel_init+0x10/0x108
>      ret_from_fork+0x10/0x1c
> 
>     Allocated by task 1:
>      kasan_kmalloc.part.0+0x4c/0x100
>      kasan_kmalloc+0xc4/0xe8
>      kasan_slab_alloc+0x14/0x20
>      __kmalloc_track_caller+0x130/0x238
>      devm_kmalloc+0x34/0xd0
>      sunxi_pinctrl_init_with_variant+0x1d8/0x12b8
>      h6_pinctrl_probe+0x18/0x20
>      platform_drv_probe+0x6c/0xc8
>      really_probe+0x244/0x4b0
>      driver_probe_device.part.4+0x11c/0x164
>      __driver_attach+0x120/0x190
>      bus_for_each_dev+0xe8/0x158
>      driver_attach+0x30/0x40
>      bus_add_driver+0x308/0x318
>      driver_register+0xbc/0x1d0
>      __platform_driver_register+0x7c/0x88
>      h6_pinctrl_driver_init+0x18/0x20
>      do_one_initcall+0xd4/0x208
>      kernel_init_freeable+0x230/0x2c8
>      kernel_init+0x10/0x108
>      ret_from_fork+0x10/0x1c
> 
>     Freed by task 0:
>     (stack is not available)
> 
>     The buggy address belongs to the object at ffff80002c680080
>      which belongs to the cache kmalloc-512 of size 512
>     The buggy address is located 0 bytes to the right of
>      512-byte region [ffff80002c680080, ffff80002c680280)
>     The buggy address belongs to the page:
>     page:ffff7e0000b1a000 count:1 mapcount:0 mapping:ffff80002e00c780 index:0xffff80002c683c80 compound_mapcount: 0
>     flags: 0x10200(slab|head)
>     raw: 0000000000010200 ffff80002e003a10 ffff80002e003a10 ffff80002e00c780
>     raw: ffff80002c683c80 0000000000100001 00000001ffffffff 0000000000000000
>     page dumped because: kasan: bad access detected
> 
>     Memory state around the buggy address:
>      ffff80002c680180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      ffff80002c680200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     >ffff80002c680280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> 		       ^
>      ffff80002c680300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>      ffff80002c680380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> 
> Correct the number of IRQ banks so there are no more mismatches.
> 
> Fixes: c8a830904991 ("pinctrl: sunxi: add support for the Allwinner H6
> 		      main pin controller")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
