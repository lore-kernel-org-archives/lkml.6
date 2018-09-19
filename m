Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD8FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A05F20880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A05F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbeISJIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 05:08:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55040 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbeISJIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 05:08:48 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 47FF6FA10A29;
        Wed, 19 Sep 2018 11:32:55 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 11:32:48 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>, <zhaohongjiang@huawei.com>,
        <hare@suse.com>, <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        <hch@lst.de>, <huangdaode@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <miaoxie@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Ewan Milne <emilne@redhat.com>, Tomas Henzl <thenzl@redhat.com>
Subject: [PATCH v2 2/5] scsi: libsas: check the lldd callback correctly
Date:   Wed, 19 Sep 2018 11:32:01 +0800
Message-ID: <20180919033204.11102-3-yanaijie@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180919033204.11102-1-yanaijie@huawei.com>
References: <20180919033204.11102-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are using lldd_port_deformed so we'd better check if lldd_port_deformed
is NULL.

After this, we can remove hisi_sas_port_deformed() because it is just a
stub to avoid a NULL dereference caused by the wrong check.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: Johannes Thumshirn <jthumshirn@suse.de>
CC: Ewan Milne <emilne@redhat.com>
CC: Christoph Hellwig <hch@lst.de>
CC: Tomas Henzl <thenzl@redhat.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Hannes Reinecke <hare@suse.com>
Acked-by: John Garry <john.garry@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 9 ++-------
 drivers/scsi/libsas/sas_discover.c    | 2 +-
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index a4e2e6aa9a6b..1975c9266978 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1861,10 +1861,6 @@ static void hisi_sas_port_formed(struct asd_sas_phy *sas_phy)
 	hisi_sas_port_notify_formed(sas_phy);
 }
 
-static void hisi_sas_port_deformed(struct asd_sas_phy *sas_phy)
-{
-}
-
 static int hisi_sas_write_gpio(struct sas_ha_struct *sha, u8 reg_type,
 			u8 reg_index, u8 reg_count, u8 *write_data)
 {
@@ -1954,10 +1950,9 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
 	.lldd_I_T_nexus_reset	= hisi_sas_I_T_nexus_reset,
 	.lldd_lu_reset		= hisi_sas_lu_reset,
 	.lldd_query_task	= hisi_sas_query_task,
-	.lldd_clear_nexus_ha = hisi_sas_clear_nexus_ha,
+	.lldd_clear_nexus_ha	= hisi_sas_clear_nexus_ha,
 	.lldd_port_formed	= hisi_sas_port_formed,
-	.lldd_port_deformed = hisi_sas_port_deformed,
-	.lldd_write_gpio = hisi_sas_write_gpio,
+	.lldd_write_gpio	= hisi_sas_write_gpio,
 };
 
 void hisi_sas_init_mem(struct hisi_hba *hisi_hba)
diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index 0148ae62a52a..dde433aa59c2 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -260,7 +260,7 @@ static void sas_suspend_devices(struct work_struct *work)
 	 * phy_list is not being mutated
 	 */
 	list_for_each_entry(phy, &port->phy_list, port_phy_el) {
-		if (si->dft->lldd_port_formed)
+		if (si->dft->lldd_port_deformed)
 			si->dft->lldd_port_deformed(phy);
 		phy->suspended = 1;
 		port->suspended = 1;
-- 
2.14.4

