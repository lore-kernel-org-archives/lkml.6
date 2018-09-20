Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A68EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DA02152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9RouN9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DA02152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388333AbeIUAn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:43:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40098 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387773AbeIUAn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:43:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id s13-v6so4797679pfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5DNkYM/u2vNrVjfLINKFIWTi0vx5/GxyxxIor3LHpG4=;
        b=I9RouN9MZn/WSy2d9e69lj7UdkXzr2CnBUO4G1A8XWjYAn5duW7QZvisFomfr8+18b
         XVCuEtFbjpgls0rok9ehUWXURUUmFx0soB/hDyWGlWexMGGdkYZvxDjT5BCY1q5nHbSZ
         etX58pt7M6r3qPgR12+LkduuQZ3XgHDplpizc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5DNkYM/u2vNrVjfLINKFIWTi0vx5/GxyxxIor3LHpG4=;
        b=jFWwCclQ1L7XCDE76sj8OAmEHk8h1V/MDBgwWAz5+iDoyKazBXqEGkhbHHwGKiuFsA
         yZg+AEtP+nNlxx8DBQ/jV+kCrT+a45KIuGXtnFEzwXCREVFjVGmuvIba7JhZSqT8Kh2z
         Oki6gqraqkYcVYgIHjDbao5QmR0oZscs84xLQaZJMLuw9xsiHv4UEUibZwdnYYbQxXgs
         oHmRBmUfMu/d42vNjp9hWUz1OGfwNajzEFBTej9T2ZMEEm7gXhyxKtiKiLwxphNT3cEy
         v0a+bvkwEaJSiUAPcesTTiNJqQoTv9JoXQ6WeSpAKb4AhWSIVltF2vROM23l5plBigXK
         6YKg==
X-Gm-Message-State: APzg51AAUewA/DgVdkJ9SlMAuVL0C7QPZqUNsnqW0o/0sUOd8sKHQh3w
        DEZ7+IguPvbEtvAAYRwCOoBDQQ==
X-Google-Smtp-Source: ANB0VdbkqBLYR8VDOltfJppItlUPwcNs18QSBwMAsVSyKdVVbigmyP/q6RJ8EjG0yKZBBxztmYK1Sw==
X-Received: by 2002:a62:9e07:: with SMTP id s7-v6mr4152550pfd.110.1537469915536;
        Thu, 20 Sep 2018 11:58:35 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id g11-v6sm31092461pgi.90.2018.09.20.11.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 11:58:34 -0700 (PDT)
Date:   Thu, 20 Sep 2018 11:58:34 -0700
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
Subject: Re: [PATCH v3 12/16] arm64: dts: msm8916: thermal: Add
 "qcom,sensors" property
Message-ID: <20180920185833.GB19253@hector.localdomain>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
 <b471798c8e6de8c23de7ed4e2363049e2aad5486.1536744310.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b471798c8e6de8c23de7ed4e2363049e2aad5486.1536744310.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 03:22:57PM +0530, Amit Kucheria wrote:
> This new property allows the number of sensors to be configured from DT
> instead of being hardcoded in platform data. Use it.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 6a277fce3333..be27d8dc9e6b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi

Acked-by: Andy Gross <andy.gross@linaro.org>
