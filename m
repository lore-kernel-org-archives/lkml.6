Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CAAC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C4E2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfA3I0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:26:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2701 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbfA3IZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:25:58 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D39B661D8BCC729635C2;
        Wed, 30 Jan 2019 16:25:56 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 16:25:50 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>, <zhaohongjiang@huawei.com>,
        <hare@suse.com>, <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        <hch@lst.de>, <huangdaode@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <xiexiuqi@huawei.com>,
        <tj@kernel.org>, <miaoxie@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Ewan Milne <emilne@redhat.com>, Tomas Henzl <thenzl@redhat.com>
Subject: [PATCH v2 6/7] scsi: libsas: reset the phy address if discover failed
Date:   Wed, 30 Jan 2019 16:24:11 +0800
Message-ID: <20190130082412.9357-7-yanaijie@huawei.com>
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

When we failed to discover the device, the phy address is still kept
in ex_phy. So when the next time we revalidate this phy the
address and device type is the same, it will be considered as flutter
and will not be discovered again. So the device will not be brought up.

Fix this by reset the phy address to the initial value. Then
in the next revalidation the device will be discovered agian.

Tested-by: Chen Liangfei <chenliangfei1@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: Xiaofei Tan <tanxiaofei@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: Johannes Thumshirn <jthumshirn@suse.de>
CC: Ewan Milne <emilne@redhat.com>
CC: Christoph Hellwig <hch@lst.de>
CC: Tomas Henzl <thenzl@redhat.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/libsas/sas_expander.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 6e56ebdc2148..e781941a7088 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1100,6 +1100,13 @@ static int sas_ex_discover_dev(struct domain_device *dev, int phy_id)
 						 i, SAS_ADDR(ex->ex_phy[i].attached_sas_addr));
 			}
 		}
+	} else {
+		/* if we failed to discover this device, we have to
+		 * reset the expander phy attached address so that we
+		 * will not treat the phy as flutter in the next
+		 * revalidation
+		 */
+		memset(ex_phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
 	}
 
 	return res;
-- 
2.14.4

