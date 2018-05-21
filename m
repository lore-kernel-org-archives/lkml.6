Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932427AbeEUVqQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:46:16 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41260 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932249AbeEUVqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:46:10 -0400
X-Google-Smtp-Source: AB8JxZrYhBsXS2hpZbAe1Tf6UyOJVvoIKru/huIcQEGGhZnh1u4hHx/+X0JvbcRRoRcln1zvH4+H+g==
From: Bo Chen <chenbo@pdx.edu>
To: pcnet32@frontier.com
Cc: davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bo Chen <chenbo@pdx.edu>
Subject: [PATCH] pcnet32: add an error handling path in pcnet32_probe_pci()
Date: Mon, 21 May 2018 14:44:49 -0700
Message-Id: <20180521214449.18516-1-chenbo@pdx.edu>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to invoke pci_disable_device() when errors occur in
pcnet32_probe_pci().

Signed-off-by: Bo Chen <chenbo@pdx.edu>
---
 drivers/net/ethernet/amd/pcnet32.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index a561705f232c..be198cc0b10c 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -1552,22 +1552,26 @@ pcnet32_probe_pci(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!ioaddr) {
 		if (pcnet32_debug & NETIF_MSG_PROBE)
 			pr_err("card has no PCI IO resources, aborting\n");
-		return -ENODEV;
+		err = -ENODEV;
+		goto err_disable_dev;
 	}
 
 	err = pci_set_dma_mask(pdev, PCNET32_DMA_MASK);
 	if (err) {
 		if (pcnet32_debug & NETIF_MSG_PROBE)
 			pr_err("architecture does not support 32bit PCI busmaster DMA\n");
-		return err;
+		goto err_disable_dev;
 	}
 	if (!request_region(ioaddr, PCNET32_TOTAL_SIZE, "pcnet32_probe_pci")) {
 		if (pcnet32_debug & NETIF_MSG_PROBE)
 			pr_err("io address range already allocated\n");
-		return -EBUSY;
+		err = -EBUSY;
+		goto err_disable_dev;
 	}
 
 	err = pcnet32_probe1(ioaddr, 1, pdev);
+
+err_disable_dev:
 	if (err < 0)
 		pci_disable_device(pdev);
 
-- 
2.17.0
