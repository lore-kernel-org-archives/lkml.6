Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeDKHxK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:53:10 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38738 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbeDKHxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:53:07 -0400
X-Google-Smtp-Source: AIpwx4/95pfnrDXMPKlhcpS/Bdp+WmYQaIQaw9mc6mdInzE0aYm8eEh5TWKWtl4GfbKxMIOI6QG4Wg==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: davem@davemloft.net, frankt@promise.com, andre@linux-ide.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/2] ide: pdc202xx_new: Replace mdelay with msleep in init_chipset_pdcnew
Date: Wed, 11 Apr 2018 15:52:56 +0800
Message-Id: <1523433176-3954-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_chipset_pdcnew() is never called in atomic context.
This function is only set as ".init_chipset" in struct ide_port_info.

Despite never getting called from atomic context, init_chipset_pdcnew()
calls mdelay() to busily wait.
This is not necessary and can be replaced with msleep() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/ide/pdc202xx_new.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
index b33646b..a654491 100644
--- a/drivers/ide/pdc202xx_new.c
+++ b/drivers/ide/pdc202xx_new.c
@@ -403,7 +403,7 @@ static int init_chipset_pdcnew(struct pci_dev *dev)
 	outb(pll_ctl1, sec_dma_base + 0x03);
 
 	/* Wait the PLL circuit to be stable */
-	mdelay(30);
+	msleep(30);
 
 #ifdef DEBUG
 	/*
-- 
1.9.1
