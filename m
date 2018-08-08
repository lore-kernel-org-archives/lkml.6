Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F781C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA94A21729
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GvDBVq4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA94A21729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeHHMUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:20:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32886 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeHHMUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:20:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so873290pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 03:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TD+ZqkbUjgZ38zUEtJdCLNHMFpa9J7oG+/PcN5nXEHU=;
        b=GvDBVq4WwkNMd8F3koMu4xO6wWSoKoh5+7AtZKQea2gBwwjNv4dFYO8r1pUtVChAlE
         6S5ZQm6J+h6xujn79BcwX+nuc/fUR74mne2lJSPlJH861hmdhY4MnpD954/2vIMEetGc
         wwtVVT3YqnG0zp7ueC8xcn6ovS5ODiHlW083+51aGYnWRQ4FoCZzos66m86ZoLrGSRTy
         GqsNDhh2sU4HdujFYlCDza4o7U4kfoLcvaDXPiR30nYb+RV8KtwCCzlc77EioxUPG1xx
         1AT4ukgeDYrIzgypvWrWNfBfMwp7VaoJGRW2cYDkVZxMT13EFjgq7YcbsIJPNzRbZ6jx
         UAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TD+ZqkbUjgZ38zUEtJdCLNHMFpa9J7oG+/PcN5nXEHU=;
        b=LdtLv8mj6WtU9fHwCHm1aH/snMVRNYfamcK03qjzX0suK/6SPWlhocf6hxTOqCA69t
         wdRwVJVY9+kTVEYHL3ivfcH3FdMQtmcJusVcyQAUjEaXYHJY1r/84/1weD2E5gUft9EL
         migb/OShUwsELLbJJ3RwD5Mua360QDKcIyy9PPIrhUgs11ZETxUAkZHmiPBPPupfYmlz
         4mCYD3K0S9PA/iP7HoIxq2Lu0djnoLccYRp6XOCEFntnno/cDSOf+s+Skr+nU1aEGIf+
         9CeHwD/+PWG/LBPntymSN1jYqmThsFDdWdBGxjmhlHnw3G8lkZGgY4cB3peIfvDcWUmV
         yxag==
X-Gm-Message-State: AOUpUlH/rz7pjZaciPzTIPuF1dA5dPxtnUgtl97XOLoFy4bnKSk9/ET1
        COsTY2RWX97BBtsUKehxiW/mXQ==
X-Google-Smtp-Source: AA+uWPzdOifZKJRZTyXZNC/xhb3evq7Zy1MKM0tywm0Z6xh960ix9l1fuM5CHP4xksog+sCPiJAo2g==
X-Received: by 2002:a62:1c13:: with SMTP id c19-v6mr2211260pfc.148.1533722471876;
        Wed, 08 Aug 2018 03:01:11 -0700 (PDT)
Received: from [172.23.146.46] ([96.46.149.166])
        by smtp.gmail.com with ESMTPSA id 14-v6sm8766819pft.93.2018.08.08.03.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 03:01:11 -0700 (PDT)
Subject: Re: [PATCH V4 0/9] clk: add imx7ulp clk support
To:     "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
Cc:     Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB421169829CFE1A6A32DCC209802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Alexandre Bailon <abailon@baylibre.com>
Openpgp: preference=signencrypt
Message-ID: <5a5950a4-e164-a604-ccb4-ae6d5bbe1708@baylibre.com>
Date:   Wed, 8 Aug 2018 12:01:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB421169829CFE1A6A32DCC209802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dong Aisheng,

On 07/26/2018 03:50 AM, A.s. Dong wrote:
> Hi Stephen,
> 
> Do you have a chance to look at it?
> This patch series has been pending for quite a long time without much comments.
I'm not a kernel maintainer but I would not review a series that has
checkpatch errors.
Please run checkpatch, fix the errors and the warnings, and then
resubmit a series.

