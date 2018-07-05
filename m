Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4132BC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076EF24018
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076EF24018
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753887AbeGEQBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:01:13 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50318 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753417AbeGEQBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:01:12 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D8C0A1A0020;
        Thu,  5 Jul 2018 18:01:10 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A1A191A0014;
        Thu,  5 Jul 2018 18:01:10 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id 1921B40A6B;
        Thu,  5 Jul 2018 09:01:10 -0700 (MST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w65G17To026341;
        Thu, 5 Jul 2018 09:01:08 -0700
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org
Cc:     vivek.gautam@codeaurora.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH] drivers/base: add sysfs entries for suppliers and consumers
Date:   Thu,  5 Jul 2018 19:00:28 +0300
Message-Id: <1530806428-19702-1-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of scraping dmesg for messages such as 'Linked as a consumer to'
or 'Dropping the link to' export two new sysfs entries in the device
folder that list the consumer and supplier devices.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/base/core.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index df3e1a4..6d245f7 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1055,6 +1055,34 @@ static ssize_t online_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(online);
 
+static ssize_t suppliers_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct device_link *link;
+	size_t count = 0;
+
+	list_for_each_entry(link, &dev->links.suppliers, c_node)
+		count += scnprintf(buf + count, PAGE_SIZE - count, "%s\n",
+				   dev_name(link->supplier));
+
+	return count;
+}
+static DEVICE_ATTR_RO(suppliers);
+
+static ssize_t consumers_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct device_link *link;
+	size_t count = 0;
+
+	list_for_each_entry(link, &dev->links.consumers, s_node)
+		count += scnprintf(buf + count, PAGE_SIZE - count, "%s\n",
+				   dev_name(link->consumer));
+
+	return count;
+}
+static DEVICE_ATTR_RO(consumers);
+
 int device_add_groups(struct device *dev, const struct attribute_group **groups)
 {
 	return sysfs_create_groups(&dev->kobj, groups);
@@ -1226,8 +1254,20 @@ static int device_add_attrs(struct device *dev)
 			goto err_remove_dev_groups;
 	}
 
+	error = device_create_file(dev, &dev_attr_suppliers);
+	if (error)
+		goto err_remove_online;
+
+	error = device_create_file(dev, &dev_attr_consumers);
+	if (error)
+		goto err_remove_suppliers;
+
 	return 0;
 
+ err_remove_suppliers:
+	device_remove_file(dev, &dev_attr_suppliers);
+ err_remove_online:
+	device_remove_file(dev, &dev_attr_online);
  err_remove_dev_groups:
 	device_remove_groups(dev, dev->groups);
  err_remove_type_groups:
@@ -1245,6 +1285,8 @@ static void device_remove_attrs(struct device *dev)
 	struct class *class = dev->class;
 	const struct device_type *type = dev->type;
 
+	device_remove_file(dev, &dev_attr_consumers);
+	device_remove_file(dev, &dev_attr_suppliers);
 	device_remove_file(dev, &dev_attr_online);
 	device_remove_groups(dev, dev->groups);
 
-- 
1.9.1

