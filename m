Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE0AECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C0120834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FG/AC4Xr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C0120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeJYS42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:56:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53656 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeJYS42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:56:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id l26-v6so968503wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 03:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=F7IVSazowHUBrL5M2zKnkNpecKKgG+YiCxDfdV/9uj4=;
        b=FG/AC4XrjawLfcygaInCKJwEAav7nv0v+tqcBki6oxLik5uVcKlOp4zCakR1n11w1C
         skbIXfVjUyqWOf6a6rA/AnC3LKomN1tU8bFCEX1UV7V0nOo54bKXNnXB7H+bQIN9hiAU
         a1x60RqgQFIxliDMbjFZ9rIeqzHetywXbyCKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=F7IVSazowHUBrL5M2zKnkNpecKKgG+YiCxDfdV/9uj4=;
        b=MnoH4uXeH0CFBdTnaXTOFU332ZvZfj06/tYyKfW08H8xbECWSl6uHCwnjL1wFlnGi3
         DE5cKjr+8BAvLv7sH/J1qUCRecp51/G9vak98p6/l037Nu2Ft57jsAxjDGDfiF1lBrDI
         G5hKFmIsdDLdqtfvDm25lGVoOuVpkp0Onb9WKGgz8+JXgDgzdFHtBmYJvpsyAJdM9Tkv
         VDUtuXs1wEZqcx8/agAnwRwCaL+XfxPMeAzlaXYHmQMrMVCHwQahh3vs1nx3FSqmm/qH
         RSiYHi9hZDp9YOi7xoOHWpjbhzXs/1DWk9/rIieZ+zWu3AgBtuM++SvbhR1vAZEEN3/v
         GyZw==
X-Gm-Message-State: AGRZ1gKd3Zps73jZDxG3OfxdlziN/zj2+huoaGG3mANOilde6EptCkwu
        LBk/girjWlK2Sgh1AFuAqOEFwA==
X-Google-Smtp-Source: AJdET5ePZA/3SssiJXkxXGotzX15bnttjCnHlylKuVPkHVGm1NNZ3BAeDJvt/SdckAKQm2c/JwjpuA==
X-Received: by 2002:a1c:6655:: with SMTP id a82-v6mr1319383wmc.10.1540463059810;
        Thu, 25 Oct 2018 03:24:19 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id q77-v6sm900376wmd.33.2018.10.25.03.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 03:24:19 -0700 (PDT)
Date:   Thu, 25 Oct 2018 11:24:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 11/11] mfd: axp20x: Add supported cells for AXP803
Message-ID: <20181025102416.GU4939@dell>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-12-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181023185330.10472-12-oskari@lemmela.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018, Oskari Lemmela wrote:

> Parts of the AXP803 are compatible with their counterparts on the AXP813.
> These include the GPIO, ADC, AC and battery power supplies.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/mfd/axp20x.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
