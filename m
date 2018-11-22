Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63679C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B0220864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B0220864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404550AbeKWEPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:15:02 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:51026 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727522AbeKWEPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:15:01 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAMHYaqA019131;
        Thu, 22 Nov 2018 11:34:36 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth9891j3-1;
        Thu, 22 Nov 2018 11:34:36 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 674B2612A760;
        Thu, 22 Nov 2018 11:34:35 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 22 Nov 2018
 17:34:34 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAMHYYrJ029760; Thu,
 22 Nov 2018 17:34:34 GMT
Date:   Thu, 22 Nov 2018 17:34:34 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] regulator: core: do not put managed GPIOd:s
Message-ID: <20181122173434.GK16508@imbe.wolfsonmicro.main>
References: <20181122160421.9658-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181122160421.9658-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=937 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811220156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 05:04:21PM +0100, Linus Walleij wrote:
> Some drivers have been converted to pass GPIO descriptors
> rather than GPIO numbers to the regulator core. We should
> not issue gpiod_put() on those descriptors, but rather
> let the driver reference count it with devm_* if they so
> desire.
> 
> Currently the regulator core issues gpiod_put() on all
> descriptors as it assumes it was obtained with the
> sequence gpio_request_one()/gpio_to_desc(), as
> gpio_request_one() will be equivalent to gpiod_get().
> 
> We introduce a helper bool that deal with this situation
> by making sure the core only issue gpiod_put() if the
> GPIO was requested from within the core itself.
> 
> A subsequent patch set will delete legacy GPIO handling
> and get rid of this ugliness, so it is a stepgap patch.
> 
> Fixes: e45e290a882e ("regulator: core: Support passing an initialized GPIO enable descriptor")
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Mark: I will rebase my v7 series for removing legacy
> GPIO on this if it solves Marek's probel, it can be applied
> for fixes if need be but I don't know how big this problem is.
> ---

Sent my patch chain anyway although the middle patch is basically
identical to this one, I really don't mind which one we use.

I think we also want to add some additional handling into the
GPIO core as well. Since whilst this patch will resolve the
situation for wm8994 here, it doesn't cover the case of actually
shared GPIOs. This patch means the drivers will still own their
GPIOs so if two drivers requested the same GPIO both will call a
gpiod_put for that GPIO, causing the same issue. In my chain I
add some very primitive reference counting to the GPIO core.

>  drivers/regulator/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 03a03763457c..05bb2db6cff5 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -80,6 +80,7 @@ struct regulator_map {
>  struct regulator_enable_gpio {
>  	struct list_head list;
>  	struct gpio_desc *gpiod;
> +	bool gpiod_needs_put;

I went with locally_requested here seemed better to be
descriptive of the situation rather than the required action,
also a bit flag at the end with the other bit flags.

>  	u32 enable_count;	/* a number of enabled shared GPIO */
>  	u32 request_count;	/* a number of requested shared GPIO */
>  	unsigned int ena_gpio_invert:1;
> @@ -2247,6 +2248,8 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
>  	}
>  
>  	pin->gpiod = gpiod;
> +	if (!config->ena_gpiod)
> +		pin->gpiod_needs_put = true;
>  	pin->ena_gpio_invert = config->ena_gpio_invert;
>  	list_add(&pin->list, &regulator_ena_gpio_list);
>  
> @@ -2268,7 +2271,8 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
>  		if (pin->gpiod == rdev->ena_pin->gpiod) {
>  			if (pin->request_count <= 1) {
>  				pin->request_count = 0;
> -				gpiod_put(pin->gpiod);
> +				if (pin->gpiod_needs_put)
> +					gpiod_put(pin->gpiod);
>  				list_del(&pin->list);
>  				kfree(pin);
>  				rdev->ena_pin = NULL;
> -- 
> 2.19.1

Thanks,
Charles
