Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851FBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB8E20866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j44K5LJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB8E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387945AbeKFEZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:25:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41593 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387928AbeKFEZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:25:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id p16-v6so4901273plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cGiYE1yQDqKuARJ23LscLCMS2BXuuOE6edSY6pYB25k=;
        b=j44K5LJ2G3gb2KYke5tkor4I30qFM/QH8rh6PEuFcIpxbJCsDwtVYmKFyAH6HEh1+E
         Bc2CZPCBUgN5Cgh/1xOJCK5W9ZdMqCz9gUJ+8bttQcR18FwW60h3xKNPxeFl1b6+WuE3
         WBRBPbGFh/I994VyUuX/8X8UDlmRu1yNioBr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cGiYE1yQDqKuARJ23LscLCMS2BXuuOE6edSY6pYB25k=;
        b=bScUO+awvd3YUtIXMyL3GIm29U5I+pRq7r9+q5BWmt2MX4bYpctRyhTWxD8YlPscMl
         4TLTqT0Rz4YM44RiJiYOb3J6lVahT+rY66g+NYi4kjCXmW7nwH2YkJDe5H1l4yxuzNo9
         /5029eo3hpzYEkJ8vZKnINdndVBEKOIPdFMDfOjySlV/MovSEWqFCyU+cyv9WCoRE1IH
         uI4zL26sLxg7xi/PaFbyYCW6W20UU965AGJwt2sysKaeqLKmOx4/HmtBbtlqlVp8Uodh
         a/yZ6jdKgc/on8Ob09TUy4kT4wR+3AAlZ3ra3T5S2ovBCthckjHwhiZ9HNmvUxIA5XFT
         KVjA==
X-Gm-Message-State: AGRZ1gLyh3dg0u0uiINmfvfu2zIB6iblxMBbFl0vjmT0DDydkIHvB/cs
        rSwcR3db+ymCnEXZaZHvbLdb6A==
X-Google-Smtp-Source: AJdET5c1dFvWIpWeZmRzdgiP+Bv+bs+dhNOTCqS9frFNm5Rp98PUMvKEtxkfo7+nsbEsTpU/P/UgBA==
X-Received: by 2002:a17:902:4d45:: with SMTP id o5-v6mr578009plh.335.1541444683649;
        Mon, 05 Nov 2018 11:04:43 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 5-v6sm8672997pfg.141.2018.11.05.11.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:04:43 -0800 (PST)
Date:   Mon, 5 Nov 2018 11:04:40 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/17] arm64: dts: qcom: pms405: add rtc node
Message-ID: <20181105190440.GP2523@minitux>
References: <20181105154529.7614-1-vkoul@kernel.org>
 <20181105154529.7614-11-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105154529.7614-11-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Nov 07:45 PST 2018, Vinod Koul wrote:

> RTC is found on PMIC PMS405 and is same as other PMIC used, so add the
> rtc node with compatible as qcom,pm8941-rtc
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/pms405.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
> index 8a585180f102..cdb4547c998b 100644
> --- a/arch/arm64/boot/dts/qcom/pms405.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
> @@ -11,5 +11,11 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		rtc@6000 {
> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6000>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
> +		};
>  	};
>  };
> -- 
> 2.14.4
> 
