Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FF8C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2AC20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXErbt1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2AC20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbeICXpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:45:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41077 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbeICXpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:45:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id b12-v6so530708plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zRdrFXi+EP6kAP/VXxUVBFfyCKmghbkfH747IPUEVB8=;
        b=PXErbt1TTgYkeHxm7MkFkC/rAlZQ+sWfQ4W81r1hU1X45TzvTT3QRprRHXEutO7AcX
         PBod0g28m667SlcekTu/pa3gWuwdUVmRujsD4kmnAaArIE0DLfq+NLYKJdKXqa1ec+mO
         FMpMT7tpZIw467sJkVfjnezjJEYAZNSrUaoLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zRdrFXi+EP6kAP/VXxUVBFfyCKmghbkfH747IPUEVB8=;
        b=FfeAOk6INaM56Vvjai19uW/eMvlNjW2HLWj2pZQde9dYXQGJGafml07SEz5Z9Gz7Xx
         PIHo0Jz0SN1pc6A5PZpaLdHke1CDZ9O09yU57r7F7phv5BNI+/doQ3qcZRByPLFp3uIp
         ox+vEUtZ/zEsNiL8scXmRB05kEOSDmBuHC9x20TN8oyImE/+5q7aizkH4pPQrmq3kSnl
         UxFeq/TWjeQoRkXYPpg2wZ/nea/pXPiUPNGmtYEXIxYvfFMyk9A+69uHrrpnPr58i5w6
         p6+gjP2EGckadXpuWVhPx6Z8rWutpgO4NBT667uV0GPPcMY5k7gsYVCHgAQlKx6p+YA1
         2RfA==
X-Gm-Message-State: APzg51BWO5rZgtV4sB0VKDg3v8wfxEgPUoJEzfQ260iga3myISHksiFZ
        B18d18S46/L94nionvhXFzaIIQ==
X-Google-Smtp-Source: ANB0VdbzppPklpmAkym5rbVCmEY4UKWuNii/af6xWMCZXKC2TdMjYa+sbXzyQI1cbO8gINjWausFng==
X-Received: by 2002:a17:902:bc8b:: with SMTP id bb11-v6mr29379767plb.112.1536002644615;
        Mon, 03 Sep 2018 12:24:04 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 9-v6sm28900877pfc.20.2018.09.03.12.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 12:24:03 -0700 (PDT)
Date:   Mon, 3 Sep 2018 12:27:58 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: db820c: Add qcom,apq8096 to compatible
 string
Message-ID: <20180903192758.GG3456@tuxbook-pro>
References: <20180829125803.11227-1-niklas.cassel@linaro.org>
 <20180829125803.11227-2-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829125803.11227-2-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Aug 05:58 PDT 2018, Niklas Cassel wrote:

> Add qcom,apq8096 to compatible string.
> This compatible is defined in Documentation/devicetree/bindings/arm/qcom.txt
> and is needed for e.g. drivers/cpufreq/qcom-cpufreq-kryo.c to be probed
> correctly (and for drivers/cpufreq/cpufreq-dt-platdev.c to work properly).
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

@Andy, please pick this independently of 1/2

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> index 230e9c8484ac..da23bdafbd33 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> @@ -17,5 +17,5 @@
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. DB820c";
> -	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc";
> +	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc", "qcom,apq8096";
>  };
> -- 
> 2.17.1
> 
