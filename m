Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958FEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB74214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EXH+uSYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfAJBPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 20:15:36 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42399 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfAJBPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 20:15:36 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so4390294plp.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 17:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lad6h/nPiENbJsEoNn3u6dkP3Hq5OGHS1HI01m1Hc5s=;
        b=EXH+uSYbr/U8J5ZP0FceUKAgIVP5RVzDxlxIJXG9eRgd+tPMdPQxX7t1xnswy4wccg
         3y/HmMELwnBo4/w2F4iBbaj04KSf/amq+o7vtUK9w+dJR5plvw5jKAfhBDy/rxWGs8xH
         VvWFuAoFU3oUGYXSnLjSjK65Vrs7JcaABC3wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lad6h/nPiENbJsEoNn3u6dkP3Hq5OGHS1HI01m1Hc5s=;
        b=RsxGKF+WIaRAOSBASqgfOv5TRm5dBdlQWAuXo8GnPrv2LT/DxSE+SSZzf/y7T8a6It
         8ectW0BSqxb8bLjwoHZ3VaKAdIAsveTwRFT3KwL5kLmPKDGp4sVZ7+yMlSfZrDzeMEtS
         pZFB3jmxmR64T/YGgN93dMdMO8m4ZcVJr4prIosFfimMm9yPE+4s54FG3agHNsqlO3y9
         o20aEXhBHRZp//4R0Ptfc62P/nt3PXua9gb5eLmP7LdHWBT2qffa4ghclIBZJqRRYzL+
         2DEmK3wOFg8dJqef9VElavH/4rRoH3Ai/Z8fKbdc0U/JyPqL1qnLMmuUzUm+Mx7dV6x2
         h10Q==
X-Gm-Message-State: AJcUukco6jC/wA+d30l0YAYUMC06ff7zPiJyA6Dt9X0DUS9zVXfx63GO
        7JLoQA9hqU7XsjMuqPLCNZtuVw==
X-Google-Smtp-Source: ALg8bN7rzLoiYJt6eP94MSYYdTQlQFrLxqzsNHcQep64h2nwZ9iow8YbaQYDW1LOXNd/HRuQHFQyZA==
X-Received: by 2002:a17:902:64c1:: with SMTP id y1mr8234626pli.64.1547082935051;
        Wed, 09 Jan 2019 17:15:35 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g136sm119475142pfb.154.2019.01.09.17.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 17:15:34 -0800 (PST)
Date:   Wed, 9 Jan 2019 17:15:33 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org,
        swboyd@chromium.org, dianders@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 6/7] arm64: dts: sdm845: Increase alert trip point to
 95 degrees
Message-ID: <20190110011533.GV261387@google.com>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <041258d65883df964890249a24d2a4788c419304.1547078153.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <041258d65883df964890249a24d2a4788c419304.1547078153.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On Thu, Jan 10, 2019 at 05:30:55AM +0530, Amit Kucheria wrote:
> 75 degrees is too aggressive for throttling the CPU. After speaking to
> Qualcomm engineers, increase it to 95 degrees.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index c27cbd3bcb0a..29e823b0caf4 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1692,7 +1692,7 @@
>  
>  			trips {
>  				cpu_alert0: trip0 {
> -					temperature = <75000>;
> +					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
> @@ -1713,7 +1713,7 @@
>  
>  			trips {
>  				cpu_alert1: trip0 {
> -					temperature = <75000>;
> +					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
> @@ -1734,7 +1734,7 @@
>  
>  			trips {
>  				cpu_alert2: trip0 {
> -					temperature = <75000>;
> +					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
> @@ -1755,7 +1755,7 @@
>  
>  			trips {
>  				cpu_alert3: trip0 {
> -					temperature = <75000>;
> +					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
> @@ -1776,7 +1776,7 @@
>  
>  			trips {
>  				cpu_alert4: trip0 {
> -					temperature = <75000>;
> +					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
> @@ -1797,7 +1797,7 @@
>  
>  			trips {
>  				cpu_alert5: trip0 {
> -					temperature = <75000>;
> +					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
> @@ -1818,7 +1818,7 @@
>  
>  			trips {
>  				cpu_alert6: trip0 {
> -					temperature = <75000>;
> +					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
> @@ -1839,7 +1839,7 @@
>  
>  			trips {
>  				cpu_alert7: trip0 {
> -					temperature = <75000>;
> +					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};

The change itself looks good to me, however I wonder if it would be
worth to eliminate redundancy and merge the current 8 thermal zones
into 2, one for the Silver and one for the Gold cluster (as done by
http://crrev.com/c/1381752). There is a single cooling device for
each cluster, so it's not clear to me if there is any gain from having
a separate thermal zone for each CPU. If it is important to monitor
the temperatures of the individual cores this can still be done by
configuring the thermal zone of the cluster with multiple thermal
sensors.

Cheers

Matthias
