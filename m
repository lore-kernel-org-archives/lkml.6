Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869A3C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F71220846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1quFqqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F71220846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbeGZRan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:30:43 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34841 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731851AbeGZRan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:30:43 -0400
Received: by mail-pl0-f67.google.com with SMTP id w3-v6so1034978plq.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 09:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1hIK/H5MmOewLypG4apEZ7USzZzkjTyf2gMX6rCPwg8=;
        b=S1quFqqQwN9Y8yzOHH+zQStJ7RTNc3fW4RrQMoK2Fs1NrdwGs7Jd1fpCs6towNMfQn
         j+tTxx8VVxbR7yaJMqWS3N0Zf+G1yCyLI7bi7EfWi3/8rlBIeRGVgYYqxsgEqEIQr9Yo
         iWWvHgjJFQCEImNVXKhdGt60b/TxYOVs+CI2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1hIK/H5MmOewLypG4apEZ7USzZzkjTyf2gMX6rCPwg8=;
        b=en0M7Xa0U22gAt6LTOplM6UZ66Xr4bzBdL9hHwejugxz96LMo1nFAMJ8xh04VElX66
         gO+RHqdX5yqcdSyXUgFvy4Mc2SkLjWIUxI+7BsWjIKenaHX0TDtxQuJrtb/4uup6muYR
         zBWS1k8OR/68VOlmbB6GJwMq3z6A9G7al0dfmTa/TXcgXEs3i3V9h04fiwLO9G0KG/hx
         uymXkXmjiPM0/8MOmolijLoMJNWf58ZahbkS6R99ERCaLITM4N793cRfh8ShjiEyaDGe
         f/cLZbkrVvFYjlw4yTO5hBE34HlgfQ9JeRD8vqGCkTV/CQpVYZ0bJn+lsIZ3PFp3JLpD
         7YyQ==
X-Gm-Message-State: AOUpUlHt+TkCrnskOmCm3ARIteJEerqeeGYcNDAeKk2G4R6fPdQLSY59
        rrVR/WLAH5ll8o83bze21LShIcfvXS0=
X-Google-Smtp-Source: AAOMgpe/Bk+ka+Qop4DZ33Q7NLBWGEruhbgKer2iWYtRNc7WdFhZXLNPQGICF+fUo0rJBLuy7IWLcw==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61-v6mr2515728plb.274.1532621592456;
        Thu, 26 Jul 2018 09:13:12 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h24-v6sm3644737pfk.113.2018.07.26.09.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 09:13:11 -0700 (PDT)
Date:   Thu, 26 Jul 2018 09:16:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] thermal: tsens: Rename variable
Message-ID: <20180726161620.GA5450@tuxbook-pro>
References: <cover.1532600791.git.amit.kucheria@linaro.org>
 <5160b58d1d14b87b84ea49adc804afbefb792c34.1532600791.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5160b58d1d14b87b84ea49adc804afbefb792c34.1532600791.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26 Jul 03:33 PDT 2018, Amit Kucheria wrote:

> We're actually reading the temperature from the status register. Fix the
> variable name to reflect that.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens-common.c |  6 +++---
>  drivers/thermal/qcom/tsens-v2.c     | 10 +++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index c22dc18c7c65..25e7f247b027 100644
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
> index f40150fd7eae..908e3dcb2d5c 100644
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
> -- 
> 2.17.GIT
> 
