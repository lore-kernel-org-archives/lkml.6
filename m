Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C712C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E9F20817
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E9F20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbeKNXwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:52:09 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732432AbeKNXwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:52:09 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D3AECCBDDB3F1;
        Wed, 14 Nov 2018 21:46:53 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Wed, 14 Nov 2018 21:46:46 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <hare@suse.com>, <yanaijie@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <joe@perches.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 3/5] scsi: libsas: Drop sas_printk()
Date:   Wed, 14 Nov 2018 21:47:47 +0800
Message-ID: <1542203269-174932-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1542203269-174932-1-git-send-email-john.garry@huawei.com>
References: <1542203269-174932-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printk wrapper sas_printk() adds little value now that libsas logs
already have the "sas" prefix through pr_fmt(fmt), so just use
pr_notice() directly.

Originally-from: Joe Perches <joe@perches.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 22 +++++++++++-----------
 drivers/scsi/libsas/sas_init.c     |  4 ++--
 drivers/scsi/libsas/sas_internal.h |  2 --
 drivers/scsi/libsas/sas_phy.c      |  8 ++++----
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 0d1f727..fdc8384 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -393,7 +393,7 @@ static int sas_ex_phy_discover_helper(struct domain_device *dev, u8 *disc_req,
 		return res;
 	dr = &((struct smp_resp *)disc_resp)->disc;
 	if (memcmp(dev->sas_addr, dr->attached_sas_addr, SAS_ADDR_SIZE) == 0) {
-		sas_printk("Found loopback topology, just ignore it!\n");
+		pr_notice("Found loopback topology, just ignore it!\n");
 		return 0;
 	}
 	sas_set_ex_phy(dev, single, disc_resp);
@@ -1262,19 +1262,19 @@ static void sas_print_parent_topology_bug(struct domain_device *child,
 	};
 	struct domain_device *parent = child->parent;
 
-	sas_printk("%s ex %016llx phy 0x%x <--> %s ex %016llx "
-		   "phy 0x%x has %c:%c routing link!\n",
+	pr_notice("%s ex %016llx phy 0x%x <--> %s ex %016llx "
+		  "phy 0x%x has %c:%c routing link!\n",
 
-		   ex_type[parent->dev_type],
-		   SAS_ADDR(parent->sas_addr),
-		   parent_phy->phy_id,
+		  ex_type[parent->dev_type],
+		  SAS_ADDR(parent->sas_addr),
+		  parent_phy->phy_id,
 
-		   ex_type[child->dev_type],
-		   SAS_ADDR(child->sas_addr),
-		   child_phy->phy_id,
+		  ex_type[child->dev_type],
+		  SAS_ADDR(child->sas_addr),
+		  child_phy->phy_id,
 
-		   sas_route_char(parent, parent_phy),
-		   sas_route_char(child, child_phy));
+		  sas_route_char(parent, parent_phy),
+		  sas_route_char(child, child_phy));
 }
 
 static int sas_check_eeds(struct domain_device *child,
diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index ede0af7..a3c25e2 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -623,8 +623,8 @@ struct asd_sas_event *sas_alloc_event(struct asd_sas_phy *phy)
 	if (atomic_read(&phy->event_nr) > phy->ha->event_thres) {
 		if (i->dft->lldd_control_phy) {
 			if (cmpxchg(&phy->in_shutdown, 0, 1) == 0) {
-				sas_printk("The phy%02d bursting events, shut it down.\n",
-					phy->id);
+				pr_notice("The phy%02d bursting events, shut it down.\n",
+					  phy->id);
 				sas_notify_phy_event(phy, PHYE_SHUTDOWN);
 			}
 		} else {
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 30f4154..257f8ed 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -38,8 +38,6 @@
 
 #define pr_fmt(fmt) "sas: " fmt
 
-#define sas_printk(fmt, ...) printk(KERN_NOTICE fmt, ## __VA_ARGS__)
-
 #define SAS_DPRINTK(fmt, ...) printk(KERN_DEBUG fmt, ## __VA_ARGS__)
 
 
diff --git a/drivers/scsi/libsas/sas_phy.c b/drivers/scsi/libsas/sas_phy.c
index bf3e1b9..0374243 100644
--- a/drivers/scsi/libsas/sas_phy.c
+++ b/drivers/scsi/libsas/sas_phy.c
@@ -122,11 +122,11 @@ static void sas_phye_shutdown(struct work_struct *work)
 		phy->enabled = 0;
 		ret = i->dft->lldd_control_phy(phy, PHY_FUNC_DISABLE, NULL);
 		if (ret)
-			sas_printk("lldd disable phy%02d returned %d\n",
-				phy->id, ret);
+			pr_notice("lldd disable phy%02d returned %d\n",
+				  phy->id, ret);
 	} else
-		sas_printk("phy%02d is not enabled, cannot shutdown\n",
-			phy->id);
+		pr_notice("phy%02d is not enabled, cannot shutdown\n",
+			  phy->id);
 }
 
 /* ---------- Phy class registration ---------- */
-- 
1.9.1

