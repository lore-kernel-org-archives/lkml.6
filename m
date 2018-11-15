Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3280BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE43A20883
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NeAKhkX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE43A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeKPFZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:25:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33627 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeKPFZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:25:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so6803278pgu.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YurAh5mAhfpuUB3OFE0dJ5x3x8KCJW8RmlRufbiVExY=;
        b=NeAKhkX3QiwNNqJpLPYhDNMDCjnpan6fGkJOJtAl5apyXIT7AwPpjA6vzvruMr8uyQ
         jRkLImjAHsCI5+li13uu0z9a6fGcZQvMoacUQMJCngCUc3yq5rGyln8iOIwh/XXHLrbe
         HpFcyqHEBE/bTeVbAefAoorbhl46S0H1RCkb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YurAh5mAhfpuUB3OFE0dJ5x3x8KCJW8RmlRufbiVExY=;
        b=Ev/vFasfoPDg44ad7Hk2DZKCu4bz0DIpeAZjsjsdaj37PfH6s4EgOETLbE92T+oJkC
         wB8oNd1q/7/v47tBGAvLWbA7tcHvryi2nreyArLlAvOMZq7JgYGR3tzqMs8ElvGVeX9D
         Knjk6Mzbt9e70mxSB6/H2KFL+9Ojn6AVnzOu/CD6s19rn/0f5n67xvypiKZ8lcxKQ4MX
         ZdpOLvhL+wVtQnkoO2ICeIaY7sC623hbcBsF1dg8egvSczB4PDUtcczeUoiKxvbVQqtq
         PP75HYoeFXXgF5HyTkbZl2dtsGXMROH/EAO5sXO0GG+nj9n2VkOfqLRcX1H5seS4L5sM
         O+SQ==
X-Gm-Message-State: AGRZ1gJj+r3eYtDrLkqPitBeDajBEv1M0KyQJz0D9cTBM/xYoTIZNsLM
        bk3YxmJXwVTl4+72L0L0p7EM2w==
X-Google-Smtp-Source: AJdET5dc+0tUh9jTXXyFlqVDdjEfgDNh0OX+FJG0C6fPBPx4ElbEiTXI7OEzXiBz535bYL9gneiE4w==
X-Received: by 2002:a63:cf56:: with SMTP id b22mr6622176pgj.336.1542309387628;
        Thu, 15 Nov 2018 11:16:27 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m198sm27774400pga.10.2018.11.15.11.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 11:16:26 -0800 (PST)
Date:   Thu, 15 Nov 2018 11:16:23 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: msm8998: Add SDC2 control pins
Message-ID: <20181115191623.GK10915@tuxbook-pro>
References: <1542302291-6864-1-git-send-email-jhugo@codeaurora.org>
 <1542302291-6864-4-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542302291-6864-4-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15 Nov 09:18 PST 2018, Jeffrey Hugo wrote:

> The SDC2 control pins are typically used to manage sleep.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8998-pins.dtsi | 78 ++++++++++++++++++++++++++++++

Rather than adding a -pins file, add the pinctrl states the individual
dts(i) directly.

>  arch/arm64/boot/dts/qcom/msm8998.dtsi      |  2 +
>  2 files changed, 80 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8998-pins.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8998-pins.dtsi
> new file mode 100644
> index 0000000..a22abf9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8998-pins.dtsi
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
> +
> +&tlmm {
> +	sdc2_clk_on: sdc2_clk_on {

Use _ in labels, - in node names.

> +		config {

You don't have to put the pinctrl state properties in an additional
subnode anymore, so feel free to remove the extra subnode level.

> +			pins = "sdc2_clk";
> +			bias-disable;           /* NO pull */
> +			drive-strength = <16>;  /* 16 MA */

Please push electrical properties to the board dts instead of the
platform one, as they might be board specific.

> +		};
> +	};

Apart from this the patch loogs good.

Regards,
Bjorn
