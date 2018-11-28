Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD017C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E2D2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E2D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbeK2C0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:26:32 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:52250 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728163AbeK2C0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:26:31 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wASFJKqK002038;
        Wed, 28 Nov 2018 09:24:24 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2ny3xu6pkq-1;
        Wed, 28 Nov 2018 09:24:24 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 77153611CE60;
        Wed, 28 Nov 2018 09:27:54 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 28 Nov 2018
 15:24:23 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wASFONsX030051; Wed,
 28 Nov 2018 15:24:23 GMT
Date:   Wed, 28 Nov 2018 15:24:23 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 08/10] regulator: max77686: Let core handle GPIO
 descriptor
Message-ID: <20181128152423.GW16508@imbe.wolfsonmicro.main>
References: <20181128104350.31902-1-linus.walleij@linaro.org>
 <20181128104350.31902-9-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181128104350.31902-9-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811280135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:43:48AM +0100, Linus Walleij wrote:
> Use the gpiod_get_from_of_node() rather than the devm_*
> version so that the regulator core can handle the lifecycle
> of these descriptors.
> 
> Fixes: 96392c3d8ca4 ("regulator: max77686: Pass descriptor instead of GPIO number")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/regulator/max77686-regulator.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
> index f5cee1775905..236cd42002f0 100644
> --- a/drivers/regulator/max77686-regulator.c
> +++ b/drivers/regulator/max77686-regulator.c
> @@ -255,8 +255,7 @@ static int max77686_of_parse_cb(struct device_node *np,
>  	case MAX77686_BUCK8:
>  	case MAX77686_BUCK9:
>  	case MAX77686_LDO20 ... MAX77686_LDO22:
> -		config->ena_gpiod = devm_gpiod_get_from_of_node(max77686->dev,
> -				np,
> +		config->ena_gpiod = gpiod_get_from_of_node(np,

As this is inside the of_parse_cb, it probably needs some thought
on where the GPIO would need to be freed on which error paths, I
am not sure it is immediately obvious to me but I suspect it will
need to be freed in some cases.

Thanks,
Charles
