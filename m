Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0700EECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CCD20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FDB/iDhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CCD20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbeGRAEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:04:06 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38104 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeGRAEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:04:06 -0400
Received: by mail-pf0-f195.google.com with SMTP id v15-v6so1243294pff.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 16:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uXZXfvosWc9kcCMIAS6OVLiJ19cLrF5WfN2cHm6LvL8=;
        b=FDB/iDhlR4TLrehz8Y9CAkYcAGcDDYsrRuzOuBJLmVsadI5aP2h27SxNLmfuxWEu38
         goXK/+J6AtWfqKFm8kPdUweKj6zR8CHDXjnmSWQI+TxXWxNEoPOv+v5juGPmQ3lNbKQ2
         nKPybqHscdBuRXEiiE0aG//v6D26WioeKmLAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uXZXfvosWc9kcCMIAS6OVLiJ19cLrF5WfN2cHm6LvL8=;
        b=XJb5xwnmQEOnaXUI/ljS4quzCppRIHCY2t+qN8x3u+aKge86LUEO+S88PWcuqKD08P
         aZQCLMd8+hs5o4AuYKrEKpfOeMfXU0Yr6GL1p3KnncRa4BO5mWD3Qzy86iE/30IZECfT
         Pn2nSO2ATvnZs7EpFhqKm7eqX1Xg1fM70EhhHl7Cq6oli2Cq9AzzKZ6BbO/X9qydn5CY
         /XFQ7fkktOgEKOQzUtHUYYfaSEl7WROV4lq8WcUuqZ9AL+1pTPO8PkYicd87ExMLofup
         qhR7vqb5K9tYUJGh6qQDs+GC035peqktQeTBI+9LMBiMLzqf0GNFImXfupLtFvEDksyA
         h4+w==
X-Gm-Message-State: AOUpUlFzzLuy4FBJhyea6BMnxuVGfBp8FjArXeYRQ01R8NEYwjkgr7Pr
        OJFSw2BZCfiOr6RwQLnfs9hCZA==
X-Google-Smtp-Source: AAOMgpcA4BlQbQOB9e5ju8//GvHT8MX/hRNP28I2HkIK1N1X8Sei3/ERIRroO+MCq+Kr2Jt2jmddvg==
X-Received: by 2002:a65:5803:: with SMTP id g3-v6mr3472025pgr.117.1531870148755;
        Tue, 17 Jul 2018 16:29:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id j5-v6sm2868925pgp.6.2018.07.17.16.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 16:29:08 -0700 (PDT)
Date:   Tue, 17 Jul 2018 16:29:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        vivek.gautam@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 2/7] thermal: tsens: Add support to split up register
 address space into two
Message-ID: <20180717232907.GC129942@google.com>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
 <8f833fee80565c4dfd381697e47f99fb5f9e65d3.1531384019.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f833fee80565c4dfd381697e47f99fb5f9e65d3.1531384019.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 02:09:03PM +0530, Amit Kucheria wrote:
> There are two banks of registers for v2 TSENS IPs: SROT and TM. On older
> SoCs these were contiguous, leading to DTs mapping them as one register
> address space of size 0x2000. In newer SoCs, these two banks are not
> contiguous anymore.
> 
> Add logic to init_common() to differentiate between old and new DTs and
> adjust associated offsets for the TM register bank so that the old DTs will
> continue to function correctly.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/qcom/tsens-8996.c   |  4 ++--
>  drivers/thermal/qcom/tsens-common.c | 12 ++++++++++++
>  drivers/thermal/qcom/tsens.h        |  1 +
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
> index e1f7781..3e60cec 100644
> --- a/drivers/thermal/qcom/tsens-8996.c
> +++ b/drivers/thermal/qcom/tsens-8996.c
> @@ -16,7 +16,7 @@
>  #include <linux/regmap.h>
>  #include "tsens.h"
>  
> -#define STATUS_OFFSET	0x10a0
> +#define STATUS_OFFSET	0xa0
>  #define LAST_TEMP_MASK	0xfff
>  #define STATUS_VALID_BIT	BIT(21)
>  #define CODE_SIGN_BIT		BIT(11)
> @@ -28,7 +28,7 @@ static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
>  	unsigned int sensor_addr;
>  	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
>  
> -	sensor_addr = STATUS_OFFSET + s->hw_id * 4;
> +	sensor_addr = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
>  	ret = regmap_read(tmdev->map, sensor_addr, &code);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index b1449ad..c22dc18 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -16,6 +16,7 @@
>  #include <linux/io.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/of_address.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include "tsens.h"
> @@ -126,11 +127,22 @@ static const struct regmap_config tsens_config = {
>  int __init init_common(struct tsens_device *tmdev)
>  {
>  	void __iomem *base;
> +	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
>  
> +	if (!op)
> +		return -EINVAL;
>  	base = of_iomap(tmdev->dev->of_node, 0);
>  	if (!base)
>  		return -EINVAL;
>  
> +	/* The driver only uses the TM register address space for now */
> +	if (op->num_resources > 1) {
> +		tmdev->tm_offset = 0;
> +	} else {
> +		/* old DTs where SROT and TM were in a contiguous 2K block */
> +		tmdev->tm_offset = 0x1000;
> +	}

nit: no curly braces for conditionals with a single statement. There
is probably no need to respin just for this though.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
