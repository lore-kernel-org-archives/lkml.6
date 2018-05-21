Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeEUMMn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:12:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752970AbeEUMJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:20 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH 18/33] power: supply: use match_string() helper
Date: Mon, 21 May 2018 19:57:55 +0800
Message-ID: <1526903890-35761-19-git-send-email-xieyisheng1@huawei.com>
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

Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/power/supply/power_supply_core.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index feac7b0..84da3a2 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -36,8 +36,6 @@
 static bool __power_supply_is_supplied_by(struct power_supply *supplier,
 					 struct power_supply *supply)
 {
-	int i;
-
 	if (!supply->supplied_from && !supplier->supplied_to)
 		return false;
 
@@ -45,18 +43,16 @@ static bool __power_supply_is_supplied_by(struct power_supply *supplier,
 	if (supply->supplied_from) {
 		if (!supplier->desc->name)
 			return false;
-		for (i = 0; i < supply->num_supplies; i++)
-			if (!strcmp(supplier->desc->name, supply->supplied_from[i]))
-				return true;
+		return match_string((const char **)supply->supplied_from,
+				    supply->num_supplies,
+				    supplier->desc->name) >= 0;
 	} else {
 		if (!supply->desc->name)
 			return false;
-		for (i = 0; i < supplier->num_supplicants; i++)
-			if (!strcmp(supplier->supplied_to[i], supply->desc->name))
-				return true;
+		return match_string((const char **)supplier->supplied_to,
+				    supplier->num_supplicants,
+				    supply->desc->name) >= 0;
 	}
-
-	return false;
 }
 
 static int __power_supply_changed_work(struct device *dev, void *data)
-- 
1.7.12.4
