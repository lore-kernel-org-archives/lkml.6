Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD4CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8114A21EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LonZIsqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8114A21EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeHIVuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:50:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32977 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbeHIVuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:50:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so3318482pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4PGalYIZTSpBlC0C1p8NiZ+NibRZgV6nZ1qUEcPK9R0=;
        b=LonZIsqwDdP30iCtLMft80M7Q+ju+8fGETK4FU2CFr5Xta79ANS4zWGwJ6LHY3nSNV
         RrWeMjY00kMMJi/P1HmVz17v/dFQHmuOkThSPeG+Y9RnFb8fSTl2h3xfrWUj2ZEoJnlD
         HKwCurg1z4kQgCWEM1SNvact0KN3+Z1i5hoZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4PGalYIZTSpBlC0C1p8NiZ+NibRZgV6nZ1qUEcPK9R0=;
        b=aeLODRq84CkQN4fXWgc+9mT5SmpL/i/YebyYMRKh/oivzrtEcDQVAUEuvOYkHv2lqI
         yptgD0A2x4u2beTKyoHP16gAPP5E1intoZK1UYbdlPwcROd+OurR/gMDj/aocek0qGyU
         VHN4BMuhgTkDMGIQK7mZZkVLR77zvz5npF3YKiUSMRcdVATADM+FYRldSW17SuhHJNnK
         IC989JCRNTxol/U6xCwdwjwqtK+nbap1XDZnVrsQ4Slrv7NNM5yYb74V1fiuoRQYbykt
         YQe0T02RUpPnhDaBWPmfW+jCYrOy6J6XmIuhoNJBHjrxcm83/E2kb16mIt79E7gl33wo
         nnjg==
X-Gm-Message-State: AOUpUlH5JAUMRlTZoRMx12//BzX1Z5iIfq5lsrXZ55Oqlmr5qGNUhDmW
        332xzLCvvLNny+YhDx4YGXNSQg==
X-Google-Smtp-Source: AA+uWPxGdrbTkNWOavKVDkz38/0lML2Rd5PIbUazjKA9a0MVwj5ojokiTVMSR431GhXhWf1MRLu/Yg==
X-Received: by 2002:a63:2c8e:: with SMTP id s136-v6mr3281656pgs.390.1533842636482;
        Thu, 09 Aug 2018 12:23:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id d19-v6sm25622340pfe.42.2018.08.09.12.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 12:23:55 -0700 (PDT)
Date:   Thu, 9 Aug 2018 12:23:55 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 04/10] thermal: tsens: Get rid of dead code
Message-ID: <20180809192355.GL160295@google.com>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <0f945a83190de17df94a1bfcab48e6a86805cc9b.1533815718.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f945a83190de17df94a1bfcab48e6a86805cc9b.1533815718.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:02:36PM +0530, Amit Kucheria wrote:
> hw_id is dynamically allocated but not used anywhere. Get rid of dead
> code.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
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

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
