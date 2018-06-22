Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070B5C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FC124627
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfOLHcCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FC124627
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933908AbeFVQ4j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:56:39 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42069 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933472AbeFVQ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:56:37 -0400
Received: by mail-pg0-f68.google.com with SMTP id c10-v6so3222508pgu.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uplf+FY22xsVmutCHVqJElx8IqHhtMdktBTBDdjS/XM=;
        b=gfOLHcCvKCWTXrW36xibcKriVsFSsL+A2n84+1gkJoYPLiDr8I1AFJKO4doRyHq0cC
         fWnLICo2QiGReL7uM0K81rqOyMllZPrWUtkz7Fwu9hbLoooqe3Vhn/TsFkuctJ8e8ncZ
         tz+WFMUgV6Zq2kvZ5LknDugCzHt/Jovdmkhws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uplf+FY22xsVmutCHVqJElx8IqHhtMdktBTBDdjS/XM=;
        b=NsPnL40KNa8zvGWz1PIvcxLH9vA53SgY7VszrC4Tf1KCKTSKvlJwKKk9QxIv+4jddl
         1e7TLL5V3VQdu6+0HzE0TCKzaMh9yBhsTmhhn++OfaX4TNZQG57UipIhd2MbDUbCiPxz
         TRviFAY4hRMYWNsOc/RAl5IFS8OAvQDh0B+wUrbgKEHMAX01MhsVWomugu1COAmogi8Y
         OEzQgDo5aIQL7GuNRJ3FHUKUVjtkJ+Alo8Vbc/uoofbNjbglPR23K8GepUiZ/ZNpDch7
         AwI7fJ58Xlv+onO9jkCWXWg1tbc4CqNmyPiB05SlkzGOJYYpMUKf2QoJRVMOGtvcJWMY
         bm/g==
X-Gm-Message-State: APt69E3Ixny79rxA+fi7z6GRSPN51+MKtO0iVl2GxHqakDgmcPyilhFn
        yzJjMvOiKz3T+nfji/5S6x+Htg==
X-Google-Smtp-Source: ADUXVKIwR2RcMMuWhHTxPLxkNPiaIQmuby12lNwhv0nRRb1S98e8OvyMHD0q+/rADrxT3J/8Syh6pg==
X-Received: by 2002:a65:4c4d:: with SMTP id l13-v6mr2162968pgr.211.1529686596589;
        Fri, 22 Jun 2018 09:56:36 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x14-v6sm7555065pge.85.2018.06.22.09.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 09:56:35 -0700 (PDT)
Date:   Fri, 22 Jun 2018 09:56:34 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Add pmu node to sdm845
Message-ID: <20180622165634.GB10336@builder>
References: <20180522062352.151257-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522062352.151257-1-swboyd@chromium.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21 May 23:23 PDT 2018, Stephen Boyd wrote:

> Add the CPU PMU on sdm845 to get perf support for hardware events.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 7c85e7c596db..93a62c2be86c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -152,6 +152,11 @@
>  		};
>  	};
>  
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
> -- 
> Sent by a computer through tubes
> 
