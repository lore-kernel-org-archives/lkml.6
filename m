Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405FEC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E750D21EF7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bcYL5vFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E750D21EF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeHIVmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:42:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45593 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbeHIVmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:42:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id i26-v6so3280678pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XGeGvyD9ApP6OtzOf6dkb1La+a2MQWPmi8gdh/b4ItQ=;
        b=bcYL5vFu2crTxhutCzacj1u6uprmqKTsWzv4uXJeWbDGuSofxLBR3DgsF9z6LV4Rz3
         MISaeqnUOot0SZavyyB2eG3nC+mIUe5s12XV5hQnNCtXEONinh9OHc0ytVe4x4eZwG7Q
         sM3o4vwHIXQcPfxMYw9cSlSF1vQs7JhP1kFaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XGeGvyD9ApP6OtzOf6dkb1La+a2MQWPmi8gdh/b4ItQ=;
        b=BtJwvTwicc1Q54EB95YnCvbxxb6w9HAMfpabc6wzVttRLyVnXbW3/cUQjPBmCdqEcY
         mOQ6h1vlwGGGA1XpIbDdRQbb16orIo33yAM16fNNuoat8/Zwgk7OVuU9rIWCWYf0xthQ
         aA9dDhtqqDcatCie1n9SMWN1f6pxNc3dSzUtr8S2fP2kS2hIbSM7ja+Ex60xk0ck5oSM
         TvUq6WTLz655gmWG1G3UOSDRQmuFHvHVg2bt1UtYgLCFP2g1px/nvpu7X256zQ1VCfyX
         XXt0oS46OsSxt0FEsh01waLQDeWM4e/11EYyh5qYQ8TTM45HvPolIAeXmwrvzGTK1fSp
         bP5g==
X-Gm-Message-State: AOUpUlHeRLGyBe43U7/UFsl8VPYreVjn+JiT2XAwdauq7qo71OWZO4Ct
        5+1PUiY1dOgbJP6vJ7fxNThtHA==
X-Google-Smtp-Source: AA+uWPykiJQ/Zqi66dr5Z9Z85Ejs6h7F1pOt8KzRr5FCj8etptuxYX4ZK7GZT7Ep6druTAd47vfM3g==
X-Received: by 2002:a62:c00c:: with SMTP id x12-v6mr3669750pff.216.1533842191950;
        Thu, 09 Aug 2018 12:16:31 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id z5-v6sm9574978pfh.83.2018.08.09.12.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 12:16:31 -0700 (PDT)
Date:   Thu, 9 Aug 2018 12:16:30 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 02/10] dt-bindings: thermal: Fix a typo in
 documentation
Message-ID: <20180809191630.GJ160295@google.com>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <08b528ddc26adcb57539b1ac9d352850d7d80bfb.1533815718.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08b528ddc26adcb57539b1ac9d352850d7d80bfb.1533815718.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:02:34PM +0530, Amit Kucheria wrote:
> c(1) + x(1) was actually meant to be c(1) * x(1).
> 
> While we're at it, add some brackets to make it nicer to read.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index cc553f0952c5..751104213d08 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -152,7 +152,7 @@ Optional property:
>    Elem size: one cell	the sensors listed in the thermal-sensors property.
>    Elem type: signed	Coefficients defaults to 1, in case this property
>  			is not specified. A simple linear polynomial is used:
> -			Z = c0 * x0 + c1 + x1 + ... + c(n-1) * x(n-1) + cn.
> +			Z = (c0 * x0) + (c1 * x1) + ... + (c(n-1) * x(n-1)) + cn.
>  
>  			The coefficients are ordered and they match with sensors
>  			by means of sensor ID. Additional coefficients are

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
