Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbeEENCn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 09:02:43 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:32852 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeEENCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 09:02:41 -0400
X-Google-Smtp-Source: AB8JxZpSTJ6hH4049jGTZxDYG9o9WCWwg1zs8IPs4zWhb/JOrAHmO0QbmeI0QM+9EMKpqMQ76gelew==
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] i2c: core-smbus: fix a potential missing-check bug
Date: Sat,  5 May 2018 08:02:21 -0500
Message-Id: <1525525341-10046-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In i2c_smbus_xfer_emulated(), the function i2c_transfer() is invoked to
transfer i2c messages. The number of actual transferred messages is
returned and saved to 'status'. If 'status' is negative, that means an
error occurred during the transfer process. In that case, the value of
'status' is an error code to indicate the reason of the transfer failure.
In most cases, i2c_transfer() can transfer 'num' messages with no error.
And so 'status' == 'num'. However, due to unexpected errors, it is probable
that only partial messages are transferred by i2c_transfer(). As a result,
'status' != 'num'. This special case is not checked after the invocation of
i2c_transfer() and can potentially lead to unexpected issues in the
following execution since it is expected that 'status' == 'num'.

This patch checks the return value of i2c_transfer() and returns an error
code -EIO if the number of actual transferred messages 'status' is not
equal to 'num'.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/i2c/i2c-core-smbus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 7d7700f..e7a2d2f 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -467,6 +467,8 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 	status = i2c_transfer(adapter, msg, num);
 	if (status < 0)
 		return status;
+	if (status != num)
+		return -EIO;
 
 	/* Check PEC if last message is a read */
 	if (i && (msg[num-1].flags & I2C_M_RD)) {
-- 
2.7.4
