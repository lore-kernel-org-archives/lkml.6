Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43A7C282D6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A93721473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfA3I0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:26:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2703 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730256AbfA3IZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:25:58 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E19F0B1B2C21C26959D1;
        Wed, 30 Jan 2019 16:25:56 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 16:25:46 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>, <zhaohongjiang@huawei.com>,
        <hare@suse.com>, <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        <hch@lst.de>, <huangdaode@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <xiexiuqi@huawei.com>,
        <tj@kernel.org>, <miaoxie@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Ewan Milne <emilne@redhat.com>, Tomas Henzl <thenzl@redhat.com>
Subject: [PATCH v2 2/7] scsi: libsas: only clear phy->in_shutdown after shutdown event done
Date:   Wed, 30 Jan 2019 16:24:07 +0800
Message-ID: <20190130082412.9357-3-yanaijie@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190130082412.9357-1-yanaijie@huawei.com>
References: <20190130082412.9357-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the event queue is full of phy up and down events and reached the
threshold, we will queue a shutdown-event, and set phy->in_shutdown so
that we will not queue a shutdown-event again. But before the
shutdown-event can be executed, every phy-down event will clear
phy->in_shutdown and a new shutdown-event will be queued. The queue will
be full of these shutdown-events.

Fix this by only clear phy->in_shutdown in sas_phye_shutdown(), that is
after the first shutdown-event has been executed.

Fixes: f12486e06ae8 ("scsi: libsas: shut down the PHY if events reached the threshold")
Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: Johannes Thumshirn <jthumshirn@suse.de>
CC: Ewan Milne <emilne@redhat.com>
CC: Christoph Hellwig <hch@lst.de>
CC: Tomas Henzl <thenzl@redhat.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/libsas/sas_phy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/libsas/sas_phy.c b/drivers/scsi/libsas/sas_phy.c
index 0374243c85d0..762bb13cca74 100644
--- a/drivers/scsi/libsas/sas_phy.c
+++ b/drivers/scsi/libsas/sas_phy.c
@@ -35,7 +35,6 @@ static void sas_phye_loss_of_signal(struct work_struct *work)
 	struct asd_sas_event *ev = to_asd_sas_event(work);
 	struct asd_sas_phy *phy = ev->phy;
 
-	phy->in_shutdown = 0;
 	phy->error = 0;
 	sas_deform_port(phy, 1);
 }
@@ -45,7 +44,6 @@ static void sas_phye_oob_done(struct work_struct *work)
 	struct asd_sas_event *ev = to_asd_sas_event(work);
 	struct asd_sas_phy *phy = ev->phy;
 
-	phy->in_shutdown = 0;
 	phy->error = 0;
 }
 
@@ -127,6 +125,7 @@ static void sas_phye_shutdown(struct work_struct *work)
 	} else
 		pr_notice("phy%02d is not enabled, cannot shutdown\n",
 			  phy->id);
+	phy->in_shutdown = 0;
 }
 
 /* ---------- Phy class registration ---------- */
-- 
2.14.4

