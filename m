Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277F0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000C1206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbfAIMmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:42:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17100 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730249AbfAIMmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:42:50 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1E052B75AF1960A9566E;
        Wed,  9 Jan 2019 20:42:46 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Wed, 9 Jan 2019 20:42:39 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dgilbert@interlog.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] scsi: hisi_sas: Use scsi lld debugfs folder
Date:   Wed, 9 Jan 2019 20:43:34 +0800
Message-ID: <1547037814-99911-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we now have a dedicated folder for scsi llds in the debugfs tree,
relocate the root of the driver debugfs folder to that same location.

Signed-off-by: John Garry <john.garry@huawei.com>
---
This patch depends on https://www.spinics.net/lists/linux-scsi/msg126764.html

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 6a1a5ad..ce527b7 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -26,6 +26,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <scsi/sas_ata.h>
+#include <scsi/scsi_dbg.h>
 #include <scsi/libsas.h>
 
 #define HISI_SAS_MAX_PHYS	9
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 3d24366..e27a06c 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2985,7 +2985,8 @@ static __init int hisi_sas_init(void)
 		return -ENOMEM;
 
 	if (hisi_sas_debugfs_enable)
-		hisi_sas_debugfs_dir = debugfs_create_dir("hisi_sas", NULL);
+		hisi_sas_debugfs_dir = debugfs_create_dir("hisi_sas",
+							  scsi_debugfs_lld);
 
 	return 0;
 }
-- 
1.9.1

