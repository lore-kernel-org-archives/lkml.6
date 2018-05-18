Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeERV2D (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 17:28:03 -0400
Received: from mail.ispras.ru ([83.149.199.45]:38938 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751985AbeERV2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 17:28:00 -0400
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Peter Melnichenko <melnichenko@ispras.ru>
Subject: [PATCH] aic94xx: don't return zero on failure paths in aic94xx_init()
Date: Sat, 19 May 2018 00:27:18 +0300
Message-Id: <1526678838-31469-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If sas_domain_attach_transport() fails in aic94xx_init(),
it breaks off initialization, deallocates all resources, but returns zero.

The patch adds -ENOMEM as return value in this case.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Peter Melnichenko <melnichenko@ispras.ru>
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/scsi/aic94xx/aic94xx_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 6c838865ac5a..4a4746cc6745 100644
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
