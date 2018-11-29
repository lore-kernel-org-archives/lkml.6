Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C85BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6822081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6822081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeK2Olb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 09:41:31 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:18009 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727098AbeK2Olb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 09:41:31 -0500
X-UUID: dc90f1dffdc94b1ba7552a14c28daff8-20181129
X-UUID: dc90f1dffdc94b1ba7552a14c28daff8-20181129
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 578699797; Thu, 29 Nov 2018 11:37:27 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Nov 2018 11:37:19 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Nov 2018 11:37:18 +0800
From:   Houlong Wei <houlong.wei@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "CK HU" <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        "Jiaguang Zhang" <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Monica Wang <monica.wang@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>, <ginny.chen@mediatek.com>,
        <enzhu.wang@mediatek.com>, <kendrick.hsu@mediatek.com>
Subject: [PATCH v27 0/2] MediaTek MT8173 CMDQ support
Date:   Thu, 29 Nov 2018 11:37:07 +0800
Message-ID: <1543462629-32746-1-git-send-email-houlong.wei@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
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

Changes since v26:
 -rebase on v4.20-rc1
 -add comment to explain why cmdq_buf_size is increased in case of
  appending command failure
Changes since v25:
 -Replace WARN_ON() with WARN_ONCE() and add debug information.
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

 arch/arm64/boot/dts/mediatek/mt8173.dtsi |  10 +
 drivers/soc/mediatek/Kconfig             |  12 +
 drivers/soc/mediatek/Makefile            |   1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c   | 300 +++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h    | 133 ++++++++++
 5 files changed, 456 insertions(+)
 create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
 create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h

-- 
2.19.1

