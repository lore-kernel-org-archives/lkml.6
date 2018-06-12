Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 55959C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0232220891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DNfLe6M+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0232220891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934871AbeFLVB1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:01:27 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:3344 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933998AbeFLU4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1528836996; x=1560372996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=e5clyo9fSmITG1Y9ftbtx5PbXbkitZHATO9TO/fz9EM=;
  b=DNfLe6M+NBt3gP/XYxh5vw5Jw4yQSDZzo8CWEKTpS0krvI85sz8eZ3Gb
   d7Hdu8fBWslxwR63206GdTxqWLvT/ONP+gUEDa12ByVQRLoBU34PyzRuh
   0CF8SF6lE3L5HmlR2Gd+EP3fEO1jEDtmk8uRtP9b4rgDYUErMYuUMdLwl
   A=;
X-IronPort-AV: E=Sophos;i="5.51,216,1526342400"; 
   d="scan'208";a="347699297"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Jun 2018 20:56:34 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5CKuVb6012052
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Jun 2018 20:56:32 GMT
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:29 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:29 +0000
Received: from localhost (10.25.15.63) by mail-relay.amazon.com (10.43.62.226)
 with Microsoft SMTP Server id 15.0.1367.3 via Frontend Transport; Tue, 12 Jun
 2018 20:56:28 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>
CC:     <boris.ostrovsky@oracle.com>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>, <netdev@vger.kernel.org>,
        <jgross@suse.com>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <kamatam@amazon.com>,
        <anchalag@amazon.com>, <fllinden@amazon.com>, <vallish@amazon.com>,
        <guruanb@amazon.com>, <eduval@amazon.com>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
        <cyberax@amazon.com>
Subject: [RFC PATCH 03/12] xenbus: add freeze/thaw/restore callbacks support
Date:   Tue, 12 Jun 2018 20:56:10 +0000
Message-ID: <20180612205619.28156-4-anchalag@amazon.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180612205619.28156-1-anchalag@amazon.com>
References: <20180612205619.28156-1-anchalag@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Munehisa Kamata <kamatam@amazon.com>

