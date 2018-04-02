Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeDBOfy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:35:54 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:53679 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbeDBOfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:35:45 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: [net-next PATCH v3 11/11] net: netcp: support probe deferral
Date: Mon, 2 Apr 2018 10:38:01 -0400
Message-ID: <1522679881-25643-12-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522679881-25643-1-git-send-email-m-karicheri2@ti.com>
References: <1522679881-25643-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The netcp driver shouldn't proceed until the knav qmss and dma
devices are ready. So return -EPROBE_DEFER if these devices are not
ready.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 9c51b25..736f6f7 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -2158,6 +2158,10 @@ static int netcp_probe(struct platform_device *pdev)
 	struct netcp_module *module;
 	int ret;
 
+	if (!knav_dma_device_ready() ||
+	    !knav_qmss_device_ready())
+		return -EPROBE_DEFER;
+
 	if (!node) {
 		dev_err(dev, "could not find device info\n");
 		return -ENODEV;
-- 
1.9.1
