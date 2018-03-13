Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932094AbeCMNQJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:16:09 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56407 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeCMNQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:16:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] of: unittest: move misplaced function declaration
Date: Tue, 13 Mar 2018 14:15:42 +0100
Message-Id: <20180313131600.85356-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:Lj6atJ1MLBC3rJqIaDHzIpGHrbjTFXxDDVVbnY2TKFeomJck0Pt
 k2GowvA0Dz0sf5i7n2+8+N/gkd8cPWUnvWr2ccaWTPabnsEcoKhEKHpMJT7cIChRWVdO9Mx
 BCq1i+P+gZnu3el0M/KLctmE2zyP7pFQEtJ1y0/bBSdiVqkhN32pgX1tWrU/ed1doOQOrj+
 TxBtS4aC9QAwesiYYZGIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pis0q6pz1Cs=:+CwWARWzRuRwaFETTsCT66
 sGCkWdSkJvwpOevuXD3CIAtB+OT1pgpU9PpgnPe76gMvqLlE7Iwd87GJsxB2fnF+Q8ABu5XvW
 BuBhpf8dIAgqpCUgZAG4rZA5ZT34LB5nfi7n8l9/wleWeRzcgK3ENsB3pO+UYbNTN5KepY+jG
 Oz1YKSl/jvRp5U91yhIBpAjgOSwow+kaFJfgW7wn4X2fT4y10Q3rglC9UyNElEIF1p+jVx7ro
 ZB/MzbrU1cUIm03T9xvuBk3GLVAhB9IU8Q6xiF6fVRrhHzbRegWWu4P0jWhlxV5Ed4zZLPjwZ
 ZIPIRENmklcE1+rQjjqhuYs4AYcL97JozZgZj8nFrIoGyd/vQ6KccqS9JP66wnYnouL/gnjRw
 dj6zDbwdNr2ZnxQFgnUx5H24vaoYMWLJCYF6iJBSPwG0Bjusiui+XLg7GNz1oGQ7UygxmPSED
 5DQwDf9cnwv4cDoSmuEC+dCyQqoWJZbTXCppn9OnFHadEu+4oOHcYqK9PO9MhoKPrFEcwwyjx
 eryAf+k/ZziS+bByEjdZtb+aYPtNZseFuY7K4YMummXehA8brrUBtMop/dyrYrnDGsOZWBxSE
 ZVOJ/QgPTe+qf7fnJURWLxm71eTxR8TtsPtt6IjvsAtlDD9TdXOEpUWfRPckQSP2hl8cWOZ1n
 Vs1dUZmLiG6s2G7yWoEMJmIOIQ/0MQK7bkqD/4PpehW/S2Wboo1YI3MJOAgn873wZ9/ni2y/h
 LFyuM4bcIVYKkQsJz5kgovtCpVU/3P/+p43cFQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The overlay_data_apply() declaration is outside of the #ifdef that contains
both the user and the definition, causing a compile-time warning in
some configurations:

drivers/of/unittest.c:48:19: error: 'overlay_data_apply' declared 'static' but never defined [-Werror=unused-function]
 static int __init overlay_data_apply(const char *overlay_name, int *overlay_id);

This moves the declaration into the #ifdef section.

Fixes: 39a751a4cb7e ("of: change overlay apply input data from unflattened to FDT")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/of/unittest.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index dede77a79820..260d5245491b 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -45,8 +45,6 @@ static struct unittest_results {
 	failed; \
 })
 
-static int __init overlay_data_apply(const char *overlay_name, int *overlay_id);
-
 static void __init of_unittest_find_node_by_name(void)
 {
 	struct device_node *np;
@@ -1185,6 +1183,7 @@ static int __init unittest_data_add(void)
 }
 
 #ifdef CONFIG_OF_OVERLAY
+static int __init overlay_data_apply(const char *overlay_name, int *overlay_id);
 
 static int unittest_probe(struct platform_device *pdev)
 {
-- 
2.9.0
