Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeBXWow (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 17:44:52 -0500
Received: from agrajag.zerfleddert.de ([88.198.237.222]:33132 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeBXWow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 17:44:52 -0500
Date: Sat, 24 Feb 2018 23:44:50 +0100
From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: xiic: Fix PM device usage count
Message-ID: <20180224224450.jss3gdnpsdhlfswk@agrajag.zerfleddert.de>
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

Fixes: 36ecbcab84d0 ("i2c: xiic: Implement power management")
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
---
This is one of a number of patches for problems found using coccinelle 
scripting in the SIL2LinuxMP project. The patch has been compile-tested;
it's based on linux-next-20180223.

For a discussion of the corresponding issue, see
https://marc.info/?l=linux-pm&m=151904483924999&w=2

 drivers/i2c/busses/i2c-xiic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index ae6ed254e01d..fd03e40ca832 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -682,8 +682,10 @@ static int xiic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		xiic_getreg8(i2c, XIIC_SR_REG_OFFSET));
 
 	err = pm_runtime_get_sync(i2c->dev);
-	if (err < 0)
+	if (err < 0) {
+		pm_runtime_put_noidle(i2c->dev);
 		return err;
+	}
 
 	err = xiic_busy(i2c);
 	if (err)
-- 
2.11.0
