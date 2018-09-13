Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B867FC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EBF20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EBF20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeIMRjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:39:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36750 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeIMRjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:39:53 -0400
Received: from wd0459.dip.tu-dresden.de ([141.76.109.203] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1g0QlG-0002vR-J5; Thu, 13 Sep 2018 14:30:18 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Damian Kos <dkos@cadence.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, pgaj@cadence.com,
        ltyrala@cadence.com, stelford@cadence.com, jartur@cadence.com,
        piotrs@cadence.com
Subject: Re: [PATCH v3 5/5] drm/bridge: add preliminary driver for cadence dpi/dp bridge
Date:   Thu, 13 Sep 2018 14:30:17 +0200
Message-ID: <1794131.JE1BxD2NGT@phil>
In-Reply-To: <1535451894-2518-6-git-send-email-dkos@cadence.com>
References: <1535451894-2518-1-git-send-email-dkos@cadence.com> <1535451894-2518-6-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 28. August 2018, 12:24:48 CEST schrieb Damian Kos:
> From: Quentin Schulz <quentin.schulz@bootlin.com>
> 
> This patch finally adds the preliminary driver for Cadence MHDP DPI/DP bridge.
> 
> Changes made in the low level driver (cdn-dp-reg.*):
> - moved it to from drivers/gpu/drm/rockchip to
>   drivers/gpu/drm/bridge/cdns-mhdp-common.*
> - functions for sending/receiving commands are now public
> - added functions for reading registers and link training
>   adjustment
> 
> Changes made in RK's driver (cdn-dp-core.*):
> - Moved audio_info and audio_pdev fields from cdn_dp_device to
>   cdns_mhdp_device structure.
> 
> Signed-off-by: Damian Kos <dkos@cadence.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig                |    9 +
>  drivers/gpu/drm/bridge/Makefile               |    3 +
>  .../cdns-mhdp-common.c}                       |  137 +-
>  .../cdns-mhdp-common.h}                       |   21 +-
>  drivers/gpu/drm/bridge/cdns-mhdp.c            | 1308 +++++++++++++++++
>  drivers/gpu/drm/rockchip/Kconfig              |    1 +
>  drivers/gpu/drm/rockchip/Makefile             |    4 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.c        |   16 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.h        |    4 +-
>  9 files changed, 1484 insertions(+), 19 deletions(-)
>  rename drivers/gpu/drm/{rockchip/cdn-dp-reg.c => bridge/cdns-mhdp-common.c} (87%)
>  rename drivers/gpu/drm/{rockchip/cdn-dp-reg.h => bridge/cdns-mhdp-common.h} (95%)
>  create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 9eeb8ef0b174..90a4810a8c96 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -35,6 +35,15 @@ config DRM_CDNS_DSI
>  	  Support Cadence DPI to DSI bridge. This is an internal
>  	  bridge and is meant to be directly embedded in a SoC.
>  
> +config DRM_CDNS_MHDP
> +	tristate "Cadence DPI/DP bridge"
> +	select DRM_KMS_HELPER
> +	select DRM_PANEL_BRIDGE
> +	depends on OF
> +	help
> +	  Support Cadence DPI to DP bridge. This is an internal
> +	  bridge and is meant to be directly embedded in a SoC.
> +

This ends up with a Kconfig error on my kernel, with:

scripts/kconfig/conf  --oldconfig Kconfig
drivers/i2c/Kconfig:7:error: recursive dependency detected!
drivers/i2c/Kconfig:7:  symbol I2C is selected by FB_DDC
drivers/video/fbdev/Kconfig:63: symbol FB_DDC depends on FB
drivers/video/fbdev/Kconfig:5:  symbol FB is selected by DRM_KMS_FB_HELPER
drivers/gpu/drm/Kconfig:74:     symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
drivers/gpu/drm/Kconfig:68:     symbol DRM_KMS_HELPER is selected by DRM_CDNS_MHDP
drivers/gpu/drm/bridge/Kconfig:38:      symbol DRM_CDNS_MHDP is selected by ROCKCHIP_CDN_DP
drivers/gpu/drm/rockchip/Kconfig:29:    symbol ROCKCHIP_CDN_DP depends on EXTCON
drivers/extcon/Kconfig:1:       symbol EXTCON is selected by CHARGER_MANAGER
drivers/power/supply/Kconfig:467:       symbol CHARGER_MANAGER depends on POWER_SUPPLY
drivers/power/supply/Kconfig:1: symbol POWER_SUPPLY is selected by HID_BATTERY_STRENGTH
drivers/hid/Kconfig:28: symbol HID_BATTERY_STRENGTH depends on HID
drivers/hid/Kconfig:7:  symbol HID is selected by I2C_HID
drivers/hid/i2c-hid/Kconfig:4:  symbol I2C_HID depends on I2C
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"


The culprit being the dependency on EXTCON in the Rockchip cdn-dp driver.
Moving to "select EXTCON" seems to fix the issue, but I'm not sure yet if that
is the correct solution.


Heiko


