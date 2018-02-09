Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeBIW32 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 17:29:28 -0500
Received: from mail.ispras.ru ([83.149.199.45]:44522 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753124AbeBIW3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 17:29:15 -0500
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Stefan Agner <stefan@agner.ch>, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH v4 3/3] mtd: nand: vf610: check mtd_device_register() return code
Date: Sat, 10 Feb 2018 01:28:36 +0300
Message-Id: <1518215316-21504-4-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518215316-21504-1-git-send-email-khoroshilov@ispras.ru>
References: <1518215316-21504-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vf610_nfc_probe() misses error handling of mtd_device_register().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/mtd/nand/vf610_nfc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
index 9cc5992e88c8..64fed3d9e3d4 100644
--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -782,8 +782,13 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mtd);
 
 	/* Register device in MTD */
-	return mtd_device_register(mtd, NULL, 0);
+	err = mtd_device_register(mtd, NULL, 0);
+	if (err)
+		goto err_cleanup_nand;
+	return 0;
 
+err_cleanup_nand:
+	nand_cleanup(chip);
 err_disable_clk:
 	clk_disable_unprepare(nfc->clk);
 	return err;
-- 
2.7.4
