Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569E0C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A51B20846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bOxWRDpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A51B20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbeGKQgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:36:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37558 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeGKQgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:36:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id n15-v6so3056156pgv.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nRbBluWhuvkXF+sqh4vOo7mQ4ma/8LkrWi+UfmCbz3g=;
        b=bOxWRDpvLgbTrbPMRzCFZrYv0v+3db0PiN3ucvn53RYeFoq5idRndC5V6NzPTYZDEn
         uBhJtQEtdRJ1N9q/0gSFtPkDeczNu7RYhgSA5bsf5kUCE3Bgwf9HQgk+wVZcZuMi6S3g
         /STA5hIToqozEQVtPOfKOG0yXwRmy4Eo25D6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nRbBluWhuvkXF+sqh4vOo7mQ4ma/8LkrWi+UfmCbz3g=;
        b=HS0Uj32QISLeJX78wcbUZPtVGnPorll53O89YPlCz3DFxqaoGmOqgTRb3XxL8moKEQ
         sVSfvQyXSi6ZKwVsx3J24+ZTcLXW7bjKJDKon9rZvm8RezntxISFpHYAsNkNMWoZozCQ
         F+xZKGfkgl2t2tgMfA7PEqLmlqQBTHgp3ZmSEt4g23bAyMqKlNj0Jp42h9s8pQRnUOox
         clqI1ZpREgZw0W59UeGKmzXTPJaGbx9BZ/CYxmjoW1+5BLEhbBwuDm8xxpksTcCZBFEm
         LFTtVcMhn3sGUghvvJ9iyGd+60L+oppR8FijwSfdb5TJHCSnshzyVkpRfzUc6l+6XbWh
         ZiMA==
X-Gm-Message-State: APt69E1lbYJf8RMc9u6HnzpCXt2Fqq08wLe5HFVLWc+tgfy1P4errMN8
        Fm1DQOxz/ACj1X2hcOqEXJZMBQ==
X-Google-Smtp-Source: AAOMgpcL8t0dIQ44yyge+Heqnvxj/VPvJptQgP/jMHIU4NDpyodO3T7nLVUy3S/fF5TW/E7WhcIIfQ==
X-Received: by 2002:a62:1f8c:: with SMTP id l12-v6mr31180363pfj.143.1531326692568;
        Wed, 11 Jul 2018 09:31:32 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n128-v6sm4495351pfn.184.2018.07.11.09.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:31:31 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:34:13 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 2/7] thermal: tsens: Add support to split up register
 address space into two
Message-ID: <20180711163413.GA545@tuxbook-pro>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <e7c5c74bd5ad1820f0f015d8e9b3d7c7b24854a4.1531135999.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7c5c74bd5ad1820f0f015d8e9b3d7c7b24854a4.1531135999.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Jul 04:43 PDT 2018, Amit Kucheria wrote:

> There are two banks of registers for v2 TSENS IPs: SROT and TM. On older
> SoCs these were contiguous, leading to DTs mapping them as one register
> address space of size 0x2000. In newer SoCs, these two banks are not
> contiguous anymore.
> 
> Fixing old DTs to split the address space into allows us to have cleaner
> common code e.g. get_temp() that is shared across new and old platforms.
> 
> But we need to add logic to init_common() to differentiate between old and
> new DTs and adjust associated offsets for the TM register bank so that the
> old DTs will continue to function correctly.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens-8996.c   |  2 +-
>  drivers/thermal/qcom/tsens-common.c | 11 +++++++++++
>  drivers/thermal/qcom/tsens.h        |  1 +
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
> index e1f7781..60765b1 100644
> --- a/drivers/thermal/qcom/tsens-8996.c
> +++ b/drivers/thermal/qcom/tsens-8996.c
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
> index b1449ad..4a741b0 100644
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
> @@ -126,11 +127,21 @@ static const struct regmap_config tsens_config = {
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
> +	if (op->num_resources > 1) {
> +		tmdev->tm_offset = 0;
> +	} else {
> +		/* old DTs where SROT and TM were in a contiguous 2K block */
> +		tmdev->tm_offset = 0x1000;
> +	}
> +
>  	tmdev->map = devm_regmap_init_mmio(tmdev->dev, base, &tsens_config);
>  	if (IS_ERR(tmdev->map)) {
>  		iounmap(base);
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index dc56e1e..d785b37 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -77,6 +77,7 @@ struct tsens_device {
>  	struct device			*dev;
>  	u32				num_sensors;
>  	struct regmap			*map;
> +	u32				tm_offset;
>  	struct tsens_context		ctx;
>  	const struct tsens_ops		*ops;
>  	struct tsens_sensor		sensor[0];
> -- 
> 2.7.4
> 
