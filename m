Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756020AbeE2COT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 22:14:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51316 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755996AbeE2COQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 22:14:16 -0400
From: Jason Yan <yanaijie@huawei.com>
To: <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>, <zhaohongjiang@huawei.com>, <hare@suse.com>,
        <dan.j.williams@intel.com>, <jthumshirn@suse.de>, <hch@lst.de>,
        <huangdaode@hisilicon.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>, <tj@kernel.org>, <miaoxie@huawei.com>,
        Jason Yan <yanaijie@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>,
        Ewan Milne <emilne@redhat.com>, Tomas Henzl <thenzl@redhat.com>
Subject: [PATCH 6/8] scsi: libsas: reset the phy state and address if discover failed
Date: Tue, 29 May 2018 10:23:07 +0800
Message-ID: <20180529022309.21071-7-yanaijie@huawei.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180529022309.21071-1-yanaijie@huawei.com>
References: <20180529022309.21071-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we failed to discover the device, the phy state and address is
still kept in ex_phy. So when the next time we revalidate this phy the
address and device type is the same, it will be considered as flutter
and will not be discovered again. So the device will not be brought up.

Fix this by reset the phy state and address to the initial value. Then
in the next revalidation the device will be discovered agian.

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
 drivers/scsi/libsas/sas_expander.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 4617eccb0c43..6b6de85466c6 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1107,6 +1107,15 @@ static int sas_ex_discover_dev(struct domain_device *dev, int phy_id)
 
 			}
 		}
+	} else {
+		/* if we failed to discover this device, we have to
+		 * reset the expander phy state and address so that we
+		 * will not treat the phy as flutter in the next
+		 * revalidation
+		 */
+		ex_phy->phy_state = PHY_VACANT;
+		ex_phy->attached_dev_type = SAS_PHY_UNUSED;
+		memset(ex_phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
 	}
 
 	return res;
-- 
2.13.6
