Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeEUMOv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:14:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38741 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751075AbeEUMJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:06 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>
Subject: [PATCH 17/33] pinctrl: armada-37xx: use match_string() helper
Date: Mon, 21 May 2018 19:57:54 +0800
Message-ID: <1526903890-35761-18-git-send-email-xieyisheng1@huawei.com>
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

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 5b63248..e338327 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -214,18 +214,6 @@ static inline void armada_37xx_update_reg(unsigned int *reg,
 	}
 }
 
-static int armada_37xx_get_func_reg(struct armada_37xx_pin_group *grp,
-				    const char *func)
-{
-	int f;
-
-	for (f = 0; (f < NB_FUNCS) && grp->funcs[f]; f++)
-		if (!strcmp(grp->funcs[f], func))
-			return f;
-
-	return -ENOTSUPP;
-}
-
 static struct armada_37xx_pin_group *armada_37xx_find_next_grp_by_pin(
 	struct armada_37xx_pinctrl *info, int pin, int *grp)
 {
@@ -344,10 +332,10 @@ static int armada_37xx_pmx_set_by_name(struct pinctrl_dev *pctldev,
 	dev_dbg(info->dev, "enable function %s group %s\n",
 		name, grp->name);
 
-	func = armada_37xx_get_func_reg(grp, name);
+	func = match_string(grp->funcs, NB_FUNCS, name);
 
 	if (func < 0)
-		return func;
+		return -ENOTSUPP;
 
 	val = grp->val[func];
 
-- 
1.7.12.4
