Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE149C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D0320989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbfA3KMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:12:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34852 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726548AbfA3KMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:12:19 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B37E3F7188B61F68510A;
        Wed, 30 Jan 2019 18:12:16 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 18:12:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <hare@suse.de>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: libfc: Fix potential NULL pointer dereference
Date:   Wed, 30 Jan 2019 18:11:41 +0800
Message-ID: <20190130101141.20132-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential NULL pointer dereference in case
fc_rport_create() fails and returns NULL.

Fixes: 2580064b5ec6 ("scsi: libfc: Replace ->rport_create callback with function call")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/libfc/fc_lport.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
index ff943f4..e2a3551 100644
--- a/drivers/scsi/libfc/fc_lport.c
+++ b/drivers/scsi/libfc/fc_lport.c
@@ -250,6 +250,10 @@ static void fc_lport_ptp_setup(struct fc_lport *lport,
 	}
 	mutex_lock(&lport->disc.disc_mutex);
 	lport->ptp_rdata = fc_rport_create(lport, remote_fid);
+	if (!lport->ptp_rdata) {
+		mutex_unlock(&lport->disc.disc_mutex);
+		return;
+	}
 	kref_get(&lport->ptp_rdata->kref);
 	lport->ptp_rdata->ids.port_name = remote_wwpn;
 	lport->ptp_rdata->ids.node_name = remote_wwnn;
-- 
2.7.0


