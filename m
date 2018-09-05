Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E827C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD1A206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD1A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeIENBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:01:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20840 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726272AbeIENBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:01:16 -0400
X-UUID: 36c1564205fb48a0beb571577e90d3a4-20180905
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 731383537; Wed, 05 Sep 2018 16:32:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 5 Sep 2018 16:31:47 +0800
Received: from mtkslt209.mediatek.inc (10.21.15.96) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 5 Sep 2018 16:31:47 +0800
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
Subject: [PATCH v2 00/13] drm/mediatek: support hdmi output for mt2701 and mt7623 
Date:   Wed, 5 Sep 2018 16:31:33 +0800
Message-ID: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
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

Changes since v1:
 - Separate some patches to independent patch.
 - add DISP_REG_CONFIG_DSI_SEL and DISP_REG_CONFIG_DPI_SEL
   configuration in the condition of BLS&DPI0 connection.

Changes since v0:
 - Correct some typos in commit message.
 - Fixup the build warning (tmp variable didn't be initialized)

Bibby Hsieh (3):
  drm/mediatek: implement connection from BLS to DPI0
  drm/mediatek: add a error return value when clock driver has been
    prepared
  drm/mediatek: config component output by device node port

chunhui dai (10):
  drm/mediatek: add refcount for DPI power on/off
  drm/mediatek: move hardware register to node data
  drm/mediatek: adjust EDGE to match clock and data
  drm/mediatek: add clock factor for different IC
  drm/mediatek: dpi use new API for finding bridge
  drm/mediatek: add dpi driver for mt2701 and mt7623
  drm/mediatek: separae hdmi phy to different file
  drm/mediatek: register hdmi codec more earlier
  drm/mediatek: add support for SPDIF audio in HDMI
  drm/mediatek: add hdmi driver for MT2701 and MT7623

 drivers/gpu/drm/mediatek/Makefile              |  16 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c             | 123 +++++++---
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h        |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c         |  19 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c    |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c         |  39 +++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h         |   4 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c            |  51 ++--
 drivers/gpu/drm/mediatek/mtk_hdmi.h            |  27 +++
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 157 +++++++++++++
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 307 +++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 129 +----------
 12 files changed, 690 insertions(+), 186 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c

-- 
2.12.5.2.gbdf23ab

