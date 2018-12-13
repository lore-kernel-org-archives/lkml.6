Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843ADC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B8920849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B8920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbeLMOhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:37:20 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:28857 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeLMOhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:37:20 -0500
Received: from [10.28.18.96] (10.28.18.96) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 13 Dec
 2018 22:37:07 +0800
Subject: Re: [PATCH v2 3/3] spi: meson-axg: add a linear clock divider support
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
 <1544690354-16409-4-git-send-email-sunny.luo@amlogic.com>
 <3cc699dc-4021-b993-2b47-b00b40f380f8@baylibre.com>
 <e6d5220e45a54d5251bec0f8fd3c147307f8b071.camel@baylibre.com>
From:   Sunny Luo <sunny.luo@amlogic.com>
Message-ID: <d9ec856c-d93f-4e4a-c5d4-7b2182f93cf7@amlogic.com>
Date:   Thu, 13 Dec 2018 22:37:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <e6d5220e45a54d5251bec0f8fd3c147307f8b071.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.96]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On 2018/12/13 17:28, Jerome Brunet wrote:
> On Thu, 2018-12-13 at 09:55 +0100, Neil Armstrong wrote:

>>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>>>   config SPI_MESON_SPICC
>>>   	tristate "Amlogic Meson SPICC controller"
>>> -	depends on ARCH_MESON || COMPILE_TEST
>>> +	depends on OF && COMMON_CLK && (ARCH_MESON || COMPILE_TEST)
> 
> The purpose of this patch is clock, right ? Why does it add a dependency on OF
> ?
> I did it by the way. Maybe it's better to add it in patch 1.


>>> +static int meson_spicc_clk_init(struct meson_spicc_device *spicc)
>>> +{
>>> +	struct device *dev = &spicc->pdev->dev;
>>> +	struct clk_fixed_factor *div0;
>>> +	struct clk_divider *div1;
> 
> Could you come up with something better than div0 and div1 ? it is confusing,
> especially with the comment above about div3 and 4 ... fixed_factor, div maybe
> ?
> Good, It is really confusing, I will change next patch.


>>> +	div1 = &meson_spicc_div1;
>>> +	div1->reg = spicc->base + (u64)div1->reg;
> 
> So you have static data which you override here. This works only if there is a
> single instance ... and does not really improve readability in your case.
> 
> IMO, you'd be better off without the static data above.

This is a terrible bug for more than one instances. I must overwrite it.


>>> +	if (!spicc->data->has_enhance_clk_div) {
> 
> Do all SoC with 'has_oen' have 'has_enhance_clk_div' too ?
> DO you really need two flags ?

Yes, all Soc with 'has_oen' must have 'has_enhance_clk_div' too.
It is distinct to use two flags here, what do you think of it?

>>> +	mux = &meson_spicc_sel;
>>> +	snprintf(name, sizeof(name), "%s#_sel", dev_name(dev));
>>> +	init.name = name;
>>> +	init.ops = &clk_mux_ops;
>>> +	init.parent_names = mux_parent_names;
>>> +	init.num_parents = 2;
>>> +	init.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT;
> 
> Why CLK_SET_RATE_NO_REPARENT ? CCF should pick the parent that give the best
> results, best to let it do its task ...
> 
There are two div in AXG, one is the coarse old-div and the other is 
enhance-div. From SoCs designer's opinion, the ehance-div aims to take 
place of the old-div.


