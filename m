Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD15C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7392084D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfBTWJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:09:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:8996 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfBTWJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:09:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 14:09:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,392,1544515200"; 
   d="scan'208";a="276594184"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004.jf.intel.com with ESMTP; 20 Feb 2019 14:09:08 -0800
Subject: [PATCH] device-dax: Add a 'target_node' attribute
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 20 Feb 2019 13:56:30 -0800
Message-ID: <155069979014.1936094.2387722425017107280.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The target-node attribute is the Linux numa-node that a device-dax
instance may create when it is online. Prior to being online the
device's 'numa_node' property reflects the closest online cpu node which
is the typical expectation of a device 'numa_node'. Once it is online it
becomes its own distinct numa node, i.e. 'target_node'.

Export the 'target_node' property to give userspace tooling the ability
to predict the effective numa-node from a device-dax instance configured
to provide 'System RAM' capacity.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index a410154d75fb..28c3324271ac 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -279,13 +279,41 @@ static ssize_t size_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(size);
 
+static int dev_dax_target_node(struct dev_dax *dev_dax)
+{
+	struct dax_region *dax_region = dev_dax->region;
+
+	return dax_region->target_node;
+}
+
+static ssize_t target_node_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	return sprintf(buf, "%d\n", dev_dax_target_node(dev_dax));
+}
+static DEVICE_ATTR_RO(target_node);
+
+static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	if (a == &dev_attr_target_node.attr && dev_dax_target_node(dev_dax) < 0)
+		return 0;
+	return a->mode;
+}
+
 static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_size.attr,
+	&dev_attr_target_node.attr,
 	NULL,
 };
 
 static const struct attribute_group dev_dax_attribute_group = {
 	.attrs = dev_dax_attributes,
+	.is_visible = dev_dax_visible,
 };
 
 static const struct attribute_group *dax_attribute_groups[] = {

