Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C4DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E57D20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfAVLfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:35:37 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51654 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbfAVLfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:35:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19A78A78;
        Tue, 22 Jan 2019 03:35:36 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6F4B3F6A8;
        Tue, 22 Jan 2019 03:35:34 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, ARM SoC Team <arm@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] firmware: arm_scmi: provide the mandatory device release callback
Date:   Tue, 22 Jan 2019 11:35:25 +0000
Message-Id: <20190122113525.13705-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device/driver model clearly mandates that bus driver that discover
and allocate the device must set the release callback. This callback
will be used to free the device after all references have gone away.

scmi bus driver is missing the obvious callback which will result in
the following warning if the device is unregistered:

Device 'scmi_dev.1' does not have a release() function, it is broken and
must be fixed. See Documentation/kobject.txt.
WARNING at drivers/base/core.c:922 device_release+0x8c/0xa0
Hardware name: ARM LTD Juno Development Platform BIOS EDK II Jan 21 2019
Workqueue: events deferred_probe_work_func
pstate: 60000005 (nZCv daif -PAN -UAO)
pc : device_release+0x8c/0xa0
lr : device_release+0x8c/0xa0
Call trace:
 device_release+0x8c/0xa0
 kobject_put+0x8c/0x208
 device_unregister+0x30/0x78
 scmi_device_destroy+0x28/0x50
 scmi_probe+0x354/0x5b0
 platform_drv_probe+0x58/0xa8
 really_probe+0x2c4/0x3e8
 driver_probe_device+0x12c/0x148
 __device_attach_driver+0xac/0x150
 bus_for_each_drv+0x78/0xd8
 __device_attach+0xe0/0x168
 device_initial_probe+0x24/0x30
 bus_probe_device+0xa0/0xa8
 deferred_probe_work_func+0x8c/0xe0
 process_one_work+0x1f0/0x478
 worker_thread+0x22c/0x450
 kthread+0x134/0x138
 ret_from_fork+0x10/0x1c
---[ end trace 420bdb7f6af50937 ]---

Fix the issue by providing scmi_device_release callback. We have
everything required for device release already in scmi_device_destroy,
so we just need to move freeing of the device to scmi_device_release.

Fixes: 933c504424a2 ("firmware: arm_scmi: add scmi protocol bus to enumerate protocol devices")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/bus.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Hi ARM-SoC team,

Can you apply this one patch directly or I can send pull request if you
prefer ?

Regards,
Sudeep

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 472c88ae1c0f..92f843eaf1e0 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -119,6 +119,11 @@ void scmi_driver_unregister(struct scmi_driver *driver)
 }
 EXPORT_SYMBOL_GPL(scmi_driver_unregister);

+static void scmi_device_release(struct device *dev)
+{
+	kfree(to_scmi_dev(dev));
+}
+
 struct scmi_device *
 scmi_device_create(struct device_node *np, struct device *parent, int protocol)
 {
@@ -138,6 +143,7 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol)
 	scmi_dev->dev.parent = parent;
 	scmi_dev->dev.of_node = np;
 	scmi_dev->dev.bus = &scmi_bus_type;
+	scmi_dev->dev.release = scmi_device_release;
 	dev_set_name(&scmi_dev->dev, "scmi_dev.%d", id);

 	retval = device_register(&scmi_dev->dev);
@@ -156,9 +162,8 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol)
 void scmi_device_destroy(struct scmi_device *scmi_dev)
 {
 	scmi_handle_put(scmi_dev->handle);
-	device_unregister(&scmi_dev->dev);
 	ida_simple_remove(&scmi_bus_id, scmi_dev->id);
-	kfree(scmi_dev);
+	device_unregister(&scmi_dev->dev);
 }

 void scmi_set_handle(struct scmi_device *scmi_dev)
--
2.17.1

