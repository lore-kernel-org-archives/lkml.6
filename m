Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757334AbeD0B0S (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:26:18 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39636 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757283AbeD0B0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:26:15 -0400
X-Google-Smtp-Source: AB8JxZpOBDXgOaZN3bBXEVOmIv+nnLe/lSEeTDD5YdyhNYKCgsur85NeSr46aZyfmdJ+uwo0ZEhFeg==
From: Moritz Fischer <mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fpga@vger.kernel.org, michal.simek@xilinx.com, corbet@lwn.net,
        atull@kernel.org, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 1/4] fpga: region: don't use drvdata in common fpga code
Date: Thu, 26 Apr 2018 18:26:02 -0700
Message-Id: <20180427012605.28981-2-mdf@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427012605.28981-1-mdf@kernel.org>
References: <20180427012605.28981-1-mdf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Tull <atull@kernel.org>

Changes to fpga_region_register function to not set drvdata.

Setting drvdata is fine for DT based devices that will have one region
per platform device.  However PCIe based devices may have multiple
FPGA regions under one PCIe device.  Without these changes, the PCIe
solution has to create an extra device for each child region to hold
drvdata.

Signed-off-by: Alan Tull <atull@kernel.org>
Reported-by: Jiuyue Ma <majiuyue@huawei.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/fpga-region.c    | 1 -
 drivers/fpga/of-fpga-region.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index cb0603e07ff8..f634a8ed5e2c 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -183,7 +183,6 @@ int fpga_region_register(struct device *dev, struct fpga_region *region)
 	region->dev.parent = dev;
 	region->dev.of_node = dev->of_node;
 	region->dev.id = id;
-	dev_set_drvdata(dev, region);
 
 	ret = dev_set_name(&region->dev, "region%d", id);
 	if (ret)
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 119ff75522f1..35e7e8c4a0cb 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -438,6 +438,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 		goto eprobe_mgr_put;
 
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
+	dev_set_drvdata(dev, region);
 
 	dev_info(dev, "FPGA Region probed\n");
 
-- 
2.17.0
