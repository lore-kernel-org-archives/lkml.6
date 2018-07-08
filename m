Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68630C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 00:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA5920899
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 00:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA5920899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754476AbeGHAdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 20:33:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36461 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754391AbeGHAdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 20:33:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so7424879wro.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 17:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BM+QKlIC8KthSCu/wLbxxvH7RykkrTcJ4SBfwo/UojQ=;
        b=Oaxu6mvQpvsca8nuyNpuh0nRoK5xPyTWgqZQ+p7P50AgSNRNbOTa7bezXOe9SLr4yY
         l8wH1ndXH1CLz8rA9AErDJfxkq6btizZUJekrqA/aDItLFuRQYi4BhlQCYqj0LJlOi7+
         Jw9lOFR0KYSpjuSPOm7DEcvX+1E4ipPHE6PU/UleZ1VhawL+cR5OzyNvODJvGHjVoNKw
         x+K0Fn+rO5stmILBF9Ex/cO4c69oyyDZ8GwsCFPxcOpCjsJMAgE5bHAmeI3WSpVMGGrV
         rHAvo1FSc6OJa1RS8eWz1V8/RCzOCvIpdlOVyzJaMccfYdlsPeSTR2mqoVaLT4AKMeaf
         GzuA==
X-Gm-Message-State: APt69E13AMmt2UxJqS8X/SHydYX0EsVQ1z/hqsw2AqOcNTzPJ0xU/3QI
        QFxZkGGHP3Etv+C3I9WgaZm8oXYkvCw=
X-Google-Smtp-Source: AAOMgpdkm8dSZh8XQqmMf+wqjJ09abeHgXWYE5CGtgMoAQOA7zIlfhRbFgTdJ1JauFiEDN7qu9e+8A==
X-Received: by 2002:adf:aadb:: with SMTP id i27-v6mr10637527wrc.149.1531009986622;
        Sat, 07 Jul 2018 17:33:06 -0700 (PDT)
Received: from minerva.wifivip.local (88.red-83-53-218.dynamicip.rima-tde.net. [83.53.218.88])
        by smtp.gmail.com with ESMTPSA id z193-v6sm16197829wmc.14.2018.07.07.17.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 17:33:05 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3] driver core: add a debugfs entry to show deferred devices
Date:   Sun,  8 Jul 2018 02:32:56 +0200
Message-Id: <20180708003256.15655-1-javierm@redhat.com>
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


 drivers/base/dd.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 6ea9c5cece7..140f534ee9c 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -16,6 +16,7 @@
  * Copyright (c) 2007-2009 Novell Inc.
  */
 
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -53,6 +54,8 @@ static DEFINE_MUTEX(deferred_probe_mutex);
 static LIST_HEAD(deferred_probe_pending_list);
 static LIST_HEAD(deferred_probe_active_list);
 static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
+static struct dentry *deferred_devices;
+static bool initcalls_done;
 
 /*
  * In some cases, like suspend to RAM or hibernation, It might be reasonable
@@ -199,6 +202,24 @@ void device_unblock_probing(void)
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
@@ -208,6 +229,9 @@ void device_unblock_probing(void)
  */
 static int deferred_probe_initcall(void)
 {
+	deferred_devices = debugfs_create_file("devices_deferred", 0444, NULL,
+					       NULL, &deferred_devs_fops);
+
 	driver_deferred_probe_enable = true;
 	driver_deferred_probe_trigger();
 	/* Sort as many dependencies as possible before exiting initcalls */
@@ -216,6 +240,12 @@ static int deferred_probe_initcall(void)
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

