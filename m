Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751802AbeEBWgf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 18:36:35 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:53754 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbeEBWgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 18:36:32 -0400
X-Google-Smtp-Source: AB8JxZqxSovJLaQq96rSMtG3on3YZYxeVZls0hCfVNjCbrNiMz2sJSrBrwjKjdAjGh6cjJSTPfr4qw==
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] i2c: core-smbus: fix a potential uninitialization bug
Date: Wed,  2 May 2018 17:36:21 -0500
Message-Id: <1525300581-27217-1-git-send-email-wang6495@umn.edu>
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
i2c_transfer(). Thus, it is possible that mgsbuf1 may still not be
uninitialized even after the invocation of the function i2c_transfer(). In
the following execution, the uninitialized msgbuf1 will be used, such as
for security checks. Since uninitialized values can be random and
arbitrary, this will cause undefined behaviors or even check bypass. For
example, it is expected that if the value of "size" is
I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larger
than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), the
value read from msgbuf1 is assigned to data->block[0], which can
potentially lead to invalid block write size, as demonstrated in the error
message.

This patch simply initializes the buffer msgbuf1 with 0 to avoid undefined
behaviors or security issues.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/i2c/i2c-core-smbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index b5aec33..0fcca75 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -324,7 +324,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 	 * somewhat simpler.
 	 */
 	unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
-	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
+	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2] = {0};
 	int num = read_write == I2C_SMBUS_READ ? 2 : 1;
 	int i;
 	u8 partial_pec = 0;
-- 
2.7.4
