Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6044BC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385DD21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfAXHP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 02:15:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:30698 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726315AbfAXHP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 02:15:26 -0500
X-UUID: c1b493784ed94f7688ac39a10bdd1555-20190124
X-UUID: c1b493784ed94f7688ac39a10bdd1555-20190124
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <shun-chih.yu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1218046010; Thu, 24 Jan 2019 15:14:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 15:14:50 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 24 Jan 2019 15:14:50 +0800
From:   <shun-chih.yu@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srv_wsdupstream@mediatek.com>
Subject: [PATCH v5] add support for Mediatek Command-Queue DMA controller on MT6765 SoC
Date:   Thu, 24 Jan 2019 15:14:18 +0800
Message-ID: <1548314060-4833-1-git-send-email-shun-chih.yu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5FFABE415C4988CF4BE118A90F62A42353F781F3C014EF2C7E41DB5436AEA0332000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces support for MediaTek Command-Queue DMA controller.

MediaTek Command-Queue DMA controller (CQDMA) on MT6765 SoC is dedicated to memory-to-memory transfer through queue-based descriptor management.

There are only 3 physical channels inside CQDMA, while the driver is extended to support 32 virtual channels for multiple dma users to issue dma requests onto the CQDMA simultaneously.

dmatest result:
dmatest: dma0chan0-copy2: summary 5000 tests, 0 failures 3500 iops 28037 KB/s (0)
dmatest: dma0chan0-copy4: summary 5000 tests, 0 failures 3494 iops 27612 KB/s (0)
dmatest: dma0chan0-copy1: summary 5000 tests, 0 failures 3491 iops 27749 KB/s (0)
dmatest: dma0chan0-copy7: summary 5000 tests, 0 failures 3673 iops 29092 KB/s (0)
dmatest: dma0chan0-copy6: summary 5000 tests, 0 failures 3763 iops 30237 KB/s (0)
dmatest: dma0chan0-copy0: summary 5000 tests, 0 failures 3730 iops 30131 KB/s (0)
dmatest: dma0chan0-copy3: summary 5000 tests, 0 failures 3717 iops 29569 KB/s (0)
dmatest: dma0chan0-copy5: summary 5000 tests, 0 failures 3699 iops 29302 KB/s (0)

Changes since v4:
- remove redundant queue structure in mtk_cqdma_pchan
- remove redundant completion management
- fix wrong residue assignment in mtk_cqdma_tx_status
- fix typos

Changes since v3:
- simplify the ISR and management on descriptors by removing tasklet and ASYNC_TX_ENABLE_CHANNEL_SWITCH
- remove useless field in mtk_cqdma_vdesc structure
- change dev_info to dev_dbg
- fix typos

Changes since v2:
- fix build warning for kernel with DMA address in 32-bit

Changes since v1:
- remove unused macros, typos
- leverage ASYNC_TX_ENABLE_CHANNEL_SWITCH to maintain DMA descriptor list

Shun-Chih Yu (2):
  dt-bindings: dmaengine: Add MediaTek Command-Queue DMA controller
    bindings
  dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for
    MT6765 SoC
 
 .../devicetree/bindings/dma/mtk-cqdma.txt          |   31 +
 drivers/dma/mediatek/Kconfig                       |   12 +
 drivers/dma/mediatek/Makefile                      |    1 +
 drivers/dma/mediatek/mtk-cqdma.c                   |  748 ++++++++++++++++++++
 4 files changed, 792 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt
 create mode 100644 drivers/dma/mediatek/mtk-cqdma.c

