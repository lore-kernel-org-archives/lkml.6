Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED28CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AE22086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuC95x1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AE22086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeKIHcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:32:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbeKIHcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:46 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F07320892;
        Thu,  8 Nov 2018 21:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714119;
        bh=JKRkFlFZD2l5gZ4GkYlhA27Rx2+Tq08jT1ZYaXK+Nbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EuC95x1j4LHekqkQl2VC9GrX2sBhSytZK0eVDhnkBmK6uzTNN/pBpLhfQm080MUDZ
         2feC+FdgXbetnACFfJH6AgglAYk9mXvT74OkDR+MQmWW+EBlnfPS1M5S3zrG3DUY5m
         yRgEKJUk6z/r/7j2RlYgFwFcEgYEG312BRQihcIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@men.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 065/144] mcb: mcb-pci: Only remap the 1st 0x200 bytes of BAR 0
Date:   Thu,  8 Nov 2018 13:50:36 -0800
Message-Id: <20181108215059.589196800@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7b7c54914f73966976893747ee8e2ca58166a627 ]

Currently it is not possible to have a kernel with built-in MCB attached
devices. This results out of the fact that mcb-pci requests PCI BAR 0, then
parses the chameleon table and calls the driver's probe function before
releasing BAR 0 again. When building the kernel with modules this is not a
problem (and therefore it wasn't detected by my tests yet).

A solution is to only remap the 1st 0x200 bytes of a Chameleon PCI device.
0x200 bytes is the maximum size of a Chameleon v2 Table.

Also this patch stops disabling the PCI device on successful registration of MCB
devices.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@men.de>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mcb/mcb-internal.h |  1 +
 drivers/mcb/mcb-pci.c      | 27 ++++++++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/mcb/mcb-internal.h b/drivers/mcb/mcb-internal.h
index f956ef26c0ce..fb7493dcfb79 100644
--- a/drivers/mcb/mcb-internal.h
+++ b/drivers/mcb/mcb-internal.h
@@ -7,6 +7,7 @@
 #define PCI_DEVICE_ID_MEN_CHAMELEON	0x4d45
 #define CHAMELEON_FILENAME_LEN		12
 #define CHAMELEONV2_MAGIC		0xabce
+#define CHAM_HEADER_SIZE		0x200
 
 enum chameleon_descriptor_type {
 	CHAMELEON_DTYPE_GENERAL = 0x0,
diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
index b59181965643..5e1bd5db02c8 100644
--- a/drivers/mcb/mcb-pci.c
+++ b/drivers/mcb/mcb-pci.c
@@ -17,6 +17,7 @@
 
 struct priv {
 	struct mcb_bus *bus;
+	phys_addr_t mapbase;
 	void __iomem *base;
 };
 
@@ -31,8 +32,8 @@ static int mcb_pci_get_irq(struct mcb_device *mdev)
 
 static int mcb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	struct resource *res;
 	struct priv *priv;
-	phys_addr_t mapbase;
 	int ret;
 	int num_cells;
 	unsigned long flags;
@@ -47,19 +48,21 @@ static int mcb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENODEV;
 	}
 
-	mapbase = pci_resource_start(pdev, 0);
-	if (!mapbase) {
+	priv->mapbase = pci_resource_start(pdev, 0);
+	if (!priv->mapbase) {
 		dev_err(&pdev->dev, "No PCI resource\n");
 		goto err_start;
 	}
 
-	ret = pci_request_region(pdev, 0, KBUILD_MODNAME);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request PCI BARs\n");
+	res = request_mem_region(priv->mapbase, CHAM_HEADER_SIZE,
+				 KBUILD_MODNAME);
+	if (IS_ERR(res)) {
+		dev_err(&pdev->dev, "Failed to request PCI memory\n");
+		ret = PTR_ERR(res);
 		goto err_start;
 	}
 
-	priv->base = pci_iomap(pdev, 0, 0);
+	priv->base = ioremap(priv->mapbase, CHAM_HEADER_SIZE);
 	if (!priv->base) {
 		dev_err(&pdev->dev, "Cannot ioremap\n");
 		ret = -ENOMEM;
@@ -84,7 +87,7 @@ static int mcb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	priv->bus->get_irq = mcb_pci_get_irq;
 
-	ret = chameleon_parse_cells(priv->bus, mapbase, priv->base);
+	ret = chameleon_parse_cells(priv->bus, priv->mapbase, priv->base);
 	if (ret < 0)
 		goto err_drvdata;
 	num_cells = ret;
@@ -93,8 +96,10 @@ static int mcb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	mcb_bus_add_devices(priv->bus);
 
+	return 0;
+
 err_drvdata:
-	pci_iounmap(pdev, priv->base);
+	iounmap(priv->base);
 err_ioremap:
 	pci_release_region(pdev, 0);
 err_start:
@@ -107,6 +112,10 @@ static void mcb_pci_remove(struct pci_dev *pdev)
 	struct priv *priv = pci_get_drvdata(pdev);
 
 	mcb_release_bus(priv->bus);
+
+	iounmap(priv->base);
+	release_region(priv->mapbase, CHAM_HEADER_SIZE);
+	pci_disable_device(pdev);
 }
 
 static const struct pci_device_id mcb_pci_tbl[] = {
-- 
2.17.1



