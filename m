Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00498C04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB53208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiGYyAOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB53208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389699AbeKPXHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:07:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbeKPXHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:07:45 -0500
Received: from ziggy.de (unknown [93.176.133.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBCDF2087A;
        Fri, 16 Nov 2018 12:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542372927;
        bh=MsX0D2nv4gCScRREhhc4JH4ktBsXjxNVzTehDsWc9p4=;
        h=From:To:Cc:Subject:Date:From;
        b=NiGYyAOlHZgoofKiCrzy8MkWtGtR6lfUFnyI2rc6tywHBzLUvnBkWcDl6YtiYxSYN
         J2QdIE7AjdvAw+ApR0PtmjnErIXSIOCFxggeKq7+1yRrYVpM19Kq/wj5lTmxh+Hl/j
         UYmIuKO5CB50sIhpy9gu4kof684kLUMV9dHcpeT8=
From:   matthias.bgg@kernel.org
To:     robh+dt@kernel.org, mark.rutland@arm.com, ck.hu@mediatek.com,
        p.zabel@pengutronix.de, airlied@linux.ie, mturquette@baylibre.com,
        sboyd@codeaurora.org, ulrich.hecht+renesas@gmail.com,
        laurent.pinchart@ideasonboard.com, matthias.bgg@gmail.com
Cc:     sean.wang@mediatek.com, sean.wang@kernel.org,
        rdunlap@infradead.org, wens@csie.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v5 00/12] arm/arm64: mediatek: Fix mmsys device probing
Date:   Fri, 16 Nov 2018 13:54:37 +0100
Message-Id: <20181116125449.23581-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

This is version four of the series. The biggest change are the last
four patches which introduce how this should be handled in the future.
Instead of creating the platform device in the DRM driver the device
tree has in the mmsys memory range a child node to probe the clock
part. That breaks backwards compatibility, so I only introduce that for
SoCs which are not available to the general public (mt2712e) or only
have the mmsys clock driver part implemented (mt6797).


Changes since v4:
- fix missing regmap accessors in drm diver (patch 1)
- omit probe deffered warning on all drivers (patch 5)
- update drm and clk bindings (patch 6 and 7)
- put mmsys clock part in dts child node of mmsys. Only done
for HW where no dts backport compatible breakage is expected 
(either DRM driver not yet implemented or no HW available to
the public) (patch 9 to 12)

Changes since v3:
- use platform device to probe clock driver
- add Acked-by CK Hu for the probe deferred patch

Changes since v2:
- fix kconfig typo (shame on me)
- delete __initconst from mm_clocks as converted to a platform driver
  
Changes since v1:
- add binding documentation
- ddp: use regmap_update_bits
- ddp: ignore EPROBE_DEFER on clock probing
- mfd: delete mmsys_private
- add Reviewed-by and Acked-by tags
 
MMSYS in Mediatek SoCs has some registers to control clock gates (which is 
used in the clk driver) and some registers to set the routing and enable
the differnet blocks of the display subsystem.

Up to now both drivers, clock and drm are probed with the same device tree
compatible. But only the first driver get probed, which in effect breaks
graphics on mt8173 and mt2701.

This patch uses a platform device registration in the DRM driver, which
will trigger the probe of the corresponding clock driver. It was tested on the
bananapi-r2 and the Acer R13 Chromebook.


Matthias Brugger (12):
  drm/mediatek: Use regmap for register access
  clk: mediatek: mt2701-mmsys: switch to platform device probing
  clk: mediatek: mt8173: switch mmsys to platform device probing
  drm/mediatek: Add support for mmsys through a pdev
  drm: mediatek: Omit warning on probe defers
  drm/mediatek: update dt-bindings
  dt-bindings: clock: mediatek: delete mmsys clocks
  dt-bindings: mediatek: Change the binding for mmsys clocks
  arm64: dts: mt2712e: Use the new mmsys clock compatible
  arm64: dts: mt6797: Use the new mmsys clock compatible
  clk: mediatek: mt2712e: Probe with new compatible
  clk: mediatek: mt6797: Probe with new compatible

 .../bindings/arm/mediatek/mediatek,mmsys.txt  | 24 +++++----
 .../display/mediatek/mediatek,disp.txt        | 34 +++++++-----
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |  8 ++-
 arch/arm64/boot/dts/mediatek/mt6797.dtsi      |  8 ++-
 drivers/clk/mediatek/clk-mt2701-mm.c          | 42 ++++++++++-----
 drivers/clk/mediatek/clk-mt2712-mm.c          |  9 ++--
 drivers/clk/mediatek/clk-mt6797-mm.c          |  9 ++--
 drivers/clk/mediatek/clk-mt8173.c             | 51 +++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_disp_color.c     |  4 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       |  4 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c      |  4 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |  4 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c        | 53 ++++++++-----------
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h        |  4 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        | 34 +++++++++---
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |  4 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c            |  6 ++-
 17 files changed, 200 insertions(+), 102 deletions(-)

-- 
2.19.1

