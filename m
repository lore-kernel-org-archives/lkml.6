Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754878AbeDDCbJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 22:31:09 -0400
Received: from m50-134.163.com ([123.125.50.134]:56894 "EHLO m50-134.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752775AbeDDCbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 22:31:08 -0400
From: Xidong Wang <wangxidong_97@163.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jack Wang <jinpu.wang@profitbricks.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Hannes Reinecke <hare@suse.de>
Cc: Kees Cook <keescook@chromium.org>, Pan Bian <bianpan2016@163.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Romain Perier <romain.perier@collabora.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] scsi: mvsas:fix memory leak
Date: Wed,  4 Apr 2018 10:15:20 +0800
Message-Id: <1522808120-11432-1-git-send-email-wangxidong_97@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DtGowAAHHCI_NcRaVNT9Ag--.25696S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1ktF4DXryDAw4kAw1kXwb_yoW3ZFb_WF
        Wjqr1xtrs0kw4kJw18uFsrZry0vw4fWa1kuFsIq34ayF1xZFn8Za1kuwnIvw4xGw48CFyU
        C3yDKr4fArnFvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn2YLDUUUUU==
X-Originating-IP: [218.106.182.185]
X-CM-SenderInfo: pzdqw5xlgr0wrbzxqiywtou0bp/1tbiDQYe81QHH93z7QAAsp
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function mvs_pci_init(), the memory allocated by
scsi_host_alloc() is not released on the error path that mvi,
which holds the return value of mvs_pci_alloc(), is NULL.
This will result in a memory leak bug.

Signed-off-by: Xidong Wang <wangxidong_97@163.com>
---
 drivers/scsi/mvsas/mv_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 8c91637..bde4b50 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -371,6 +371,7 @@ static struct mvs_info *mvs_pci_alloc(struct pci_dev *pdev,
 		(1L << mvs_chips[ent->driver_data].slot_width) *
 		sizeof(struct mvs_slot_info), GFP_KERNEL);
 	if (!mvi)
+		scsi_host_put(shost);
 		return NULL;
 
 	mvi->pdev = pdev;
-- 
2.7.4
