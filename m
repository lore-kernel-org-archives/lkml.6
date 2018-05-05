Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbeEEM5b (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 08:57:31 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:36310 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751767AbeEEM50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 08:57:26 -0400
X-Google-Smtp-Source: AB8JxZpuYTxbq4xYyH2imktGTuRksy7+TES6RJqLzVQJJMkDV9l6JQsfNvwk9JI0rRolgjdw7b0YAQ==
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] i2c: core-smbus: fix a potential uninitialization bug
Date: Sat,  5 May 2018 07:57:10 -0500
Message-Id: <1525525030-9805-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In i2c_smbus_xfer_emulated(), there are two buffers: msgbuf0 and msgbuf1,
which are used to save a series of messages, as mentioned in the comment.
According to the value of the variable 'size', msgbuf0 is initialized to
various values. In contrast, msgbuf1 is left uninitialized until the
function i2c_transfer() is invoked. However, msgbuf1 is not always
initialized on all possible execution paths (implementation) of
i2c_transfer(). Thus, it is possible that msgbuf1 may still be
uninitialized even after the invocation of the function i2c_transfer(),
especially when the return value of ic2_transfer() is not checked properly.
In the following execution, the uninitialized msgbuf1 will be used, such as
for security checks. Since uninitialized values can be random and
arbitrary, this will cause undefined behaviors or even check bypass. For
example, it is expected that if the value of 'size' is
I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larger
than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), the
value read from msgbuf1 is assigned to data->block[0], which can
potentially lead to invalid block write size, as demonstrated in the error
message.

This patch initializes the first byte of msgbuf1 with 0 to avoid such
undefined behaviors or security issues.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/i2c/i2c-core-smbus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index b5aec33..7d7700f 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -344,6 +344,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 	};
 
 	msgbuf0[0] = command;
+	msgbuf1[0] = 0;
 	switch (size) {
 	case I2C_SMBUS_QUICK:
 		msg[0].len = 0;
-- 
2.7.4
