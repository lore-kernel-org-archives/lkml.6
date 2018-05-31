Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755106AbeEaLZM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:25:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754762AbeEaLWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:22:43 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, "Eric Anholt" <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>, <linux-clk@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 08/21] clk: bcm2835: use match_string() helper
Date: Thu, 31 May 2018 19:11:13 +0800
Message-ID: <1527765086-19873-9-git-send-email-xieyisheng1@huawei.com>
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

Reviewed-by: Eric Anholt <eric@anholt.net>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v2:
 - donot change the type of i  - per Andy

 drivers/clk/bcm/clk-bcm2835.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index fa0d5c8..5e18433 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1395,7 +1395,7 @@ static struct clk_hw *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 	struct bcm2835_clock *clock;
 	struct clk_init_data init;
 	const char *parents[1 << CM_SRC_BITS];
-	size_t i, j;
+	size_t i;
 	int ret;
 
 	/*
@@ -1405,12 +1405,11 @@ static struct clk_hw *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 	for (i = 0; i < data->num_mux_parents; i++) {
 		parents[i] = data->parents[i];
 
-		for (j = 0; j < ARRAY_SIZE(cprman_parent_names); j++) {
-			if (strcmp(parents[i], cprman_parent_names[j]) == 0) {
-				parents[i] = cprman->real_parent_names[j];
-				break;
-			}
-		}
+		ret = match_string(cprman_parent_names,
+				   ARRAY_SIZE(cprman_parent_names),
+				   parents[i]);
+		if (ret >= 0)
+			parents[i] = cprman->real_parent_names[ret];
 	}
 
 	memset(&init, 0, sizeof(init));
-- 
1.7.12.4
