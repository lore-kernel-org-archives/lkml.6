Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2C0C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2221120835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550084000;
	bh=tMd2wJADDfeOgzvHQuDm82xMsDrJ1I1oe+OpO9spSHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MlAs956UpMUGGsw1SV3mnEsinObh2ZWbD7JAtNH8mPTdv5Q+Pyv15MybfZBoc1+n7
	 yM6ZmE7MF9DkneVk5Y8s5x/OZB7tSTClHB5zS0560zKcT+ECQM/wOCSrQgIr84zDtG
	 purx1KYLcloTzGoM89cdWRvnfevZlR7tFvW2RaNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405754AbfBMSm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:42:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405729AbfBMSmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:42:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16F3C222D6;
        Wed, 13 Feb 2019 18:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083372;
        bh=tMd2wJADDfeOgzvHQuDm82xMsDrJ1I1oe+OpO9spSHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQUiRBYZyFuwWqLoD4c2mgx9luegxTGKQxLYQhIcxP1Ad7+Svvd9bOLKE8RDrDIvL
         aRylucCLwdbNl4tSNCv4XZnEeVTH9QX/Ijr7+vsvaW7CC/bHZCvJEDleHW+vOmIqBq
         eOcuO2Y9wkulqONRWxiFV1aNadbOjYwyT5ibP4M4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.19 16/44] pinctrl: sunxi: Correct number of IRQ banks on H6 main pin controller
Date:   Wed, 13 Feb 2019 19:38:17 +0100
Message-Id: <20190213183653.042951004@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wens@csie.org>

commit 10098709b4ee6f6f19f25ba81d9c6f83518c584c upstream.

The H6 main pin controller has four banks of interrupt-triggering pins.
The driver as originally submitted only specified three, but had pin
descriptions referencing a fourth bank. This results in a out-of-bounds
access into .irq_array of struct sunxi_pinctrl. This however did not
result in a crash until v4.20, with commit a66d972465d1 ("devres: Align
data[] to ARCH_KMALLOC_MINALIGN"), which changed the alignment of memory
region returned by devm_kcalloc(). The increase likely moved the
out-of-bounds access into the next, unmapped page.

With KASAN on, the bug is quite clear:

    BUG: KASAN: slab-out-of-bounds in sunxi_pinctrl_init_with_variant+0x49c/0x12b8
    Write of size 4 at addr ffff80002c680280 by task swapper/0/1

    CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc1-00016-gc480a5e6a077 #3
    Hardware name: OrangePi Lite2 (DT)
    Call trace:
     dump_backtrace+0x0/0x220
     show_stack+0x14/0x20
     dump_stack+0xac/0xd4
     print_address_description+0x60/0x25c
     kasan_report+0x14c/0x1ac
     __asan_store4+0x80/0xa0
     sunxi_pinctrl_init_with_variant+0x49c/0x12b8
     h6_pinctrl_probe+0x18/0x20
     platform_drv_probe+0x6c/0xc8
     really_probe+0x244/0x4b0
     driver_probe_device.part.4+0x11c/0x164
     __driver_attach+0x120/0x190
     bus_for_each_dev+0xe8/0x158
     driver_attach+0x30/0x40
     bus_add_driver+0x308/0x318
     driver_register+0xbc/0x1d0
     __platform_driver_register+0x7c/0x88
     h6_pinctrl_driver_init+0x18/0x20
     do_one_initcall+0xd4/0x208
     kernel_init_freeable+0x230/0x2c8
     kernel_init+0x10/0x108
     ret_from_fork+0x10/0x1c

    Allocated by task 1:
     kasan_kmalloc.part.0+0x4c/0x100
     kasan_kmalloc+0xc4/0xe8
     kasan_slab_alloc+0x14/0x20
     __kmalloc_track_caller+0x130/0x238
     devm_kmalloc+0x34/0xd0
     sunxi_pinctrl_init_with_variant+0x1d8/0x12b8
     h6_pinctrl_probe+0x18/0x20
     platform_drv_probe+0x6c/0xc8
     really_probe+0x244/0x4b0
     driver_probe_device.part.4+0x11c/0x164
     __driver_attach+0x120/0x190
     bus_for_each_dev+0xe8/0x158
     driver_attach+0x30/0x40
     bus_add_driver+0x308/0x318
     driver_register+0xbc/0x1d0
     __platform_driver_register+0x7c/0x88
     h6_pinctrl_driver_init+0x18/0x20
     do_one_initcall+0xd4/0x208
     kernel_init_freeable+0x230/0x2c8
     kernel_init+0x10/0x108
     ret_from_fork+0x10/0x1c

    Freed by task 0:
    (stack is not available)

    The buggy address belongs to the object at ffff80002c680080
     which belongs to the cache kmalloc-512 of size 512
    The buggy address is located 0 bytes to the right of
     512-byte region [ffff80002c680080, ffff80002c680280)
    The buggy address belongs to the page:
    page:ffff7e0000b1a000 count:1 mapcount:0 mapping:ffff80002e00c780 index:0xffff80002c683c80 compound_mapcount: 0
    flags: 0x10200(slab|head)
    raw: 0000000000010200 ffff80002e003a10 ffff80002e003a10 ffff80002e00c780
    raw: ffff80002c683c80 0000000000100001 00000001ffffffff 0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff80002c680180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     ffff80002c680200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    >ffff80002c680280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
		       ^
     ffff80002c680300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
     ffff80002c680380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

Correct the number of IRQ banks so there are no more mismatches.

Fixes: c8a830904991 ("pinctrl: sunxi: add support for the Allwinner H6 main pin controller")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
@@ -588,7 +588,7 @@ static const unsigned int h6_irq_bank_ma
 static const struct sunxi_pinctrl_desc h6_pinctrl_data = {
 	.pins = h6_pins,
 	.npins = ARRAY_SIZE(h6_pins),
-	.irq_banks = 3,
+	.irq_banks = 4,
 	.irq_bank_map = h6_irq_bank_map,
 	.irq_read_needs_mux = true,
 };


