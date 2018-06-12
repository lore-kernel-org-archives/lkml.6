Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 314D6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41F42086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXRWLv0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41F42086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933767AbeFLTnp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:43:45 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35147 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932533AbeFLTnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:43:43 -0400
Received: by mail-pg0-f68.google.com with SMTP id 15-v6so66498pge.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 12:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B41EEUmPD91lDJ5Ytk33rHfhIZaofOEto0+sYlsK4zI=;
        b=JXRWLv0cu9rMu1A7f1DhLPwktnnuByQSMfWU6EJ0cvGI84+qvQHfCGsw8uFRU3UB3x
         8Pjde0FQgBFgef7/kbDHgRFyLkeLekl6kurx+SFlDlXYf35dAYi/g7ONnfkxPitoXv0c
         FEM1tArsbqzJrGhSfSWNdvfGVnzF4mKb8z4u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B41EEUmPD91lDJ5Ytk33rHfhIZaofOEto0+sYlsK4zI=;
        b=ID87wB1Mxx045ylh88cA7QSOcK6jZx0fg+fz1+KdTFojynovH9h99bOaQ2KhaPitjL
         0sD6qYUaL6OYhqx6oPv4tFQSALzP2F6Z3erANA0rqiFDeUMIhu5B2ve58YUV2WCxvOdJ
         Dkt5dDFfx0fUXtcbAHrf+keCEHY3C+dBNWt6BIAoMXg73lPtTMSqvh42ePJIsppHsiLP
         u+b0sBVbkm2VCzrH4E0w7EZN3b6CXhLS7xiZUuTBPMOV/3bIdGutI16+5Ejtb8xGguQc
         6zXYzSy9WDGAjdYOY+tdy5Ek4ckSz3jZFqmEEnOLKbrwSf+62KbeRqDuYLyXQ2qCMTt0
         snqw==
X-Gm-Message-State: APt69E1lvZPCMbL1QawE21/Axhgp5rSfFISk51cGenYH3VESg1aN4GC+
        bkSX8f/SSPefvTKrPB8IIn1MhEPI7S8=
X-Google-Smtp-Source: ADUXVKKp1v8/ZF60JityWwAH7IvZgSF2L1WmM4tLT9A8BB1JEkuJ4ccrjDHZKMXRfBoSq4tZ4MfGsA==
X-Received: by 2002:a62:9652:: with SMTP id c79-v6mr1822869pfe.114.1528832622524;
        Tue, 12 Jun 2018 12:43:42 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m16-v6sm818258pgu.67.2018.06.12.12.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 12:43:41 -0700 (PDT)
Date:   Tue, 12 Jun 2018 12:43:40 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] thermal: tsens: Check if we have valid data
 before reading
Message-ID: <20180612194340.GQ14924@minitux>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
 <021331bdb04642e9ddf34accda65a93b850c4a23.1528799892.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021331bdb04642e9ddf34accda65a93b850c4a23.1528799892.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 Jun 03:54 PDT 2018, Amit Kucheria wrote:

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens-common.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 961ace4..f510e61 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -114,6 +114,9 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
>  #define STATUS_VALID_BIT	BIT(21)
>  #define CODE_SIGN_BIT		BIT(11)
>  
> +#define TRDY_OFFSET     	0xe4
> +#define TRDY_READY_BIT  	BIT(0)
> +
>  int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  {
>  	struct tsens_sensor *s = &tmdev->sensor[id];
> @@ -121,6 +124,12 @@ int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  	unsigned int sensor_addr;
>  	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
>  
> +	ret = regmap_read(tmdev->map, TRDY_OFFSET, &code);
> +	if (ret)
> +		return ret;
> +	if (code & TRDY_READY_BIT)
> +		return -ENODATA;
> +
>  	sensor_addr = STATUS_OFFSET + s->hw_id * 4;
>  	ret = regmap_read(tmdev->map, sensor_addr, &code);
>  	if (ret)
> -- 
> 2.7.4
> 
