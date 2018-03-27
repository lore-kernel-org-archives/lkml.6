Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753066AbeC0N0E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:26:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45628 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbeC0N0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:26:02 -0400
From: Colin King <colin.king@canonical.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] libata: ensure host is free'd on error exit paths
Date: Tue, 27 Mar 2018 14:26:01 +0100
Message-Id: <20180327132601.12749-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The host structure is not being kfree'd on two error exit paths
leading to memory leaks. Add in new err_free label and kfree host.

Detected by CoverityScan, CID#1466103 ("Resource leak")

Fixes: 2623c7a5f279 ("libata: add refcounting to ata_host")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ata/libata-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dc2c48b8ae45..8bc71ca61e7f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6108,7 +6108,7 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 		return NULL;
 
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
-		return NULL;
+		goto err_free;
 
 	dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
 	if (!dr)
@@ -6140,6 +6140,8 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 
  err_out:
 	devres_release_group(dev, NULL);
+ err_free:
+	kfree(host);
 	return NULL;
 }
 
-- 
2.15.1
