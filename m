Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98DBC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1AB20685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bSrRLRmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1AB20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbeGYX6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:58:38 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46318 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731681AbeGYX6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:58:38 -0400
Received: by mail-pl0-f68.google.com with SMTP id t17-v6so3885511ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gv+6Rv6SOVDod4pEGWPGRz0NX93HBELeZcpHl2aJbrU=;
        b=bSrRLRmgiFV/CuQiwi5tRy072G1pULWMCL6vrnxs0zTSGFF1WxUgtdxDHJj0kg4LUo
         j8NxLFtjprG5wzkLKW9yZBG1c7e23DdERsPyljRc2cb1XLgaUQKFMmJXx1GJTa601g9/
         SvnAN3ilWl6MVk+qbo0bf3+OryWQ9mOnuyzlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gv+6Rv6SOVDod4pEGWPGRz0NX93HBELeZcpHl2aJbrU=;
        b=fBlhjYw+eLiaqXtFbfLGlCiHT4DNsxzEsN0Zv3K+EmKBLE6c7IIDDzPDmkj4Gh+ffb
         Ql4+Wd+b2oXi24tkxVrpI/lBZ2YLnUv0SNsgeVQ/xhkICnAvU0BUmW70eWXEBJlPEFQ6
         vPVgZBKB6s1k+zx18VxqkS8G2GhszlrSsBFcUxR6WHs1tKW/9gmv49DxBhhr+/dBNp5Y
         jxSq5uFuhzxKpQra0CkO53zBlBf5EECgMcRgiHUBpirpvI+oGvIpYVvTZGPx5HkdtWCc
         FP5zcpIycBiKGhoGZ3KvfJ0NvldvoD64g31dmAJMSktO3ysanoA6kLhpRq2PLVsQW9ax
         FKbg==
X-Gm-Message-State: AOUpUlG9V4xsu6XuQro+bq1e86KRDq8inoiV31pnJwlz2Li+4neNPMuO
        Y0qomgjM1Uq3zzzxOnGrJ+2DNw==
X-Google-Smtp-Source: AAOMgpeNp6BLiW0Hrtn6aobr1G4yCQ0A4hjbiV7mhgiY1pbxaLMp7HTGVpLzKqpX5+OwyNVvpttQxg==
X-Received: by 2002:a17:902:9345:: with SMTP id g5-v6mr22645878plp.10.1532558689355;
        Wed, 25 Jul 2018 15:44:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id d123-v6sm22236655pfa.22.2018.07.25.15.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 15:44:48 -0700 (PDT)
Date:   Wed, 25 Jul 2018 15:44:47 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/3] thermal: tsens: Rename variable
Message-ID: <20180725224447.GR129942@google.com>
References: <cover.1531898088.git.amit.kucheria@linaro.org>
 <45062f2bcfd0f20e604f663e3627dcedf01f0be5.1531898088.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45062f2bcfd0f20e604f663e3627dcedf01f0be5.1531898088.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:55:01PM +0530, Amit Kucheria wrote:
> We're actually reading the temperature from the status register. Fix the
> variable name to reflect that.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-common.c |  6 +++---
>  drivers/thermal/qcom/tsens-v2.c     | 10 +++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index c22dc18..25e7f24 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -104,11 +104,11 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
>  {
>  	struct tsens_sensor *s = &tmdev->sensor[id];
>  	u32 code;
> -	unsigned int sensor_addr;
> +	unsigned int status_reg;
>  	int last_temp = 0, ret;
>  
> -	sensor_addr = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
> -	ret = regmap_read(tmdev->map, sensor_addr, &code);
> +	status_reg = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
> +	ret = regmap_read(tmdev->map, status_reg, &code);
>  	if (ret)
>  		return ret;
>  	last_temp = code & SN_ST_TEMP_MASK;
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index f40150f..908e3dc 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -16,11 +16,11 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  {
>  	struct tsens_sensor *s = &tmdev->sensor[id];
>  	u32 code;
> -	unsigned int sensor_addr;
> +	unsigned int status_reg;
>  	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
>  
> -	sensor_addr = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
> -	ret = regmap_read(tmdev->map, sensor_addr, &code);
> +	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
> +	ret = regmap_read(tmdev->map, status_reg, &code);
>  	if (ret)
>  		return ret;
>  	last_temp = code & LAST_TEMP_MASK;
> @@ -28,7 +28,7 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  		goto done;
>  
>  	/* Try a second time */
> -	ret = regmap_read(tmdev->map, sensor_addr, &code);
> +	ret = regmap_read(tmdev->map, status_reg, &code);
>  	if (ret)
>  		return ret;
>  	if (code & STATUS_VALID_BIT) {
> @@ -39,7 +39,7 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  	}
>  
>  	/* Try a third/last time */
> -	ret = regmap_read(tmdev->map, sensor_addr, &code);
> +	ret = regmap_read(tmdev->map, status_reg, &code);
>  	if (ret)
>  		return ret;
>  	if (code & STATUS_VALID_BIT) {

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
