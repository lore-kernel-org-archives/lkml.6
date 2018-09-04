Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC81C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3562077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxYfFrx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3562077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeIDRa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:30:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46381 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeIDRaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:30:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so3045359ljj.13;
        Tue, 04 Sep 2018 06:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Upe3TYatnxKCqeXoi9nTOeWzDnbeMRTAHDOO8UjGpY=;
        b=lxYfFrx+Sd5s6bUT0pj1/lbk5D/YTMSHDZtHUXNoDF5eZuEMRkqhTHuX6i1vFGdgfd
         nk6rcRclf1902NvvIA9QKz+wUY8XSqEKS5bxIHMQTqKWjPCVqx84i3PIxFdmfqKRQZc9
         gMlsiUv4Acq7N/QOr/dNy3xbnnAev92hzzlREMcZ6H4t/AQ2Bbvr0uQd1BD7I+tpVHtS
         FS5HFOplEje5Riq2e4QTfjg0amSseSbTid8ggi2yXzYMkWcSzI08KI8WklkdZW1HZ7LF
         f+I1YiyZuiVzn5UFM+tEwssF919ZiwxWJ+nAoxupVuy6PBRc2nRPGcHRWQVDxdT6lGy5
         vWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Upe3TYatnxKCqeXoi9nTOeWzDnbeMRTAHDOO8UjGpY=;
        b=Py8OnTVlCadpCqe1hfy1bCUF8L8Kf0+gFzD9PQfdBJ0sLg6piU0WC2Dnlkv22EIjsF
         FokvzmydB653mHIqhZ9iihH0Arc8gIKNpmtLxl6UHI2vjaYLZn+wl/2DiC6nSDHtbMiE
         qq96fr36mZItwnsG0ZKhOgyagmfa+hB/M9a0HOSudAM4vnwM372VaJQ6nhXGzPd7xy1M
         CfzYk/Idu4DSSWqBEw4VwvjkcoDSeiB6Z55bSPVhlVasPic5Y9xC16F2YBMCRTWHVtFI
         biNm1eMuqPjiPl2p6b67glYSR1WlJ+WcMpzSY7zM+ulhVwMmwycltKRrzxatZKlUnUmV
         lEMQ==
X-Gm-Message-State: APzg51BY1trPgwEl/ZfFNLaPuo3wTzsyurDjYRLSssFijcQd5iFTp7ea
        k+SjUA3+2secuWPLzFNh+HM=
X-Google-Smtp-Source: ANB0VdZbOZlrqOO6MSKCfOtKTQdTQdzIOz+dqVNTMbp8eBB83YGszqDGyohL3q5sO/qKLI8XT4k97Q==
X-Received: by 2002:a2e:29da:: with SMTP id p87-v6mr19670511ljp.12.1536066350159;
        Tue, 04 Sep 2018 06:05:50 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y85-v6sm4170586lfi.46.2018.09.04.06.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 06:05:49 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fxB1p-0001gs-Pm; Tue, 04 Sep 2018 15:05:57 +0200
Date:   Tue, 4 Sep 2018 15:05:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Josh Wu <rainyfeeling@outlook.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 0/9] of: fix compatible-child-node lookups
Message-ID: <20180904130557.GT28861@localhost>
References: <20180827082153.22537-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827082153.22537-1-johan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Mon, Aug 27, 2018 at 10:21:44AM +0200, Johan Hovold wrote:
> Several drivers currently use of_find_compatible_node() to lookup child
> nodes while failing to notice that the of_find_ functions search the
> entire tree depth-first (from a given start node) and therefore can
> match unrelated nodes.
> 
> The fact that these functions also drop a reference to the node they
> start searching from (e.g. the parent node) is typically also
> overlooked, something which can lead to use-after-free bugs (e.g. after
> probe deferrals).
> 
> This series adds a new helper, similar to of_get_child_by_name(), 
> that can be used to lookup compatible child nodes, and uses the new
> helper to fix child-node lookups throughout the tree.
> 
> This is related to the fixes I posted about a year ago, which addressed
> a similar anti-pattern when looking up child nodes by name. Since it
> took me more than a year to get all those fixes into Linus' tree (one
> fix is still pending), and as these fixes depend on the new helper, I'm
> suggesting that these all go in through Rob's or Greg's trees.
> 
> Alternatively, the helper could go into to -rc2, and I'll be pinging
> submaintainers for the coming year as well. ;)

Rob has gotten the helper into -rc2 now:

        36156f9241cb of: add helper to lookup compatible child node

so feel free to pick these fixes up directly for 4.19-rc or -next,
whichever you prefer. I've been able to trigger crashes after probe
deferrals due to the use-after-free, but this seems unlikely to be
exploitable.

I think Rob will be picking up any patches that remain by the end of the
release cycle for 4.20.

Thanks,
Johan

> Johan Hovold (9):
>   of: add helper to lookup compatible child node
>   drm/mediatek: fix OF sibling-node lookup
>   drm/msm: fix OF child-node lookup
>   mmc: meson-mx-sdio: fix OF child-node lookup
>   mtd: nand: atmel: fix OF child-node lookup
>   net: bcmgenet: fix OF child-node lookup
>   net: stmmac: dwmac-sun8i: fix OF child-node lookup
>   NFC: nfcmrvl_uart: fix OF child-node lookup
>   power: supply: twl4030-charger: fix OF sibling-node lookup
> 
>  drivers/gpu/drm/mediatek/mtk_hdmi.c           |  5 ++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  5 ++--
>  drivers/mmc/host/meson-mx-sdio.c              |  8 ++++--
>  drivers/mtd/nand/raw/atmel/nand-controller.c  | 11 +++++---
>  drivers/net/ethernet/broadcom/genet/bcmmii.c  |  2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 12 +++++++--
>  drivers/nfc/nfcmrvl/uart.c                    |  5 ++--
>  drivers/of/base.c                             | 25 +++++++++++++++++++
>  drivers/power/supply/twl4030_charger.c        |  5 ++--
>  include/linux/of.h                            |  8 ++++++
>  10 files changed, 68 insertions(+), 18 deletions(-)
