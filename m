Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E09CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5086D2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5086D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeKJACi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:02:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:21407 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbeKJACh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:02:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2018 06:21:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,483,1534834800"; 
   d="scan'208";a="106729694"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Nov 2018 06:21:45 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2 2/6] drivers core: Prepare support for multiple platform notifications
Date:   Fri,  9 Nov 2018 17:21:34 +0300
Message-Id: <20181109142138.54770-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109142138.54770-1-heikki.krogerus@linux.intel.com>
References: <20181109142138.54770-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it should be possible to support several hardware
description models at the same time (at least in theory),
for example ACPI and devicetree on a running system, the
platform notifications need to be handled differently.

For now a single "platform_notify" callback function was
used to notify the underlying base system which is in charge
of the hardware description when a new device entry was
added to the system, but that callback is available to only
a single base system at the time. This will add a function
device_platform_notify() and replace all direct
platform_notify() calls with it.

device_platform_notify() will first simply call the
platform_notify() callback, so this commit has no functional
affect, however, the idea is that individual base systems
will put their direct notification calls there instead of
using the platform_notify function pointer.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/core.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd779e11..3972ef3f080b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -728,6 +728,16 @@ static inline int device_is_not_partition(struct device *dev)
 }
 #endif
 
+static int
+device_platform_notify(struct device *dev, enum kobject_action action)
+{
+	if (platform_notify && action == KOBJ_ADD)
+		platform_notify(dev);
+	else if (platform_notify_remove && action == KOBJ_REMOVE)
+		platform_notify_remove(dev);
+	return 0;
+}
+
 /**
  * dev_driver_string - Return a device's driver name, if at all possible
  * @dev: struct device to get the name of
@@ -1883,8 +1893,9 @@ int device_add(struct device *dev)
 	}
 
 	/* notify platform of device entry */
-	if (platform_notify)
-		platform_notify(dev);
+	error = device_platform_notify(dev, KOBJ_ADD);
+	if (error)
+		goto platform_error;
 
 	error = device_create_file(dev, &dev_attr_uevent);
 	if (error)
@@ -1960,6 +1971,8 @@ int device_add(struct device *dev)
  SymlinkError:
 	device_remove_file(dev, &dev_attr_uevent);
  attrError:
+	device_platform_notify(dev, KOBJ_REMOVE);
+platform_error:
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	glue_dir = get_glue_dir(dev);
 	kobject_del(&dev->kobj);
@@ -2077,14 +2090,10 @@ void device_del(struct device *dev)
 	bus_remove_device(dev);
 	device_pm_remove(dev);
 	driver_deferred_probe_del(dev);
+	device_platform_notify(dev, KOBJ_REMOVE);
 	device_remove_properties(dev);
 	device_links_purge(dev);
 
-	/* Notify the platform of the removal, in case they
-	 * need to do anything...
-	 */
-	if (platform_notify_remove)
-		platform_notify_remove(dev);
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_REMOVED_DEVICE, dev);
-- 
2.19.1

