Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C9EECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760C62082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760C62082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbeKEAzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 19:55:22 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:16198 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730531AbeKEAzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 19:55:22 -0500
Received: from [192.168.0.111] (223.167.21.242) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Sun, 4 Nov 2018
 23:39:51 +0800
Subject: Re: [PATCH v5 2/3] clk: meson: add DT documentation for emmc clock
 controller
To:     Stephen Boyd <sboyd@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Yixun Lan <dlan@gentoo.org>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-3-git-send-email-jianxin.pan@amlogic.com>
 <ca95948abd58876a23b2eb3e52b96124e9eed793.camel@baylibre.com>
 <20181024145513.GA6647@ofant>
 <154130064120.88331.5081431734592584205@swboyd.mtv.corp.google.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <fe4b3d70-12ae-84ae-0451-f5d67aa99fcd@amlogic.com>
Date:   Sun, 4 Nov 2018 23:39:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <154130064120.88331.5081431734592584205@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [223.167.21.242]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Stephen,

Thank you for the review.

On 2018/11/4 11:04, Stephen Boyd wrote:
> Quoting Yixun Lan (2018-10-25 00:29:15)
>> yes, I think the documentation need to be fixed
>>
>> for the final solution, we decide to make 'mmc-clkc' an independent node
>> instead of being a sub-node of 'mmc', so both of them may exist in parallel..
>>
>> the DT part may like this:
>>
>>                         sd_emmc_c_clkc: clock-controller@7000 {
>>                                 compatible = "amlogic,axg-mmc-clkc", "syscon";
>>                                 reg = <0x0 0x7000 0x0 0x4>;
>>                                 ...
>>                         };
>>
>>                         sd_emmc_c: mmc@7000 {
>>                                 compatible = "amlogic,axg-mmc";
>>                                 reg = <0x0 0x7000 0x0 0x800>;
>>                                 ...
>>                         };
> 
> That's improper usage of DT. We don't want two devices at the same
> register offset.
sd_emmc_c_clkc is shared by nand and sd_emmc_c controller, and this clock is part of the MMC controller's register space.
 
The idea of adding the clock-controller@7000is introduced during the discussion in the NAND driver mainline effort:
https://lkml.kernel.org/r/20180628090034.0637a062@xps13
> 
> .
> 

