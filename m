Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE6DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A317C243C6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A317C243C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964784AbeGBH6T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:58:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43457 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932988AbeGBH6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:58:16 -0400
X-UUID: 29dae81092f941608214d6e525b22cfc-20180702
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1830051628; Mon, 02 Jul 2018 15:58:14 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 2 Jul 2018 15:58:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 2 Jul 2018 15:58:10 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <marc.zyngier@arm.com>,
        <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>
CC:     <honghui.zhang@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>
Subject: [PATCH v3 1/4] PCI: mediatek: fixup mtk_pcie_find_port logical
Date:   Mon, 2 Jul 2018 15:57:41 +0800
Message-ID: <1530518264-6125-2-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
References: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
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
index 0baabe3..b43f41d 100644
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

