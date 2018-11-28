Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A911FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795D32086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795D32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeK2CUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:20:40 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:33182 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727789AbeK2CUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:20:40 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wASFBk6x011690;
        Wed, 28 Nov 2018 09:18:37 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2ny4x670vf-1;
        Wed, 28 Nov 2018 09:18:37 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 2C2DB611E124;
        Wed, 28 Nov 2018 09:18:37 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 28 Nov 2018
 15:18:36 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wASFIaGV024024; Wed,
 28 Nov 2018 15:18:36 GMT
Date:   Wed, 28 Nov 2018 15:18:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 10/10] regulator: tps65090: Let core handle GPIO
 descriptors
Message-ID: <20181128151836.GU16508@imbe.wolfsonmicro.main>
References: <20181128104350.31902-1-linus.walleij@linaro.org>
 <20181128104350.31902-11-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181128104350.31902-11-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811280134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:43:50AM +0100, Linus Walleij wrote:
> Use the gpiod_get_from_of_node() rather than the devm_*
> version so that the regulator core can handle the lifecycle
> of these descriptors.
> 
> This patch requires "gpio: Export gpiod_get_from_of_node()"
> to be applied first.
> 
> Fixes: 3012e81446d0 ("regulator: tps65090: Pass descriptor instead of GPIO number")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/regulator/tps65090-regulator.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
> index db714d5edafc..223f6974a9f3 100644
> --- a/drivers/regulator/tps65090-regulator.c
> +++ b/drivers/regulator/tps65090-regulator.c
> @@ -376,11 +376,11 @@ static struct tps65090_platform_data *tps65090_parse_dt_reg_data(
>  				gflags = GPIOD_OUT_LOW;
>  			gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
>  
> -			rpdata->gpiod = devm_gpiod_get_from_of_node(&pdev->dev,
> -								    tps65090_matches[idx].of_node,
> -								    "dcdc-ext-control-gpios", 0,
> -								    gflags,
> -								    "tps65090");
> +			rpdata->gpiod = gpiod_get_from_of_node(
> +						tps65090_matches[idx].of_node,
> +						"dcdc-ext-control-gpios", 0,
> +						gflags,
> +						"tps65090");
>  			if (IS_ERR(rpdata->gpiod))
>  				return ERR_CAST(rpdata->gpiod);
>  			if (!rpdata->gpiod)

This one needs some handling to avoid leaking the gpio too.

Thanks,
Charles
