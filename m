Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E347C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23B62145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23B62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbeLCDps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:45:48 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbeLCDps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:45:48 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6C8A9418649A5;
        Mon,  3 Dec 2018 11:45:42 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Mon, 3 Dec 2018 11:45:33 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "John Stultz" <john.stultz@linaro.org>
Subject: [PATCH v1 07/12] usb: roles: Find the usb role switch by also matching against the device node
Date:   Mon, 3 Dec 2018 11:45:10 +0800
Message-ID: <20181203034515.91412-8-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
In-Reply-To: <20181203034515.91412-1-chenyu56@huawei.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds code for supporting find usb role switch by matching against
the device node described using of_graph.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
---
 drivers/usb/common/roles.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/usb/common/roles.c b/drivers/usb/common/roles.c
index 99116af07f1d..0f48090c5c30 100644
--- a/drivers/usb/common/roles.c
+++ b/drivers/usb/common/roles.c
@@ -12,6 +12,8 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
 
 static struct class *role_class;
 
@@ -100,6 +102,38 @@ static void *usb_role_switch_match(struct device_connection *con, int ep,
 	return dev ? to_role_switch(dev) : ERR_PTR(-EPROBE_DEFER);
 }
 
+static int __switch_match_by_of_node(struct device *dev, const void *name)
+{
+	if (!dev->parent || !dev->parent->of_node)
+		return 0;
+
+	return of_node_name_eq(dev->parent->of_node, (const char *)name);
+}
+
+static void *of_graph_find_match_by_type(struct device *dev, const char *ep_type)
+{
+	struct device_node *ep;
+	struct device_node *remote_parent;
+	struct device *role_switch;
+
+	for_each_endpoint_of_node(dev_of_node(dev), ep) {
+		if (!ep->type || strcmp(ep->type, ep_type))
+			continue;
+
+		remote_parent = of_graph_get_remote_port_parent(ep);
+		if (!remote_parent || !remote_parent->name)
+			continue;
+
+		role_switch = class_find_device(role_class, NULL,
+				remote_parent->name, __switch_match_by_of_node);
+
+		return role_switch ? to_role_switch(role_switch) :
+			ERR_PTR(-EPROBE_DEFER);
+	}
+
+	return NULL;
+}
+
 /**
  * usb_role_switch_get - Find USB role switch linked with the caller
  * @dev: The caller device
@@ -114,6 +148,12 @@ struct usb_role_switch *usb_role_switch_get(struct device *dev)
 	sw = device_connection_find_match(dev, "usb-role-switch", NULL,
 					  usb_role_switch_match);
 
+	if (!IS_ERR_OR_NULL(sw)) {
+		WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
+		return sw;
+	}
+
+	sw = of_graph_find_match_by_type(dev, "usb-role-switch");
 	if (!IS_ERR_OR_NULL(sw))
 		WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
 
-- 
2.15.0-rc2

