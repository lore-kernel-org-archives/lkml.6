Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24BDC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92D02084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfBCOV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:21:29 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55790 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728500AbfBCOVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:22 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIe8-0006QW-KO; Sun, 03 Feb 2019 14:21:20 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9V-0006rJ-Cx; Sun, 03 Feb 2019 14:49:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "MyungJoo Ham" <myungjoo.ham@samsung.com>,
        "Chanwoo Choi" <cw00.choi@samsung.com>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.894266655@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 052/305] PM / devfreq: Fix devfreq_add_device() when
 drivers are built as modules.
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

commit 23c7b54ca1cd1797ef39169ab85e6d46f1c2d061 upstream.

When the devfreq driver and the governor driver are built as modules,
the call to devfreq_add_device() or governor_store() fails because the
governor driver is not loaded at the time the devfreq driver loads. The
devfreq driver has a build dependency on the governor but also should
have a runtime dependency. We need to make sure that the governor driver
is loaded before the devfreq driver.

This patch fixes this bug by adding a try_then_request_governor()
function. First tries to find the governor, and then, if it is not found,
it requests the module and tries again.

Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
[bwh: Backported to 3.16:
 - Use string literal instead of DEVFREQ_GOV_SIMPLE_ONDEMAND
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/devfreq/devfreq.c | 53 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/kmod.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -148,6 +149,49 @@ static struct devfreq_governor *find_dev
 	return ERR_PTR(-ENODEV);
 }
 
+/**
+ * try_then_request_governor() - Try to find the governor and request the
+ *                               module if is not found.
+ * @name:	name of the governor
+ *
+ * Search the list of devfreq governors and request the module and try again
+ * if is not found. This can happen when both drivers (the governor driver
+ * and the driver that call devfreq_add_device) are built as modules.
+ * devfreq_list_lock should be held by the caller. Returns the matched
+ * governor's pointer.
+ */
+static struct devfreq_governor *try_then_request_governor(const char *name)
+{
+	struct devfreq_governor *governor;
+	int err = 0;
+
+	if (IS_ERR_OR_NULL(name)) {
+		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+	WARN(!mutex_is_locked(&devfreq_list_lock),
+	     "devfreq_list_lock must be locked.");
+
+	governor = find_devfreq_governor(name);
+	if (IS_ERR(governor)) {
+		mutex_unlock(&devfreq_list_lock);
+
+		if (!strncmp(name, "simple_ondemand",
+			     DEVFREQ_NAME_LEN))
+			err = request_module("governor_%s", "simpleondemand");
+		else
+			err = request_module("governor_%s", name);
+		/* Restore previous state before return */
+		mutex_lock(&devfreq_list_lock);
+		if (err)
+			return NULL;
+
+		governor = find_devfreq_governor(name);
+	}
+
+	return governor;
+}
+
 /* Load monitoring helper functions for governors use */
 
 /**
@@ -499,9 +543,8 @@ struct devfreq *devfreq_add_device(struc
 	mutex_unlock(&devfreq->lock);
 
 	mutex_lock(&devfreq_list_lock);
-	list_add(&devfreq->node, &devfreq_list);
 
-	governor = find_devfreq_governor(devfreq->governor_name);
+	governor = try_then_request_governor(devfreq->governor_name);
 	if (IS_ERR(governor)) {
 		dev_err(dev, "%s: Unable to find governor for the device\n",
 			__func__);
@@ -517,12 +560,14 @@ struct devfreq *devfreq_add_device(struc
 			__func__);
 		goto err_init;
 	}
+
+	list_add(&devfreq->node, &devfreq_list);
+
 	mutex_unlock(&devfreq_list_lock);
 
 	return devfreq;
 
 err_init:
-	list_del(&devfreq->node);
 	mutex_unlock(&devfreq_list_lock);
 
 	device_unregister(&devfreq->dev);
@@ -798,7 +843,7 @@ static ssize_t governor_store(struct dev
 		return -EINVAL;
 
 	mutex_lock(&devfreq_list_lock);
-	governor = find_devfreq_governor(str_governor);
+	governor = try_then_request_governor(str_governor);
 	if (IS_ERR(governor)) {
 		ret = PTR_ERR(governor);
 		goto out;