Best Regards,
Alexandre
> 
> Regards
> Dong Aisheng
> 
>> -----Original Message-----
>> From: A.s. Dong
>> Sent: Wednesday, July 18, 2018 9:37 PM
>> To: linux-clk@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org;
>> Anson Huang <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-
>> linux-imx <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
>> Subject: [PATCH V4 0/9] clk: add imx7ulp clk support
>>
>> This is a rebased version of below patch series against latest clk tree.
>> [PATCH RESEND V3 0/9] clk: add imx7ulp clk support
>> https://lkml.org/lkml/2018/3/16/310
>>
>> This patch series intends to add imx7ulp clk support.
>>
>> i.MX7ULP Clock functions are under joint control of the System Clock
>> Generation (SCG) modules, Peripheral Clock Control (PCC) modules, and
>> Core Mode Controller (CMC)1 blocks
>>
>> The clocking scheme provides clear separation between M4 domain and A7
>> domain. Except for a few clock sources shared between two domains, such
>> as the System Oscillator clock, the Slow IRC (SIRC), and and the Fast IRC clock
>> (FIRCLK), clock sources and clock management are separated and contained
>> within each domain.
>>
>> M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
>> A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
>>
>> Note: this series only adds A7 clock domain support as M4 clock domain will
>> be handled by M4 seperately.
>>
>> Change Log:
>> v3->v4:
>>  * rebased to latest kernel
>>  * make scg and pcc separate nodes according to Rob's suggestion
>>
>> v2->v3:
>>  * Patch 1 changed on: 1) split normal and gate ops 2) fix the possible racy
>>    Others no changes.
>>
>> v1->v2:
>>  * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE dividers
>>  * use clk_hw apis to register clocks
>>  * use of_clk_add_hw_provider
>>  * split the clocks register process into two parts: early part for possible
>>    timers clocks registered by CLK_OF_DECLARE_DRIVER and the later part for
>>    the left normal peripheral clocks registered by a platform driver.
>>
>> Dong Aisheng (9):
>>   clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
>>   clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag support
>>   clk: imx: add pllv4 support
>>   clk: imx: add pfdv2 support
>>   clk: imx: add composite clk support
>>   dt-bindings: clock: add imx7ulp clock binding doc
>>   clk: imx: make mux parent strings const
>>   clk: imx: implement new clk_hw based APIs
>>   clk: imx: add imx7ulp clk driver
>>
>>  .../devicetree/bindings/clock/imx7ulp-clock.txt    |  87 +++++++++
>>  drivers/clk/clk-divider.c                          | 152 +++++++++++++++
>>  drivers/clk/clk-fractional-divider.c               |  10 +
>>  drivers/clk/imx/Makefile                           |   6 +-
>>  drivers/clk/imx/clk-busy.c                         |   2 +-
>>  drivers/clk/imx/clk-composite.c                    |  85 +++++++++
>>  drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
>>  drivers/clk/imx/clk-imx7ulp.c                      | 209 +++++++++++++++++++++
>>  drivers/clk/imx/clk-pfdv2.c                        | 201 ++++++++++++++++++++
>>  drivers/clk/imx/clk-pllv4.c                        | 182 ++++++++++++++++++
>>  drivers/clk/imx/clk.c                              |  22 +++
>>  drivers/clk/imx/clk.h                              |  92 ++++++++-
>>  include/dt-bindings/clock/imx7ulp-clock.h          | 109 +++++++++++
>>  include/linux/clk-provider.h                       |  17 ++
>>  14 files changed, 1166 insertions(+), 10 deletions(-)  create mode 100644
>> Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
>>  create mode 100644 drivers/clk/imx/clk-composite.c  create mode 100644
>> drivers/clk/imx/clk-imx7ulp.c  create mode 100644 drivers/clk/imx/clk-
>> pfdv2.c  create mode 100644 drivers/clk/imx/clk-pllv4.c  create mode 100644
>> include/dt-bindings/clock/imx7ulp-clock.h
>>
>> --
>> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

