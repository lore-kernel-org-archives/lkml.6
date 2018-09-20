Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF80C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E26C20833
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TraAZe1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E26C20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbeIUApf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:45:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41579 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387865AbeIUApf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:45:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id h79-v6so4797679pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WUDDTysN+hMQoI7T9rLazXOcfxN0zIVybboW7mZvHqY=;
        b=TraAZe1JysexxHdKsDSPdKcne78+YqOZyjzN7o+umA4aUNRp3NELl/7Iix9oi0Y2px
         z5mE2LusOv9sSHfkvIm+h5gg3CkjMqhfIMc7OMQK4iF8O717VINcMAs1Ni7IhCNoN+Rh
         ce8VLp/6GiEsD9BkxGeW6dOV5XVlEdn5bMb1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WUDDTysN+hMQoI7T9rLazXOcfxN0zIVybboW7mZvHqY=;
        b=Gt4mZS+YLFQaOGMA2hLxthLfbctxF3oBSQEjmcY0FvpTaFSdBSR8yQCndE8S3TDVY7
         EW9ttFnfBzL9Ja4qMdC8HgPXXDcXpxlPEv96UEGTS6RlamGqwEVL9roYdO5A0rqmxrVf
         3aMV692PTGQEwclIxGSxmr3JkgL7alu3ZK/khu5XjiYRP9AR6eW4y+2YWR2usHsB7fOv
         3dHZ7at8t7r4D1PIUXHewv+0W92dqZRmjJsgCyofJO8NAGP/a06khQoLoU72eFwEvXlp
         fJLylTOyGv8VbsKvcpkLVrFqg4HPuxTLOU2TTUqNAa5pkRKetoVAl6agWSmjQLjEuP5n
         ox3w==
X-Gm-Message-State: APzg51DGAyR0ugqceLgTtbE4OZRykAjpPsntd4RPNamCs3H3APayoZ+P
        hG49E6VfYZTZCYYaaMbYaYs+Ww==
X-Google-Smtp-Source: ANB0VdYF4t3LB/nJkl2cTpnjd/yub9aPfQjgQthr1tgjEVgb0ye3LQAr9v+FxgvWhlRsGbAKqD075w==
X-Received: by 2002:a63:6283:: with SMTP id w125-v6mr37053322pgb.83.1537470040829;
        Thu, 20 Sep 2018 12:00:40 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id 142-v6sm153323pgg.54.2018.09.20.12.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:00:39 -0700 (PDT)
Date:   Thu, 20 Sep 2018 12:00:39 -0700
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
Subject: Re: [PATCH v3 15/16] arm64: dts: msm8916: Add camera thermal zone
Message-ID: <20180920190039.GD19253@hector.localdomain>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
 <5c678cd9c1f9d531efa39e9edb6151106957a077.1536744310.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c678cd9c1f9d531efa39e9edb6151106957a077.1536744310.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 03:23:00PM +0530, Amit Kucheria wrote:
> Initialise the camera thermal zone to export temperature to userspace.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 62f079ae9ba3..3dc8b8aa76c7 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi

Acked-by: Andy Gross <andy.gross@linaro.org>
