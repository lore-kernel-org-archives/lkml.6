Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68142C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0AC20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnlWZLdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0AC20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeICXpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:45:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35284 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbeICXpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:45:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so549672pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ys/FMPFCfU8C5FZ/YzNVz+HoCT+BQUAigfGmjSOcDHg=;
        b=jnlWZLdIeqCTMygU2RjTtSQTI2rCPysf48KEQUfsQ7UJmbVewlp0+nxV4/BaE/lqH/
         D4jF4E0SEmN5UvsMwnUzD0Q750a7DHzXwnK3KbDCxYnXwnxPw8Qo+HMUifjwcIFqBe2+
         Im36WARvMWr/UZ/Oc5T1DNAS+/5AwgeuTvvOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ys/FMPFCfU8C5FZ/YzNVz+HoCT+BQUAigfGmjSOcDHg=;
        b=avb3JMF4jBqj72e0QyVIFd67AQSpYBN9Tlw1JPr/QnljjygxeGXHIbAHrF4Mrt1zcD
         +zmrqOu5m6egRW1IObcoYQ+P111rdqjhctY1EtrYd9ymLEi6qg9Iz/fUDRykjnGgePZ3
         zFGqSIlKBUuPF3p3ohCrLPsoqbbrKHA2jnvTtyKDujQa5jJc+CgwmnaSoaDKbG/de3V9
         W/Hms7KivTPU5VqdUgf3sZo8q0qRDwgpA/dyjZiVMBZqWn8a53qcv55bc+eABOYzh4Dw
         lQWgNXhfqoGjEB/a+0iv8vcMpfZDndfNTiHlabnsGrBLwcW+k9H6xZNhJ5DLewIgi/fB
         iIBA==
X-Gm-Message-State: APzg51CdcNlB0fBLR78j45+nAcAXVjRACMZRsboEepWkSAjwTPlcxfDO
        LSoZx3b6P7l4IhkRb4WigCTAag==
X-Google-Smtp-Source: ANB0VdY7yh+TmHATfsjFlptO4qHqei6Ke8O8RzehJo4eKRBLAIIuraphvERu/dkaxTmw4frrLCnpFw==
X-Received: by 2002:a63:1750:: with SMTP id 16-v6mr5483546pgx.31.1536002615605;
        Mon, 03 Sep 2018 12:23:35 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f11-v6sm25090530pfa.131.2018.09.03.12.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 12:23:34 -0700 (PDT)
Date:   Mon, 3 Sep 2018 12:27:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: msm8996: Add a default compatible
 string
Message-ID: <20180903192728.GF3456@tuxbook-pro>
References: <20180829125803.11227-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829125803.11227-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Aug 05:58 PDT 2018, Niklas Cassel wrote:

> Add a default compatible string.
> This compatible is defined in Documentation/devicetree/bindings/arm/qcom.txt
> and matches how it's done in arch/arm64/boot/dts/qcom/msm8916.dtsi
> 
> Usually the dts overrides this compatible property, however, if the dts
> doesn't specify a compatible, this compatible string will be used.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

I think we should just say that the board dts must specify a compatible.

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index cd3865e7a270..354d3f900f72 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -17,6 +17,7 @@
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. MSM8996";
> +	compatible = "qcom,msm8996";
>  
>  	interrupt-parent = <&intc>;
>  
> -- 
> 2.17.1
> 
