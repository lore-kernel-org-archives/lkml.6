Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3D7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADAC20878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpLvUML4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADAC20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeIDAke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:40:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35184 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeIDAkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:40:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so590831pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 13:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B7BT97TJF5MxYBHaW0n5UuNfHBDvgjAHzZYBwswED/U=;
        b=GpLvUML4DST2BAswoATFSPthvu6JZDhcy5hiWKhj+SqgZQBpu65IhnIyJxSFU/DkQr
         SJgcAwAyblf2G/kB5MbO1Ut9nOVnxZnRvngPRqegN9DwA4r9pJR6ttUtCK5rili2lM5n
         /jjfeB9WPD8v4Pz7aK0BzPoTaLR0WgmAObom8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B7BT97TJF5MxYBHaW0n5UuNfHBDvgjAHzZYBwswED/U=;
        b=KldlQLItj5QOMWoSfoBwNAUx0kopQVO1CwIGEWrEJeIaNcgRyz1UhtM2mwOtxiKIV5
         W9ydwzD5/kOXoVT67svK6ogeD7+s8U42owjEWhdLnfhXZkoSZ0iBv+RjfosAEqb3Ehpv
         gJjrkHiOJ2GqLFPRJ4FVQryY9Fi0hoDuh4d7X+DCxoCF2lQpxQJwH9G+9B46VCU1gP+3
         gfOA2t8gKuMbebubahbtqiaUJyhziAWlWf8zN/pIha69yGaZaGfYbZVUiB0bj0VO/2S4
         0LjkJlS02NbhJJ5Rr0fDuxjMkIAMA6zPkRV7aR0sa6ifOKTvTuuqQLKyNgI8MWGoX1Xw
         JF+g==
X-Gm-Message-State: APzg51CYAFF8BfcAV6ahH5o4Zxrcb7/Pxcv+S4HzYXQbkc3cVk7a7Q3r
        vqHK6YNUWgSGBY/DMW35g7du0w==
X-Google-Smtp-Source: ANB0VdYLTiCHKuT7usxlkfPxwPFg6KuY+h6eKYHRaOb13z9RgcrIP++9TnIKjxenKq81FcwEcpu2+w==
X-Received: by 2002:a63:ee56:: with SMTP id n22-v6mr27999680pgk.402.1536005926353;
        Mon, 03 Sep 2018 13:18:46 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r25-v6sm24698455pgm.59.2018.09.03.13.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 13:18:45 -0700 (PDT)
Date:   Mon, 3 Sep 2018 13:22:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 05/11] thermal: tsens: Get rid of dead code
Message-ID: <20180903202239.GP3456@tuxbook-pro>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
 <c50d9e71fc8cf466b9a7ff32edf7fb9370cca2dd.1535462942.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c50d9e71fc8cf466b9a7ff32edf7fb9370cca2dd.1535462942.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Aug 06:38 PDT 2018, Amit Kucheria wrote:

> hw_id is dynamically allocated but not used anywhere. Get rid of dead
> code.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Good catch.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 90bb431cf740..9a8e8f7b4ae1 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -80,11 +80,6 @@ static int tsens_register(struct tsens_device *tmdev)
>  {
>  	int i;
>  	struct thermal_zone_device *tzd;
> -	u32 *hw_id, n = tmdev->num_sensors;
> -
> -	hw_id = devm_kcalloc(tmdev->dev, n, sizeof(u32), GFP_KERNEL);
> -	if (!hw_id)
> -		return -ENOMEM;
>  
>  	for (i = 0;  i < tmdev->num_sensors; i++) {
>  		tmdev->sensor[i].tmdev = tmdev;
> -- 
> 2.17.1
> 
