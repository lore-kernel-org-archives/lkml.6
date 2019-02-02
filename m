Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48A8C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7699E20870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfBBHzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 02:55:37 -0500
Received: from emcscan.emc.com.tw ([192.72.220.5]:6822 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfBBHzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 02:55:36 -0500
X-IronPort-AV: E=Sophos;i="5.56,253,1539619200"; 
   d="scan'208";a="29450454"
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with SMTP; 02 Feb 2019 15:55:33 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(2812:0:AUTH_RELAY)
        (envelope-from <kt.liao@emc.com.tw>); Sat, 02 Feb 2019 15:55:34 +0800 (CST)
Received: from 192.168.33.46
        by webmail.emc.com.tw with Mail2000 ESMTPA Server V7.00(118975:0:AUTH_LOGIN)
        (envelope-from <kt.liao@emc.com.tw>); Sat, 02 Feb 2019 15:55:33 +0800 (CST)
From:   KT Liao <kt.liao@emc.com.tw>
To:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, ulrik.debie-os@e2big.org
Cc:     kt.liao@emc.com.tw, Roger.Whittaker@suse.com
Subject: [PATCH] Input: elan_i2c - Add i2c_reset in sysfs for ELAN touchpad recovery
Date:   Sat,  2 Feb 2019 15:54:56 +0800
Message-Id: <1549094096-4082-1-git-send-email-kt.liao@emc.com.tw>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roger from SUSE reported the touchpad on Lenovo yoga2 crush sometimes.
He found that rmmod/modprobe elan_i2c will recover the issue.
He add the workaround on SUSE and solve the problem.
Recently, the workaround fails in kernel 4.20 becasue IRQ mismatch.
genirq: Flags mismatch irq 0. 00002002 (ELAN0600:00) vs. 00015a00 (timer)
I can't reproduce the issue in SUSE with the same kernel.
And it's a 5 years old laptop, ELAN can't find the module for testing.
Instead of IRQ debugging IRQ, I tried another approach.
I added i2c_reset in sysfs to avoid IRQ requesting in probe.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Acked-by: Roger Whittaker <Roger.Whittaker@suse.com>
---
 drivers/input/mouse/elan_i2c_core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 2690a4b..388b1f0 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -670,6 +670,29 @@ static ssize_t calibrate_store(struct device *dev,
 	return retval ?: count;
 }
 
+static ssize_t i2c_reset_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct elan_tp_data *data = i2c_get_clientdata(client);
+	int retval;
+
+	retval = mutex_lock_interruptible(&data->sysfs_mutex);
+	if (retval)
+		return retval;
+
+	disable_irq(client->irq);
+
+	retval = elan_initialize(data);
+	if (retval)
+		dev_err(dev, "failed to re-initialize touchpad: %d\n", retval);
+
+	enable_irq(client->irq);
+	mutex_unlock(&data->sysfs_mutex);
+	return retval ?: count;
+}
+
 static ssize_t elan_sysfs_read_mode(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
@@ -702,6 +725,7 @@ static DEVICE_ATTR(mode, S_IRUGO, elan_sysfs_read_mode, NULL);
 static DEVICE_ATTR(update_fw, S_IWUSR, NULL, elan_sysfs_update_fw);
 
 static DEVICE_ATTR_WO(calibrate);
+static DEVICE_ATTR_WO(i2c_reset);
 
 static struct attribute *elan_sysfs_entries[] = {
 	&dev_attr_product_id.attr,
@@ -710,6 +734,7 @@ static struct attribute *elan_sysfs_entries[] = {
 	&dev_attr_iap_version.attr,
 	&dev_attr_fw_checksum.attr,
 	&dev_attr_calibrate.attr,
+	&dev_attr_i2c_reset.attr,
 	&dev_attr_mode.attr,
 	&dev_attr_update_fw.attr,
 	NULL,
-- 
2.7.4

