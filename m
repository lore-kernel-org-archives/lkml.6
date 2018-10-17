Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9AAC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB02F214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Or3Av8ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB02F214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeJQLV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:21:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38236 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbeJQLV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:21:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id f29-v6so12476207pff.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 20:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c2NGBkleLooUmiW44+p0aReBMQJapUb9eKrSpvpqdLY=;
        b=Or3Av8axUrV4bBZsq8J9dfjAfolYL9nbYK4wT7+9BB8yO0cKv0RM28Lz/xzxgffmA/
         vG46WJQU5ASVNlao0Nk2cnDEGg6tsAUI5dKp9Jqe+De7vP6gDu3Dm/rH7pze6mZmwNCy
         D71Gfe1Isz8Ji4K+5hM9prGBciEKOUICf6i5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c2NGBkleLooUmiW44+p0aReBMQJapUb9eKrSpvpqdLY=;
        b=I3q9NDZAynwjo2I0gEk43l/gGZL8m6ew6yBXAWv6qVlJD4cLuE1vnTm1M9S08F9DmV
         8bRTDevDNl5QMjLPcKHaOcYAO9aB3ieaJb+Zhtnl5h2sMIedP7riurzhrb8lWqTF7uBX
         rUTrO3GHwhizaPvowdoWyPnLGLIM8k7Ct+wT4veaNkXvp7NKBTvFEOr88W/2sDAZojRM
         Euano6E8F4N7Qm3C2FLqkTW2qVCnsC7aZghT5IInpB/nZaQWx1iZ/66XPZ0EHD3RvpP5
         MSG0PByK2OYV2ietjd8btPg//A+KnES2CSpU25tfEDUDCmbl6ioHOUIL1kQOuYxJ5tXZ
         WA5w==
X-Gm-Message-State: ABuFfogYS40j7gHUNZIztdUGHofTvYC7IbfqAOiyb+x91axW8C+EQsWy
        Zn1G/WfjA/zMFi4wTNanajNA
X-Google-Smtp-Source: ACcGV61l82DxE/pDVALljfjIVxQgnBCBMhE2kiv/OPYPmejIER83dRfp97JdbmuCWUKmGRzGzruuaQ==
X-Received: by 2002:a63:3181:: with SMTP id x123-v6mr386739pgx.83.1539746874866;
        Tue, 16 Oct 2018 20:27:54 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6305:1a9d:4c38:eda8:7f99:11d3])
        by smtp.gmail.com with ESMTPSA id 187-v6sm24701183pfu.129.2018.10.16.20.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 20:27:54 -0700 (PDT)
Date:   Wed, 17 Oct 2018 08:57:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     xuwei5@hisilicon.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/4] Add clock support for Hi3670 SoC
Message-ID: <20181017032746.GB2888@Mani-XPS-13-9360>
References: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 11:00:59PM -0700, Manivannan Sadhasivam wrote:
> This patchset adds clock support for Hi3670 SoC from HiSilicon utilizing
> the HiSi common clock code. While adding clock support, let's remove the
> fixed clock for UART and source SoC clock on HiKey970 board.
> 
> This patchset has been verified on HiKey970 board.
> 
> Thanks,
> Mani
> 
> Manivannan Sadhasivam (4):
>   dt-bindings: clk: hisilicon: Add bindings for Hi3670 clk
>   arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
>   arm64: dts: hisilicon: Source SoC clock for UART6

Hi Wei,

Since the clk patches are merged, can you please take the DTS patches
through HiSi tree? I will post the pinctrl/gpio patches soon which will
depend on clk bits.

Thanks,
Mani

>   clk: hisilicon: Add clock driver for Hi3670 SoC
> 
>  .../bindings/clock/hi3670-clock.txt           |   43 +
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |   48 +-
>  drivers/clk/hisilicon/Kconfig                 |    7 +
>  drivers/clk/hisilicon/Makefile                |    1 +
>  drivers/clk/hisilicon/clk-hi3670.c            | 1016 +++++++++++++++++
>  include/dt-bindings/clock/hi3670-clock.h      |  348 ++++++
>  6 files changed, 1458 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/hi3670-clock.txt
>  create mode 100644 drivers/clk/hisilicon/clk-hi3670.c
>  create mode 100644 include/dt-bindings/clock/hi3670-clock.h
> 
> -- 
> 2.17.1
> 
