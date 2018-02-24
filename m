Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbeBXWnG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 17:43:06 -0500
Received: from agrajag.zerfleddert.de ([88.198.237.222]:33082 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbeBXWnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 17:43:05 -0500
Date: Sat, 24 Feb 2018 23:43:03 +0100
From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: img-scb: fix PM device usage count
Message-ID: <20180224224303.3mpwhal2axcr6aos@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync() increases the device's usage count even when
reporting an error, so add a call to pm_runtime_put_noidle() in the
error branch.

Fixes: 93222bd9b966 ("i2c: img-scb: Add runtime PM")
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
---
This is one of a number of patches for problems found using coccinelle 
scripting in the SIL2LinuxMP project. The patch has been compile-tested;
it's based on linux-next-20180223.

For a discussion of the corresponding issue, see
https://marc.info/?l=linux-pm&m=151904483924999&w=2

 drivers/i2c/busses/i2c-img-scb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index f038858b6c54..569a1a8a2753 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -1061,8 +1061,10 @@ static int img_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	}
 
 	ret = pm_runtime_get_sync(adap->dev.parent);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(adap->dev.parent);
 		return ret;
+	}
 
 	for (i = 0; i < num; i++) {
 		struct i2c_msg *msg = &msgs[i];
@@ -1162,8 +1164,10 @@ static int img_i2c_init(struct img_i2c *i2c)
 	int ret;
 
 	ret = pm_runtime_get_sync(i2c->adap.dev.parent);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(i2c->adap.dev.parent);
 		return ret;
+	}
 
 	rev = img_i2c_readl(i2c, SCB_CORE_REV_REG);
 	if ((rev & 0x00ffffff) < 0x00020200) {
-- 
2.11.0
