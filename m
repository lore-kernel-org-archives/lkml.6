Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,SUBJ_ALL_CAPS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD25C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC60B20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC60B20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeICKVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 06:21:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33109 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725856AbeICKVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 06:21:01 -0400
X-UUID: 83e9f5425ed1440e909e032565b688e5-20180903
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1423922480; Mon, 03 Sep 2018 14:02:19 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 3 Sep 2018 14:02:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 3 Sep 2018 14:02:16 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>,
        Daniel Kurtz <djkurtz@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <yong.wu@mediatek.com>
Subject: [PATCH 00/13] MT8183 IOMMU SUPPORT
Date:   Mon, 3 Sep 2018 14:01:29 +0800
Message-ID: <1535954502-30646-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset mainly adds support for mt8183 IOMMU and SMI.

mt8183 has only one M4U like mt8173 and is also MTK IOMMU gen2 which
uses ARM Short-Descriptor translation table format.

The mt8183 M4U-SMI HW diagram is as below:

                          EMI
                           |
                          M4U
                           |
                       ----------
                       |        |
                   gals0-rx   gals1-rx
                       |        |
                       |        |
                   gals0-tx   gals1-tx
                       |        |
                      ------------
                       SMI Common
                      ------------
                           |
  +-----+-----+--------+-----+-----+-------+-------+
  |     |     |        |     |     |       |       |
  |     |  gals-rx  gals-rx  |   gals-rx gals-rx gals-rx
  |     |     |        |     |     |       |       |
  |     |     |        |     |     |       |       |
  |     |  gals-tx  gals-tx  |   gals-tx gals-tx gals-tx
  |     |     |        |     |     |       |       |
larb0 larb1  larb2   larb3  larb4 larb5  larb6    CCU
disp  vdec   IPU0    IPU1   venc  IPU1    cam

All the connections are HW fixed, SW can NOT adjust it.

Compared with mt8173, we add a GALS(Global Async Local Sync) module
between SMI-common and M4U, and additional between larb2/3/5/6 and
SMI-common. GALS can help synchronize for the modules in different
clock frequence, it can be seen as a "asynchronous fifo".

GALS can only help transfer the command/data while it don't have the
register, thus it has the special "smi" clock and it don't have the
"apb" clock. From the diagram above, we add "gals0" and "gals1"
clockes for smi-common and add a "gals" clock for smi-larb.

From the diagram above, CCU(Camera Control Unit) is connected with
smi-common directly, we can look it as "larb7" but its register space
is different with the normal larb.

This patchset is based on v4.19-rc1.
the patch 1/2/3/4/5 add the iommu/smi support for mt8183;
the patch 6/7/8/9 add mmu1 support;
the last patches contain some minor changes:
   -patch 10 fix a issue.
   -patch 11 improve the code flow(add shutdown).
   -patch 12 cleanup some smi codes(delete need_larbid).
   -patch 13 switch to SPDX license.
this patchset don't contain the dtsi part since it need depend on the
ccf and power-domain nodes which has not been accepted.

Yong Wu (13):
  dt-bindings: mediatek: Add binding for mt8183 IOMMU and SMI
  iommu/mediatek: Use a struct as the platform data
  memory: mtk-smi: Use a general config_port interface
  iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB mode
  iommu/mediatek: Add mt8183 IOMMU support
  iommu/mediatek: Add mmu1 support
  memory: mtk-smi: Invoke pm runtime_callback to enable clocks
  memory: mtk-smi: Use a struct for the platform data for smi-common
  memory: mtk-smi: Add bus_sel for mt8183
  iommu/mediatek: Add VLD_PA_RANGE register backup when suspend
  iommu/mediatek: Add shutdown callback
  memory: mtk-smi: Get rid of need_larbid
  iommu/mediatek: Switch to SPDX license identifier

 .../devicetree/bindings/iommu/mediatek,iommu.txt   |  15 +-
 .../memory-controllers/mediatek,smi-common.txt     |  11 +-
 .../memory-controllers/mediatek,smi-larb.txt       |   3 +
 drivers/iommu/io-pgtable-arm-v7s.c                 |  38 ++-
 drivers/iommu/io-pgtable.h                         |   8 +-
 drivers/iommu/mtk_iommu.c                          | 145 +++++++----
 drivers/iommu/mtk_iommu.h                          |  23 +-
 drivers/iommu/mtk_iommu_v1.c                       |  10 +-
 drivers/memory/mtk-smi.c                           | 267 ++++++++++++++-------
 include/dt-bindings/memory/mt2701-larb-port.h      |  10 +-
 include/dt-bindings/memory/mt8173-larb-port.h      |  10 +-
 include/dt-bindings/memory/mt8183-larb-port.h      | 130 ++++++++++
 include/soc/mediatek/smi.h                         |  10 +-
 13 files changed, 476 insertions(+), 204 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt8183-larb-port.h

-- 
1.9.1 

