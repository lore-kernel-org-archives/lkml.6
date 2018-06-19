Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE992C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF002083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF002083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937390AbeFSIvw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:51:52 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:36336 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937236AbeFSIvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:51:42 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5J8nwsp021706;
        Tue, 19 Jun 2018 03:51:34 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2jmxynmtt7-1;
        Tue, 19 Jun 2018 03:51:34 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 669E8611C8B1;
        Tue, 19 Jun 2018 03:52:20 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.301.0; Tue, 19 Jun 2018
 09:51:34 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w5J8pXqw013883; Tue,
 19 Jun 2018 09:51:33 +0100
Date:   Tue, 19 Jun 2018 09:51:33 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Matthias Reichl <hias@horus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Regression in 4.18-rc1 caused by regulator: arizona-ldo1: Look
 up a descriptor and pass to the core
Message-ID: <20180619085133.GF18740@imbe.wolfsonmicro.main>
References: <20180618171410.z3bshzmwu7x5yylj@camel2.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180618171410.z3bshzmwu7x5yylj@camel2.lan>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=943 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1805220000
 definitions=main-1806190102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 07:14:10PM +0200, Matthias Reichl wrote:
> Commit e1739e86f0cb9c48e8745a610e6981a4e24cadad breaks reading
> the wlf,ldoena property from device tree. This causes ldo1 to
> stay off and thus arizona device detection to fail:
> 
> [    4.495958] of_get_named_gpiod_flags: parsed 'wlf,reset' property of node '/s
> oc/spi@7e204000/wm5102@1[0]' - status (0)
> [    4.509756] arizona-ldo1 arizona-ldo1: GPIO lookup for consumer wlf,ldoena
> [    4.511339] arizona-ldo1 arizona-ldo1: using lookup tables for GPIO lookup
> [    4.511351] arizona-ldo1 arizona-ldo1: No GPIO consumer wlf,ldoena found
> [    4.511413] LDO1: supplied by RPi-Cirrus 1v8
> [    4.549164] arizona spi0.1: Unknown device ID: 0
> 
> With this commit reverted the ldoena GPIO is properly found and
> asserted high and the arizona device type is read successfully:
> 
> [    4.630445] of_get_named_gpiod_flags: parsed 'wlf,reset' property of node '/s
> oc/spi@7e204000/wm5102@1[0]' - status (0)
> [    4.647622] of_get_named_gpiod_flags: parsed 'wlf,ldoena' property of node '/soc/spi@7e204000/wm5102@1[0]' - status (0)
> [    4.666100] arizona spi0.1: WM5102 revision C
> 
> I've tested this on a Raspberry Pi 3 with upstream 4.18-rc1,
> the Cirrus Logic Audio Card from Element 14 (using a WM5102
> connected via SPI) and the downstream card driver added as
> a module.
> 
> Both wlf,reset and wlf,ldoena properties are defined in
> the wm5102 devicetree node:
> 
> wm5102@1{
> 	compatible = "wlf,wm5102";
> 	reg = <1>;
> 	...
> 	wlf,reset = <&gpio 17 0>;
> 	wlf,ldoena = <&gpio 22 0>;
> 	...
> };
> 
> If I understand the code correctly the cuplrit seems to be that
> with this patch the gpio is looked up from the arizona-ldo1 dev,
> which has a NULL of_node:
> 
> config.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, "wlf,ldoena", ...
> 
> The old version did an of lookup in the parent (arizona) dev, which
> contains the of_node with wlf,ldoena:
> 
> arizona_ldo1_common_init:
> 	struct device *parent_dev = pdev->dev.parent;
> 	struct regulator_config config = { };
> 	...
> 	config.dev = parent_dev;
> 	...
> 	arizona_ldo1_of_get_pdata(pdata, config, ...
> 
> arizona_ldo1_of_get_pdata:
> 	struct device_node *np = config->dev->of_node;
> 	...
> 	pdata->ldoena = of_get_named_gpio(np, "wlf,ldoena", 0);
> 

Urgh.. sorry about that. I did test that patch but it seems I
messed it up. On our boards the LDOENA defaults to on so I missed
that it wasn't getting configured anymore.

I think we just need to not use the devm version of the
get_optional and pass the correct device. I will get a patch
ready this morning and ping it through for testing.

Thanks,
Charles
