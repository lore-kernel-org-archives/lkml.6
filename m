Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31430C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FE52075B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FE52075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbeKQMvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:51:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:31949 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729714AbeKQMvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:51:04 -0500
X-UUID: efa4312179044a2097a65f7ee2e604b4-20181117
X-UUID: efa4312179044a2097a65f7ee2e604b4-20181117
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1969350159; Sat, 17 Nov 2018 10:36:00 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 17 Nov 2018 10:35:59 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 17 Nov 2018 10:35:51 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v3 00/15] MT8183 IOMMU SUPPORT
Date:   Sat, 17 Nov 2018 10:35:27 +0800
Message-ID: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
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
larb0 larb1  IPU0    IPU1  larb4  larb5  larb6    CCU
disp  vdec   img     cam    venc   img    cam

All the connections are HW fixed, SW can NOT adjust it.

Compared with mt8173, we add a GALS(Global Async Local Sync) module
between SMI-common and M4U, and additional GALS between larb2/3/5/6
and SMI-common. GALS can help synchronize for the modules in different
clock frequency, it can be seen as a "asynchronous fifo".

GALS can only help transfer the command/data while it doesn't have
the configuring register, thus it has the special "smi" clock and it
doesn't have the "apb" clock. From the diagram above, we add "gals0"
and "gals1" clocks for smi-common and add a "gals" clock for smi-larb.

From the diagram above, IPU0/IPU1(Image Processor Unit) and CCU(Camera
Control Unit) is connected with smi-common directly, we can take them
as "larb2", "larb3" and "larb7", and their register spaces are
different with the normal larb.

This is the general purpose of each patch in this patchset:
the patch 1/2/3/4/5/6 add the iommu/smi support for mt8183;
the patch 7/8/9/10 add mmu1 support;
the last patches contain some minor changes:
   -patch 11 fix a issue.
   -patch 12 improve the code flow(add shutdown).
   -patch 13 cleanup some smi codes(delete need_larbid).
   -patch 14 switch to SPDX license.
   -patch 15 Constify iommu_ops.
this patchset don't contain the dtsi part since it need depend on the
ccf and power-domain nodes which has not been accepted.

Change notes:

v3: 1) rebase on v4.20-rc1.
    2) In the dt-binding, add a minor string "mt7623" which also use gen1
       since Matthias added it in v4.20.
    3) About v7s:
       a) for paddr_to_pte, change the param from "arm_v7s_io_pgtable" to
          "arm_pgtable_cfg", according to Robin suggestion.
       b) Don't use CONFIG_PHYS_ADDR_T_64BIT.
       c) add a little comment(pgtable address still don't over 4GB) in the
          commit message of the patch "Extend MediaTek 4GB Mode".
    4) add "iommu/mediatek: Constify iommu_ops" into this patchset. this may
       be helpful for review and merge.
       https://lists.linuxfoundation.org/pipermail/iommu/2018-October/030637.html

v2: https://lists.linuxfoundation.org/pipermail/iommu/2018-September/030164.html
    1) Fix typo in the commit message of dt-binding.
    2) Change larb2/larb3 to the special larbs.
    3) Refactor the larb-id remapped array(larbid_remapped), then we
    don't need add the new function(mtk_iommu_get_larbid).
    4) Add a new patch for v7s two helpers(paddr_to_iopte and
    iopte_to_paddr).
    5) Change some comment for MTK 4GB mode.

v1: base on v4.19-rc1.
http://lists.infradead.org/pipermail/linux-mediatek/2018-September/014881.html

Arvind Yadav (1):
  iommu/mediatek: Constify iommu_ops

Yong Wu (14):
  dt-bindings: mediatek: Add binding for mt8183 IOMMU and SMI
  iommu/mediatek: Use a struct as the platform data
  memory: mtk-smi: Use a general config_port interface
  iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and iopte_to_paddr
    helpers
  iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode
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
 drivers/iommu/io-pgtable-arm-v7s.c                 |  72 ++++--
 drivers/iommu/io-pgtable.h                         |   7 +-
 drivers/iommu/mtk_iommu.c                          | 134 +++++++----
 drivers/iommu/mtk_iommu.h                          |  23 +-
 drivers/iommu/mtk_iommu_v1.c                       |  14 +-
 drivers/memory/mtk-smi.c                           | 267 ++++++++++++++-------
 include/dt-bindings/memory/mt2701-larb-port.h      |  10 +-
 include/dt-bindings/memory/mt8173-larb-port.h      |  10 +-
 include/dt-bindings/memory/mt8183-larb-port.h      | 130 ++++++++++
 include/soc/mediatek/smi.h                         |  10 +-
 13 files changed, 491 insertions(+), 215 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt8183-larb-port.h

-- 
1.9.1

