Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FDAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60CF20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EpmeU5d2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfAOJFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:05:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40415 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbfAOJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:05:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so1996751wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 01:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3WI7iVpHS7FPhv7sFxWt3KEdzuchwcFOY5GT15pgrVA=;
        b=EpmeU5d2KmHILylKFl8RtQZhbawA9lZNzKJDzsNWI+PKZgJS6XNDr1LN5RjHGiNpSf
         jPhIrwsCCpyv1pb4W/TCKsOKifnBTjQjUgBpRV5pwFSkYvtFnK2ZDcZ6DHQ49grazSBO
         hIF9l8k7rikRXKmbJU6sf6WzZhncZfMike9eLd3P17ocRMnEO/H703sIjS4By7ZNqgq+
         FRmnF5k865kXXMcY6kk0hpBLCDCw4UPnguBtoDqZoUduW1o8c8v2XE1UA6xPyTiy2n2n
         2dR5w2w2dnJiMCHRvKXAeX3EccEdMVE/vr9dJsq3MQAMKBByZA5EgCTOLPrmkTkHYyD9
         egyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3WI7iVpHS7FPhv7sFxWt3KEdzuchwcFOY5GT15pgrVA=;
        b=hfORFinJh2HJSGK4QqSWZGDwZvmeELonzqq3MoH3gJRsoRKeSPGqB2If63BYW63Vbg
         wcZ95yKUpwECSksLZ16tojF8LS5n/PegarHG0ZdSS0qufcELqo28Brh6gU20ZzdvizA/
         rH1sGBFV8/7AglvWeKP3s+fYgVIlDkPj/fqWxFrUy4B92MOQ642AyK22KpyXZOUhczai
         LSvHoB78d7rvHwjZRqlOj1OmU5MfIhrdV5c6Ep7I4+eTbsUR+pl2XmvR34qN7Y7Hvlyy
         il9uFCI9ra5j9fB/SbDoDxsY7Pre+ixIJczie75CkByK8uZ5BnFXd4H3EiaGd/uuA7B2
         MXgA==
X-Gm-Message-State: AJcUukeoPBjHU4nQRc5XWHNq//DQKI13k9Pd1q7XmiGhWHOSp8GCW98Z
        phBqVj9ztKyBNfz1MiQIliCrYs793nJAzg==
X-Google-Smtp-Source: ALg8bN7IwoxyFgUYLNC68puN+jfsMgarWMj2HpJzWsJ5gKWdpXbjZgmECayT7Q+HS6zljRmMa8Lg7A==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr2097758wrh.250.1547543131103;
        Tue, 15 Jan 2019 01:05:31 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g188sm33237363wmf.32.2019.01.15.01.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 01:05:30 -0800 (PST)
Subject: Re: [PATCH] pinctrl: sunxi: Correct number of IRQ banks on H6 main
 pin controller
To:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190115024543.12928-1-wens@csie.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <1ab66321-5294-66b1-46c7-cbf39411549f@baylibre.com>
Date:   Tue, 15 Jan 2019 10:05:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115024543.12928-1-wens@csie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/01/2019 03:45, Chen-Yu Tsai wrote:
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
> ---
>  drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
> index aa8b58125568..ef4268cc6227 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
> @@ -588,7 +588,7 @@ static const unsigned int h6_irq_bank_map[] = { 1, 5, 6, 7 };
>  static const struct sunxi_pinctrl_desc h6_pinctrl_data = {
>  	.pins = h6_pins,
>  	.npins = ARRAY_SIZE(h6_pins),
> -	.irq_banks = 3,
> +	.irq_banks = 4,
>  	.irq_bank_map = h6_irq_bank_map,
>  	.irq_read_needs_mux = true,
>  };
> 

Tested-by: Neil Armstrong <narmstrong@baylibre.com>

Fixes boot on Linux 5.0-rc2 on a Pine H64 Model B

Neil
