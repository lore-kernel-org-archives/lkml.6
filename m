Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAAAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EFF2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZrzHFxJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EFF2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbeIFU2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:28:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33987 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbeIFU2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:28:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id d19-v6so5459596pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 08:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YTxrCgDwO4VAE/5cZnmEtHIeu0ljt9ZxDRWt9uSHFBk=;
        b=ZrzHFxJ7IHjHV6vBTaMUwECi8Bi35s6ccLtgfFELbHdajpQw+yClbMo09KSaMvE3ko
         oeBShpxFRzDqCYfHBODzuThJbEqIZfRHOBLSl7b7uG0Pg3FaBz7ULlKjFSEmBxpQPyQ2
         yGo2IIrTe4CxYH7Ena78PIFaTVKmC5CFjet8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YTxrCgDwO4VAE/5cZnmEtHIeu0ljt9ZxDRWt9uSHFBk=;
        b=UWIw1n6j2RW7IdJh7VQXPx7o/6sonfThM7c4+0AsohO3FadSsRlubUSIAhnockUQvX
         VETMJuvhK+dFaouFHyDXk0wvDFlmPDgWn7KAntZqCIUN1mbWx9oT+L8EA0SY0R+zSZOc
         NfdBNS4K2b28HWC6n+1bYq0FZGMqcn4agf9/iC3pvlXudYABHSe+aHP7H/6O0lJn5htP
         VxH5TcODJOohLRhXJNTYpdgWwakzUFvQDRkGkalEO9dKxF8ctrxLmEFasfujTUqrz+6d
         Pm7RLWcnkN7WLekki658Drf+IxNkpNlUn+s77IYkhrLAAS0isHb2Dx1ZgnMtuSFmwuqx
         s23g==
X-Gm-Message-State: APzg51DLwB7sQf35YBo2l0cwiQ+20CSDFWPkuWzEHNCWQq/Lbeobd6AE
        zEvNd1vBJ3Jsmzff7JQYK4gSng==
X-Google-Smtp-Source: ANB0VdYBQC0LG5JV/Cz1nZXV/VBnwi8YsCeDX/QdrVUCopn8MRIRrdgaLWOwuwwcdMLk19wYoiS8JA==
X-Received: by 2002:a63:3dc6:: with SMTP id k189-v6mr3396611pga.191.1536249121859;
        Thu, 06 Sep 2018 08:52:01 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 71-v6sm7683065pfx.182.2018.09.06.08.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 08:52:01 -0700 (PDT)
Date:   Thu, 6 Sep 2018 08:55:58 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: msm8916: Drop model and compatible
Message-ID: <20180906155558.GB3286@tuxbook-pro>
References: <20180905183517.9390-1-niklas.cassel@linaro.org>
 <20180905183517.9390-3-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905183517.9390-3-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05 Sep 11:35 PDT 2018, Niklas Cassel wrote:

> DTS board files should always specify model and compatible.
> 
> All DTS board files that includes msm8916.dtsi
> already specifies model and compatible, and will thus
> override the model and compatible in msm8916.dtsi.
> 
> Drop model and compatible from msm8916.dtsi,
> since they are only a source of confusion.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 7b32b8990d62..726a45960742 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -18,9 +18,6 @@
>  #include <dt-bindings/thermal/thermal.h>
>  
>  / {
> -	model = "Qualcomm Technologies, Inc. MSM8916";
> -	compatible = "qcom,msm8916";
> -
>  	interrupt-parent = <&intc>;
>  
>  	#address-cells = <2>;
> -- 
> 2.17.1
> 
