Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755923AbeEaS21 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:28:27 -0400
Received: from mail.ispras.ru ([83.149.199.45]:46744 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755826AbeEaS20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:28:26 -0400
From: Peter Melnichenko <melnichenko@ispras.ru>
To: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: Peter Melnichenko <melnichenko@ispras.ru>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] aic94xx: set error code on an error path in aic94xx_init
Date: Thu, 31 May 2018 21:28:14 +0300
Message-Id: <1527791294-21600-1-git-send-email-melnichenko@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sas_domain_attach_transport returns NULL, aic94xx_init
frees acquired resources but returns err equal to 0, as
assigned by a previous statement.

The patch sets err to -ENOMEM before jumping to the error label.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Peter Melnichenko <melnichenko@ispras.ru>
---
 drivers/scsi/aic94xx/aic94xx_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 6c83886..4a4746c 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -1030,8 +1030,10 @@ static int __init aic94xx_init(void)
 
 	aic94xx_transport_template =
 		sas_domain_attach_transport(&aic94xx_transport_functions);
-	if (!aic94xx_transport_template)
+	if (!aic94xx_transport_template) {
+		err = -ENOMEM;
 		goto out_destroy_caches;
+	}
 
 	err = pci_register_driver(&aic94xx_pci_driver);
 	if (err)
-- 
2.7.4
