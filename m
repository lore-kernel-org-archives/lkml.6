Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753765AbeDKPkC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:40:02 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36685 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752852AbeDKPkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:40:00 -0400
X-Google-Smtp-Source: AIpwx49GprQ1IBGNtbrZfn8Lrf13ATM2xClsbftM9/IEmbSl0fWDVBPvEnnU3vjQ4Cl16IwJyel0Zw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: davem@davemloft.net, stephen@networkplumber.org,
        johannes.berg@intel.com, arvind.yadav.cs@gmail.com,
        dhowells@redhat.com
Cc: netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] dec: tulip: de4x5: Replace mdelay with usleep_range in de4x5_hw_init
Date: Wed, 11 Apr 2018 23:39:42 +0800
Message-Id: <1523461182-5897-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

de4x5_hw_init() is never called in atomic context.

de4x5_hw_init() is only called by de4x5_pci_probe(), which is only 
set as ".probe" in struct pci_driver.

Despite never getting called from atomic context, de4x5_hw_init() 
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to 
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Use usleep_range() to correct usleep() in v1.
	
---
 drivers/net/ethernet/dec/tulip/de4x5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dec/tulip/de4x5.c b/drivers/net/ethernet/dec/tulip/de4x5.c
index 0affee9..3fb0119 100644
--- a/drivers/net/ethernet/dec/tulip/de4x5.c
+++ b/drivers/net/ethernet/dec/tulip/de4x5.c
@@ -1107,7 +1107,7 @@ static int (*dc_infoblock[])(struct net_device *dev, u_char, u_char *) = {
 	pdev = to_pci_dev (gendev);
 	pci_write_config_byte(pdev, PCI_CFDA_PSM, WAKEUP);
     }
-    mdelay(10);
+    usleep_range(10000, 11000);
 
     RESET_DE4X5;
 
-- 
1.9.1
