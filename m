Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933091AbeBLW53 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:57:29 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37551 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932700AbeBLWs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:27 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 13/45] rtc: m48t86: put m48t86_nvmem_cfg on the stack
Date: Mon, 12 Feb 2018 23:47:27 +0100
Message-Id: <20180212224759.15999-14-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move m48t86_nvmem_cfg to the stack of m48t86_rtc_probe. This results in a
very small code size reduction and make it safer on systems with two
similar RTCs:

   text	   data	    bss	    dec	    hex	filename
   1733	    164	      0	   1897	    769	drivers/rtc/rtc-m48t86.o.before
   1793	    100	      0	   1893	    765	drivers/rtc/rtc-m48t86.o.after

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-m48t86.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 3a48a7eb3e9c..8d17be1e6650 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -218,21 +218,21 @@ static bool m48t86_verify_chip(struct platform_device *pdev)
 	return false;
 }
 
-static struct nvmem_config m48t86_nvmem_cfg = {
-	.name = "m48t86_nvram",
-	.word_size = 1,
-	.stride = 1,
-	.size = M48T86_NVRAM_LEN,
-	.reg_read = m48t86_nvram_read,
-	.reg_write = m48t86_nvram_write,
-};
-
 static int m48t86_rtc_probe(struct platform_device *pdev)
 {
 	struct m48t86_rtc_info *info;
 	struct resource *res;
 	unsigned char reg;
 	int err;
+	struct nvmem_config m48t86_nvmem_cfg = {
+		.name = "m48t86_nvram",
+		.word_size = 1,
+		.stride = 1,
+		.size = M48T86_NVRAM_LEN,
+		.reg_read = m48t86_nvram_read,
+		.reg_write = m48t86_nvram_write,
+		.priv = &pdev->dev,
+	};
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -264,8 +264,6 @@ static int m48t86_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(info->rtc);
 
 	info->rtc->ops = &m48t86_rtc_ops;
-
-	m48t86_nvmem_cfg.priv = &pdev->dev;
 	info->rtc->nvram_old_abi = true;
 
 	err = rtc_register_device(info->rtc);
-- 
2.16.1
