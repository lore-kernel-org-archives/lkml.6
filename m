Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030ECC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE51A206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE51A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeIENqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:46:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39597 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbeIENqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:46:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8D2C520812; Wed,  5 Sep 2018 11:16:53 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 587EC20618;
        Wed,  5 Sep 2018 11:16:43 +0200 (CEST)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Witos <kwitos@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 00/10] phy: Add configuration interface for MIPI D-PHY devices
Date:   Wed,  5 Sep 2018 11:16:31 +0200
Message-Id: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a set of patches to allow the phy framework consumers to test and
apply runtime configurations.

This is needed to support more phy classes that require tuning based on
parameters depending on the current use case of the device, in addition to
the power state management already provided by the current functions.

A first test bed for that API are the MIPI D-PHY devices. There's a number
of solutions that have been used so far to support these phy, most of the
time being an ad-hoc driver in the consumer.

That approach has a big shortcoming though, which is that this is quite
difficult to deal with consumers integrated with multiple variants of phy,
of multiple consumers integrated with the same phy.

The latter case can be found in the Cadence DSI bridge, and the CSI
transceiver and receivers. All of them are integrated with the same phy, or
can be integrated with different phy, depending on the implementation.

I've looked at all the MIPI DSI drivers I could find, and gathered all the
parameters I could find. The interface should be complete, and most of the
drivers can be converted in the future. The current set converts two of
them: the above mentionned Cadence DSI driver so that the v4l2 drivers can
use them, and the Allwinner MIPI-DSI driver.

Let me know what you think,
Maxime

Maxime Ripard (10):
  phy: Add MIPI D-PHY mode
  phy: Add configuration interface
  phy: Add MIPI D-PHY configuration options
  phy: dphy: Add configuration helpers
  sun6i: dsi: Convert to generic phy handling
  phy: Move Allwinner A31 D-PHY driver to drivers/phy/
  drm/bridge: cdns: Remove mode_check test
  drm/bridge: cdns: Separate DSI and D-PHY configuration
  phy: Add Cadence D-PHY support
  drm/bridge: cdns: Convert to phy framework

 drivers/gpu/drm/bridge/cdns-dsi.c           | 506 ++-------------------
 drivers/gpu/drm/sun4i/Kconfig               |   3 +-
 drivers/gpu/drm/sun4i/Makefile              |   5 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c     | 292 +------------
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c      |  30 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h      |  17 +-
 drivers/phy/Kconfig                         |   9 +-
 drivers/phy/Makefile                        |   2 +-
 drivers/phy/allwinner/Kconfig               |  12 +-
 drivers/phy/allwinner/Makefile              |   1 +-
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 322 +++++++++++++-
 drivers/phy/cadence/Kconfig                 |  13 +-
 drivers/phy/cadence/Makefile                |   1 +-
 drivers/phy/cadence/cdns-dphy.c             | 499 +++++++++++++++++++++-
 drivers/phy/phy-core-mipi-dphy.c            | 160 +++++++-
 drivers/phy/phy-core.c                      |  62 +++-
 include/linux/phy/phy-mipi-dphy.h           | 247 ++++++++++-
 include/linux/phy/phy.h                     |  49 ++-
 18 files changed, 1455 insertions(+), 775 deletions(-)
 delete mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c
 create mode 100644 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/cdns-dphy.c
 create mode 100644 drivers/phy/phy-core-mipi-dphy.c
 create mode 100644 include/linux/phy/phy-mipi-dphy.h

base-commit: 5b394b2ddf0347bef56e50c69a58773c94343ff3
-- 
git-series 0.9.1
