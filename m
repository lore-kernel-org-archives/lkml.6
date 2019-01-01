Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66094C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7E92075D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfAAEvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 23:51:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51896 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726740AbfAAEve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 23:51:34 -0500
X-UUID: 2b92e5bd38144bac8313d87bac1e32d0-20190101
X-UUID: 2b92e5bd38144bac8313d87bac1e32d0-20190101
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1186191890; Tue, 01 Jan 2019 12:51:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Jan 2019 12:51:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Jan 2019 12:51:26 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH 00/13] Clean up "mediatek,larb" after adding device_link
Date:   Tue, 1 Jan 2019 12:51:03 +0800
Message-ID: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 40C8168AB5B51643D5C91BE1842E5E56A0565B3483FA56B61046AC7EDDCA7E762000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek IOMMU block diagram always like below:

        M4U
         |
    smi-common
         |
  -------------
  |         |  ...
  |         |
larb1     larb2
  |         |
vdec       venc

All the consumer connect with smi-larb, then connect with smi-common.

MediaTek IOMMU don't have its power-domain. When the consumer works,
it should enable the smi-larb's power which also need enable the smi-common's
power firstly.

Thus, Firstly, use the device link connect the consumer and the
smi-larbs. then add device link between the smi-larb and smi-common.

The ref_count of the device_link normally is over 1, when the consumer
device driver is removed, we should remove all the device_link, Hence,
I add the patch "driver core: xxx" at the beginning of this patchset.

After adding the device_link, then "mediatek,larb" property can be removed.
the iommu consumer don't need call the mtk_smi_larb_get/put to enable
the power and clock of smi-larb and smi-common.

This patchset depends on "MT8183 IOMMU SUPPORT"[1].

[1] https://lists.linuxfoundation.org/pipermail/iommu/2019-January/032387.html

Yong Wu (13):
  dt-binding: mediatek: Get rid of mediatek,larb for multimedia HW
  driver core: Remove the link if there is no driver with AUTO flag
  iommu/mediatek: Add probe_defer for smi-larb
  iommu/mediatek: Add device_link between the consumer and the larb
    devices
  memory: mtk-smi: Add device-link between smi-larb and smi-common
  media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
  media: mtk-mdp: Get rid of mtk_smi_larb_get/put
  media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
  drm/mediatek: Get rid of mtk_smi_larb_get/put
  memory: mtk-smi: Get rid of mtk_smi_larb_get/put
  iommu/mediatek: Use builtin_platform_driver
  arm: dts: mediatek: Get rid of mediatek,larb for MM nodes
  arm64: dts: mediatek: Get rid of mediatek,larb for MM nodes

 .../bindings/display/mediatek/mediatek,disp.txt    |  9 -----
 .../bindings/media/mediatek-jpeg-decoder.txt       |  4 ---
 .../devicetree/bindings/media/mediatek-mdp.txt     |  8 -----
 .../devicetree/bindings/media/mediatek-vcodec.txt  |  4 ---
 arch/arm/boot/dts/mt2701.dtsi                      |  1 -
 arch/arm/boot/dts/mt7623.dtsi                      |  1 -
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           | 15 --------
 drivers/base/core.c                                |  4 +--
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            | 11 ------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        | 26 --------------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  1 -
 drivers/iommu/mtk_iommu.c                          | 40 +++++++++-------------
 drivers/iommu/mtk_iommu_v1.c                       | 32 ++++++++---------
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c    | 22 ------------
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h    |  2 --
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c      | 38 --------------------
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h      |  2 --
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c      |  1 -
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c  | 19 ----------
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h |  3 --
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |  1 -
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c  | 38 --------------------
 drivers/memory/mtk-smi.c                           | 30 ++++------------
 include/soc/mediatek/smi.h                         | 20 -----------
 24 files changed, 40 insertions(+), 292 deletions(-)

-- 
1.9.1
 
