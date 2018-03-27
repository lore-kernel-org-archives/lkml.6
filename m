Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeC0UA4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 16:00:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751178AbeC0UAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 16:00:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40446217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
From: Alan Tull <atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Anatolij Gustschin <agust@denx.de>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Joel Holdsworth <joel@airwebreathe.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Joshua Clayton <stillcompiling@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [RESEND PATCH v3 1/4] fpga: region: don't use drvdata in common fpga code
Date: Tue, 27 Mar 2018 14:59:54 -0500
Message-Id: <20180327195957.3878-2-atull@kernel.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180327195957.3878-1-atull@kernel.org>
References: <20180327195957.3878-1-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Part of patchset that changes the following fpga_*_register
functions to not set drvdata:
* fpga_region_register.
* fpga_mgr_register
* fpga_bridge_register

The rationale is that setting drvdata is fine for DT based devices
that will have one manager, bridge, or region per platform device.
However PCIe based devices may have multiple FPGA mgr/bridge/regions
under one PCIe device.  Without these changes, the PCIe solution has
to create an extra device for each child mgr/bridge/region to hold
drvdata.

Signed-off-by: Alan Tull <atull@kernel.org>
Reported-by: Jiuyue Ma <majiuyue@huawei.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v2: No change to this patch in v2 of patchset
v3: Add Moritz' ack
---
 drivers/fpga/fpga-region.c    | 1 -
 drivers/fpga/of-fpga-region.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index edab2a2e03ef..ebe1f872810d 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -178,7 +178,6 @@ int fpga_region_register(struct device *dev, struct fpga_region *region)
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
2.14.2
