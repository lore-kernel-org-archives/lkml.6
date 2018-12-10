Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6011C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADBF2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADBF2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbeLJSAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:00:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43522 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeLJSAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:00:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 66467261098
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] mfd: cros_ec_dev: Add missing mfd_remove_devices() call in remove
Date:   Mon, 10 Dec 2018 19:00:02 +0100
Message-Id: <20181210180002.4440-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver adds different MFD child devices via mfd_add_devices() and
hence it is required to call mfd_remove_devices() to remove MFD child
devices.

Fixes: 5e0115581bbc ("cros_ec: Move cros_ec_dev module to drivers/mfd")
Cc: stable@vger.kernel.org
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Hi Lee,

I saw that you send a mfd-fixes pull request this morning, so sorry in
advance for sending this too late. This was broken since the driver
moved from platform/chrome to mfd (and probably before that), so
it's an old problem. Note that I plan to send a patch series that depends
on this to apply cleanly. If the patch is fine with you and there is any
possibility to go in this version that will be good, if not, let me know
if you prefer queue this in your for-next branch or if you prefer I
include the patch on the series I plan to send on top of it to not mess
things.

Thanks,
 Enric

 drivers/mfd/cros_ec_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index b99a194ce5a4..2d0fee488c5a 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -499,6 +499,7 @@ static int ec_device_remove(struct platform_device *pdev)
 
 	cros_ec_debugfs_remove(ec);
 
+	mfd_remove_devices(ec->dev);
 	cdev_del(&ec->cdev);
 	device_unregister(&ec->class_dev);
 	return 0;
-- 
2.19.2

