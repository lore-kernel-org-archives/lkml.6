Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeDSM3m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:29:42 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45418 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeDSM3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:29:41 -0400
X-Google-Smtp-Source: AIpwx4/Zx9WqJcwTTjihtA7RHVzilc6tuTO930yqtYR9aWxM6MwWV24j3/1rL0BNOiTCAejJ+Hr9ZA==
From: Alexander Popov <alex.popov@linux.com>
To: Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        sil2review@lists.osadl.org, Dmitry Vyukov <dvyukov@google.com>,
        syzkaller@googlegroups.com, Alexander Popov <alex.popov@linux.com>
Subject: [v2 1/1] i2c: dev: prevent ZERO_SIZE_PTR deref in i2cdev_ioctl_rdwr()
Date: Thu, 19 Apr 2018 15:29:22 +0300
Message-Id: <1524140962-25639-1-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i2cdev_ioctl_rdwr() allocates i2c_msg.buf using memdup_user(), which
returns ZERO_SIZE_PTR if i2c_msg.len is zero.

Currently i2cdev_ioctl_rdwr() always dereferences the buf pointer in case
of I2C_M_RD | I2C_M_RECV_LEN transfer. That causes a kernel oops in
case of zero len.

Let's check the len against zero before dereferencing buf pointer.

This issue was triggered by syzkaller.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 drivers/i2c/i2c-dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 036a03f..5790bc8 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -280,6 +280,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		 */
 		if (msgs[i].flags & I2C_M_RECV_LEN) {
 			if (!(msgs[i].flags & I2C_M_RD) ||
+			    !msgs[i].len ||
 			    msgs[i].buf[0] < 1 ||
 			    msgs[i].len < msgs[i].buf[0] +
 					     I2C_SMBUS_BLOCK_MAX) {
-- 
2.7.4
