Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeEDRZj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:25:39 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34704 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeEDRZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:25:38 -0400
X-Google-Smtp-Source: AB8JxZrLgQD7c4HCUSW73yTrQ4GaiW8QaHIC7ugE7sWB7hShe+iid99KBPMQnUS9PbmSTrSnSbd6Jg==
From: Moritz Fischer <mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, alex.williams@ni.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 1/2] net: nixge: Fix error path for obtaining mac address
Date: Fri,  4 May 2018 10:18:33 -0700
Message-Id: <20180504171834.9365-1-mdf@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix issue where nixge_get_nvmem_address() returns a non-NULL
return value on a failed nvmem_cell_get() that causes an invalid
access when error value encoded in pointer is dereferenced.

Furthermore ensure that buffer allocated by nvmem_cell_read()
actually gets kfreed() if the function succeeds.

Fixes commit 492caffa8a1a ("net: ethernet: nixge: Add support for
National Instruments XGE netdev")
Reported-by: Alex Williams <alex.williams@ni.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/net/ethernet/ni/nixge.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 27364b7572fc..c41fea9253e3 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -1170,7 +1170,7 @@ static void *nixge_get_nvmem_address(struct device *dev)
 
 	cell = nvmem_cell_get(dev, "address");
 	if (IS_ERR(cell))
-		return cell;
+		return NULL;
 
 	mac = nvmem_cell_read(cell, &cell_size);
 	nvmem_cell_put(cell);
@@ -1202,10 +1202,12 @@ static int nixge_probe(struct platform_device *pdev)
 	ndev->max_mtu = NIXGE_JUMBO_MTU;
 
 	mac_addr = nixge_get_nvmem_address(&pdev->dev);
-	if (mac_addr && is_valid_ether_addr(mac_addr))
+	if (mac_addr && is_valid_ether_addr(mac_addr)) {
 		ether_addr_copy(ndev->dev_addr, mac_addr);
-	else
+		kfree(mac_addr);
+	} else {
 		eth_hw_addr_random(ndev);
+	}
 
 	priv = netdev_priv(ndev);
 	priv->ndev = ndev;
-- 
2.17.0
