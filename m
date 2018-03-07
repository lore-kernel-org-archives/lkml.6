Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754178AbeCGIrI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:47:08 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39687 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751322AbeCGIqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:46:19 -0500
X-Google-Smtp-Source: AG47ELvqEzbmbKw3eGMN8kDffm/nl3Svt/xLJ1axsyoeXNWEXzB8t8qhhvFG3KxMvyX2tuBLE9My4w==
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH] PCI/hotplug: ppc: correct a php_slot usage after free
Date: Wed,  7 Mar 2018 16:46:04 +0800
Message-Id: <1520412364-2680-1-git-send-email-wei.guo.simon@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Guo <wei.guo.simon@gmail.com>

In pnv_php_unregister_one(), pnv_php_put_slot() might kfree
php_slot structure. But there is pci_hp_deregister() after
that with php_slot reference.

This patch moves pnv_php_put_slot() to the end of function.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 drivers/pci/hotplug/pnv_php.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 74f6a17..eb60692e 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -930,8 +930,8 @@ static void pnv_php_unregister_one(struct device_node *dn)
 		return;
 
 	php_slot->state = PNV_PHP_STATE_OFFLINE;
-	pnv_php_put_slot(php_slot);
 	pci_hp_deregister(&php_slot->slot);
+	pnv_php_put_slot(php_slot);
 }
 
 static void pnv_php_unregister(struct device_node *dn)
-- 
1.8.3.1
