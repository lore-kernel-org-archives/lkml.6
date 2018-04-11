Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeDKC6K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 22:58:10 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45448 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbeDKC6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 22:58:08 -0400
X-Google-Smtp-Source: AIpwx49Y6VNLGqellRabbHY/EzMcqGU19KXm2cls+0e/RaCVYf/3DMVTdHQ+opUH3vu98cKNRDq+YA==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: boris.brezillon@free-electrons.com, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, cyrille.pitchen@wedev4u.fr
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] mtd: nand: diskonchip: Replace mdelay with usleep_range in doc_probe
Date: Wed, 11 Apr 2018 10:57:57 +0800
Message-Id: <1523415477-2850-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

doc_probe() is never called in atomic context.

doc_probe() is only called by init_nanddoc(), which is only set as 
a parameter of module_init().
This function is not called in atomic context.

Despite never getting called from atomic context, doc_probe()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/mtd/nand/diskonchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index c3aa53c..2679bc4 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -1482,12 +1482,12 @@ static int __init doc_probe(unsigned long physadr)
 		WriteDOC(tmp, virtadr, Mplus_DOCControl);
 		WriteDOC(~tmp, virtadr, Mplus_CtrlConfirm);
 
-		mdelay(1);
+		usleep_range(1000, 2000);
 		/* Enable the Millennium Plus ASIC */
 		tmp = DOC_MODE_NORMAL | DOC_MODE_MDWREN | DOC_MODE_RST_LAT | DOC_MODE_BDECT;
 		WriteDOC(tmp, virtadr, Mplus_DOCControl);
 		WriteDOC(~tmp, virtadr, Mplus_CtrlConfirm);
-		mdelay(1);
+		usleep_range(1000, 2000);
 
 		ChipID = ReadDOC(virtadr, ChipID);
 
-- 
1.9.1
