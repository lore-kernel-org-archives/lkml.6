Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24628C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 13:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79C3208A6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 13:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79C3208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeGHNfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 09:35:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34357 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeGHNfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 09:35:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id s13-v6so7903972wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 06:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pN04fejRgMTBwWfZiwOZz6ZhygZUxMPjZ0VEZ6LF0EA=;
        b=rP2WqedBNxHkq/eQL84wDLH6pqCtZu9VPAVXJIEp6daCjOQDjFnPch5jfVYCzTFadJ
         P0ZdfAN5jjGhlov/IgkzmWXqRcH/hEXUG5DERilZylT0wOxmYoYc1fgJqbWp2zKCnEZy
         LfnDAoEHtyNYOkIYiyVTi4kY6X549MyqWmTi+OmspNpmiFJ5IAQHlObmGllvwC3gOxQc
         JEdBE7wvXzSVIAaPmAkTPoBcI1wUXWMzjjRs6d1aLQ3atH458S49gQiBhH9XFVxjGBnC
         jmdejYbqR1phNPVx0817dM3tiqbtRHuSIfsTIesbuMbZqv1O/W9xyZzFWyuDMK4hw7pQ
         Ge3w==
X-Gm-Message-State: APt69E0ArD1dRWPmvg0Zo02rl/4SF7d7MO+elD9Pn4HkvBDRWbuqXrYE
        aIaQKcf0NHjs3bhAM5fR2WyBM4byMVM=
X-Google-Smtp-Source: AAOMgpeEcVLOwNSO+VI1SOa79iq8xOPlNxsOrejHaSoF2+IlhUsjFF9UgNoyY9E+fYqY//M230GrmQ==
X-Received: by 2002:a1c:e041:: with SMTP id x62-v6mr9502540wmg.155.1531056909907;
        Sun, 08 Jul 2018 06:35:09 -0700 (PDT)
Received: from minerva.ual.es (nat-wifi-invi.ual.es. [150.214.223.90])
        by smtp.gmail.com with ESMTPSA id 24-v6sm33815043wrz.94.2018.07.08.06.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Jul 2018 06:35:09 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4] driver core: add a debugfs entry to show deferred devices
Date:   Sun,  8 Jul 2018 15:34:59 +0200
Message-Id: <20180708133459.24883-1-javierm@redhat.com>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Mark Brown <broonie@kernel.org>

---

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

Changes since v2:
- Add Andy Shevchenko and Mark Brown Reviewed-by tag.
- Rebase on top of Greg's driver-core-next branch.

Changes since v3:
- Fixed a build warning caused by a wrong conflict resolution on v3.


 drivers/base/dd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 6ea9c5cece7..e85705e8440 100644
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
 
 /*
  * In some cases, like suspend to RAM or hibernation, It might be reasonable
@@ -199,6 +201,24 @@ void device_unblock_probing(void)
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
@@ -208,6 +228,9 @@ void device_unblock_probing(void)
  */
 static int deferred_probe_initcall(void)
 {
+	deferred_devices = debugfs_create_file("devices_deferred", 0444, NULL,
+					       NULL, &deferred_devs_fops);
+
 	driver_deferred_probe_enable = true;
 	driver_deferred_probe_trigger();
 	/* Sort as many dependencies as possible before exiting initcalls */
@@ -216,6 +239,12 @@ static int deferred_probe_initcall(void)
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

