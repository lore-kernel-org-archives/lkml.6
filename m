Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B028EC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6996F24614
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5RMFOvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6996F24614
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933609AbeFVQvm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:51:42 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36264 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754385AbeFVQvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:51:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id a12-v6so3490158pfi.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 09:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RteV/a3EYTSzOTVLB4TIlGK8GTZj2dkhBQG2q3bDobM=;
        b=K5RMFOvZvQYPP3A8LWrHd32UaKieLRfOpI0MIcDbEGlNgHHIBREswHAyucOPcMbDi9
         svZS6euP+qalQ+oD6GCl2o6Xj3TKZXhByIn0e+4yJyZjQOCuz8uIYmw1+WEB2eDZ3su6
         0aXZaoVHcAvYCvzfOymvpjwX7SSmWBvTV4wzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RteV/a3EYTSzOTVLB4TIlGK8GTZj2dkhBQG2q3bDobM=;
        b=b0nqgSt3ZuEiLjzgNKLKhwKxpD+MZcWygESi714JWm1Re8xu7TKxuemN71ee1CcCy4
         qOT7wW3uPrwVoD4DP7d5z/YvOwLEMhARdKN0zYNEka3Eb+/FxS9s1kovYji6sVCSoJid
         myZigkeUDmTSZYoxakm+bf3PKOKSzQhavTIhsVset36yMryb/dT8hi/ketrPgKzno4js
         VaFBQVAK6Qu/BwtFP6ErMW+PFun8RzuwywzORGUG9h3DRBIMPdP+G3eNBdmkUqz2JlgO
         QEeQqx6sRO8eTAJzb+08snUpxE2M6MpXO49PU61/6qtzj+nXrSJ3ntwSKYRxajwNsHhJ
         lZ4Q==
X-Gm-Message-State: APt69E2ihF+bAlFdRFOEr7nHGKfOQ/+N132zRbPbg/xcZDzjcU037Lvd
        ju+cUJRIdiMnvepKQpEil8pkuw==
X-Google-Smtp-Source: ADUXVKLTjX8LrRLtZbTnGsbnkM9v92jS52ybXUswCt63SESfp3YLizUFXwcnHUSyM4HlyiL6WzGDCw==
X-Received: by 2002:a65:6303:: with SMTP id g3-v6mr2155788pgv.424.1529686298154;
        Fri, 22 Jun 2018 09:51:38 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d22-v6sm20265259pfk.126.2018.06.22.09.51.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 09:51:37 -0700 (PDT)
Date:   Fri, 22 Jun 2018 09:51:35 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     andy.gross@linaro.org, kramasub@codeaurora.org, wsa@the-dreams.de,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: qcom: Fix default clock-freq for
 qcom,geni-i2c
Message-ID: <20180622165135.GB25607@builder>
References: <20180613175011.217585-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613175011.217585-1-dianders@chromium.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13 Jun 10:50 PDT 2018, Douglas Anderson wrote:

> In an early version of the I2C patch that was posted to the list the
> default I2C frequency (if none was specified) was 400 kHz.  There was
> debate on the list and we decided that it would be more consistent
> with the rest of i2c if we defaulted to 100 kHz.  ...but we never
> updated the bindings.  Let's fix this.
> 
> NOTE: since the i2c driver itself hasn't actually landed yet and the
> SoC here is very new it seems terribly unlikely that anyone was
> relying on the old 400 kHz number, so I'll assume this is an OK
> "incompatible" device tree change.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> index d330c73de9a2..68b7d6207e3d 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> @@ -39,7 +39,7 @@ Required properties:
>  
>  Optional property:
>  - clock-frequency:	Desired I2C bus clock frequency in Hz.
> -			When missing default to 400000Hz.
> +			When missing default to 100000Hz.
>  
>  Child nodes should conform to I2C bus binding as described in i2c.txt.
>  
> -- 
> 2.18.0.rc1.244.gcf134e6275-goog
> 
