Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9A8C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47339216FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47339216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeHTRdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:33:04 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:46540 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726524AbeHTRdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:33:04 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7KEE2mg020728;
        Mon, 20 Aug 2018 09:17:13 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2kxgv1adns-1;
        Mon, 20 Aug 2018 09:17:13 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 97BE1611C8B0;
        Mon, 20 Aug 2018 09:17:12 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Mon, 20 Aug 2018
 15:17:11 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w7KEHBgt016862; Mon,
 20 Aug 2018 15:17:11 +0100
Date:   Mon, 20 Aug 2018 15:17:11 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <sapthagiri.baratam@gmail.com>
CC:     <lee.jones@linaro.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
Subject: Re: [PATCH] mfd: arizona: Correct calling of runtime_put_sync
Message-ID: <20180820141711.GQ32322@imbe.wolfsonmicro.main>
References: <5b7a983d.1c69fb81.8349b.fc57@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b7a983d.1c69fb81.8349b.fc57@mx.google.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=934 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808200154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 03:59:01PM +0530, sapthagiri.baratam@gmail.com wrote:
> From: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
> 
> Don't call runtime_put_sync when clk32k_ref is ARIZONA_32KZ_MCLK2
> as there is no corresponding runtime_get_sync call.
> 
> MCLK1 is not in the AoD power domain so if it is used as 32kHz clock
> source we need to hold a runtime PM reference to keep the device from
> going into low power mode.
> 
> fixes: cdd8da8cc66b ("mfd: arizona: Add gating of external MCLKn clocks")
> Signed-off-by: baratam <sapthagiri.baratam@cirrus.com>

You should have your full name here too.

Otherwise the change looks good to me:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

> ---
>  drivers/mfd/arizona-core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
> index c7c3d72..190f9a4 100644
> --- a/drivers/mfd/arizona-core.c
> +++ b/drivers/mfd/arizona-core.c
> @@ -53,8 +53,10 @@ int arizona_clk32k_enable(struct arizona *arizona)
>  			if (ret != 0)
>  				goto err_ref;
>  			ret = clk_prepare_enable(arizona->mclk[ARIZONA_MCLK1]);
> -			if (ret != 0)
> -				goto err_pm;
> +			if (ret != 0) {
> +				pm_runtime_put_sync(arizona->dev);
> +				goto err_ref;
> +			}
>  			break;
>  		case ARIZONA_32KZ_MCLK2:
>  			ret = clk_prepare_enable(arizona->mclk[ARIZONA_MCLK2]);
> @@ -68,8 +70,6 @@ int arizona_clk32k_enable(struct arizona *arizona)
>  					 ARIZONA_CLK_32K_ENA);
>  	}
>  
> -err_pm:
> -	pm_runtime_put_sync(arizona->dev);
>  err_ref:
>  	if (ret != 0)
>  		arizona->clk32k_ref--;
> -- 
> 1.9.1
