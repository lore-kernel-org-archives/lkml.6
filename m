Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932731AbeEaD2g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:28:36 -0400
Received: from regular1.263xmail.com ([211.150.99.130]:58856 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932637AbeEaD2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:28:34 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 183.57.25.242
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <56470a8d3e2f819420024ad18e7ef67c>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: djw@t-chip.com.cn
To: linux-rockchip@lists.infradead.org
Cc: Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] gpio: syscon: allow fetching syscon from parent node
Date: Thu, 31 May 2018 11:27:49 +0800
Message-Id: <1527737273-8387-2-git-send-email-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527737273-8387-1-git-send-email-djw@t-chip.com.cn>
References: <1527737273-8387-1-git-send-email-djw@t-chip.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko@sntech.de>

Syscon nodes can be a simple-mfd and the syscon-users then be declared
as children of this node. That way the parent-child structure can be
better represented for devices that are fully embedded in the syscon.

Therefore allow getting the syscon from the parent if neither
a special compatible nor a gpio,syscon-dev property is defined.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Levin Du <djw@t-chip.com.cn>
---

Changes in v3: None
Changes in v2: None
Changes in v1:
- New: allow fetching syscon from parent node in gpio-syscon driver

 drivers/gpio/gpio-syscon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 537cec7..7325b86 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -205,6 +205,8 @@ static int syscon_gpio_probe(struct platform_device *pdev)
 	} else {
 		priv->syscon =
 			syscon_regmap_lookup_by_phandle(np, "gpio,syscon-dev");
+		if (IS_ERR(priv->syscon) && np->parent)
+			priv->syscon = syscon_node_to_regmap(np->parent);
 		if (IS_ERR(priv->syscon))
 			return PTR_ERR(priv->syscon);
 
-- 
2.7.4
