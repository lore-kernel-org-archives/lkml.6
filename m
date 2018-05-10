Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757206AbeEJLpv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 07:45:51 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:34004 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757181AbeEJLpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 07:45:49 -0400
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 10 May 2018 13:45:47 +0200
X-ME-IP: 86.244.116.1
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] scsi: qlogicpti: Fix an error handling path in 'qpti_sbus_probe()'
Date: Thu, 10 May 2018 13:45:58 +0200
Message-Id: <20180510114558.20769-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'free_irq()' call is not at the right place in the error handling path.
The changed order has been introduced in commit 3d4253d9afab
("[SCSI] qlogicpti: Convert to new SBUS device framework.")

Fixes: 3d4253d9afab ("[SCSI] qlogicpti: Convert to new SBUS device framework.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Please review carefully.  This patch is proposed because it triggers one of
my coccinelle scripts. I'm not 100% sure if correct.

The script tries to spot wrongly ordered error handling path. It is:
@@
identifier l1, l2;
@@

  if (...) {
     ...
*     goto l1;
  }
  ...
  if (...) {
     ...
*     goto l2;
  }
  ...
*l1:
  ...
*l2:
  ...
---
 drivers/scsi/qlogicpti.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index cec9a14982e6..8578e566ab41 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1385,6 +1385,9 @@ static int qpti_sbus_probe(struct platform_device *op)
 			  qpti->req_cpu, qpti->req_dvma);
 #undef QSIZE
 
+fail_free_irq:
+	free_irq(qpti->irq, qpti);
+
 fail_unmap_regs:
 	of_iounmap(&op->resource[0], qpti->qregs,
 		   resource_size(&op->resource[0]));
@@ -1392,9 +1395,6 @@ static int qpti_sbus_probe(struct platform_device *op)
 		of_iounmap(&op->resource[0], qpti->sreg,
 			   sizeof(unsigned char));
 
-fail_free_irq:
-	free_irq(qpti->irq, qpti);
-
 fail_unlink:
 	scsi_host_put(host);
 
-- 
2.17.0
