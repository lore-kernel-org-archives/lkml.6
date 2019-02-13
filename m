Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4B9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444FA222D2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083732;
	bh=i9RPEOaBnAnS0wO5pb7AMApP4zMj5RK5u00kKQZDTv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cDq2ul8pC6CZp3QmtpdxwV18clXJQ3sUAe4sj8yWLhlttqPiB6aBIeH309ZF5Y4wc
	 0UX7i9YN+1PqRmGTr+PjlViltuGmH9BArIdTVRM+GWafwj432Msk8/WpGdCoUhBaIh
	 YMoTku3CDYjlD9PFjrPDDe0QSIOQJVAAK5J472E4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394118AbfBMSsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:48:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:44548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730819AbfBMSp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:45:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E073B20811;
        Wed, 13 Feb 2019 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083555;
        bh=i9RPEOaBnAnS0wO5pb7AMApP4zMj5RK5u00kKQZDTv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y4nWsfaNj183e6F6hCseCgHG7Tc+uNAMLJluapjACqa/tO7fi9kCAMws23yk0liBF
         4I2RksZKKz4ars2p2hWDopPiqiieD2n52DN/pxEtOViAo+4MHpPttb9dikUu8Qz6uI
         ds9JTJtoZMrDimVuHp7MTl7HG5IbmseaukQA/6gg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.20 32/50] firmware: arm_scmi: provide the mandatory device release callback
Date:   Wed, 13 Feb 2019 19:38:37 +0100
Message-Id: <20190213183658.291475193@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudeep Holla <sudeep.holla@arm.com>

commit 46edb8d1322c1763dd04e179992f8e9996085047 upstream.

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
Cc: stable@vger.kernel.org # 4.17+
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/arm_scmi/bus.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -119,6 +119,11 @@ void scmi_driver_unregister(struct scmi_
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
@@ -138,6 +143,7 @@ scmi_device_create(struct device_node *n
 	scmi_dev->dev.parent = parent;
 	scmi_dev->dev.of_node = np;
 	scmi_dev->dev.bus = &scmi_bus_type;
+	scmi_dev->dev.release = scmi_device_release;
 	dev_set_name(&scmi_dev->dev, "scmi_dev.%d", id);
 
 	retval = device_register(&scmi_dev->dev);
@@ -156,9 +162,8 @@ free_mem:
 void scmi_device_destroy(struct scmi_device *scmi_dev)
 {
 	scmi_handle_put(scmi_dev->handle);
-	device_unregister(&scmi_dev->dev);
 	ida_simple_remove(&scmi_bus_id, scmi_dev->id);
-	kfree(scmi_dev);
+	device_unregister(&scmi_dev->dev);
 }
 
 void scmi_set_handle(struct scmi_device *scmi_dev)


