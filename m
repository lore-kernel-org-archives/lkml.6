Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F495C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BC620672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BC620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeLDP6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:58:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46094 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeLDP6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:58:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4433E26395B
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org, dtor@google.com,
        stable@vger.kernel.org
Subject: [PATCH] Revert "mfd: cros_ec: Use devm_kzalloc for private data"
Date:   Tue,  4 Dec 2018 16:58:43 +0100
Message-Id: <20181204155843.11411-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3aa2177e47878f7e7616da8a2050c44f22301b6e.

That commit triggered a new WARN when unloading the module (see at the
end of the commit message). When a class_dev is embedded in a structure
then that class_dev is the thing that controls the lifetime of that
structure, for that reason device managed allocations can't be used here.
See Documentation/kobject.txt.

Revert the above patch, so the struct is allocated using kzalloc and we
have a release function for it that frees the allocated memory, otherwise
it is broken.

 ------------[ cut here ]------------
 Device 'cros_ec' does not have a release() function, it is broken and must be fixed.
 WARNING: CPU: 3 PID: 3675 at drivers/base/core.c:895 device_release+0x80/0x90
 Modules linked in: btusb btrtl btintel btbcm bluetooth ...
 CPU: 3 PID: 3675 Comm: rmmod Not tainted 4.20.0-rc4 #76
 Hardware name: Google Kevin (DT)
 pstate: 40000005 (nZcv daif -PAN -UAO)
 pc : device_release+0x80/0x90
 lr : device_release+0x80/0x90
 sp : ffff00000c47bc70
 x29: ffff00000c47bc70 x28: ffff8000e86b0d40
 x27: 0000000000000000 x26: 0000000000000000
 x25: 0000000056000000 x24: 0000000000000015
 x23: ffff8000f0bbf860 x22: ffff000000d320a0
 x21: ffff8000ee93e100 x20: ffff8000ed931428
 x19: ffff8000ed931418 x18: 0000000000000020
 x17: 0000000000000000 x16: 0000000000000000
 x15: 0000000000000400 x14: 0000000000000143
 x13: 0000000000000000 x12: 0000000000000400
 x11: 0000000000000157 x10: 0000000000000960
 x9 : ffff00000c47b9b0 x8 : ffff8000e86b1700
 x7 : 0000000000000000 x6 : ffff8000f7d520b8
 x5 : ffff8000f7d520b8 x4 : 0000000000000000
 x3 : ffff8000f7d58e68 x2 : ffff8000e86b0d40
 x1 : 37d859939c964800 x0 : 0000000000000000
 Call trace:
  device_release+0x80/0x90
  kobject_put+0x74/0xe8
  device_unregister+0x20/0x30
  ec_device_remove+0x34/0x48 [cros_ec_dev]
  platform_drv_remove+0x28/0x48
  device_release_driver_internal+0x1a8/0x240
  driver_detach+0x40/0x80
  bus_remove_driver+0x54/0xa8
  driver_unregister+0x2c/0x58
  platform_driver_unregister+0x10/0x18
  cros_ec_dev_exit+0x1c/0x2d8 [cros_ec_dev]
  __arm64_sys_delete_module+0x16c/0x1f8
  el0_svc_common+0x84/0xd8
  el0_svc_handler+0x2c/0x80
  el0_svc+0x8/0xc
 ---[ end trace a57c4625f3c60ae8 ]---

Cc: stable@vger.kernel.org
Fixes: 3aa2177e4787 ("mfd: cros_ec: Use devm_kzalloc for private data")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/mfd/cros_ec_dev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 8f9d6964173e..b99a194ce5a4 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -263,6 +263,11 @@ static const struct file_operations fops = {
 #endif
 };
 
+static void cros_ec_class_release(struct device *dev)
+{
+	kfree(to_cros_ec_dev(dev));
+}
+
 static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 {
 	/*
@@ -395,7 +400,7 @@ static int ec_device_probe(struct platform_device *pdev)
 	int retval = -ENOMEM;
 	struct device *dev = &pdev->dev;
 	struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
-	struct cros_ec_dev *ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
+	struct cros_ec_dev *ec = kzalloc(sizeof(*ec), GFP_KERNEL);
 
 	if (!ec)
 		return retval;
@@ -417,6 +422,7 @@ static int ec_device_probe(struct platform_device *pdev)
 	ec->class_dev.devt = MKDEV(ec_major, pdev->id);
 	ec->class_dev.class = &cros_class;
 	ec->class_dev.parent = dev;
+	ec->class_dev.release = cros_ec_class_release;
 
 	retval = dev_set_name(&ec->class_dev, "%s", ec_platform->ec_name);
 	if (retval) {
-- 
2.19.1

