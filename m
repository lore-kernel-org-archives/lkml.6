Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE1CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEDE20989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEDE20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbeK2CTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:19:19 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:33008 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727726AbeK2CTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:19:19 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wASFBreL011746;
        Wed, 28 Nov 2018 09:17:16 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2ny4x670q6-1;
        Wed, 28 Nov 2018 09:17:16 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 874BC611C8AF;
        Wed, 28 Nov 2018 09:20:06 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 28 Nov 2018
 15:17:15 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wASFHFLg023567; Wed,
 28 Nov 2018 15:17:15 GMT
Date:   Wed, 28 Nov 2018 15:17:15 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 09/10] regulator: s5m8767: Let core handle GPIO
 descriptors
Message-ID: <20181128151715.GT16508@imbe.wolfsonmicro.main>
References: <20181128104350.31902-1-linus.walleij@linaro.org>
 <20181128104350.31902-10-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181128104350.31902-10-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=846 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811280134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:43:49AM +0100, Linus Walleij wrote:
> Use the gpiod_get_from_of_node() rather than the devm_*
> version so that the regulator core can handle the lifecycle
> of these descriptors.
> 
> Introduce an errorpath so we free any retrieved descriptors
> properly.
> 
> This patch requires "gpio: Export gpiod_get_from_of_node()"
> to be applied first.
> 
> Fixes: 9ae5cc75ceaa ("regulator: s5m8767: Pass descriptor instead of GPIO number")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/regulator/s5m8767.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> @@ -674,6 +681,14 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
>  	}
>  
>  	return 0;
> +
> +err_gpiod_put:
> +	while (j) {
> +		gpiod_put(rdata->ext_control_gpiod);
> +		rdata--;
> +		j--;
> +	}
> +	return ret;
>  }

These looks like it handles the error paths in
s5m8767_pmic_dt_parse_pdata, however there are still all the
error paths between the call to that function and the call to
regulator_register that need to be handled as well.

Thanks,
Charles
