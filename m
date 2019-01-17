Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6079C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9805820657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XV5xvWcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfAQGhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:37:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33411 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfAQGhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:37:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so3996787pgu.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 22:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BRoWq6QA3qXs2sGySJTI8itioTQ0G12j79FEeArL7fQ=;
        b=XV5xvWcGUIX8XKEYjooW+BSHWzyZuau3H+TQByT5K3DnTUPMysFCzWcM9RL+OJUr8o
         0NlUm8C1TxouVDx52aKJu2u1W2dz8en6QFJp6hhXtydYiZxMLgMyr+uE4GCSaiI8Dlgu
         ovGyvY6g7B9csf+ZFIoL4fpAMpot6JqZVBaVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BRoWq6QA3qXs2sGySJTI8itioTQ0G12j79FEeArL7fQ=;
        b=OjysLQH7l+YxRA/A8nDrxZZTyUE+GsyZqqipRdofkFaGYd7zaJxAyJe0JAHc/y3KHL
         Dod+9og6E4FpvINM8BIYs7DKez1jt9bU8BEOxbgbasUIlrvN96ZhG5AfcVrl0+yH5umr
         RR0Fdh/PFFWBxKN94fE+lOB++pUKbnrhcgOI29nfwoi2pFC+ilE5wGvx4sPI7fz8FktG
         eSKmnxbfevr8d2nMro8CAslqsKDix7BKXdfundhrgFowkisbVjTDM6QsTB2/PaX6BLQv
         zxy8syovqogEwQxZUD6mCr/SGqhymTtf5fFN+VAsYlIrk8zuJO7OEoskGmZJmvYhwJWj
         PXaQ==
X-Gm-Message-State: AJcUukeKCRPQLNSxxcRk7t0/m3yhXBnaaBg5zm7pC+mqsaiayU112BKk
        nRHeA61WbuPhlld5NP1Z6agCoQ==
X-Google-Smtp-Source: ALg8bN6YmqkH+B0NgtT3Hu83Xh8ALxL68xcPoX2x8QAgbHE6sowX540mNSC2NGyLDFrV7gI/0eZdkw==
X-Received: by 2002:a62:6143:: with SMTP id v64mr13729570pfb.142.1547707039115;
        Wed, 16 Jan 2019 22:37:19 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n21sm1072121pfg.84.2019.01.16.22.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 22:37:18 -0800 (PST)
Date:   Wed, 16 Jan 2019 22:36:38 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com,
        vkoul@kernel.org, niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 13/13] arm64: defconfig: Enable HFPLL
Message-ID: <20190117063638.GI25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-14-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545039990-19984-14-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Dec 01:46 PST 2018, Jorge Ramirez-Ortiz wrote:

> The high frequency pll is required on compatible Qualcomm SoCs to
> support the CPU frequency scaling feature.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5c2b1f6..da390aa 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -615,6 +615,7 @@ CONFIG_MSM_MMCC_8996=y
>  CONFIG_MSM_GCC_8998=y
>  CONFIG_QCS_GCC_404=y
>  CONFIG_SDM_GCC_845=y
> +CONFIG_QCOM_HFPLL=y
>  CONFIG_HWSPINLOCK=y
>  CONFIG_HWSPINLOCK_QCOM=y
>  CONFIG_ARM_MHU=y
> -- 
> 2.7.4
> 
