Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202EDC46462
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7712087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7712087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbeJKBaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:30:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33979 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbeJKBaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:30:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A3F45207B4; Wed, 10 Oct 2018 20:06:51 +0200 (CEST)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id 736F520714;
        Wed, 10 Oct 2018 20:06:41 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH] clk: mvebu: armada-37xx-tbg: Balance devm_clk_get in probe
References: <20180914153421.7090-1-gregory.clement@bootlin.com>
        <153919299293.119890.9655297515756412545@swboyd.mtv.corp.google.com>
Date:   Wed, 10 Oct 2018 20:06:42 +0200
In-Reply-To: <153919299293.119890.9655297515756412545@swboyd.mtv.corp.google.com>
        (Stephen Boyd's message of "Wed, 10 Oct 2018 10:36:32 -0700")
Message-ID: <87va69he19.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,
 
 On mer., oct. 10 2018, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Gregory CLEMENT (2018-09-14 08:34:21)
>> The parent clock is get only to have its name, and then the clock is no
>> more used, so we can safely free it using devm_clk_put.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  drivers/clk/mvebu/armada-37xx-tbg.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
>> index 71f30149e80e..caaa91a41683 100644
>> --- a/drivers/clk/mvebu/armada-37xx-tbg.c
>> +++ b/drivers/clk/mvebu/armada-37xx-tbg.c
>> @@ -102,6 +102,7 @@ static int armada_3700_tbg_clock_probe(struct platform_device *pdev)
>>                 return -EINVAL;
>>         }
>>         parent_name = __clk_get_name(parent);
>> +       devm_clk_put(dev, parent);
>
> So then why use devm_clk_get()? Please replace both so tha
> devm_clk_put() doesn't need to be used..

Indeed between the successful devm_clk_get and the devm_clk_put we don't
exit the function in error so I can use clk_get and clk_put.

Gregory

>
>>  
>>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>         reg = devm_ioremap_resource(dev, res);

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
