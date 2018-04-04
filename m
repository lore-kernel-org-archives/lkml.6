Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755092AbeDDCiZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 22:38:25 -0400
Received: from m12-18.163.com ([220.181.12.18]:49633 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754682AbeDDCiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 22:38:23 -0400
From: Xidong Wang <wangxidong_97@163.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jack Wang <jinpu.wang@profitbricks.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: Kees Cook <keescook@chromium.org>, Pan Bian <bianpan2016@163.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Romain Perier <romain.perier@collabora.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] scsi:mvsas:fix memory leak
Date: Wed,  4 Apr 2018 10:37:52 +0800
Message-Id: <1522809472-11749-1-git-send-email-wangxidong_97@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EsCowACHLkeCOsRatf3rDA--.42347S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1ktF4DXryDAw4kAw1kXwb_yoWfArb_WF
        W0qrn7Jr4Ykwn7Jw18WrsFvryI9w4fWa1kuFsIqryayF1fZF4DAa18WrnxZw4xC3y8CFyU
        A34DJw4fArnFvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5aksDUUUUU==
X-Originating-IP: [106.120.213.14]
X-CM-SenderInfo: pzdqw5xlgr0wrbzxqiywtou0bp/1tbiyAge81p62HJpWAAAsW
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function mvs_pci_init(), the memory allocated by
scsi_host_alloc() is not released on the error path that mvi,
which holds the return value of mvs_pci_alloc(), is NULL.
This will result in a memory leak bug.

Signed-off-by: Xidong Wang <wangxidong_97@163.com>
---
 drivers/scsi/mvsas/mv_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 8c91637..936b8ef 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -370,8 +370,10 @@ static struct mvs_info *mvs_pci_alloc(struct pci_dev *pdev,
 	mvi = kzalloc(sizeof(*mvi) +
 		(1L << mvs_chips[ent->driver_data].slot_width) *
 		sizeof(struct mvs_slot_info), GFP_KERNEL);
-	if (!mvi)
+	if (!mvi) {
+		scsi_host_put(shost);
 		return NULL;
+	}
 
 	mvi->pdev = pdev;
 	mvi->dev = &pdev->dev;
-- 
2.7.4
