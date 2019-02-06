Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EFAC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6ED20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfBFRkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:40:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46836 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730103AbfBFRkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:40:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id CD87E27977F
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, lee.jones@linaro.org, gwendal@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] mfd: cros_ec_dev: Return number of bytes read with CROS_EC_DEV_IOCRDMEM
Date:   Wed,  6 Feb 2019 18:39:59 +0100
Message-Id: <20190206173959.23925-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

While ioctls normally return a negative error or 0 on success, this is not
the case for CROS_EC_DEV_IOCXCMD in the cros_ec driver, which returns the
number of bytes read instead. However, CROS_EC_DEV_IOCRDMEM in the same
driver does not return the number of byte read on success. This is both
inconsistent and problematic, since the amount of returned data can be
dynamic. Have it return the number of data bytes for consistency.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Hi,

This patch was send long time ago and never landed to mainline [1]. This
is a second attempt. Originally was made to apply on platform/chrome but
after the recent changes we did it should go now throught the MFD
subsystem. Without this patch userspace tools like ectool doesn't work
as expected.

Best regards,
 Enric

[1] https://lore.kernel.org/patchwork/patch/665211/

Changes in v2:
- Adapt and rebase to current mainline.

 drivers/mfd/cros_ec_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index ed809fc97df8..d275deaecb12 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -224,7 +224,7 @@ static long ec_device_ioctl_readmem(struct cros_ec_dev *ec, void __user *arg)
 	if (copy_to_user((void __user *)arg, &s_mem, sizeof(s_mem)))
 		return -EFAULT;
 
-	return 0;
+	return num;
 }
 
 static long ec_device_ioctl(struct file *filp, unsigned int cmd,
-- 
2.20.1

