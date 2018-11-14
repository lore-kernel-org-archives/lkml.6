Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE9BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B5921780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B5921780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbeKOBEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:04:42 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56594 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728125AbeKOBEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:04:42 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 02ED9AFD086E5;
        Wed, 14 Nov 2018 23:00:56 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Wed, 14 Nov 2018
 23:00:53 +0800
Subject: Re: [PATCH] arm64: sunxi: Enable REGMAP_MMIO to fix linker error
To:     Maxime Ripard <maxime.ripard@bootlin.com>
References: <1542128665-78302-1-git-send-email-john.garry@huawei.com>
 <20181114145131.qv4gzg6pqktkpun5@flea>
CC:     <catalin.marinas@arm.com>, <will.deacon@arm.com>, <wens@csie.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <icenowy@aosc.io>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f08ea0c8-d1f0-a139-e5e7-dd82001d157b@huawei.com>
Date:   Wed, 14 Nov 2018 15:00:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181114145131.qv4gzg6pqktkpun5@flea>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2018 14:51, Maxime Ripard wrote:
> Hi John,
>
> On Wed, Nov 14, 2018 at 01:04:25AM +0800, John Garry wrote:
>> The following linker failure can be seen for a certain heavily reduced
>> defconfig:
>> drivers/soc/sunxi/sunxi_sram.o: In function `sunxi_sram_probe':
>> drivers/soc/sunxi/sunxi_sram.c:353: undefined reference to `__devm_regmap_init_mmio_clk'
>> drivers/soc/sunxi/sunxi_sram.c:353:(.text+0x3c4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__devm_regmap_init_mmio_clk'
>>
>> It would seem that the sunxi sram driver implicitly depended on config
>> REGMAP_MMIO.
>>
>> To solve, select config REGMAP_MMIO for ARCH_SUNXI. This seems a better
>> option than selecting from the respective driver config as this just
>> defaults to ARCH_SUNXI.
>>
>> Fixes: 5828729bebbb ("soc: sunxi: export a regmap for EMAC clock reg on A64")
>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 51bc479..c8a6ad3 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -12,6 +12,7 @@ config ARCH_SUNXI
>>  	select ARCH_HAS_RESET_CONTROLLER
>>  	select GENERIC_IRQ_CHIP
>>  	select PINCTRL
>> +	select REGMAP_MMIO
>>  	select RESET_CONTROLLER
>>  	help
>>  	  This enables support for Allwinner sunxi based SoCs like the A64.
>
> The sunxi_sram driver has a Kconfig symbol of its own now, it would
> make more sense to add that select there, especially since we can also
> compile it for arm.

Fine, so I'll leave this to you to fix if you don't mind.

Thanks,
John

>
> Maxime
>


