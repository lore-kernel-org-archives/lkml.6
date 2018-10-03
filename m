Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E43CC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4888820644
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4888820644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJCK2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 06:28:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34769 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726548AbeJCK2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 06:28:37 -0400
X-UUID: 9ade117103ab4daca5aef53d132d950d-20181003
X-UUID: 9ade117103ab4daca5aef53d132d950d-20181003
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1991035885; Wed, 03 Oct 2018 11:41:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 3 Oct 2018 11:41:52 +0800
Received: from mtkslt209.mediatek.inc (10.21.15.96) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 3 Oct 2018 11:41:52 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, Mao Huang <littlecvr@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: [PATCH v5 00/11] drm/mediatek: support hdmi output for mt2701 and mt7623 
Date:   Wed, 3 Oct 2018 11:41:40 +0800
Message-ID: <20181003034151.31452-1-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.12.5.2.gbdf23ab
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support HDMI on mt2701,
we have to make some modifications.
1) Add the HDMI driver.
2) Add the DPI driver.
3) Add a mechanism that config output component by dts.

Change since v4:
 - move some change from patch9 to patch7

Change since v3:
 - Remove drm/mediatek: config component output by device node port
   patch, we will push another patches to flexibly config the component output.
 - fixup the return value
 - replace dpi->power_ctl and power_sta with reference count mechanism.
 - move the common function to mtk_hdmi_phy.c/h

Changes since v2:
 - Fix the typo in commit message.
 - Remove const of reg_h_fre_con in the mtk_dpi_conf struct
 - Remove unused error log
 - Use lower casee for hex number
 - Use common API which defined in mtk_hdmi_phy.c to reduce code size
 - Implemet the enable/disable of phy_pll_ops the same as 8173
 - Move the common header to mtk_hdmi_phy.h
 - Remove the including of debugfs.h
NOTE:
 - add description about thecoponent output in the binding document in v4.

Changes since v1:
 - Separate some patches to independent patch.
 - add DISP_REG_CONFIG_DSI_SEL and DISP_REG_CONFIG_DPI_SEL
   configuration in the condition of BLS&DPI0 connection.

Changes since v0:
 - Correct some typos in commit message.
 - Fixup the build warning (tmp variable didn't be initialized)

Bibby Hsieh (2):
  drm/mediatek: implement connection from BLS to DPI0
  drm/mediatek: add a error return value when clock driver has been
    prepared

chunhui dai (9):
  drm/mediatek: add refcount for DPI power on/off
  drm/mediatek: move hardware register to node data
  drm/mediatek: adjust EDGE to match clock and data
  drm/mediatek: add clock factor for different IC
  drm/mediatek: convert dpi driver to use drm_of_find_panel_or_bridge
  drm/mediatek: add dpi driver for mt2701 and mt7623
  drm/mediatek: separate hdmi phy to different file
  drm/mediatek: add support for SPDIF audio in HDMI
  drm/mediatek: add hdmi driver for MT2701 and MT7623

 drivers/gpu/drm/mediatek/Makefile              |   5 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c             | 131 ++++++++------
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h        |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c         |  14 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c    |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c         |   2 +
 drivers/gpu/drm/mediatek/mtk_hdmi.c            |  15 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.h            |   2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 235 +++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  60 +++++++
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 212 ++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 226 +-----------------------
 12 files changed, 627 insertions(+), 279 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c

-- 
2.12.5.2.gbdf23ab

