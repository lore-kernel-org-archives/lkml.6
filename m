Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754907AbeEaL16 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:27:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8223 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754600AbeEaLWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:22:38 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        Jaroslav Kysela <perex@perex.cz>, <netdev@vger.kernel.org>
Subject: [PATCH v2 05/21] hp100: use match_string() helper
Date: Thu, 31 May 2018 19:11:10 +0800
Message-ID: <1527765086-19873-6-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: netdev@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v2:
 - add Reviewed-by tag.

 drivers/net/ethernet/hp/hp100.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hp/hp100.c b/drivers/net/ethernet/hp/hp100.c
index c8c7ad2..84501b3 100644
--- a/drivers/net/ethernet/hp/hp100.c
+++ b/drivers/net/ethernet/hp/hp100.c
@@ -335,7 +335,6 @@ static const char *hp100_read_id(int ioaddr)
 static __init int hp100_isa_probe1(struct net_device *dev, int ioaddr)
 {
 	const char *sig;
-	int i;
 
 	if (!request_region(ioaddr, HP100_REGION_SIZE, "hp100"))
 		goto err;
@@ -351,13 +350,7 @@ static __init int hp100_isa_probe1(struct net_device *dev, int ioaddr)
 	if (sig == NULL)
 		goto err;
 
-	for (i = 0; i < ARRAY_SIZE(hp100_isa_tbl); i++) {
-		if (!strcmp(hp100_isa_tbl[i], sig))
-			break;
-
-	}
-
-	if (i < ARRAY_SIZE(hp100_isa_tbl))
+	if (match_string(hp100_isa_tbl, ARRAY_SIZE(hp100_isa_tbl), sig) >= 0)
 		return hp100_probe1(dev, ioaddr, HP100_BUS_ISA, NULL);
  err:
 	return -ENODEV;
-- 
1.7.12.4
