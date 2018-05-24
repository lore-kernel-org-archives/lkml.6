Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971223AbeEXTtH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:49:07 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34395 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966483AbeEXTtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:49:01 -0400
X-Google-Smtp-Source: AB8JxZqP5XZNkvjuZYRiglpi3WXNOjyr6P2TkPpP8inbTh79y2llC3YazwHpPAjF7YbqYTqJRHkOIw==
From: Bo Chen <chenbo@pdx.edu>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bo Chen <chenbo@pdx.edu>
Subject: [PATCH] 8139too: Remove unnecessary netif_napi_del()
Date: Thu, 24 May 2018 12:48:35 -0700
Message-Id: <20180524194835.14700-1-chenbo@pdx.edu>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to free_netdev() in __rtl8139_cleanup_dev() clears the network device
napi list, and explicit calls to netif_napi_del() are unnecessary.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
---
 drivers/net/ethernet/realtek/8139too.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139too.c b/drivers/net/ethernet/realtek/8139too.c
index d118da5a10a2..ffd68a7bc9e1 100644
--- a/drivers/net/ethernet/realtek/8139too.c
+++ b/drivers/net/ethernet/realtek/8139too.c
@@ -1104,7 +1104,6 @@ static int rtl8139_init_one(struct pci_dev *pdev,
 	return 0;
 
 err_out:
-	netif_napi_del(&tp->napi);
 	__rtl8139_cleanup_dev (dev);
 	pci_disable_device (pdev);
 	return i;
@@ -1119,7 +1118,6 @@ static void rtl8139_remove_one(struct pci_dev *pdev)
 	assert (dev != NULL);
 
 	cancel_delayed_work_sync(&tp->thread);
-	netif_napi_del(&tp->napi);
 
 	unregister_netdev (dev);
 
-- 
2.17.0
