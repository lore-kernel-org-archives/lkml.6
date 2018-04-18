Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeDRARH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 20:17:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41130 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeDRARG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 20:17:06 -0400
X-Google-Smtp-Source: AIpwx4+bLH2J2gfjxwSHIVADmPF30mb4nGOOxwR+AIf2/D+EPp+TRdP/Wcpf2b60CdEuSgyA7x9uaw==
From: Alexander Popov <alex.popov@linux.com>
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, sil2review@lists.osadl.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Popov <alex.popov@linux.com>
Subject: [PATCH 1/1] i2c: dev: check i2c_msg len before memdup_user() to prevent ZERO_SIZE_PTR deref
Date: Wed, 18 Apr 2018 03:16:45 +0300
Message-Id: <1524010605-21552-1-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently i2cdev_ioctl_rdwr() doesn't check i2c_msg len against zero
before calling memdup_user(). If this len is zero memdup_user() returns
ZERO_SIZE_PTR, which is later considered as valid since
IS_ERR(ZERO_SIZE_PTR) is false. That causes ZERO_SIZE_PTR deref oops.

Let's check i2c_msg len against zero before calling memdup_user().

This issue was triggered by syzkaller.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 drivers/i2c/i2c-dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 036a03f..b9b6715 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -252,8 +252,8 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 
 	res = 0;
 	for (i = 0; i < nmsgs; i++) {
-		/* Limit the size of the message to a sane amount */
-		if (msgs[i].len > 8192) {
+		/* Check that the size is sane */
+		if (!msgs[i].len || msgs[i].len > 8192) {
 			res = -EINVAL;
 			break;
 		}
-- 
2.7.4
