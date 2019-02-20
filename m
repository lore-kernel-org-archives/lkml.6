Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B0DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0442084D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfBTQmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:42:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59229 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfBTQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:42:06 -0500
Received: from [194.204.107.10] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1gwUwf-0002E2-0f; Wed, 20 Feb 2019 16:42:05 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cheiny@synaptics.com,
        aduggan@synaptics.com, benjamin.tissoires@redhat.com,
        aaron.ma@canonical.com
Subject: [PATCH 2/2] Input: synaptics-rmi4 - export nosleep of f01 via sysfs
Date:   Wed, 20 Feb 2019 17:42:00 +0100
Message-Id: <20190220164200.31044-2-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190220164200.31044-1-aaron.ma@canonical.com>
References: <20190220164200.31044-1-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of ThinkPad X1C6 touchpads didn't wakeup after resume.
Forcing enable nosleep make touchpad back.
Add nosleep via sysfs, so user can control it to workaround issue.

/sys/devices/rmi4-00/nosleep can be written non-zero will enable
nosleep mode.

BugLink: https://bugs.launchpad.net/bugs/1791427
Cc: <stable@vger.kernel.org>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/input/rmi4/rmi_f01.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 4edaa14fe878..e41d1ec625d9 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -325,12 +325,57 @@ static ssize_t rmi_driver_package_id_show(struct device *dev,
 
 static DEVICE_ATTR(package_id, 0444, rmi_driver_package_id_show, NULL);
 
+static ssize_t rmi_driver_nosleep_show(struct device *dev,
+					  struct device_attribute *dattr,
+					  char *buf)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(dev);
+	struct f01_data *f01 = dev_get_drvdata(&data->f01_container->dev);
+	int f01_nosleep;
+
+	f01_nosleep = ((f01->device_control.ctrl0 & RMI_F01_CTRL0_NOSLEEP_BIT)
+		 ? 1 : 0);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", f01_nosleep);
+}
+
+static ssize_t rmi_driver_nosleep_store(struct device *dev,
+					  struct device_attribute *dattr,
+					  const char *buf, size_t count)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(dev);
+	struct f01_data *f01 = dev_get_drvdata(&data->f01_container->dev);
+	int error;
+
+	if (count <= 0)
+		return count;
+
+	if ('0' == *buf) {
+		f01->device_control.ctrl0 &= ~RMI_F01_CTRL0_NOSLEEP_BIT;
+	} else {
+		f01->device_control.ctrl0 |= RMI_F01_CTRL0_NOSLEEP_BIT;
+	}
+
+	error = rmi_write(data->rmi_dev,
+			data->f01_container->fd.control_base_addr,
+			  f01->device_control.ctrl0);
+	if (error) {
+		dev_err(dev, "Failed to write nosleep mode: %d.\n", error);
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(nosleep, 0644,
+		rmi_driver_nosleep_show, rmi_driver_nosleep_store);
+
 static struct attribute *rmi_f01_attrs[] = {
 	&dev_attr_manufacturer_id.attr,
 	&dev_attr_date_of_manufacture.attr,
 	&dev_attr_product_id.attr,
 	&dev_attr_firmware_id.attr,
 	&dev_attr_package_id.attr,
+	&dev_attr_nosleep.attr,
 	NULL
 };
 
-- 
2.17.1

