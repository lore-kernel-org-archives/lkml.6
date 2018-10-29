Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BEBC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B2D2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqG9RLWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B2D2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbeJ2LHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:07:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45983 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbeJ2LHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:07:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id q25so6118591otn.12;
        Sun, 28 Oct 2018 19:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hB4glIvpN25CHz9BVQVLXCKI/3f0qmHAEdqG6MMcW1A=;
        b=VqG9RLWO3weFS3g4baWRPu5vVQ9sGB3k2KEFSgftQoacgIItRwj7xpEr8+J+tvnLhI
         QBpq0ewK4br0LoG4diie2yJ0lizWqe+tpzo7jmjENWqigGuHrv8cpmoxVLbjlCPJNgJ/
         QZ6Ah1/BHzLZAdp9vFwt+oJwse+6jHJ3nKo4Gyd2N7WL1QYJ6xYO8bjeYHKsGgD7wouN
         HclW8ugWxuh6FbjNNKmVAZJHGZ5/g8ZVZZy7eC0NmkwisghKHl26NgINi+gOkM2nMY/C
         437iojCAAwZrRa7iRRXKDCBfmkr0rLH4RrsAWteUwzWxPwLbw38fmNb2+RlvWzizeh6d
         mszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hB4glIvpN25CHz9BVQVLXCKI/3f0qmHAEdqG6MMcW1A=;
        b=IWkEY5oqmXJNuOYXMD67dElaHfo8SSfpDct3KW/xbGBUBFwAJbakbec/93ftKnvBeh
         6tCGCD+kVo/boB74i4VGtcL4pHsFuwQdvhwYFYmom1b/D77vdG6R4YbDU+RLckE8z+VQ
         3UUtkpt9NJMw33RgNMKViNg2V4U4Nj+5U7wR+1M7k8Xfarnn+QyiV4DoeZVDIDNQZxwR
         Z4VFNwvKEZzVmY99yZ8JmPxD3FLFX6WjfjSp48VmlKCzzm0DRqU7fApf0u0uOg2wTr94
         WGNoE5zUEVByBus7ttQ+aaIiZe2rfN/KhdqV7D29fsYwJI8rpbv6vlryAxrWwpPEoXYB
         JO3g==
X-Gm-Message-State: AGRZ1gJjIW7a8wGHn3Uur9DzdLD5EQwNdzu+MRPGu3jVL2TvLWNV0eVG
        bh2HDb4Oz38L6318PY8rzNOxsx4+EVD3vzXS8V0=
X-Google-Smtp-Source: AJdET5ca+LQxgo0N4/aGAb6gwKQkkDGEsLT09aG2Fj9ztcEA7NMzuWeY0esQnFCYhIUQigFzuiiiQLsaRys+r65E81U=
X-Received: by 2002:a9d:3cf3:: with SMTP id t48mr7815210otf.203.1540779628685;
 Sun, 28 Oct 2018 19:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181018073327.64942-1-icenowy@aosc.io>
In-Reply-To: <20181018073327.64942-1-icenowy@aosc.io>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Sun, 28 Oct 2018 19:20:03 -0700
Message-ID: <CA+E=qVenpYz3oZC0iiS6ZFxTnkFcBkE0=qB46rvXA30o_AJAYg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Analogix ANX6345 RGB-(e)DP bridge support
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi@googlegroups.com,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 12:35 AM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> This patchset brings the support for Analogix ANX6345 RGB-(e)DP bridge,
> which is used by some Allwinner A64 laptops, such as Pinebook and Olimex
> TERES-I.
>
> It reuses some definitions from the ANX78xx driver that already exists
> in the kernel tree, but the driver code itself is rewritten, because the
> big difference between ANX6345 and ANX78xx.
>
> This patchset also enables the bridge on Pinebook and TERES-I, and a
> temporary workaround patch (do not merge) for the dot clock accuracy
> problem of sun4i-drm.
>
> This patchset assumes some fixes ([1], [2] and [3]) are already
> applied, without them the patchset cannot be tested on the A64 devices
> mentioned above.

For whole series:

Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>

>
> [1] https://patchwork.kernel.org/patch/10628827/
> [2] https://patchwork.kernel.org/patch/10628825/
> [3] https://patchwork.kernel.org/patch/10646791/
>
> Chen-Yu Tsai (1):
>   [DO NOT MERGE] drm/sun4i: rgb: Add 5% tolerance to dot clock frequency
>     check
>
> Icenowy Zheng (8):
>   drm/bridge: move ANA78xx driver to analogix subdirectory
>   drm/bridge: split some definitions of ANX78xx to dedicated headers
>   drm/bridge: extract some Analogix I2C DP common code
>   dt-bindings: Add ANX6345 DP/eDP transmitter binding
>   drm/bridge: Add Analogix anx6345 support
>   arm64: allwinner: a64: add pinmux for RGB666 LCD
>   arm64: allwinner: a64: enable ANX6345 bridge on Pinebook
>   arm64: allwinner: a64: enable ANX6345 bridge on TERES-I
>
>  .../bindings/display/bridge/anx6345.txt       |  39 +
>  .../dts/allwinner/sun50i-a64-pinebook.dts     |  43 +
>  .../boot/dts/allwinner/sun50i-a64-teres-i.dts |  40 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |   9 +
>  drivers/gpu/drm/bridge/Kconfig                |  10 -
>  drivers/gpu/drm/bridge/Makefile               |   4 +-
>  drivers/gpu/drm/bridge/analogix-anx78xx.h     | 719 ---------------
>  drivers/gpu/drm/bridge/analogix/Kconfig       |  25 +
>  drivers/gpu/drm/bridge/analogix/Makefile      |   4 +
>  .../drm/bridge/analogix/analogix-anx6345.c    | 862 ++++++++++++++++++
>  .../bridge/{ => analogix}/analogix-anx78xx.c  | 146 +--
>  .../drm/bridge/analogix/analogix-anx78xx.h    | 265 ++++++
>  .../drm/bridge/analogix/analogix-i2c-dptx.c   | 169 ++++
>  .../drm/bridge/analogix/analogix-i2c-dptx.h   | 258 ++++++
>  .../bridge/analogix/analogix-i2c-txcommon.h   | 240 +++++
>  drivers/gpu/drm/sun4i/sun4i_rgb.c             |   5 +-
>  16 files changed, 1956 insertions(+), 882 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx6345.txt
>  delete mode 100644 drivers/gpu/drm/bridge/analogix-anx78xx.h
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
>  rename drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.c (90%)
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h
>
> --
> 2.18.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
