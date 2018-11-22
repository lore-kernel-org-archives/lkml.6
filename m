Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C78C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285BD20831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OL3jzdbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285BD20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404974AbeKVRp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:45:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34042 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389253AbeKVRp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:45:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so8826868plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 23:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J6pZAqbjPzp40/iN4kBlUTeaAOiPkvXIWgAC2llWM+g=;
        b=OL3jzdbDzKajrLObX9Wa1eGGAbeUeleldF6RVk47msNOyExky1+9pIzcoRA8B60egp
         vwVWyrvNTfQKgp3+ZNI0+6/n5ik0ZmeEyXKMYBUSp1u3Xzjv5gpdK6ccn8GsCh4CWL4a
         vw0rZ9sXY2r03T4y4E8fOxFfOCvylGMbOomyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J6pZAqbjPzp40/iN4kBlUTeaAOiPkvXIWgAC2llWM+g=;
        b=TAhXAAthbcUyzR42dblxuLtIy+s3rO6zfbPTyJZRHg8VkKetGLOjqsHOLF5koi3+2Y
         LKlGOql8fCb4Vwbv6pGaivhbRmlFBvylt58q4MjkASnCKKW8vctyz1sguUrlD06AAL8w
         qC7QmpqiSPstkIt8NTJCekT4ZrwPmY827IFTenjzzYcXiUBnYJFXdZkRuoR0W+IIIihT
         LZjnW1DLVVDYC789hR3yHhSN4eL602sr9S8AqmLQEyNUjuryerjL7LDs14Y3KN3V79Gk
         Stak1ddCSoHFP07uz9OcpEbYCRoFOJ8b8MorHGDujx9qQ/rsfFLDlH1zifzNdKn7bJVL
         AY+A==
X-Gm-Message-State: AA+aEWYZSpWfz2HvT1Dm8k1b4ltVh1IhIN6FxUUFc037kuMZzn4r5/Ll
        iiqJue1ZNSstxn4tYC4/bDM/9w==
X-Google-Smtp-Source: AFSGD/WHzn9V+CCqyaajTv/VemZsaYQ8YKyvB8Ewb5gxL/nL8Zh8laZq7M1gyzkpJmbnxcZFKzvbYA==
X-Received: by 2002:a17:902:a988:: with SMTP id bh8-v6mr10136770plb.163.1542870474353;
        Wed, 21 Nov 2018 23:07:54 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 64sm23052414pff.101.2018.11.21.23.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 23:07:53 -0800 (PST)
Date:   Wed, 21 Nov 2018 23:07:51 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: Re: [PATCH v5 5/5] arm64: dts: qcom: sdm845: Add USB PHY lane two
Message-ID: <20181122070751.GK2225@minitux>
References: <20181026173544.136037-1-evgreen@chromium.org>
 <20181026173544.136037-6-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026173544.136037-6-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26 Oct 10:35 PDT 2018, Evan Green wrote:

> Add the second lane registers for the USB PHY, now that the
> QMP phy bindings have been updated. This way the driver can stop
> reaching beyond its register region to get at the second lane.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
>  - Removed erroneous fixup for USB UniPro PHY, which is not dual lane (Doug)
> 
> Changes in v2: None
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 9c72edb678ec..ff2db36ec4fa 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1188,10 +1188,12 @@
>  				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
>  			reset-names = "phy", "common";
>  
> -			usb_1_ssphy: lane@88e9200 {
> +			usb_1_ssphy: lanes@88e9200 {
>  				reg = <0x88e9200 0x128>,
>  				      <0x88e9400 0x200>,
>  				      <0x88e9c00 0x218>,
> +				      <0x88e9600 0x128>,
> +				      <0x88e9800 0x200>,
>  				      <0x88e9a00 0x100>;
>  				#phy-cells = <0>;
>  				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> -- 
> 2.16.4
> 
