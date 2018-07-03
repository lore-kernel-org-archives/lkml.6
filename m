Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E81AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D70924ECC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWNFjhn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D70924ECC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933060AbeGCGd0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:33:26 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45750 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932730AbeGCGdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:33:24 -0400
Received: by mail-wr0-f193.google.com with SMTP id u7-v6so652461wrn.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 23:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/Wga1auxKMLetusQnTuJeURg/3LPUjHb9JsmfbwxSN4=;
        b=IWNFjhn/O87pR+0lC3VPN53HHrYYoZYBgkEG1ed/RiyFUjcNDTTFsIQBwcwqs8rtHv
         PzwS08pQtCWxglvwGtMbbmFtkZqxZ9R17TRhcu3M/mDrmLLvY9deOKpYeq/nLnYDWqEp
         aqd+qvTtxGKl7ecABeWMXIVzGKhHIr4eZ5sAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/Wga1auxKMLetusQnTuJeURg/3LPUjHb9JsmfbwxSN4=;
        b=JW0jObdWaaLokNP0RZP66MO457JOU6LSMKw5GJcYysc73tGmwryeL9TbcmHUWms+QZ
         f4W33pyH4bb+lw1PmuUayVi63y3g/jda6UUqkmqWV0yZW2pccRyjEa5PzHqJPS9RXBeU
         o2bHmi3GOBq8Dmbo8nROu4jNQ8kCs7rr3+94zZ/K5BLGNydfT/SHIhp9PoJ9y+LCTYGQ
         tCaG4F/ewOR8bhoPkRqf6pHiEDJ4XttJ8KK15OKrIcl/RpUnnzzkWb1aaSjmwYKWVfYK
         Q16+osxHOcbD92318s5Ds1FKLfmgYJZ7IhXmUwlz1xg0OY+lxYqFLI/r2k/W2SzEsdC7
         bitw==
X-Gm-Message-State: APt69E3qgsZvDOpnQHHAB+6TgbB6dbmdr3uPMYEryOQiUV1Ws11vRzmO
        72mbztDCFvvRzjegrnMVgyRBhA==
X-Google-Smtp-Source: AAOMgpfSFLAcXTIh+EJieASOH0BvpvSK1XBfwEL/qmVUBnRLyMRC963ZKNB0sA0A74yK/X9qik2LpQ==
X-Received: by 2002:adf:f086:: with SMTP id n6-v6mr10871853wro.49.1530599603147;
        Mon, 02 Jul 2018 23:33:23 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id j43-v6sm678459wrj.1.2018.07.02.23.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 23:33:22 -0700 (PDT)
Date:   Tue, 3 Jul 2018 07:33:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Benson Leung <bleung@google.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Kukjin Kim <kgene@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Guenter Roeck <groeck@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anand Moon <linux.amoon@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Lukas Wunner <lukas@wunner.de>,
        Tony Lindgren <tony@atomide.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 2/3] arm/arm64: configs: Remove the MFD_ prefix for
 MFD_CROS_EC_I2C/SPI symbols.
Message-ID: <20180703063320.GD4242@dell>
References: <20180702102201.13461-1-enric.balletbo@collabora.com>
 <20180702102201.13461-3-enric.balletbo@collabora.com>
 <CAJKOXPd51yU8-zObXszc4zJpHsGtMNFTsbQsQdKBFg=k22xZLA@mail.gmail.com>
 <20180702230226.GA86110@decatoncale.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180702230226.GA86110@decatoncale.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Jul 2018, Benson Leung wrote:
> On Mon, Jul 02, 2018 at 01:05:40PM +0200, Krzysztof Kozlowski wrote:
> > On 2 July 2018 at 12:22, Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> > > The cros-ec I2C and SPI transport drivers have been moved from MFD
> > > subsystem to platform/chrome, at the same time, the config symbol has
> > > been renamed and lost the MFD_ prefix, so update all configs to the new
> > > config symbol name.
> > >
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > ---
> > >
> > >  arch/arm/configs/exynos_defconfig   | 4 ++--
> > >  arch/arm/configs/multi_v7_defconfig | 4 ++--
> > >  arch/arm/configs/pxa_defconfig      | 4 ++--
> > >  arch/arm64/configs/defconfig        | 4 ++--
> > >  4 files changed, 8 insertions(+), 8 deletions(-)
> > 
> > Since you put in one patch multiple defconfigs belonging to multiple
> > maintainers, I assume you are pushing this through arm-soc or Russell.
> > In such case, for Exynos boards:
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > Best regards,
> > Krzysztof
> 
> I was planning on creating an immutable branch for this series and merging it
> through platform/chrome.
> 
> Lee, Russell, Dmitry, what do you think?

Fine by me.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
