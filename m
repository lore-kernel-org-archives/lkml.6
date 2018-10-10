Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C75C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30358214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30358214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeJJV4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:56:25 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:35224 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726636AbeJJV4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:56:24 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9AEPWf0032600;
        Wed, 10 Oct 2018 09:33:42 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2mxu4958xy-1;
        Wed, 10 Oct 2018 09:33:42 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 4F97C611C8AF;
        Wed, 10 Oct 2018 09:36:24 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 10 Oct 2018
 15:33:41 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w9AEXeJh025379; Wed,
 10 Oct 2018 15:33:41 +0100
Date:   Wed, 10 Oct 2018 15:33:40 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: madera: Fix uninitialized variable issue in
 madera_mux_set_mux
Message-ID: <20181010143340.GA1653@imbe.wolfsonmicro.main>
References: <20181010141353.GA14382@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181010141353.GA14382@embeddedor.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810100144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 04:13:53PM +0200, Gustavo A. R. Silva wrote:
> There is a potential execution path in which variable *ret* is checked
> in an IF statement, and then its value is used to report an error at
> line 659 without being properly initialized previously:
> 
> 659 if (ret)
> 660	dev_err(priv->dev, "Failed to write to 0x%x (%d)\n", reg, ret);
> 
> Fix this by initializing variable *ret* to -1.
> 
> Addresses-Coverity-ID: 1471969 ("Uninitialized scalar variable")
> Fixes: 218d72a77b0b ("pinctrl: madera: Add driver for Cirrus Logic Madera codecs")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/pinctrl/cirrus/pinctrl-madera-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/cirrus/pinctrl-madera-core.c b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
> index 0266302..a99ace8 100644
> --- a/drivers/pinctrl/cirrus/pinctrl-madera-core.c
> +++ b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
> @@ -608,7 +608,7 @@ static int madera_mux_set_mux(struct pinctrl_dev *pctldev,
>  	unsigned int n_chip_groups = priv->chip->n_pin_groups;
>  	const char *func_name = madera_mux_funcs[selector].name;
>  	unsigned int reg;
> -	int i, ret;
> +	int i, ret = -1;
>  

I don't believe this would fully address the issue since if you
initialise ret to -1 you will still drop into the if statement
and you will use the reg variable which should also be
uninitialised on that code path.

Feels like initialising to 0 would probably be better anyway
since the code path looks like the case were you have n_pins == 0
and nothing really failed in that case just nothing needed to be
done.

Thanks,
Charles

>  	dev_dbg(priv->dev, "%s selecting %u (%s) for group %u (%s)\n",
>  		__func__, selector, func_name, group,
> -- 
> 2.7.4
