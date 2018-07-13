Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC3DECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1301C2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1301C2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387696AbeGMQXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:23:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38397 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbeGMQXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:23:31 -0400
Received: from 2.general.tyhicks.us.vpn ([10.172.64.53] helo=sec.ubuntu-ci)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1fe0c8-0006pX-L1; Fri, 13 Jul 2018 16:08:12 +0000
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: [PATCH net-next v2 4/7] driver core: set up ownership of class devices in sysfs
Date:   Fri, 13 Jul 2018 16:05:46 +0000
Message-Id: <1531497949-1766-5-git-send-email-tyhicks@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Plumb in get_ownership() callback for devices belonging to a class so that
they can be created with uid/gid different from global root. This will
allow network devices in a container to belong to container's root and not
global root.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
---
 drivers/base/core.c    | 9 +++++++++
 include/linux/device.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index df3e1a44707a..276c7e3f754c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -866,10 +866,19 @@ static const void *device_namespace(struct kobject *kobj)
 	return ns;
 }
 
+static void device_get_ownership(struct kobject *kobj, kuid_t *uid, kgid_t *gid)
+{
+	struct device *dev = kobj_to_dev(kobj);
+
+	if (dev->class && dev->class->get_ownership)
+		dev->class->get_ownership(dev, uid, gid);
+}
+
 static struct kobj_type device_ktype = {
 	.release	= device_release,
 	.sysfs_ops	= &dev_sysfs_ops,
 	.namespace	= device_namespace,
+	.get_ownership	= device_get_ownership,
 };
 
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 055a69dbcd18..fe6ccb6dc119 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -384,6 +384,9 @@ int subsys_virtual_register(struct bus_type *subsys,
  * @shutdown_pre: Called at shut-down time before driver shutdown.
  * @ns_type:	Callbacks so sysfs can detemine namespaces.
  * @namespace:	Namespace of the device belongs to this class.
+ * @get_ownership: Allows class to specify uid/gid of the sysfs directories
+ *		for the devices belonging to the class. Usually tied to
+ *		device's namespace.
  * @pm:		The default device power management operations of this class.
  * @p:		The private data of the driver core, no one other than the
  *		driver core can touch this.
@@ -413,6 +416,8 @@ struct class {
 	const struct kobj_ns_type_operations *ns_type;
 	const void *(*namespace)(struct device *dev);
 
+	void (*get_ownership)(struct device *dev, kuid_t *uid, kgid_t *gid);
+
 	const struct dev_pm_ops *pm;
 
 	struct subsys_private *p;
-- 
2.7.4

