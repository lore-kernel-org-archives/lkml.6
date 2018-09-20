Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888D9ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A52221523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VgTRHWmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A52221523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbeIUAnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:43:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38122 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387930AbeIUAnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:43:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so4799617pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=prBgS2y7Zu6AI5h4rG28r4Kl+qyAkp0FbqfzD9XYhc8=;
        b=VgTRHWmulpTQEn3LlpkEUSbRKhKPD9NDTps6ZFiqydQciomoxsFZyLrItWuc7XuIYi
         jotvWJ/EUEpX7uxpDwN+uZHLKb8+ZlUjvIncN5AnGUEl6X3wLLJ1hS2yL1veP3Q00B0U
         lVShiVpVof1pVcgyOYRVEhaEAkWH6/1DJyP0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=prBgS2y7Zu6AI5h4rG28r4Kl+qyAkp0FbqfzD9XYhc8=;
        b=P1GRyOaKGxkkrJaLz439/u8knCPzXHGNjHUFBgTznL6HiMDtnBPilRROTg+7EpqWWR
         SpZJJfQ1WK90N6poaiLs3WMpsrP4SqI3uRD4cPPAh+Q6RfReZhO405ghI2joFXksg5XT
         lB5gmriVdJMKcmaEZLOxvHrlFjNueDPiULL7QALHg1sk6EsSLorhKmnQGXV2qre5sQkU
         ARTlWQhFmq3fsbPTP8f3b98tBnudLiCB1o0p/+myoBW6NZ0NcCiMlnm9FZfWbSRYby56
         ZhGPrFrLszaLWo9pqj4ZzZU770+KPoFsgBp9NvLbcrlpNJJasjz0RB6gj0Icla8yLQBW
         kY4g==
X-Gm-Message-State: APzg51AUU6Axpj/DdAkPazwICwBsp+gD215iqo8kMytCITW8vZKWQGch
        WlsWUouLhmPff2ovvRQE4exzUA==
X-Google-Smtp-Source: ANB0VdZHknQIubOmd9KwCqBmKlCQcqEvfFHhUNGvLjzG83UU8I1yHR4PaH4z2Ff9zNc3fjS82E4nPA==
X-Received: by 2002:a63:a5c:: with SMTP id z28-v6mr37103347pgk.209.1537469896984;
        Thu, 20 Sep 2018 11:58:16 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id q25-v6sm34985102pfk.96.2018.09.20.11.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 11:58:16 -0700 (PDT)
Date:   Thu, 20 Sep 2018 11:58:15 -0700
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
Subject: Re: [PATCH v3 11/16] arm: dts: msm8974: thermal: Add "qcom,sensors"
 property
Message-ID: <20180920185815.GA19253@hector.localdomain>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
 <98b41f976cbedd0e93d7988f0b3cd3ae8b911414.1536744310.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98b41f976cbedd0e93d7988f0b3cd3ae8b911414.1536744310.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 03:22:56PM +0530, Amit Kucheria wrote:
> This new property allows the number of sensors to be configured from DT
> instead of being hardcoded in platform data. Use it.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 56dbbf788d15..3c4b81c29798 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi

Acked-by: Andy Gross <andy.gross@linaro.org>
