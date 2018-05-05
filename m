Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeEEBn3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 21:43:29 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:44406 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeEEBn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 21:43:27 -0400
X-Google-Smtp-Source: AB8JxZqhLzcqYa+UDwKJiJEx6544pJ/A8qCBlRKXnGVB3ABefv64ZBL/PPev98E9qw5AbeIxkt1IZQ==
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] i2c: core-smbus: fix a potential uninitialization bug
Date: Fri,  4 May 2018 20:43:16 -0500
Message-Id: <1525484596-5585-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In i2c_smbus_xfer_emulated(), there are two buffers: msgbuf0 and msgbuf1,
which are used to save a series of messages, as mentioned in the comment.
According to the value of the variable "size", msgbuf0 is initialized to
various values. In contrast, msgbuf1 is left uninitialized until the
function i2c_transfer() is invoked. However, mgsbuf1 is not always
initialized on all possible execution paths (implementation) of
i2c_transfer(). Thus, it is possible that mgsbuf1 may still be
uninitialized even after the invocation of the function i2c_transfer(),
especially when the return value of ic2_transfer() is not checked properly.
In the following execution, the uninitialized msgbuf1 will be used, such as
for security checks. Since uninitialized values can be random and
arbitrary, this will cause undefined behaviors or even check bypass. For
example, it is expected that if the value of "size" is
I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larger
than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), the
value read from msgbuf1 is assigned to data->block[0], which can
potentially lead to invalid block write size, as demonstrated in the error
message.

This patch checks the return value of i2c_transfer() and also initializes
the first byte of msgbuf1 with 0 to avoid undefined behaviors or security
issues.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/i2c/i2c-core-smbus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index b5aec33..e8470d5 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -344,6 +344,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 	};
 
 	msgbuf0[0] = command;
+	msgbug1[0] = 0;
 	switch (size) {
 	case I2C_SMBUS_QUICK:
 		msg[0].len = 0;
@@ -466,6 +467,8 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 	status = i2c_transfer(adapter, msg, num);
 	if (status < 0)
 		return status;
+	if (status != num)
+		return -EIO;
 
 	/* Check PEC if last message is a read */
 	if (i && (msg[num-1].flags & I2C_M_RD)) {
-- 
2.7.4
