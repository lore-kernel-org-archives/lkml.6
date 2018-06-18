Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DBEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4A420850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b="DRXvIljL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4A420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=horus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935282AbeFRROO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:14:14 -0400
Received: from mail.horus.com ([78.46.148.228]:34897 "EHLO mail.horus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934857AbeFRRON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:14:13 -0400
Received: from [192.168.1.20] (193-83-224-126.adsl.highway.telekom.at [193.83.224.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "E-Mail Matthias Reichl", Issuer "HiassofT CA 2014" (verified OK))
        by mail.horus.com (Postfix) with ESMTPSA id C7D506409F;
        Mon, 18 Jun 2018 19:14:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1529342051;
        bh=wzPTYkYAdPQGpcD6vjWo+ibAScnLKRUoQCuMSZBqmxg=;
        h=Date:From:To:Cc:Subject:From;
        b=DRXvIljLA4feVNTw1RylzVHWNwIB2bZdXzsB8ezr/iC+oBGa/L1PNLyvLcFHdiY06
         MO0L5BtDQYGEpaMTczeAUY5ltN/Jh7ixxApD7LXNtXpbIjze42geMHz1e4jtcr/zEd
         ON57BrlsrsUSJK8S/piDz1OTYgQDWC3wct2vBIfs=
Received: by camel2.lan (Postfix, from userid 1000)
        id 082E71C78CB; Mon, 18 Jun 2018 19:14:10 +0200 (CEST)
Date:   Mon, 18 Jun 2018 19:14:10 +0200
From:   Matthias Reichl <hias@horus.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
Subject: Regression in 4.18-rc1 caused by regulator: arizona-ldo1: Look up a
 descriptor and pass to the core
Message-ID: <20180618171410.z3bshzmwu7x5yylj@camel2.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e1739e86f0cb9c48e8745a610e6981a4e24cadad breaks reading
the wlf,ldoena property from device tree. This causes ldo1 to
stay off and thus arizona device detection to fail:

[    4.495958] of_get_named_gpiod_flags: parsed 'wlf,reset' property of node '/s
oc/spi@7e204000/wm5102@1[0]' - status (0)
[    4.509756] arizona-ldo1 arizona-ldo1: GPIO lookup for consumer wlf,ldoena
[    4.511339] arizona-ldo1 arizona-ldo1: using lookup tables for GPIO lookup
[    4.511351] arizona-ldo1 arizona-ldo1: No GPIO consumer wlf,ldoena found
[    4.511413] LDO1: supplied by RPi-Cirrus 1v8
[    4.549164] arizona spi0.1: Unknown device ID: 0

With this commit reverted the ldoena GPIO is properly found and
asserted high and the arizona device type is read successfully:

[    4.630445] of_get_named_gpiod_flags: parsed 'wlf,reset' property of node '/s
oc/spi@7e204000/wm5102@1[0]' - status (0)
[    4.647622] of_get_named_gpiod_flags: parsed 'wlf,ldoena' property of node '/soc/spi@7e204000/wm5102@1[0]' - status (0)
[    4.666100] arizona spi0.1: WM5102 revision C

I've tested this on a Raspberry Pi 3 with upstream 4.18-rc1,
the Cirrus Logic Audio Card from Element 14 (using a WM5102
connected via SPI) and the downstream card driver added as
a module.

Both wlf,reset and wlf,ldoena properties are defined in
the wm5102 devicetree node:

wm5102@1{
	compatible = "wlf,wm5102";
	reg = <1>;
	...
	wlf,reset = <&gpio 17 0>;
	wlf,ldoena = <&gpio 22 0>;
	...
};

If I understand the code correctly the cuplrit seems to be that
with this patch the gpio is looked up from the arizona-ldo1 dev,
which has a NULL of_node:

config.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, "wlf,ldoena", ...

The old version did an of lookup in the parent (arizona) dev, which
contains the of_node with wlf,ldoena:

arizona_ldo1_common_init:
	struct device *parent_dev = pdev->dev.parent;
	struct regulator_config config = { };
	...
	config.dev = parent_dev;
	...
	arizona_ldo1_of_get_pdata(pdata, config, ...

arizona_ldo1_of_get_pdata:
	struct device_node *np = config->dev->of_node;
	...
	pdata->ldoena = of_get_named_gpio(np, "wlf,ldoena", 0);

so long,

Hias
