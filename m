Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693A2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389DA20859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfAGMhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:37:55 -0500
Received: from asrmicro.com ([210.13.118.86]:32362 "EHLO spam.asrmicro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727616AbfAGMhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:37:53 -0500
Received: from mail2012.asrmicro.com (mail2012.asrmicro.com [10.1.24.123])
        by spam.asrmicro.com with ESMTP id x07CbKdU086898;
        Mon, 7 Jan 2019 20:37:20 +0800 (GMT-8)
        (envelope-from yizeng@asrmicro.com)
Received: from localhost (10.1.166.151) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 7 Jan 2019 20:37:45
 +0800
From:   Yi Zeng <yizeng@asrmicro.com>
To:     <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Yi Zeng <yizeng@asrmicro.com>
Subject: [PATCH] i2c: dev: prevent adapter retries and timeout being set as minus value
Date:   Mon, 7 Jan 2019 20:37:41 +0800
Message-ID: <1546864661-19407-1-git-send-email-yizeng@asrmicro.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.166.151]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
X-DNSRBL: 
X-MAIL: spam.asrmicro.com x07CbKdU086898
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
without any error or information log print out.

If set adapter->timeout to minus value from user space via ioctl,
will make the retrying loop in __i2c_transfer and __i2c_smbus_xfer
always break after the the first try, due to the time_after always
returns true.

Signed-off-by: Yi Zeng <yizeng@asrmicro.com>
---
 drivers/i2c/i2c-dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 1aca742..14d01f5 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -470,9 +470,15 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 					  data_arg.data);
 	}
 	case I2C_RETRIES:
+		if (arg > INT_MAX)
+			return -EINVAL;
+
 		client->adapter->retries = arg;
 		break;
 	case I2C_TIMEOUT:
+		if (arg > INT_MAX)
+                        return -EINVAL;
+
 		/* For historical reasons, user-space sets the timeout
 		 * value in units of 10 ms.
 		 */
-- 
1.9.1

