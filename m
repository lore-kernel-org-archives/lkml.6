Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbeDQVbi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:31:38 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:29973 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752840AbeDQV2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:28:23 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: [net-next PATCH v4 10/13] Revert "net: netcp: remove dead code from the driver"
Date: Tue, 17 Apr 2018 17:30:39 -0400
Message-ID: <1524000642-23944-11-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
References: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the probe sequence is not guaranteed contrary to the assumption
of the commit 2d8e276a9030, same has to be reverted.

commit 2d8e276a9030 ("net: netcp: remove dead code from the driver")

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index f5a7eb2..9c51b25 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -2155,6 +2155,7 @@ static int netcp_probe(struct platform_device *pdev)
 	struct device_node *child, *interfaces;
 	struct netcp_device *netcp_device;
 	struct device *dev = &pdev->dev;
+	struct netcp_module *module;
 	int ret;
 
 	if (!node) {
@@ -2203,6 +2204,14 @@ static int netcp_probe(struct platform_device *pdev)
 	/* Add the device instance to the list */
 	list_add_tail(&netcp_device->device_list, &netcp_devices);
 
+	/* Probe & attach any modules already registered */
+	mutex_lock(&netcp_modules_lock);
+	for_each_netcp_module(module) {
+		ret = netcp_module_probe(netcp_device, module);
+		if (ret < 0)
+			dev_err(dev, "module(%s) probe failed\n", module->name);
+	}
+	mutex_unlock(&netcp_modules_lock);
 	return 0;
 
 probe_quit_interface:
-- 
1.9.1
