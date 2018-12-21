Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DD1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF582173C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388842AbeLUJr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:47:58 -0500
Received: from asrmicro.com ([210.13.118.86]:6362 "EHLO mail2012.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbeLUJr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:47:57 -0500
X-Greylist: delayed 910 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Dec 2018 04:47:57 EST
Received: from localhost (10.1.166.151) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 21 Dec 2018 17:32:09
 +0800
From:   Yi Zeng <yizeng@asrmicro.com>
To:     <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Yi Zeng <yizeng@asrmicro.com>
Subject: [PATCH] i2c: dev: prevent adapter retries being set as minus value
Date:   Fri, 21 Dec 2018 17:32:06 +0800
Message-ID: <1545384726-12463-1-git-send-email-yizeng@asrmicro.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.166.151]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If set adapter->retries to minus value from user space via ioctl,
will make __i2c_transfer and __i2c_smbus_xfer jump the calling to
adapter->algo->master_xfer and adapter->algo->smbus_xfer that
registered by the underlying bus drivers, and return value 0 to
all the callers. The bus driver will never be accessed anymore by
all users, besides, the users may still get successful return value
with no any error or information log print out.

Signed-off-by: Yi Zeng <yizeng@asrmicro.com>
---
 drivers/i2c/i2c-dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 1aca742..c349f58 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -470,6 +470,14 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 					  data_arg.data);
 	}
 	case I2C_RETRIES:
+		/*
+		 * The adapter->retries is defined as int type, and as
+		 * the upper limit for times of i2c transfer retry when
+		 * get -EAGAIN, it should not be set as minus value.
+		 */
+		if ((int)arg < 0)
+			return -EINVAL;
+
 		client->adapter->retries = arg;
 		break;
 	case I2C_TIMEOUT:
-- 
1.9.1

