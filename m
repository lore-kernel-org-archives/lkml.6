Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A55C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A733120849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e58j5W0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A733120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeLKHrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:47:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32820 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeLKHrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:47:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so13026183wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 23:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4Rm21wiT2xwkpRL/nKWNEA7SX93smuHg4UNbEyGCk1c=;
        b=e58j5W0Y5Zq+ugEJUtS8+SdtzBXxsRHlNrXehdHNATY7EGLuMAbdlxLVp4egcl9aO8
         kysmkgr5y/7tgKPTiTWinuNP8/ZDc3cGRT0EuLcnTO8BDHOqv9iIsFRZwKomWxZX4RyP
         DcJwWKod+cGfcLHpPYZpWReNLlgWnd+w+vgpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4Rm21wiT2xwkpRL/nKWNEA7SX93smuHg4UNbEyGCk1c=;
        b=KUjw7agCMN7BKYqeBAnoqsf1luNy1KZh/vduTDyfUyGoUjr2jUsDWPpkjwtIvMONH5
         7/36+mr5dDi5t69RW2PSg+jWRlzSDvLfBz9vz08PiRHlm9NgS8ngYMbHyqGN1TiAy9XE
         ja13vYGw8TioXfHJDg7xrxq2ohVIrwM6RyPQB4/RRcyF/Jedyk5cAHLdLqs7PviKs2Cy
         G9ODMIKgMdGY/uHdaXp/EOzw4dV4Z+VzLZ0EOmm2bIHmBcMrR9cz2oe32O/bO4oXwHQm
         88iDKyZLrmZkjrgLXEIenjBJsxXBibH4BbnEgOPiqmjAq8WeEBQ++WdpHWHkIFJnpLI/
         ZyiA==
X-Gm-Message-State: AA+aEWZ3GVAnlRFOjnBR1w6XjdP0N3YZYZc3JBrp+GPjs2N5Qh0CH7VA
        Ntb+82dh1cBHsok1DvUqzU75kQ==
X-Google-Smtp-Source: AFSGD/Wz6hfKcKq5o0BXWB6d9XzuSDUCA4v1kLCP6d6SX/2lsPo30tanpir59MzDFQ0KqkK5qohKhQ==
X-Received: by 2002:adf:c888:: with SMTP id k8mr13492292wrh.6.1544514417849;
        Mon, 10 Dec 2018 23:46:57 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id q9sm12825131wrp.0.2018.12.10.23.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 23:46:56 -0800 (PST)
Date:   Tue, 11 Dec 2018 07:46:54 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Priit Laes <plaes@plaes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH 0/8] This is a second edition of a series
 that implements voltage
Message-ID: <20181211074654.GF4497@dell>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
 <20181211071137.k3rqwctnibg6tyc2@plaes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181211071137.k3rqwctnibg6tyc2@plaes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018, Priit Laes wrote:

> On Mon, Dec 10, 2018 at 08:42:11PM +0200, Priit Laes wrote:
> > ramping for AXP209 DCDC2 and LDO3 regulators and software
> > based soft-start for AXP209 LDO3 regulator.
> 
> Ugh.. managed to botch this series. I'll send a fixed one
> today.

While you're at it, please don't forget to add the version number in
the patch subject lines.  Each patch should have read "[PATCH v2]
<...>" in this submission.

> > Both features are needed to work around a PMIC shutdown when
> > toggling LDO3 on certain boards with high capacitance on the
> > LDO3 output.
> > 
> > Similar features (or workarounds) have been also implemented
> > on u-boot side [1].
> > 
> > Changes since v1:
> > - Rebased on top of next and dropped already merged patches.
> > - Dropped LDO4 full range devicetree change for Lime2 (prev patch 9)
> >   in favor of general pin-bank regulator dependency [2].
> > - Fixed paths in devicetree bindings (patch 3)
> > - Added note about software based soft-start for LDO3 (patch 5)
> > 
> > [1] https://lists.denx.de/pipermail/u-boot/2018-November/348612.html
> > [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-December/618459.html
> > 
> > Olliver Schinagl (8):
> >   mfd: axp20x: name voltage ramping define properly
> >   regulator: axp20x: add support for set_ramp_delay for AXP209
> >   dt-bindings: mfd: axp20x: add support for regulator-ramp-delay for AXP209
> >   regulator: axp20x: add software based soft_start for AXP209 LDO3
> >   dt-bindings: mfd: axp20x: Add software based soft_start for AXP209 LDO3
> >   regulator: dts: enable soft-start and ramp delay for the OLinuXino Lime2
> >   mfd: axp20x: Clean up included headers
> >   mfd: axp20x: use explicit bit defines
> > 
> >  Documentation/devicetree/bindings/mfd/axp20x.txt |   9 +-
> >  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts  |   2 +-
> >  drivers/mfd/axp20x.c                             |  13 +-
> >  drivers/regulator/axp20x-regulator.c             | 142 +++++++++++++++-
> >  include/linux/mfd/axp20x.h                       |   4 +-
> >  5 files changed, 161 insertions(+), 9 deletions(-)
> > 
> > base-commit: 14cf8c1d5b90a0cf6a8ba51ef59db8da8c7a2622

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
