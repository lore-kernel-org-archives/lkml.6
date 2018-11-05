Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36386C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E0E20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SkubdnWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E0E20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387988AbeKFEcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:32:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44387 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387462AbeKFEcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:32:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so4897008plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ie/FI3BHrWFr/tKne4O7SsZ8eFPUDkrxqA6FuLrRzag=;
        b=SkubdnWYXZjAGJM2VZ1ZzNKQb/iNYqr0C8l81hFpkOP8azf1FjM0RQOULqcQrq1WkP
         wu+RdJN5TLAcqsv7BOBdyAMrXnXPo5G4s55VII/dStEFsW6Vu4I+EpJEc6m4Dhm49rom
         a7NjaQcwSq/BvIyn6V4L+ev55XKlN1eGfpYhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ie/FI3BHrWFr/tKne4O7SsZ8eFPUDkrxqA6FuLrRzag=;
        b=Xj8fNNLxEBS/Ei8QnH4vxgcrP65FXQRiwj7JFc9SvS5Npzwuz6uZ9FchFyJF1xTA0y
         NQcVSu7hkZjOVokJ09x86IULjp/39YHm8DW3591j2lUb4cGbAeOp9CbvrZZh+a/LGehU
         sZjDJQe6e3yjBUWSuJm42QKiwJkSoyVMsB84C8MwREa3Wok7U23om0GC+0CR+pyC43WO
         hkBw6CoxSsmW/6Q2Slf2r8TcGysEW4oLuv8RLgeQ4az3OcpGM7PmSN7LFqokINzpI4UI
         p7xlS534qxupATaR5uv5sNoufkvAVUxbUsnWVXUDlVngXqPnlSlLn6NfWLjwnVNdxhmR
         e2qQ==
X-Gm-Message-State: AGRZ1gKi7et1TNP7b22CtykG5e+O4Vl09IplhrnqPwNgpXSonvzMx/Cf
        spPykJ0+/bnlOnbbgtcY5x3mbA==
X-Google-Smtp-Source: AJdET5dnvz9u9Dr+UBtyJErBNnQWcoPSI/Ir/4dc2V6psnKOuF0YiksJGj6f8LjKHvQ8VpsUJCK7vw==
X-Received: by 2002:a17:902:8a89:: with SMTP id p9-v6mr23675120plo.183.1541445060137;
        Mon, 05 Nov 2018 11:11:00 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q1sm25403232pgs.14.2018.11.05.11.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:10:59 -0800 (PST)
Date:   Mon, 5 Nov 2018 11:10:57 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/17] arm64: dts: qcom: qcs404: add prng-ee node
Message-ID: <20181105191057.GS2523@minitux>
References: <20181105154529.7614-1-vkoul@kernel.org>
 <20181105154529.7614-15-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105154529.7614-15-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Nov 07:45 PST 2018, Vinod Koul wrote:

> RNG hardware in QCS404 features (Execution Environment) EE for
> HLOS to use, add the node for prng-ee for QCS404.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index b560ab6e49ff..a37930639b8d 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -282,6 +282,13 @@
>  			#mbox-cells = <1>;
>  		};
>  
> +		rng: rng@e3000 {
> +			compatible = "qcom,prng-ee";
> +			reg = <0x000e3000 0x1000>;
> +			clocks = <&gcc GCC_PRNG_AHB_CLK>;
> +			clock-names = "core";
> +		};
> +
>  		tlmm: pinctrl@1000000 {
>  			compatible = "qcom,qcs404-pinctrl";
>  			reg = <0x01000000 0x200000>,
> -- 
> 2.14.4
> 
