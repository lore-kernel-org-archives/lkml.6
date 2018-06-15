Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 90B4CC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50934208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50934208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936258AbeFOKFD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:05:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32790 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934900AbeFOKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:05:02 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 7E32F260BF3
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH] PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.
Date:   Fri, 15 Jun 2018 12:04:52 +0200
Message-Id: <20180615100452.17466-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the devfreq driver and the governor driver are built as modules,
the call to devfreq_add_device() fails because the governor driver is
not loaded at the time the devfreq driver loads. The devfreq driver has
a build dependency on the governor but also should have a runtime
dependency. We need to make sure that the governor driver is loaded
before the devfreq driver.

This patch fixes this bug in devfreq_add_device(). First tries to find
the governor, and then, if was not found, it requests the module and
tries again.

Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/devfreq/devfreq.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index fe2af6aa88fc..1d917f043e30 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/kmod.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -648,10 +649,35 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	governor = find_devfreq_governor(devfreq->governor_name);
 	if (IS_ERR(governor)) {
-		dev_err(dev, "%s: Unable to find governor for the device\n",
-			__func__);
-		err = PTR_ERR(governor);
-		goto err_init;
+		list_del(&devfreq->node);
+		mutex_unlock(&devfreq_list_lock);
+
+		/*
+		 * If the governor is not found, then request the module and
+		 * try again. This can happen when both drivers (the governor
+		 * driver and the driver that calls devfreq_add_device) are
+		 * built as modules.
+		 */
+		if (!strncmp(devfreq->governor_name,
+			     DEVFREQ_GOV_SIMPLE_ONDEMAND, DEVFREQ_NAME_LEN))
+			err = request_module("governor_%s", "simpleondemand");
+		else
+			err = request_module("governor_%s",
+					     devfreq->governor_name);
+		if (err)
+			goto err_unregister;
+
+		mutex_lock(&devfreq_list_lock);
+		list_add(&devfreq->node, &devfreq_list);
+
+		governor = find_devfreq_governor(devfreq->governor_name);
+		if (IS_ERR(governor)) {
+			dev_err(dev,
+				"%s: Unable to find governor for the device\n",
+				__func__);
+			err = PTR_ERR(governor);
+			goto err_init;
+		}
 	}
 
 	devfreq->governor = governor;
@@ -669,7 +695,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 err_init:
 	list_del(&devfreq->node);
 	mutex_unlock(&devfreq_list_lock);
-
+err_unregister:
 	device_unregister(&devfreq->dev);
 err_dev:
 	if (devfreq)
-- 
2.17.1

