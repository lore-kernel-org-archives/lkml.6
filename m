Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829C0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D22F2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NprYLnHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D22F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeH3HTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 03:19:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45035 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeH3HTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 03:19:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id ba4-v6so3193458plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 20:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8GxJe4XjU75vV9nw+mwzzmFSWYdJBZmup5I88sXCOsU=;
        b=NprYLnHU6BcihCoa0R14VHyT0XMYKx31CdsDuzSyGfYyFrS6RdK+TAYsvLtWUoFiPi
         YXttFjuMMtCS6P/9THn0yTJSaaDXJG1+FnMyJWSNFLIuDl9pIiIGVodg/yt456Puk7q1
         OuTQMKijffvEAJHkhsQ8uAg1sodpwUcRsPE/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8GxJe4XjU75vV9nw+mwzzmFSWYdJBZmup5I88sXCOsU=;
        b=FJJ45dOM95UfhCRhkPTWHiH0EM1dHsKPi848i9Js4OGA9Gvnv6rmpQg09pM7EjKeGp
         5ejhk3dY4kC+4f3XecN5r2UAmMoV3Y/CQeKGGwWRBl27xZqKOFjmHbmdPywuAv6z7uKg
         PkdqPBzUjBRZu+aS2PxXk2Vb5sjrvQCmoYgDN+UoTD8/r5HzSUFaULg6i7yZI/W/IUvd
         fcav7KSTmjavCsgZTCVHbnOuoyK1C3gOAtvpj9b4RYEm/AqRPJGrFxLCUnHGeW7vtnEf
         vyC2km+mFOtMLtxmFuXcbLhXuzMbaEoti7QKcdHpK7AN/N3TnkMe3q1eYkPjxBt0+Kch
         ZTHw==
X-Gm-Message-State: APzg51BKy0qLDWOm6TbYAmPo8nJWRh57gI7ideJR9zkdmAtG+itbwS2E
        qtAxHZtu6TlRVvz1YZpsn6V5
X-Google-Smtp-Source: ANB0VdZbjOpcEZMXbNbVVtFMcX/m88omUAGNFYZfUDIpu8+F7LGJbybtBy+haN/rLVjh6AJFJBf60g==
X-Received: by 2002:a17:902:1025:: with SMTP id b34-v6mr8499969pla.291.1535599188824;
        Wed, 29 Aug 2018 20:19:48 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:7305:2604:758a:c93a:b490:179f])
        by smtp.gmail.com with ESMTPSA id 6-v6sm8282681pfr.115.2018.08.29.20.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 20:19:48 -0700 (PDT)
Date:   Thu, 30 Aug 2018 08:49:33 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org, afaerber@suse.de,
        robh+dt@kernel.org, linux-clk@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br,
        sravanhome@gmail.com
Subject: Re: [PATCH v3 0/9] Add Reset Controller support for Actions Semi Owl
 SoCs
Message-ID: <20180830031933.GD8565@Mani-XPS-13-9360>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 03:21:04PM +0530, Manivannan Sadhasivam wrote:
> This patchset adds Reset Controller (RMU) support for Actions Semi
> Owl SoCs, S900 and S700. For the Owl SoCs, RMU has been integrated into
> the clock subsystem in hardware. Hence, in software we integrate RMU
> support into common clock driver inorder to maintain compatibility. The
> syscon approach is not taken into account based on the review by Rob.
> 
> This patch series depends on the recently posted S700 clk series:
> "[PATCH v7 0/5] Add clock driver for Actions S700 SoC". For the S700 clk
> series, driver and bindings patches are applied through the clk tree.
> But the DTS patches are not yet picked up by the platform maintainer,
> Andreas.
> 
> Hence, Andreas is expected to pick the DTS patches in this series once
> reviewed by the maintainers along with S700 clk DTS patches.
> 
> Because of the absence of the S500 SoC clk support, the reset controller
> registration code is added to both S700 and S900 SoC clk drivers for now.
> But once S500 clk support is added, the reset controller registration part
> will be moved to Owl SoCs common clk code.
>

Hi Pavel,

Just a ping on this patchset!

Thanks,
Mani

> Thanks,
> Mani
> 
> Changes in v3:
> 
> * Reverted back the syscon approach based on the review by Rob Herring
> * Dropped the MAINTAINERS patch
> * Converted reset_map struct definitions to const based on the review by
>   Philipp
> * Fixed S700 header in DT spotted by Parthiban
> * Added Reviewed-by tags from Rob for 3 bindings patches
> 
> Changes in v2:
> 
> * Converted the CMU and RMU drivers to syscon for a more cleaner
>   approach
> * Declared the owl_reset_map structs to const
> * Used regmap_update_bits instead of a combined regmap_read and write
> * Removed unused headers in RMU drivers
> * Added MAINTAINERS entry for the RMU driver and bindings
> 
> Manivannan Sadhasivam (9):
>   clk: actions: Cache regmap info in private clock descriptor
>   dt-bindings: clock: Add reset controller bindings for Actions Semi Owl
>     SoCs
>   dt-bindings: reset: Add binding constants for Actions Semi S700 RMU
>   dt-bindings: reset: Add binding constants for Actions Semi S900 RMU
>   arm64: dts: actions: Add Reset Controller support for S700 SoC
>   arm64: dts: actions: Add Reset Controller support for S900 SoC
>   clk: actions: Add Actions Semi Owl SoCs Reset Management Unit support
>   clk: actions: Add Actions Semi S700 SoC Reset Management Unit support
>   clk: actions: Add Actions Semi S900 SoC Reset Management Unit support
> 
>  .../bindings/clock/actions,owl-cmu.txt        |  2 +
>  arch/arm64/boot/dts/actions/s700.dtsi         |  2 +
>  arch/arm64/boot/dts/actions/s900.dtsi         |  2 +
>  drivers/clk/actions/Kconfig                   |  1 +
>  drivers/clk/actions/Makefile                  |  1 +
>  drivers/clk/actions/owl-common.c              |  3 +-
>  drivers/clk/actions/owl-common.h              |  5 +-
>  drivers/clk/actions/owl-reset.c               | 66 ++++++++++++++
>  drivers/clk/actions/owl-reset.h               | 31 +++++++
>  drivers/clk/actions/owl-s700.c                | 55 +++++++++++-
>  drivers/clk/actions/owl-s900.c                | 86 ++++++++++++++++++-
>  .../dt-bindings/reset/actions,s700-reset.h    | 34 ++++++++
>  .../dt-bindings/reset/actions,s900-reset.h    | 65 ++++++++++++++
>  13 files changed, 347 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/clk/actions/owl-reset.c
>  create mode 100644 drivers/clk/actions/owl-reset.h
>  create mode 100644 include/dt-bindings/reset/actions,s700-reset.h
>  create mode 100644 include/dt-bindings/reset/actions,s900-reset.h
> 
> -- 
> 2.17.1
> 
