Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6832C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F38F20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfS9n4Rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F38F20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeICKm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 06:42:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44650 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeICKm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 06:42:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so8207010pff.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 23:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q9mXbbliqPsUp2kuAMJvTavWwBLslfpeh+Dx/aJAKb8=;
        b=dfS9n4RbsEweMa4ZOzsZqTnzDBzdyFNSSIvMiQ8TxFso2Csya6PLgRjOdaAPGjRQAf
         r5k6NpL/LvZ+DldF7KfeBU8/ga9Du0dwin5a0kBieohDpPgnmsEXxs4kXXF7zmaubPE7
         GSyNOYYYyXtOBLOnTx1aAXhLLTr+N88VAVdCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q9mXbbliqPsUp2kuAMJvTavWwBLslfpeh+Dx/aJAKb8=;
        b=sEu8CoGC401+7M+zla0dat3li4owG81LA5u6NIJb+MZQ3d+LHTHGtkpi+kJHbCwBwo
         szXshQ0bcWvQ+pTn9RzfaQLtmZY9X/9niNgPandQHIIgTkHbt6wlzSCqnayXgNa5DSjL
         Gbw/84/rLCiTN5ySAPs89IG9T9LYIVCUiJaMAfiIgSNf7b57HS9xVRqvTrRo2M7068rg
         gh6U02pfOdx1uiIWBDPO2w6mFT5AAc/g1nXnLsmPRevXppYkNJLfnKerLtbCQpceisiK
         kilu6qMbdlczyY5ioIMAhX6n/wiubcjLMwQgLHeRz4ay3LQ2FMyLpVraWpX3kQS5GROn
         eelg==
X-Gm-Message-State: APzg51C9tNinCssN+Dyen8CRJMHzo0Bv7uBtZjHZfVyJVn5Kfzdr0Kxl
        BD7rCjqE3fACkKLaEjuRhvac1w==
X-Google-Smtp-Source: ANB0VdZTlKx3d/w9VaYzvpS6SBCmO8IjXvcVjdDqCJkYvYyX+zlv7WBlZFECg/QwA03WSEv7dRk3Zw==
X-Received: by 2002:a62:bd4:: with SMTP id 81-v6mr28088161pfl.67.1535955857762;
        Sun, 02 Sep 2018 23:24:17 -0700 (PDT)
Received: from localhost ([122.171.76.41])
        by smtp.gmail.com with ESMTPSA id 193-v6sm9499349pgh.47.2018.09.02.23.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 23:24:17 -0700 (PDT)
Date:   Mon, 3 Sep 2018 11:54:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH v2] ARM: dts: spear: fix stmpe811 interrupt properties
Message-ID: <20180903062415.xlzipo3mvpcorkk4@vireshk-i7>
References: <20180814073949.27392-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814073949.27392-1-marcel@ziswiler.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-08-18, 09:39, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> The property "irq-over-gpio" simply does not exist (this is nowadays
> actually auto detected) and the property "irq-gpios" is actually called
> "irq-gpio".
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Fix commit message as pointed out by Viresh.
> 
>  arch/arm/boot/dts/spear320-hmi.dts | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/spear320-hmi.dts b/arch/arm/boot/dts/spear320-hmi.dts
> index 0d0da1f65f0e..d2d1fe944407 100644
> --- a/arch/arm/boot/dts/spear320-hmi.dts
> +++ b/arch/arm/boot/dts/spear320-hmi.dts
> @@ -241,8 +241,7 @@
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					reg = <0x41>;
> -					irq-over-gpio;
> -					irq-gpios = <&gpiopinctrl 29 0x4>;
> +					irq-gpio = <&gpiopinctrl 29 0x4>;
>  					id = <0>;
>  					blocks = <0x5>;
>  					irq-trigger = <0x1>;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
