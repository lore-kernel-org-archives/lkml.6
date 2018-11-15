Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D51BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E66A20868
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E66A20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbeKOU05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:26:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728801AbeKOU0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:26:34 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4D2DE73D9FC37;
        Thu, 15 Nov 2018 18:19:14 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Thu, 15 Nov 2018 18:19:08 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <hare@suse.com>, <yanaijie@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <joe@perches.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 2/5] scsi: libsas: Use pr_fmt(fmt)
Date:   Thu, 15 Nov 2018 18:20:29 +0800
Message-ID: <1542277232-135789-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1542277232-135789-1-git-send-email-john.garry@huawei.com>
References: <1542277232-135789-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for dropping the libsas printk wrappers, use pr_fmt(fmt)
declaration to add the framework log prefix - "sas".

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_ata.c      |  2 +-
 drivers/scsi/libsas/sas_internal.h | 13 +++++++++++--
 drivers/scsi/libsas/sas_task.c     |  3 +++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 4f6cdf5..9f3521f 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -375,7 +375,7 @@ static int sas_ata_printk(const char *level, const struct domain_device *ddev,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	r = printk("%ssas: ata%u: %s: %pV",
+	r = printk("%s" SAS_FMT "ata%u: %s: %pV",
 		   level, ap->print_id, dev_name(dev), &vaf);
 
 	va_end(args);
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 50e12d6..94ebf41 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -32,9 +32,18 @@
 #include <scsi/libsas.h>
 #include <scsi/sas_ata.h>
 
-#define sas_printk(fmt, ...) printk(KERN_NOTICE "sas: " fmt, ## __VA_ARGS__)
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define SAS_FMT "sas: "
+
+#define pr_fmt(fmt) SAS_FMT fmt
+
+#define sas_printk(fmt, ...) printk(KERN_NOTICE fmt, ## __VA_ARGS__)
+
+#define SAS_DPRINTK(fmt, ...) printk(KERN_DEBUG fmt, ## __VA_ARGS__)
 
-#define SAS_DPRINTK(fmt, ...) printk(KERN_DEBUG "sas: " fmt, ## __VA_ARGS__)
 
 #define TO_SAS_TASK(_scsi_cmd)  ((void *)(_scsi_cmd)->host_scribble)
 #define ASSIGN_SAS_TASK(_sc, _t) do { (_sc)->host_scribble = (void *) _t; } while (0)
diff --git a/drivers/scsi/libsas/sas_task.c b/drivers/scsi/libsas/sas_task.c
index a78e5bd..d305c8f 100644
--- a/drivers/scsi/libsas/sas_task.c
+++ b/drivers/scsi/libsas/sas_task.c
@@ -1,3 +1,6 @@
+
+#include "sas_internal.h"
+
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <scsi/sas.h>
-- 
1.9.1

