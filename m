Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeEUMJH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:09:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38632 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751685AbeEUMJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:00 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>, <netdev@vger.kernel.org>
Subject: [PATCH 05/33] cxgb4: use match_string() helper
Date: Mon, 21 May 2018 19:57:42 +0800
Message-ID: <1526903890-35761-6-git-send-email-xieyisheng1@huawei.com>
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

Cc: Ganesh Goudar <ganeshgr@chelsio.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
index 9da6f57..bd61610 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
@@ -782,17 +782,11 @@ static int cudbg_get_mem_region(struct adapter *padap,
 	if (rc)
 		return rc;
 
-	for (i = 0; i < ARRAY_SIZE(cudbg_region); i++) {
-		if (!strcmp(cudbg_region[i], region_name)) {
-			found = 1;
-			idx = i;
-			break;
-		}
-	}
-	if (!found)
-		return -EINVAL;
+	rc = match_string(cudbg_region, ARRAY_SIZE(cudbg_region), region_name);
+	if (rc < 0)
+		return rc;
 
-	found = 0;
+	idx = rc;
 	for (i = 0; i < meminfo->mem_c; i++) {
 		if (meminfo->mem[i].idx >= ARRAY_SIZE(cudbg_region))
 			continue; /* Skip holes */
-- 
1.7.12.4
