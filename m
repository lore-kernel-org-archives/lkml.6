Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F39C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D362087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfA3IZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:25:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2699 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbfA3IZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:25:54 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C3DC751258FFD29DE41B;
        Wed, 30 Jan 2019 16:25:51 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 16:25:45 +0800
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
Subject: [PATCH v2 1/7] scsi: libsas: reset the negotiated_linkrate when phy is down
Date:   Wed, 30 Jan 2019 16:24:06 +0800
Message-ID: <20190130082412.9357-2-yanaijie@huawei.com>
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

If the device is unplugged or disconnected, the negotiated_linkrate
still can be seen from the userspace by sysfs. This makes people
confused and leaks information of the device last used. So let's reset
the negotiated_linkrate after the phy is down.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: Johannes Thumshirn <jthumshirn@suse.de>
CC: Ewan Milne <emilne@redhat.com>
CC: Christoph Hellwig <hch@lst.de>
CC: Tomas Henzl <thenzl@redhat.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/libsas/sas_expander.c | 2 ++
 include/scsi/libsas.h              | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 17eb4185f29d..7b0e6dcef6e6 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1904,6 +1904,8 @@ static void sas_unregister_devs_sas_addr(struct domain_device *parent,
 				&parent->port->sas_port_del_list);
 		phy->port = NULL;
 	}
+	if (phy->phy)
+		phy->phy->negotiated_linkrate = SAS_LINK_RATE_UNKNOWN;
 }
 
 static int sas_discover_bfs_by_root_level(struct domain_device *root,
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 3de3b10da19a..420156cea3ee 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -448,6 +448,9 @@ static inline void sas_phy_disconnected(struct asd_sas_phy *phy)
 {
 	phy->oob_mode = OOB_NOT_CONNECTED;
 	phy->linkrate = SAS_LINK_RATE_UNKNOWN;
+
+	if (phy->phy)
+		phy->phy->negotiated_linkrate = SAS_LINK_RATE_UNKNOWN;
 }
 
 static inline unsigned int to_sas_gpio_od(int device, int bit)
-- 
2.14.4

