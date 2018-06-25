Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14EBC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C2F25800
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C2F25800
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755179AbeFYQE3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:04:29 -0400
Received: from hermes.aosc.io ([199.195.250.187]:55340 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754627AbeFYQE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:04:26 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id ECD5263409;
        Mon, 25 Jun 2018 16:04:03 +0000 (UTC)
Date:   Mon, 25 Jun 2018 23:59:37 +0800
In-Reply-To: <20180625155805.kds7bl3cburblwv6@flea>
References: <20180622124540.56203-1-icenowy@aosc.io> <20180622124540.56203-2-icenowy@aosc.io> <20180625155805.kds7bl3cburblwv6@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2 3/7] bus: add bus driver for accessing Allwinner A64 DE2
To:     Maxime Ripard <maxime.ripard@bootlin.com>
CC:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <4DFADAD6-3E17-425F-8B03-CAC4402BF14F@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年6月25日 GMT+08:00 下午11:58:05, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Fri, Jun 22, 2018 at 08:45:36PM +0800, Icenowy Zheng wrote:
>> The "Display Engine 2.0" (usually called DE2) on the Allwinner A64
>SoC
>> is different from the ones on other Allwinner SoCs. It requires a
>SRAM
>> region to be claimed, otherwise all DE2 subblocks won't be
>accessible.
>> 
>> Add a bus driver for the Allwinner A64 DE2 part which claims the SRAM
>> region when probing.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> No changes since v1.
>> 
>>  drivers/bus/Kconfig      | 10 ++++++++
>>  drivers/bus/Makefile     |  1 +
>>  drivers/bus/sun50i-de2.c | 49
>++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 60 insertions(+)
>>  create mode 100644 drivers/bus/sun50i-de2.c
>> 
>> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
>> index d1c0b60e9326..1851112ccc29 100644
>> --- a/drivers/bus/Kconfig
>> +++ b/drivers/bus/Kconfig
>> @@ -103,6 +103,16 @@ config SIMPLE_PM_BUS
>>  	  Controller (BSC, sometimes called "LBSC within Bus Bridge", or
>>  	  "External Bus Interface") as found on several Renesas ARM SoCs.
>>  
>> +config SUN50I_DE2_BUS
>> +	bool "Allwinner A64 DE2 Bus Driver"
>> +	  default ARM64
>> +	  depends on ARCH_SUNXI
>> +	  select SUNXI_SRAM
>> +	  help
>
>The alignment here should be one tab.
>
>> +static int sun50i_de2_bus_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *np = pdev->dev.of_node;
>> +	int ret;
>> +
>> +	ret = sunxi_sram_claim(&pdev->dev);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Error couldn't map SRAM to device\n");
>> +		return ret;
>> +	}
>> +
>> +	if (np)
>> +		of_platform_populate(np, NULL, NULL, &pdev->dev);
>
>Why do you need to test np here?

Oh thanks. Currently it's only probeable via dt.

>
>Maxime
