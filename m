Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC27BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B5B21741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbeL0Jj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 04:39:56 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:34003 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbeL0Jj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 04:39:56 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 0709B20027;
        Thu, 27 Dec 2018 10:39:52 +0100 (CET)
Date:   Thu, 27 Dec 2018 10:39:51 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        pakki001@umn.edu, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] backlight: (adp8870) fix a missing check for
 adp8870_write
Message-ID: <20181227093951.GA14579@ravnborg.org>
References: <20181225062109.66943-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181225062109.66943-1-kjlu@umn.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=weBmRkxsz3CPpMl1aI4A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kangjie

> adp8870_write() may fail. This fix checks if adp8870_write fails, and if
> so, returns its error code.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/video/backlight/adp8870_bl.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
> index 8d50e0299578..79901fb4fcd1 100644
> --- a/drivers/video/backlight/adp8870_bl.c
> +++ b/drivers/video/backlight/adp8870_bl.c
> @@ -811,9 +811,14 @@ static ssize_t adp8870_bl_ambient_light_zone_store(struct device *dev,
>  		if (!ret) {
>  			reg_val &= ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
>  			reg_val |= (val - 1) << CFGR_BLV_SHIFT;
> -			adp8870_write(data->client, ADP8870_CFGR, reg_val);
> -		}
> -		mutex_unlock(&data->lock);
> +			ret = adp8870_write(data->client,
> +					ADP8870_CFGR, reg_val);
> +			if (ret) {
> +				mutex_unlock(&data->lock);
> +				return ret;
> +			}
> +		}	else
> +			mutex_unlock(&data->lock);
>  	}

Something looks wrong with the indent.
If you have braces around first part of if () then use
barces also after else. Then it is easier to follow the code.
In this case please consider another approach where you
have only a single mutex_unlock() both in the good and
in the error case.

	Sam
