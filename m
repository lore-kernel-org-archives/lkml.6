Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4BBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB7C21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnP3IGVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB7C21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388269AbeIUAqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:46:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37958 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388084AbeIUAqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:46:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id t84-v6so4855607pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UxhSj9lnZRPhIqAYpOQcHk70p088qcnz82T7yfRZHTw=;
        b=BnP3IGVgC7nGSRhiE08vE4j6NBP218ogm31FY7DJGeI5FYYmUPxKxzZW1OI6pUD+4/
         YNrFGedqLfpouZMrAlAEPwh/Wn14NV8/nNkyaNr+3oBGgMWIpx/n8siacTE9UfYsWVp1
         E2CzgYpSIsi8VQUWzmb/GiPeRerEj6Jp+HwLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UxhSj9lnZRPhIqAYpOQcHk70p088qcnz82T7yfRZHTw=;
        b=JQbhxN7w4K4c8DfVdenlz8YNjIc9JKkJNZGKmOLp/NmYTp2Rw/KraS6FSIO/mWj07f
         kbCmvgEh69w1S5O38jQMa8BuqjvqeVp8NLbHVa3LdWrXelRICGvY0QWSDSHdtpFDQTsH
         1IHsoJCvoVeI2hYytZgmgk8EYU0re95I9CECLWsUH1NmfPPnou4qIifM6WRfnFXYOWnC
         ik5PqEqIckSTk2YPLhJc48ZSbOpAseEYJzXPaaPZU0dlQ9M1/E0n5p0lqvMA6O8wAieH
         rXeGGH/jjTczoULm15B/xEzCx/XQlkjfKU1J7gd4Dl2hS3hNJ6WNlvSnq07s0G1wxjNU
         D8gg==
X-Gm-Message-State: APzg51BCXQq4QBvP1EFR/stagYpIhcCOFes8/XRnrpWd7lJZm00ZArBg
        wOebR4EuesF+/AsOcWAzfIjcIg==
X-Google-Smtp-Source: ANB0Vdb4YNyIdutUKjyZSLuXd6gz4tFc+m3x7PUISZ1BD0qcAm+xNQr+2cIyRr2EPB4/HTbjw3nctQ==
X-Received: by 2002:aa7:86cb:: with SMTP id h11-v6mr42174879pfo.58.1537470073272;
        Thu, 20 Sep 2018 12:01:13 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id n26-v6sm26397958pgv.78.2018.09.20.12.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:01:12 -0700 (PDT)
Date:   Thu, 20 Sep 2018 12:01:11 -0700
From:   Andy Gross <andy.gross@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 16/16] arm64: dts: sdm845: enable tsens thermal zones
Message-ID: <20180920190111.GE19253@hector.localdomain>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
 <5e2d5fc463a5f5623c4fc1b18ccdf62adc954758.1536744310.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e2d5fc463a5f5623c4fc1b18ccdf62adc954758.1536744310.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 03:23:01PM +0530, Amit Kucheria wrote:
> One thermal zone per cpu is defined
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 170 +++++++++++++++++++++++++++
>  1 file changed, 170 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0c9a2aa6a1b5..eb801922f6bb 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi

Acked-by: Andy Gross <andy.gross@linaro.org>
