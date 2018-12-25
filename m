Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE23C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 07:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5742173B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 07:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbeLYHyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 02:54:53 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:22608 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeLYHyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 02:54:52 -0500
Received: from [10.28.18.115] (10.28.18.115) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 25 Dec
 2018 15:55:16 +0800
From:   Liang Yang <liang.yang@amlogic.com>
Subject: Re: [PATCH RESEND v8 2/2] mtd: rawnand: meson: add support for
 Amlogic NAND flash controller
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-mtd@lists.infradead.org>, Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1545392724-6637-1-git-send-email-jianxin.pan@amlogic.com>
 <1545392724-6637-3-git-send-email-jianxin.pan@amlogic.com>
 <CAFBinCAeDtu-KTy=4bmAtBY9hGK8rRo=OW70tgEOyRBnQcdz1g@mail.gmail.com>
Message-ID: <081f7986-0f8e-bd42-bae2-17058c7da301@amlogic.com>
Date:   Tue, 25 Dec 2018 15:55:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAFBinCAeDtu-KTy=4bmAtBY9hGK8rRo=OW70tgEOyRBnQcdz1g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.115]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,
On 2018/12/23 1:07, Martin Blumenstingl wrote:
> Hi Jianxin, Hi Liang,
> 
> On Fri, Dec 21, 2018 at 12:45 PM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>>
>> From: Liang Yang <liang.yang@amlogic.com>
>>
>> Add initial support for the Amlogic NAND flash controller which found
>> in the Meson-GXBB/GXL/AXG SoCs.
>>
>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>   drivers/mtd/nand/raw/Kconfig      |   10 +
>>   drivers/mtd/nand/raw/Makefile     |    1 +
>>   drivers/mtd/nand/raw/meson_nand.c | 1468 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1479 insertions(+)
>>   create mode 100644 drivers/mtd/nand/raw/meson_nand.c
>>
>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>> index 1a55d3e..d05ff20 100644
>> --- a/drivers/mtd/nand/raw/Kconfig
>> +++ b/drivers/mtd/nand/raw/Kconfig
>> @@ -541,4 +541,14 @@ config MTD_NAND_TEGRA
>>            is supported. Extra OOB bytes when using HW ECC are currently
>>            not supported.
>>
>> +config MTD_NAND_MESON
>> +       tristate "Support for NAND controller on Amlogic's Meson SoCs"
>> +       depends on ARCH_MESON || COMPILE_TEST
>> +       depends on COMMON_CLK_AMLOGIC
>> +       select COMMON_CLK_REGMAP_MESON
> I believe that "depends on COMMON_CLK_AMLOGIC" and "select
> COMMON_CLK_REGMAP_MESON" are not necessary:
> the driver should build fine without them because it's only
> interfacing with the common clock framework.
> the common clock framework is enabled by ARCH_MESON and for the
> COMPILE_TEST case the common clock framework provides stub
> implementations inside the headers.
> 
>> +       select MFD_SYSCON
>> +       help
>> +         Enables support for NAND controller on Amlogic's Meson SoCs.
>> +         This controller is found on Meson GXBB, GXL, AXG SoCs.
> you are explicitly mentioning GXBB here but you don't add a "GXBB" compatible.
> I suggest to shorten this sentence ("This controller is found on Meson
> SoCs.") because this driver can also support the 32-bit
> Meson8/Meson8b/Meson8m2 SoCs with minor adjustments.
> 
we only have tested on Meson GXL and AXG platform, but it should support 
GXBB and Meson8/Meson8b/Meson8m2 and the differences between these 
controllers are only the base address of register and some SD_EMMC_CLOCK 
control bits.

i think "This controller is found on Meson SoCs." is ok.

> Regards
> Martin
> 
> .
> 
