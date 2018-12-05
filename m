Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED77C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC1F2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC1F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeLENIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:08:35 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:59228 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726909AbeLENIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:08:35 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB5CxIC1024054;
        Wed, 5 Dec 2018 07:08:29 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2p3rk7fjxw-1;
        Wed, 05 Dec 2018 07:08:28 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id D8208611C8B0;
        Wed,  5 Dec 2018 07:11:20 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 5 Dec 2018
 13:08:27 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wB5D8Q0n025635; Wed,
 5 Dec 2018 13:08:26 GMT
Date:   Wed, 5 Dec 2018 13:08:26 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 06/13 v2] regulator: max8973: Let core handle GPIO
 descriptor
Message-ID: <20181205130826.GD16508@imbe.wolfsonmicro.main>
References: <20181201154151.14890-1-linus.walleij@linaro.org>
 <20181201154151.14890-7-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181201154151.14890-7-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=611 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1812050119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 04:41:44PM +0100, Linus Walleij wrote:
> Use the gpiod_get() rather than the devm_* version so that the
> regulator core can handle the lifecycle of these descriptors.
> 
> Fixes: e7d2be696faa ("regulator: max8973: Pass descriptor instead of GPIO number")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Drop the gpiod_put() on the errorpath after devm_regulator_register()
>   as this will be handled by the regulator core.
> - Fix the second case of devm_gpiod_get()
> - Put a comment in the code so maintainers knows not to
>   use managed resources (devm*)
> ---
> @@ -759,9 +759,13 @@ static int max8973_probe(struct i2c_client *client,
>  		else
>  			gflags = GPIOD_OUT_LOW;
>  		gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
> -		gpiod = devm_gpiod_get_optional(&client->dev,
> -						"maxim,enable",
> -						gflags);
> +		/*
> +		 * Do not use devm* here: the regulator core takes over the
> +		 * lifecycle management of the GPIO descriptor.
> +		 */
> +		gpiod = gpiod_get_optional(&client->dev,
> +					   "maxim,enable",
> +					   gflags);
>  		if (IS_ERR(gpiod))
>  			return PTR_ERR(gpiod);
>  		if (gpiod) {
> @@ -775,10 +779,13 @@ static int max8973_probe(struct i2c_client *client,
>  		/*
>  		 * We do not let the core switch this regulator on/off,
>  		 * we just leave it on.
> +		 *
> +		 * Do not use devm* here: the regulator core takes over the
> +		 * lifecycle management of the GPIO descriptor.
>  		 */
> -		gpiod = devm_gpiod_get_optional(&client->dev,
> -						"maxim,enable",
> -						GPIOD_OUT_HIGH);
> +		gpiod = gpiod_get_optional(&client->dev,
> +					   "maxim,enable",
> +					   GPIOD_OUT_HIGH);

Need to be careful here this path actually never passes the GPIO
to the regulator core. I suspect you want to leave this one as a
devm_

>  		if (IS_ERR(gpiod))
>  			return PTR_ERR(gpiod);
>  		if (gpiod)
> @@ -798,6 +805,8 @@ static int max8973_probe(struct i2c_client *client,
>  
>  	ret = max8973_init_dcdc(max, pdata);
>  	if (ret < 0) {
> +		if (gpiod)
> +			gpiod_put(gpiod);

And make this use config.ena_gpiod instead.

Thanks,
Charles
