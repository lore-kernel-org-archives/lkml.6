Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58A8C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F83206B2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bofWJkmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F83206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeHUCcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 22:32:54 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39089 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbeHUCcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 22:32:53 -0400
Received: by mail-pl0-f66.google.com with SMTP id w14-v6so7846289plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 16:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GUGKXAAChqCwCb0toU+XVme1Dd4ojfXDjxe1s8eRMkI=;
        b=bofWJkmgADwHdsjRfrBscqA7yJjf8uxz6Scpm9ViCmpol6K5/GIzfBeAShw1xRv6uW
         SA5U4ezS88BgbS2V9Cu8bzL6XawiplGsP7KOE10TqndiCz/cn6C2CkbhRXX85CrO2XLO
         0kFOFs35uiqAqV5WPx6qXG+hTTzq8XSc8b+fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GUGKXAAChqCwCb0toU+XVme1Dd4ojfXDjxe1s8eRMkI=;
        b=gomV4+5tB81NmsU1f/VlPlYnFjo3xvnmmZnsUUNgnf2XjSGjCjtGKK5cx1k0rtk2Ui
         JhtvV0qzcB7UW1ztX78L4ZYrtuHDOW9Ol5d0fFBrSd8y/S7DsfCyscP+Iot6hCBnT0Ln
         RXyRKkZYbsGdwD17uCU43rHzBqLYGHndBhUjaTxyu5+GDYChuHPLV+67rVTA25pishJJ
         iqLAPbsTXM60lb6PmKW+W4n+9GaYKEEu5yLgWdkkcvTHjLT8m4eMfRROUIPzUex8DzGk
         KKN6UfT6B2YulMDLjUJozWTe27v6Z156ClAdWXsfOnUMV7Ptf/1vIGLl2aGzsRRT6KoE
         pwLw==
X-Gm-Message-State: AOUpUlHie+zBm+mhEraqw2lqRYXr1emUiLGkDGFfAjd1CYvArenIXLGN
        vsmR2HE/kyke5I8Mbc1fVRaRbg==
X-Google-Smtp-Source: AA+uWPwuvKuiVjkKN6oKt2BGNt34z6t0AKOBvdFiw9UXMyK32TXZloton7RIsM+YdmGsyRr0sUc0Qw==
X-Received: by 2002:a17:902:227:: with SMTP id 36-v6mr48112313plc.103.1534806916320;
        Mon, 20 Aug 2018 16:15:16 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l27-v6sm18974533pfi.180.2018.08.20.16.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 16:15:15 -0700 (PDT)
Date:   Mon, 20 Aug 2018 16:19:01 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     marc.zyngier@arm.com, sboyd@kernel.org, evgreen@chromium.org,
        linus.walleij@linaro.org, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        andy.gross@linaro.org, dianders@chromium.org
Subject: Re: [PATCH RESEND v1 1/5] dt-bindings: pinctrl: add wakeup capable
 GPIOs for SDM845
Message-ID: <20180820231901.GA5603@tuxbook-pro>
References: <20180817191026.32245-1-ilina@codeaurora.org>
 <20180817191026.32245-2-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817191026.32245-2-ilina@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17 Aug 12:10 PDT 2018, Lina Iyer wrote:
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
[..]
> @@ -155,11 +166,52 @@ Example:
>  	tlmm: pinctrl@3400000 {
>  		compatible = "qcom,sdm845-pinctrl";
>  		reg = <0x03400000 0xc00000>;
> -		interrupts = <GIC_SPI 208 0>;
>  		gpio-controller;
>  		#gpio-cells = <2>;
>  		interrupt-controller;
>  		#interrupt-cells = <2>;
> +		interrupts-extended = <&intc GIC_SPI 208 0>,
> +			<&pdc 510 0>, <&pdc 511 0>, <&pdc 512 0>, <&pdc 513 0>,
> +			<&pdc 514 0>, <&pdc 515 0>, <&pdc 516 0>, <&pdc 517 0>,
> +			<&pdc 518 0>, <&pdc 519 0>, <&pdc 632 0>, <&pdc 639 0>,
> +			<&pdc 521 0>, <&pdc 522 0>, <&pdc 523 0>, <&pdc 524 0>,
> +			<&pdc 525 0>, <&pdc 526 0>, <&pdc 527 0>, <&pdc 630 0>,
> +			<&pdc 637 0>, <&pdc 529 0>, <&pdc 530 0>, <&pdc 531 0>,
> +			<&pdc 532 0>, <&pdc 633 0>, <&pdc 640 0>, <&pdc 534 0>,
> +			<&pdc 535 0>, <&pdc 536 0>, <&pdc 537 0>, <&pdc 538 0>,
> +			<&pdc 539 0>, <&pdc 540 0>, <&pdc 541 0>, <&pdc 542 0>,
> +			<&pdc 543 0>, <&pdc 544 0>, <&pdc 545 0>, <&pdc 546 0>,
> +			<&pdc 547 0>, <&pdc 548 0>, <&pdc 549 0>, <&pdc 550 0>,
> +			<&pdc 551 0>, <&pdc 552 0>, <&pdc 553 0>, <&pdc 554 0>,
> +			<&pdc 555 0>, <&pdc 556 0>, <&pdc 557 0>, <&pdc 631 0>,
> +			<&pdc 638 0>, <&pdc 559 0>, <&pdc 560 0>, <&pdc 561 0>,
> +			<&pdc 562 0>, <&pdc 563 0>, <&pdc 564 0>, <&pdc 565 0>,
> +			<&pdc 566 0>, <&pdc 570 0>, <&pdc 571 0>, <&pdc 572 0>,
> +			<&pdc 573 0>, <&pdc 609 0>, <&pdc 610 0>, <&pdc 611 0>,
> +			<&pdc 612 0>, <&pdc 613 0>, <&pdc 614 0>, <&pdc 615 0>,
> +			<&pdc 617 0>, <&pdc 618 0>, <&pdc 619 0>, <&pdc 620 0>,
> +			<&pdc 621 0>, <&pdc 622 0>, <&pdc 623 0>;

I would expect that there are about 80 WARN_ON() hit in the irq code
when you boot mainline with this. Have you tried that?


Looks reasonable otherwise.

Regards,
Bjorn
