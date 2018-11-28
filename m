Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A988AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796582081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796582081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeK2CNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:13:10 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:2290 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727726AbeK2CNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:13:09 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wASF5Ig8007301;
        Wed, 28 Nov 2018 09:11:06 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2ny4x6704m-1;
        Wed, 28 Nov 2018 09:11:06 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id D1F17611E12A;
        Wed, 28 Nov 2018 09:11:05 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 28 Nov 2018
 15:11:05 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wASFB5BG023330; Wed,
 28 Nov 2018 15:11:05 GMT
Date:   Wed, 28 Nov 2018 15:11:05 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 07/10] regulator: da9211: Let core handle GPIO descriptors
Message-ID: <20181128151105.GS16508@imbe.wolfsonmicro.main>
References: <20181128104350.31902-1-linus.walleij@linaro.org>
 <20181128104350.31902-8-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181128104350.31902-8-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=979 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811280133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:43:47AM +0100, Linus Walleij wrote:
> Use the gpiod_get_from_of_node() rather than the devm_*
> version so that the regulator core can handle the lifecycle
> of these descriptors.
> 
> This patch requires "gpio: Export gpiod_get_from_of_node()"
> to be applied first.
> 
> Fixes: 11da04af0d3b ("regulator: da9211: Pass descriptors instead of GPIO numbers")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/regulator/da9211-regulator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
> index 8f68c7a05d27..bfdead356526 100644
> --- a/drivers/regulator/da9211-regulator.c
> +++ b/drivers/regulator/da9211-regulator.c
> @@ -293,8 +293,8 @@ static struct da9211_pdata *da9211_parse_regulators_dt(
>  
>  		pdata->init_data[n] = da9211_matches[i].init_data;
>  		pdata->reg_node[n] = da9211_matches[i].of_node;
> -		pdata->gpiod_ren[n] = devm_gpiod_get_from_of_node(dev,
> -				  da9211_matches[i].of_node,
> +		pdata->gpiod_ren[n] =
> +			gpiod_get_from_of_node(da9211_matches[i].of_node,

This driver has a lot of error paths that will leak the GPIO with
this change.

Thanks,
Charles

>  				  "enable",
>  				  0,
>  				  GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
> -- 
> 2.19.1
