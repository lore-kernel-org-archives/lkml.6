Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753300AbeEAJqD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:46:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37106 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbeEAJqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:46:02 -0400
X-Google-Smtp-Source: AB8JxZqCJz7JWCjn1o7ubRkB8SwlLt6/6XQPQ7aImY5lcc1Ew4JJo09PgzdQ8ZR0zsys1udxGAvyEQ==
From: Lee Jones <lee.jones@linaro.org>
To: dan.carpenter@oracle.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/1] mfd: tps65911-comparator: Fix an off by one bug
Date: Tue,  1 May 2018 10:45:53 +0100
Message-Id: <20180501094553.31545-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The COMP1 and COMP2 elements are in 0 and 1 respectively so this code is
accessing the wrong elements and one space beyond the end of the array.

The "id" variable is never COMP (0) so that code can be removed.

Fixes: 6851ad3ab346 ("TPS65911: Comparator: Add comparator driver")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---

History:

Dan was the originator of this patch and the author of the commit log,
but produced 2 code solutions which I wasn't happy with.  The first
submission [0] introduced a COMP device, which after a quick check of
the datasheet [1] appeared to be fictitious.  A subsequent submission
[2] conducted arithmetic in array indexes.

It is my belief that the correct solution is to roll which the
situation the hardware engineers presented us with and define COMP1
at position 0 and COMP2 at position 1 such that we can use the
simplest code possible to select them.

Dan wasn't happy to put his name to this, which I completely
understand.  Calling SOMETHING1 0 (zero) is a little unnatural.

However, since I have no shame, I offered to submit it.

[0] https://lkml.org/lkml/2018/4/19/449
[1] http://www.ti.com/lit/ds/symlink/tps65911.pdf (page 52)
[2] https://lkml.org/lkml/2018/4/20/204

drivers/mfd/tps65911-comparator.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/tps65911-comparator.c b/drivers/mfd/tps65911-comparator.c
index d223857fb4ad..33591767fb9b 100644
--- a/drivers/mfd/tps65911-comparator.c
+++ b/drivers/mfd/tps65911-comparator.c
@@ -22,9 +22,8 @@
 #include <linux/gpio.h>
 #include <linux/mfd/tps65910.h>
 
-#define COMP					0
-#define COMP1					1
-#define COMP2					2
+#define COMP1					0
+#define COMP2					1
 
 /* Comparator 1 voltage selection table in millivolts */
 static const u16 COMP_VSEL_TABLE[] = {
@@ -63,9 +62,6 @@ static int comp_threshold_set(struct tps65910 *tps65910, int id, int voltage)
 	int ret;
 	u8 index = 0, val;
 
-	if (id == COMP)
-		return 0;
-
 	while (curr_voltage < tps_comp.uV_max) {
 		curr_voltage = tps_comp.vsel_table[index];
 		if (curr_voltage >= voltage)
@@ -89,9 +85,6 @@ static int comp_threshold_get(struct tps65910 *tps65910, int id)
 	unsigned int val;
 	int ret;
 
-	if (id == COMP)
-		return 0;
-
 	ret = tps65910_reg_read(tps65910, tps_comp.reg, &val);
 	if (ret < 0)
 		return ret;
-- 
2.17.0
