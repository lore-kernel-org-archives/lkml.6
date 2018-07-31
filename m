Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C823C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3E220841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qf74dvWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3E220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbeHAALJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:11:09 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41895 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732244AbeHAALJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:11:09 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so7785272ply.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 15:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tmbtfbzI6puP3QSpGYOfeeH32qqFkX4qrmc2EsmofsM=;
        b=Qf74dvWiX9R3H0sqkdWIbUozChe8XjyxRtz7Mb4MMHrGydsuMAYtufmO3sABYjiS/J
         WBbSba1iEslQMh6bFRI5qKhBcRtrD+X+qHzb648LU+449O0SX5OSbTfAOy/9ZMI7Rqav
         E8vbFgwiG8XGqbbqzzYxS4staSU/pAVlbpS0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tmbtfbzI6puP3QSpGYOfeeH32qqFkX4qrmc2EsmofsM=;
        b=F0+bTqy3eKRaNQO6+OahqU1s0FNCSeX4WNLfpXJQ/U2rSfAfU4h+uFuRyCq2H2BHnZ
         94DQlhcbIif6CJn+zZZtHLgb0FKsyf1mWd8MQBbeiDzNnC1pSF1m3hbwNfsA2shwT/oW
         8YamRxw28cZQwO3jOpcMoTfGy60tbJ2FFUDxAlHj+EsRti0HR0ra5/p+JW0Jr1VLLg89
         nH4fSpmy0OwdCGscor9+1S9AeO2JuJ37c+RbAik+mCmAt8uDURM4R+xd/yPRcSwzZQnR
         bSWt00lmUdebN0CKdjDhc7cpGXbPvaK53qzM2t3O1GGtJomuOLjSyMJWLakrg2HggbgR
         NKBA==
X-Gm-Message-State: AOUpUlG1yFp0IPK/xufuS0Go3G7x+yydNofXJ+dlIMQG9DalgTILCzyx
        +TsdnlJPblg0yt1fxy03Wo7P6Q==
X-Google-Smtp-Source: AAOMgpeTe4l2D/5OeNk1/6/XcYRNDtRm913YYwglZjejeljMztHoo8oGLLpPlaTW4z8alMs+XvNeJg==
X-Received: by 2002:a17:902:70cc:: with SMTP id l12-v6mr22328486plt.132.1533076119830;
        Tue, 31 Jul 2018 15:28:39 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 2-v6sm27791062pfs.58.2018.07.31.15.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 15:28:39 -0700 (PDT)
Date:   Tue, 31 Jul 2018 15:29:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhushan Shah <bshah@kde.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH] ARM: dts: qcom: msm8974-hammerhead: increase load on l20
 for sdhci
Message-ID: <20180731222928.GA24465@builder>
References: <20180709091628.GA8854@orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709091628.GA8854@orion>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Jul 02:16 PDT 2018, Bhushan Shah wrote:

> The kernel would not boot on the hammerhead hardware due to the
> following error:
> 
> mmc0: Timeout waiting for hardware interrupt.
> mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> mmc0: sdhci: Sys addr:  0x00000200 | Version:  0x00003802
> mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000200
> mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000023
> mmc0: sdhci: Present:   0x03e80000 | Host ctl: 0x00000034
> mmc0: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
> mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
> mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
> mmc0: sdhci: Int enab:  0x02ff900b | Sig enab: 0x02ff100b
> mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
> mmc0: sdhci: Caps:      0x642dc8b2 | Caps_1:   0x00008007
> mmc0: sdhci: Cmd:       0x00000c1b | Max curr: 0x00000000
> mmc0: sdhci: Resp[0]:   0x00000c00 | Resp[1]:  0x00000000
> mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> mmc0: sdhci: Host ctl2: 0x00000008
> mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x70040220
> mmc0: sdhci: ============================================
> mmc0: Card stuck in wrong state! mmcblk0 card_busy_detect status: 0xe00
> mmc0: cache flush error -110
> mmc0: Reset 0x1 never completed.
> 
> This patch increases the load on l20 to 0.2 amps for the sdhci
> and allows the device to boot normally.
> 
> Signed-off-by: Bhushan Shah <bshah@kde.org>
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> index 4dc0b347b1ee..c2dc9d09484a 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> @@ -189,6 +189,8 @@
>  						regulator-max-microvolt = <2950000>;
>  
>  						regulator-boot-on;
> +						regulator-system-load = <200000>;
> +						regulator-allow-set-load;
>  					};
>  
>  					l21 {
> -- 
> 2.17.1
> 
