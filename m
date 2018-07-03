Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0E0C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD00424899
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aTUI2Hd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD00424899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754528AbeGCHEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:04:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55541 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754483AbeGCHEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:04:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so1056063wmv.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=H0YeWxYBBpYLCHw1rru+1ip2aA5j2xw8Gts5ANn45h4=;
        b=aTUI2Hd7gObMtGAasV4VZXnJ3B9rz9/rerB9dkXoG/c28D99yFMBNyO79P1a+zbrzB
         /vUno6rcxgGorYRLQjahbQkSFYE4UYFwEFoD5scvHTVZbNHBxyuC2mtaPBIv38hlljmz
         vEgX+9dICG89kV1zYfiiMK2EEBfguFaOtXRh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H0YeWxYBBpYLCHw1rru+1ip2aA5j2xw8Gts5ANn45h4=;
        b=nKN50B52ypqFCu4FVdGCjrqC6oIzOdZW10exa5vnr/fGpTnHT92LbKW/3mhKNOIZPH
         uBTG2Oy6hZugbSDKOaqgM+6Td+18oTsVZ6PAxNHOoGQxXH2GOwjiahaEF49hQieUc0M4
         pVn1hRQIQDL1t5qA3ehSuDR1PW9oCjk3+XMdWR/sPqtzoSMgO0qd4dZjJD7UwBTvUvlg
         cYy1mmXXCPdKwJgLFFosONEUMM3q9rMCHLuxWxOd06y9rsevROJTr8KKWTvkFdL7vlTU
         H+++ZrpVJe4y+pINDrPMjlw/ycyPJMr5l9HyuyefFBnJTwykwoUKRZb38TQLNf6b8WUc
         htLg==
X-Gm-Message-State: APt69E0IGjLpK59N+XCiRWz1/br5sOzqmbCDgTb7ZzAGx9z7eyvHvk7J
        /7l98PIYTY8Ibyl2KcBb2L/1Tw==
X-Google-Smtp-Source: AAOMgpfH92zBq+hhXfUgP3V/zQnSVRtMC/CUDLus0VO6O58mQvYzOf0meM2X8/JikGZrxAI8IRb+jQ==
X-Received: by 2002:a1c:8f0e:: with SMTP id r14-v6mr9545960wmd.79.1530601459567;
        Tue, 03 Jul 2018 00:04:19 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id f133-v6sm1038059wme.42.2018.07.03.00.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:04:18 -0700 (PDT)
Date:   Tue, 3 Jul 2018 08:04:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     matthias.bgg@kernel.org, ulrich.hecht+renesas@gmail.com,
        laurent.pinchart@ideasonboard.com, ck.hu@mediatek.com,
        p.zabel@pengutronix.de, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        rdunlap@infradead.org, sean.wang@mediatek.com,
        linux-clk@vger.kernel.org, linux@armlinux.org.uk,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [v3 01/10] dt-bindings: mediatek: mmsys: Add support for mfd
Message-ID: <20180703070416.GD20176@dell>
References: <cover.1524820923.git.mbrugger@suse.com>
 <64ca273429d92f581568a48f3efe6035af65f579.1524820923.git.mbrugger@suse.com>
 <20180430103029.GD5147@dell>
 <4ead47f6-2f69-2afa-bfcc-a240a9845dc4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ead47f6-2f69-2afa-bfcc-a240a9845dc4@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018, Matthias Brugger wrote:

> 
> 
> On 30/04/18 12:30, Lee Jones wrote:
> > On Fri, 27 Apr 2018, matthias.bgg@kernel.org wrote:
> > 
> >> From: Matthias Brugger <mbrugger@suse.com>
> >>
> >> Add binding description for the mmsys mfd for some Mediatek
> >> devices. mmsys has some registers to control clock gates (which is
> >> used in the clk driver) and some registers to set the routing and enable
> >> the differnet blocks of the display subsystem.
> >>
> >> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> >> ---
> >>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |  2 --
> >>  .../bindings/display/mediatek/mediatek,disp.txt    |  2 +-
> >>  .../devicetree/bindings/mfd/mediatek,mmsys.txt     | 27 ++++++++++++++++++++++
> >>  3 files changed, 28 insertions(+), 3 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> >> index 4eb8bbe15c01..4468345f8b1a 100644
> >> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> >> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> >> @@ -6,10 +6,8 @@ The Mediatek mmsys controller provides various clocks to the system.
> >>  Required Properties:
> >>  
> >>  - compatible: Should be one of:
> >> -	- "mediatek,mt2701-mmsys", "syscon"
> >>  	- "mediatek,mt2712-mmsys", "syscon"
> >>  	- "mediatek,mt6797-mmsys", "syscon"
> >> -	- "mediatek,mt8173-mmsys", "syscon"
> >>  - #clock-cells: Must be 1
> >>  
> >>  The mmsys controller uses the common clk binding from
> >> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> >> index 383183a89164..85a3b4ec06cd 100644
> >> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> >> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> >> @@ -9,7 +9,7 @@ function block.
> >>  
> >>  All DISP device tree nodes must be siblings to the central MMSYS_CONFIG node.
> >>  For a description of the MMSYS_CONFIG binding, see
> >> -Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt.
> >> +Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
> >>  
> >>  DISP function blocks
> >>  ====================
> >> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt b/Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
> >> new file mode 100644
> >> index 000000000000..2331ae16917e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
> >> @@ -0,0 +1,27 @@
> >> +MediaTek MMSYS Multifunction Device Driver
> > 
> > What is "MMSYS"?
> > 
> > "Multi-Function Driver"s are specific to Linux.
> > 
> > What actually is the device?
> 
> It's includes all the DRM parts of the SoC together with the clocks for the
> device. MMSYS IMHO stands for Multi-Media-System.

Please update the document with that information.

Is there a datasheet I can view?

> >> +MMSYS is a multifunction device with the following sub modules:
> >> +- clocks for the multi-media subsystem
> >> +- central node for the DRM subsystem.
> >> +
> >> +This document describes the binding for MFD device. The MFD takes care to initailize
> >> +the clock driver and the DRM driver. More info see
> >> +Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> >> +
> >> +Required properties:
> >> +- compatible: Should be one of:
> >> +	- "mediatek,mt2701-mmsys", "syscon"
> >> +	- "mediatek,mt8173-mmsys", "syscon"
> >> +- #clock-cells: Must be 1
> >> +
> >> +Optional properties:
> >> +- power-domains: list of powerdomains needed for the subsystem to work
> >> +
> >> +Example:
> >> +
> >> +mmsys: clock-controller@14000000 {
> >> +	compatible = "mediatek,mt8173-mmsys", "syscon";
> >> +	reg = <0 0x14000000 0 0x1000>;
> >> +	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> >> +	#clock-cells = <1>;
> >> +};
> > 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