Since commit b3e96c0c7562 ("xen: use freeze/restore/thaw PM events for
suspend/resume/chkpt"), xenbus uses PMSG_FREEZE, PMSG_THAW and
PMSG_RESTORE events for Xen suspend. However, they're actually assigned
to xenbus_dev_suspend(), xenbus_dev_cancel() and xenbus_dev_resume()
respectively, and only suspend and resume callbacks are supported at
driver level. To support PM suspend and PM hibernation, modify the bus
level PM callbacks to invoke not only device driver's suspend/resume but
also freeze/thaw/restore.

Note that we'll use freeze/restore callbacks even for PM suspend whereas
suspend/resume callbacks are normally used in the case, becausae the
existing xenbus device drivers already have suspend/resume callbacks
specifically designed for Xen suspend. So we can allow the device
drivers to keep the existing callbacks wihtout modification.

Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Reviewed-by: Munehisa Kamata <kamatam@amazon.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
---
 drivers/xen/xenbus/xenbus_probe.c | 102 ++++++++++++++++++++++++++++++++------
 include/xen/xenbus.h              |   3 ++
 2 files changed, 89 insertions(+), 16 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index ec9eb4f..95b0a6d 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -49,6 +49,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -588,26 +589,47 @@ int xenbus_dev_suspend(struct device *dev)
 	struct xenbus_driver *drv;
 	struct xenbus_device *xdev
 		= container_of(dev, struct xenbus_device, dev);
+	int (*cb)(struct xenbus_device *) = NULL;
+	bool xen_suspend = xen_suspend_mode_is_xen_suspend();
 
 	DPRINTK("%s", xdev->nodename);
 
 	if (dev->driver == NULL)
 		return 0;
 	drv = to_xenbus_driver(dev->driver);
-	if (drv->suspend)
-		err = drv->suspend(xdev);
-	if (err)
-		pr_warn("suspend %s failed: %i\n", dev_name(dev), err);
+
+	if (xen_suspend)
+		cb = drv->suspend;
+	else
+		cb = drv->freeze;
+
+	if (cb)
+		err = cb(xdev);
+
+	if (err) {
+		pr_warn("%s %s failed: %i\n", xen_suspend ?
+			"suspend" : "freeze", dev_name(dev), err);
+		return err;
+	}
+
+	if (!xen_suspend) {
+		/* Forget otherend since this can become stale after restore */
+		free_otherend_watch(xdev);
+		free_otherend_details(xdev);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xenbus_dev_suspend);
 
 int xenbus_dev_resume(struct device *dev)
 {
-	int err;
+	int err = 0;
 	struct xenbus_driver *drv;
 	struct xenbus_device *xdev
 		= container_of(dev, struct xenbus_device, dev);
+	int (*cb)(struct xenbus_device *) = NULL;
+	bool xen_suspend = xen_suspend_mode_is_xen_suspend();
 
 	DPRINTK("%s", xdev->nodename);
 
@@ -616,24 +638,34 @@ int xenbus_dev_resume(struct device *dev)
 	drv = to_xenbus_driver(dev->driver);
 	err = talk_to_otherend(xdev);
 	if (err) {
-		pr_warn("resume (talk_to_otherend) %s failed: %i\n",
+		pr_warn("%s (talk_to_otherend) %s failed: %i\n",
+			xen_suspend ? "resume" : "restore",
 			dev_name(dev), err);
 		return err;
 	}
 
-	xdev->state = XenbusStateInitialising;
+	if (xen_suspend)
+		xdev->state = XenbusStateInitialising;
 
-	if (drv->resume) {
-		err = drv->resume(xdev);
-		if (err) {
-			pr_warn("resume %s failed: %i\n", dev_name(dev), err);
-			return err;
-		}
+	if (xen_suspend)
+		cb = drv->resume;
+	else
+		cb = drv->restore;
+
+	if (cb)
+		err = cb(xdev);
+
+	if (err) {
+		pr_warn("%s %s failed: %i\n",
+			xen_suspend ? "resume" : "restore",
+			dev_name(dev), err);
+		return err;
 	}
 
 	err = watch_otherend(xdev);
 	if (err) {
-		pr_warn("resume (watch_otherend) %s failed: %d.\n",
+		pr_warn("%s (watch_otherend) %s failed: %d.\n",
+			xen_suspend ? "resume" : "restore",
 			dev_name(dev), err);
 		return err;
 	}
@@ -644,8 +676,46 @@ EXPORT_SYMBOL_GPL(xenbus_dev_resume);
 
 int xenbus_dev_cancel(struct device *dev)
 {
-	/* Do nothing */
-	DPRINTK("cancel");
+	int err = 0;
+	struct xenbus_driver *drv;
+	struct xenbus_device *xdev
+		= container_of(dev, struct xenbus_device, dev);
+	bool xen_suspend = xen_suspend_mode_is_xen_suspend();
+
+	if (xen_suspend) {
+		/* Do nothing */
+		DPRINTK("cancel");
+		return 0;
+	}
+
+	DPRINTK("%s", xdev->nodename);
+
+	if (dev->driver == NULL)
+		return 0;
+	drv = to_xenbus_driver(dev->driver);
+
+	err = talk_to_otherend(xdev);
+	if (err) {
+		pr_warn("thaw (talk_to_otherend) %s failed: %d.\n",
+			dev_name(dev), err);
+		return err;
+	}
+
+	if (drv->thaw) {
+		err = drv->thaw(xdev);
+		if (err) {
+			pr_warn("thaw %s failed: %i\n", dev_name(dev), err);
+			return err;
+		}
+	}
+
+	err = watch_otherend(xdev);
+	if (err) {
+		pr_warn("thaw (watch_otherend) %s failed: %d.\n",
+			dev_name(dev), err);
+		return err;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xenbus_dev_cancel);
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 869c816..20261d5 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -100,6 +100,9 @@ struct xenbus_driver {
 	int (*remove)(struct xenbus_device *dev);
 	int (*suspend)(struct xenbus_device *dev);
 	int (*resume)(struct xenbus_device *dev);
+	int (*freeze)(struct xenbus_device *dev);
+	int (*thaw)(struct xenbus_device *dev);
+	int (*restore)(struct xenbus_device *dev);
 	int (*uevent)(struct xenbus_device *, struct kobj_uevent_env *);
 	struct device_driver driver;
 	int (*read_otherend_details)(struct xenbus_device *dev);
-- 
2.7.4

