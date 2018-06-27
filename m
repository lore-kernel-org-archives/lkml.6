Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD758C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED1A25CD3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED1A25CD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755101AbeF0WHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 18:07:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54239 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbeF0WHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 18:07:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id b188-v6so1272664wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 15:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/jlTPwjC2QOSC70OfROrsR01Fp2ChvkKkYQSli8f+FI=;
        b=O0PWGpwvygyaGmJ7RqnXrj8fbRZEKrwWCXtDqxpsModLV3a7juQb2O+R4AK8Mibl/N
         fNgs+Onl/B6B+xSKhKUOqOv0ty2Kv0UN/Ib4IHb+jSGMAL0C4XF/1r0ICE5vILiWnuTZ
         mhioS56mxaDLigMYaj+Xcrd3hXRPkqv510eCEZl2VAtM5eqJD+DfVCo4m6El+oUB9At/
         8vrg2UOcZl6SaGGJoRA75k0zJTlAK6uzo9sirqNLf9rCYIGXkOAnhSkKbbp2BkCRWH33
         8kl3FGhyVBOl9qjWSaMNjdIAc5/spJc7htmuCBP3S7McrDD5yVQaRR5jfTm7EFF6eFHX
         r0Dg==
X-Gm-Message-State: APt69E165Oa0qKuvqtoaPknwqixS40DoQs93GbKQ8saRX1DiFiGrQUtf
        73c2JDBIKrvNzGLmnhB4bPBceJyy368=
X-Google-Smtp-Source: AAOMgpd9TZG38+FppRgNg8pcZUeMhehZkJEIiBs0cPnp2zKMsp2JaFoR3THvkMzz1PAtTP3P8rpGiQ==
X-Received: by 2002:a1c:1414:: with SMTP id 20-v6mr5939866wmu.119.1530137234448;
        Wed, 27 Jun 2018 15:07:14 -0700 (PDT)
Received: from minerva.home ([90.77.100.34])
        by smtp.gmail.com with ESMTPSA id d4-v6sm7735767wrp.51.2018.06.27.15.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 15:07:13 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] driver core: add a debugfs entry to show deferred devices
Date:   Thu, 28 Jun 2018 00:06:56 +0200
Message-Id: <20180627220656.19298-1-javierm@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Device Trees (DT), the dependencies of the devices are defined in the
DT, then the drivers parse that information to lookup the needed resources
that have as dependencies.

Since drivers and devices are registered in a non-deterministic way, it is
possible that a device that is a dependency has not been registered yet by
the time that is looked up.

In this case the driver that requires this dependency cannot probe and has
to defer it. So the driver core adds it to a list of deferred devices that
is iterated again every time that a new driver is probed successfully.

For debugging purposes it may be useful to know what are the devices whose
probe function was deferred. Add a debugfs entry showing that information.

  $ cat /sys/kernel/debug/devices_deferred
  48070000.i2c:twl@48:bci
  musb-hdrc.0.auto
  omapdrm.0

This information could be obtained partially by enabling debugging, but it
means that the kernel log has to be parsed and the probe deferral balanced
with the successes. This can be error probe and has to be done in a ad-hoc
manner by everyone who needs to debug these kind of issues.

Since the information is already known by the kernel, just show it to make
it easier to debug.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---

Andy, I didn't carry your Reviewed-by tag because it wasn't clear to me
if you had agreed with the patch or not from your last email.

Changes since RFC v1:
- Remove unneeded ret variable from deferred_devs_show()

Changes since RFC v2:
- Use DEFINE_SHOW_ATTRIBUTE() macro.
- Don't propagate debugfs_create_file() error.
- Remove IS_ENABLED(CONFIG_DEBUG_FS) guards.
- Drop RFC prefix.

Changes since v1:
- Better explain in the commit message why this patch is useful.
- Rename deferred_devices entry to devices_deferred.
- Add an exit function and remove the debugfs entry.


 drivers/base/dd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1435d7281c6..489c484301b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -16,6 +16,7 @@
  * Copyright (c) 2007-2009 Novell Inc.
  */
 
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -53,6 +54,7 @@ static DEFINE_MUTEX(deferred_probe_mutex);
 static LIST_HEAD(deferred_probe_pending_list);
 static LIST_HEAD(deferred_probe_active_list);
 static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
+static struct dentry *deferred_devices;
 static bool initcalls_done;
 
 /*
@@ -224,6 +226,24 @@ void device_unblock_probing(void)
 	driver_deferred_probe_trigger();
 }
 
+/*
+ * deferred_devs_show() - Show the devices in the deferred probe pending list.
+ */
+static int deferred_devs_show(struct seq_file *s, void *data)
+{
+	struct device_private *curr;
+
+	mutex_lock(&deferred_probe_mutex);
+
+	list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
+		seq_printf(s, "%s\n", dev_name(curr->device));
+
+	mutex_unlock(&deferred_probe_mutex);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(deferred_devs);
+
 /**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
@@ -233,6 +253,9 @@ void device_unblock_probing(void)
  */
 static int deferred_probe_initcall(void)
 {
+	deferred_devices = debugfs_create_file("devices_deferred", 0444, NULL,
+					       NULL, &deferred_devs_fops);
+
 	driver_deferred_probe_enable = true;
 	driver_deferred_probe_trigger();
 	/* Sort as many dependencies as possible before exiting initcalls */
@@ -242,6 +265,12 @@ static int deferred_probe_initcall(void)
 }
 late_initcall(deferred_probe_initcall);
 
+static void __exit deferred_probe_exit(void)
+{
+	debugfs_remove_recursive(deferred_devices);
+}
+__exitcall(deferred_probe_exit);
+
 /**
  * device_is_bound() - Check if device is bound to a driver
  * @dev: device to check
-- 
2.17.1

