Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB03C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5D621566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gyjDh/X0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5D621566
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeHBVbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:31:53 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35365 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbeHBVbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:31:53 -0400
Received: by mail-pl0-f68.google.com with SMTP id w3-v6so1488012plq.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 12:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VIn2ZnOBIwBwpBaYvnn8RWhCKxQW+3S/xGRtwr+OT40=;
        b=gyjDh/X0Hw16nOkd9s1FuXhuOMJw+DdyWDGbknxPRIu14iF6hyafrtIYhVwSP1+tEd
         GUVfv39VDxDRpuy5IpCI7GKI+IAPMH4U+msiFB+/EoNmbyuB6VUO+StLHf2C6VROOuRz
         LXJ+C1BYNB4uPWNqqPivOGKS4PqL/GSiVesVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VIn2ZnOBIwBwpBaYvnn8RWhCKxQW+3S/xGRtwr+OT40=;
        b=A3fkAzHa7/kZr3v+imD0K0AwIUIN5LoAa4FO7Twf/px75Oxju/BqEU9t2Q2RxvFJTy
         cgVK7b+nLiUM2xTFWaul6NOQgWa8ZKnt3wINqsrh0SQ2Di2AOwWZmtwpTULonXRrpsqY
         ESclVzyGLpv1Se3QgOWy6DaIh5xRvmZQnh7+iDdFWRDWY8lMce18oLb1k31iIDytAFzW
         9bwDKi0krcFR0jVOEMnRb+VA9ZeGlkhbeJmUkYhL16NmsHHQ6vBVrdPXmpoxqLeZKEl5
         NmhG20XOHMYi6j+2zICPJcyM9sTLW8yXg0QhweIFJYowZmeqvXtyNEIg0GbY4KzK+Uo3
         mAGg==
X-Gm-Message-State: AOUpUlHM95PgrsAQn4tOm1tHo0XIp5Ygkbfiy0Q5JNsTkqxvxhssklJZ
        Tny9ZZAFMClgH79iI0XrXHRxdQ==
X-Google-Smtp-Source: AAOMgpefu2oRF1MIQhEbhNLEk35ESIH5G/ZJLZCS+9XW54BtwjkqdYa395DEe8ALv3ncUTWnKw7l7w==
X-Received: by 2002:a17:902:9a4b:: with SMTP id x11-v6mr711447plv.342.1533238758738;
        Thu, 02 Aug 2018 12:39:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id j191-v6sm6093572pfc.136.2018.08.02.12.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 12:39:18 -0700 (PDT)
Date:   Thu, 2 Aug 2018 12:39:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v13 1/7] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
Message-ID: <20180802193917.GP68975@google.com>
References: <20180802190732.4811-1-bgodavar@codeaurora.org>
 <20180802190732.4811-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180802190732.4811-2-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 12:37:26AM +0530, Balakrishna Godavarthi wrote:
> This patch enables regulators for the Qualcomm Bluetooth wcn3990
> controller.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes in v13:
>  * Segregated optional and required properties for wcn3990.
> ---
>  .../bindings/net/qualcomm-bluetooth.txt       | 29 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index 0ea18a53cc29..824c0e23c544 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -10,12 +10,25 @@ device the slave device is attached to.
>  Required properties:
>   - compatible: should contain one of the following:
>     * "qcom,qca6174-bt"
> +   * "qcom,wcn3990-bt"
> +
> +Optional properties for compatible string qcom,qca6174-bt:
>  
> -Optional properties:
>   - enable-gpios: gpio specifier used to enable chip
>   - clocks: clock provided to the controller (SUSCLK_32KHZ)
>  
> -Example:
> +Required properties for compatible string qcom,wcn3990-bt:
> +
> + - vddio-supply: VDD_IO supply regulator handle.
> + - vddxo-supply: VDD_XO supply regulator handle.
> + - vddrf-supply: VDD_RF supply regulator handle.
> + - vddch0-supply: VDD_CH0 supply regulator handle.
> +
> +Optional properties for compatible string qcom,wcn3990-bt:
> +
> + - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
> +
> +Examples:
>  
>  serial@7570000 {
>  	label = "BT-UART";
> @@ -28,3 +41,15 @@ serial@7570000 {
>  		clocks = <&divclk4>;
>  	};
>  };
> +
> +serial@898000 {
> +	bluetooth {
> +		compatible = "qcom,wcn3990-bt";
> +
> +		vddio-supply = <&vreg_s4a_1p8>;
> +		vddxo-supply = <&vreg_l7a_1p8>;
> +		vddrf-supply = <&vreg_l17a_1p3>;
> +		vddch0-supply = <&vreg_l25a_3p3>;
> +		max-speed = <3200000>;
> +	};
> +};

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
