Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2415C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 09:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD8E2064D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 09:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD8E2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeI2Pt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 11:49:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:14941 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727518AbeI2Pt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 11:49:57 -0400
X-UUID: b850b2c685c24ac8af694d8229281da3-20180929
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1865963386; Sat, 29 Sep 2018 17:22:10 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 29 Sep 2018 17:22:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 29 Sep 2018 17:22:06 +0800
From:   Houlong Wei <houlong.wei@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        CK HU <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Monica Wang <monica.wang@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>, <ginny.chen@mediatek.com>,
        <enzhu.wang@mediatek.com>
Subject: MediaTek MT8173 CMDQ support
Date:   Sat, 29 Sep 2018 17:21:41 +0800
Message-ID: <1538212903-14331-1-git-send-email-houlong.wei@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F1892C88F674BBB3ECCA8D2A6B63FF87E6E061B8755671CF09F64D92D58638652000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
to help write registers with critical time limitation, such as
updating display configuration during the vblank. It controls Global
Command Engine (GCE) hardware to achieve this requirement.

Changes since v24:
 -move WARN_ON() into cmdq_pkt_append_command() from outside
Changes since v23:
 -rebase on v4.19-rc1
 -revise return value of cmdq_mbox_create()
 -revise cmdq_pkt_create()
 -add MODULE_LICENSE() for mtk-cmdq-helper.c
 -adjust functions order in mtk-cmdq.h
Changes since v22:
 -remove properties 'timeout' and 'thread-num' from device tree
 -move timer from CMDQ driver to CMDQ helper
 -move dma unmap from CMDQ driver to CMDQ helper
 -config thread number in CMDQ match table
 -remove reallocate mechanism and let client specify the cmdq buffer size
 -let client specify the timeout time
Changes since v21:
 -rebase on v4.18-rc1
 -remove subsys code and event id definition from mtk-cmdq-helper.c
 -add mt8173-gce.h to define the subsys code and envent id
Changes since v20:
 -rebase on v4.15-rc1
 -move dma_map_single outside of spinlock
Changes since v19:
 -rebase to v4.10-rc2

Houlong Wei (2):
  arm64: dts: mt8173: Add GCE node
  soc: mediatek: Add Mediatek CMDQ helper

 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   10 +
 drivers/soc/mediatek/Kconfig             |   12 ++
 drivers/soc/mediatek/Makefile            |    1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c   |  291 ++++++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h    |  133 ++++++++++++++
 5 files changed, 447 insertions(+)
 create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
 create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h

-- 
1.7.9.5
