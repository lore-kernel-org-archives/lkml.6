Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbeEUMPf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:15:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38694 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752095AbeEUMJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:05 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>, <linux-ide@vger.kernel.org>
Subject: [PATCH 10/33] pata_hpt37x: use match_string() helper
Date: Mon, 21 May 2018 19:57:47 +0800
Message-ID: <1526903890-35761-11-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/ata/pata_hpt37x.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 3ba843f..ef8aaeb 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -224,17 +224,14 @@ static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
 			       const char * const list[])
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
-	int i = 0;
+	int i;
 
 	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 
-	while (list[i] != NULL) {
-		if (!strcmp(list[i], model_num)) {
-			pr_warn("%s is not supported for %s\n",
-				modestr, list[i]);
-			return 1;
-		}
-		i++;
+	i = match_string(list, -1, model_num);
+	if (i >= 0) {
+		pr_warn("%s is not supported for %s\n", modestr, list[i]);
+		return 1;
 	}
 	return 0;
 }
-- 
1.7.12.4
