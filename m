Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1864CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00962083E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l3hr/rHi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YTPVSqIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00962083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeKQGgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:36:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43894 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeKQGgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:36:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 05C5A6074C; Fri, 16 Nov 2018 20:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542399782;
        bh=5gbiFaTEAmVh9vyx2qbm11ZoSIUcgqF8XiMbPaUFApQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l3hr/rHi5cV1xm8DZWq9zBb9a4JzHd45eUWJDKQ6w6CRABSa8IsPptSddngz9O7rJ
         5RCG0j0E8k6GKR55SFjp+mBJFtQxdpo15ywY+89XxHZ1UsqRIqbwuhE7HodcRY8+DY
         l5S5RENait3ojzoNQf7KE19wMv5YH0JeIByxszrQ=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 604E360452;
        Fri, 16 Nov 2018 20:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542399781;
        bh=5gbiFaTEAmVh9vyx2qbm11ZoSIUcgqF8XiMbPaUFApQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YTPVSqIyc0cPNuCZujPk2EVl/J1ELTVjuALIInhsyI9/02tT+oM9trn4Sanl7XOGj
         xCWMSOpZOEq1fwWnEQOnxtnX2t5vGkHVWOf490KIU7t2m3ZlUhX9caGoba/pEE5urZ
         pH59C89heP51aXgmiNc5i8ZOMWHQSmP5OBmPm2Ts=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 604E360452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Fri, 16 Nov 2018 13:22:57 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     robdclark@gmail.com, airlied@linux.ie, seanpaul@chromium.org,
        linux-kernel@vger.kernel.org, jsanka@codeaurora.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH -next] drm/msm: dpu: Fix "WARNING: invalid free of devm_
 allocated data"
Message-ID: <20181116202257.GC6285@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: YueHaibing <yuehaibing@huawei.com>, robdclark@gmail.com,
        airlied@linux.ie, seanpaul@chromium.org,
        linux-kernel@vger.kernel.org, jsanka@codeaurora.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20181116112526.10552-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116112526.10552-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 07:25:26PM +0800, YueHaibing wrote:
> 'dpu_enc' is a member of 'drm_enc'
> And 'drm_enc' got allocated with devm_kzalloc in dpu_encoder_init.
> 
> This gives this error message:
> ./drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:459:1-6:
>  WARNING: invalid free of devm_ allocated data

I had partial fix of this in my ill-fated patch from a few weeks ago but this
is better.

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 82c55ef..99526d9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -455,8 +455,6 @@ static void dpu_encoder_destroy(struct drm_encoder *drm_enc)
>  
>  	drm_encoder_cleanup(drm_enc);
>  	mutex_destroy(&dpu_enc->enc_lock);
> -
> -	kfree(dpu_enc);
>  }
>  
>  void dpu_encoder_helper_split_config(
> -- 
> 2.7.0
> 
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
