Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906D9C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BC52145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BC52145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbeLCDpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:45:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15627 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbeLCDpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:45:49 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 73E36384591E0;
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
Subject: [PATCH v1 08/12] usb: roles: Add usb role switch notifier.
Date:   Mon, 3 Dec 2018 11:45:11 +0800
Message-ID: <20181203034515.91412-9-chenyu56@huawei.com>
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

This patch adds notifier for drivers want to be informed of the usb role switch.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>

--
v0:
The patch is provided by Heikki Krogerus. I modified and test it
on Hikey960 platform.
--
---
 drivers/usb/common/roles.c | 20 +++++++++++++++++++-
 include/linux/usb/role.h   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/common/roles.c b/drivers/usb/common/roles.c
index 0f48090c5c30..bfd7a988b64c 100644
--- a/drivers/usb/common/roles.c
+++ b/drivers/usb/common/roles.c
@@ -21,6 +21,7 @@ struct usb_role_switch {
 	struct device dev;
 	struct mutex lock; /* device lock*/
 	enum usb_role role;
+	struct blocking_notifier_head nh;
 
 	/* From descriptor */
 	struct device *usb2_port;
@@ -50,8 +51,10 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
 	mutex_lock(&sw->lock);
 
 	ret = sw->set(sw->dev.parent, role);
-	if (!ret)
+	if (!ret) {
 		sw->role = role;
+		blocking_notifier_call_chain(&sw->nh, role, NULL);
+	}
 
 	mutex_unlock(&sw->lock);
 
@@ -59,6 +62,20 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_set_role);
 
+int usb_role_switch_register_notifier(struct usb_role_switch *sw,
+				      struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&sw->nh, nb);
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_register_notifier);
+
+int usb_role_switch_unregister_notifier(struct usb_role_switch *sw,
+					struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&sw->nh, nb);
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_unregister_notifier);
+
 /**
  * usb_role_switch_get_role - Get the USB role for a switch
  * @sw: USB role switch
@@ -297,6 +314,7 @@ usb_role_switch_register(struct device *parent,
 		return ERR_PTR(-ENOMEM);
 
 	mutex_init(&sw->lock);
+	BLOCKING_INIT_NOTIFIER_HEAD(&sw->nh);
 
 	sw->allow_userspace_control = desc->allow_userspace_control;
 	sw->usb2_port = desc->usb2_port;
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
index edc51be4a77c..c97d4be91ada 100644
--- a/include/linux/usb/role.h
+++ b/include/linux/usb/role.h
@@ -40,6 +40,8 @@ struct usb_role_switch_desc {
 	bool allow_userspace_control;
 };
 
+
+#if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
 int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role);
 enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw);
 struct usb_role_switch *usb_role_switch_get(struct device *dev);
@@ -49,5 +51,49 @@ struct usb_role_switch *
 usb_role_switch_register(struct device *parent,
 			 const struct usb_role_switch_desc *desc);
 void usb_role_switch_unregister(struct usb_role_switch *sw);
+int usb_role_switch_register_notifier(struct usb_role_switch *sw,
+				      struct notifier_block *nb);
+int usb_role_switch_unregister_notifier(struct usb_role_switch *sw,
+					struct notifier_block *nb);
+#else
+static inline int usb_role_switch_set_role(struct usb_role_switch *sw,
+		enum usb_role role)
+{
+	return 0;
+}
+
+static inline enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
+{
+	return USB_ROLE_NONE;
+}
+
+static inline struct usb_role_switch *usb_role_switch_get(struct device *dev)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void usb_role_switch_put(struct usb_role_switch *sw) { }
+
+static inline struct usb_role_switch *
+usb_role_switch_register(struct device *parent,
+			 const struct usb_role_switch_desc *desc)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void usb_role_switch_unregister(struct usb_role_switch *sw) { }
+
+static int usb_role_switch_register_notifier(struct usb_role_switch *sw,
+				      struct notifier_block *nb)
+{
+	return -ENODEV;
+}
+
+static int usb_role_switch_unregister_notifier(struct usb_role_switch *sw,
+					struct notifier_block *nb)
+{
+	return -ENODEV;
+}
+#endif
 
 #endif /* __LINUX_USB_ROLE_H */
-- 
2.15.0-rc2

