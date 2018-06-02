Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeFBWW3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 18:22:29 -0400
Received: from mail.ispras.ru ([83.149.199.45]:34728 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751342AbeFBWW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 18:22:28 -0400
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Sebastian Reichel <sre@kernel.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Julia Lawall <julia.lawall@lip6.fr>, sil2review@lists.osadl.org
Subject: [PATCH] power: reset: zx-reboot: put device node in zx_reboot_probe()
Date: Sun,  3 Jun 2018 01:22:05 +0300
Message-Id: <1527978125-29850-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zx_reboot_probe() increments refcnt of zx296702-pcu device node by
of_find_compatible_node() and leaves it undecremented on both
successful and error paths.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/power/reset/zx-reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/zx-reboot.c b/drivers/power/reset/zx-reboot.c
index c03e96e6a041..186901c96c01 100644
--- a/drivers/power/reset/zx-reboot.c
+++ b/drivers/power/reset/zx-reboot.c
@@ -51,6 +51,7 @@ static int zx_reboot_probe(struct platform_device *pdev)
 
 	np = of_find_compatible_node(NULL, NULL, "zte,zx296702-pcu");
 	pcu_base = of_iomap(np, 0);
+	of_node_put(np);
 	if (!pcu_base) {
 		iounmap(base);
 		WARN(1, "failed to map pcu_base address");
-- 
2.7.4
