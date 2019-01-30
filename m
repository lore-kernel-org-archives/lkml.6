Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F39C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F69920882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfA3JZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:25:57 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:7233 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfA3JZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:25:57 -0500
Received: from [10.28.18.236] (10.28.18.236) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 30 Jan
 2019 17:26:39 +0800
Subject: Re: [PATCH] mtd: rawnand: meson: Fix linking error on 32-bit
 platforms
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Kevin Hilman <khilman@baylibre.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20190129214657.5877-1-natechancellor@gmail.com>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <42d2e92e-9f5a-62b2-c0af-b7f3544d79d2@amlogic.com>
Date:   Wed, 30 Jan 2019 17:26:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129214657.5877-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.236]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On 2019/1/30 5:46, Nathan Chancellor wrote:
> On arm little endian allyesconfig:
> 
>    ld.lld: error: undefined symbol: __aeabi_uldivmod
>    >>> referenced by meson_nand.c
>    >>> mtd/nand/raw/meson_nand.o:(meson_nfc_setup_data_interface) in archive drivers/built-in.a
> 
> The dividend tBERS_max is u64, meaning we need to use DIV_ROUND_UP_ULL
> (which wraps do_div) to prevent the compiler from emitting
> __aebi_uldivmod.
> 
> Fixes: 2d570b34b41a ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>   drivers/mtd/nand/raw/meson_nand.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index e858d58d97b0..6f12a96195d1 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -1116,8 +1116,8 @@ int meson_nfc_setup_data_interface(struct nand_chip *nand, int csline,
>   				       div * NFC_CLK_CYCLE);
>   	meson_chip->tadl = DIV_ROUND_UP(PSEC_TO_NSEC(timings->tADL_min),
>   					div * NFC_CLK_CYCLE);
> -	tbers_clocks = DIV_ROUND_UP(PSEC_TO_NSEC(timings->tBERS_max),
> -				    div * NFC_CLK_CYCLE);
> +	tbers_clocks = DIV_ROUND_UP_ULL(PSEC_TO_NSEC(timings->tBERS_max),
> +					div * NFC_CLK_CYCLE);

Looks good to me:

Acked-by: Liang Yang <liang.yang@amlogic.com>

>   	meson_chip->tbers_max = ilog2(tbers_clocks);
>   	if (!is_power_of_2(tbers_clocks))
>   		meson_chip->tbers_max++;
> 
