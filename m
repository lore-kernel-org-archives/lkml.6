Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeDKCBL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 22:01:11 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40247 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752849AbeDKCBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 22:01:10 -0400
X-Google-Smtp-Source: AIpwx48R5J5Kphi+YzxksVyufGz79VUg7FY9RCcrcU0pRK4nY/U2ssXu0mzFUBFLarcbxcoirAvZ1A==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: davem@davemloft.net, dhowells@redhat.com, stephen@networkplumber.org,
        johannes.berg@intel.com, arvind.yadav.cs@gmail.com
Cc: netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] dec: tulip: de4x5: Replace mdelay with usleep_range in de4x5_hw_init
Date: Wed, 11 Apr 2018 10:00:54 +0800
Message-Id: <1523412054-2108-1-git-send-email-baijiaju1990@gmail.com>
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
+    usleep(10000, 11000);
 
     RESET_DE4X5;
 
-- 
1.9.1
