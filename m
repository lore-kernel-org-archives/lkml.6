Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B73C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756D0204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756D0204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeIJOns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:43:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60535 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727261AbeIJOns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:43:48 -0400
X-UUID: 4e2a515c2b764d2eac1bc721134295e6-20180910
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1567075511; Mon, 10 Sep 2018 17:50:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 10 Sep 2018 17:50:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 10 Sep 2018 17:50:26 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <marc.zyngier@arm.com>,
        <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>
CC:     <ulf.hansson@linaro.org>, <honghui.zhang@mediatek.com>,
        <hongkun.cao@mediatek.com>, <youlin.pei@mediatek.com>,
        <yong.wu@mediatek.com>, <yt.shen@mediatek.com>,
        <sean.wang@mediatek.com>, <xinping.qian@mediatek.com>
Subject: [PATCH v4 1/4] PCI: mediatek: fixup mtk_pcie_find_port logical
Date:   Mon, 10 Sep 2018 17:50:20 +0800
Message-ID: <1536573023-6720-2-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1536573023-6720-1-git-send-email-honghui.zhang@mediatek.com>
References: <1536573023-6720-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The Mediatek's host controller has two slots, each with it's own control
registers. The host driver need to identify which slot was connected
in order to access the device's configuration space. There's problem
for current host driver to find out which slot was connected to for
a given EP device.

Assuming each slot have connect with one EP device as below:

                host bridge
  bus 0 --> __________|_______
           |                  |
           |                  |
         slot 0             slot 1
  bus 1 -->|        bus 2 --> |
           |                  |
         EP 0               EP 1

During PCI enumeration, system software will scan all the PCI device
starting from devfn 0. So it will get the proper port for slot0 and
slot1 device when using PCI_SLOT(devfn) for match. But it will get
the wrong slot for EP1: The devfn will be start from 0 when scanning
EP1 behind slot1, it will get port0 since the PCI_SLOT(EP1) is match
for port0's slot value. So the host driver should not using EP's devfn
but the slot's devfn(the slot which EP was connected to) for match.

This patch fix the mtk_pcie_find_port's logical by using the slot's
devfn for match.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 861dda6..20b9088 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -337,11 +337,26 @@ static struct mtk_pcie_port *mtk_pcie_find_port(struct pci_bus *bus,
 {
 	struct mtk_pcie *pcie = bus->sysdata;
 	struct mtk_pcie_port *port;
+	struct pci_dev *dev;
+	struct pci_bus *pbus;
 
-	list_for_each_entry(port, &pcie->ports, list)
-		if (port->slot == PCI_SLOT(devfn))
+	list_for_each_entry(port, &pcie->ports, list) {
+		if (!bus->number && port->slot == PCI_SLOT(devfn))
 			return port;
 
+		if (bus->number) {
+			pbus = bus;
+
+			while (pbus->number) {
+				dev = pbus->self;
+				pbus = dev->bus;
+			}
+
+			if (port->slot == PCI_SLOT(dev->devfn))
+				return port;
+		}
+	}
+
 	return NULL;
 }
 
-- 
2.6.4

