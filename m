Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031315AbeEXRun (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:50:43 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34623 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031146AbeEXRug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:50:36 -0400
X-Google-Smtp-Source: AB8JxZp9kB6y6KEqfkpbIUpJB67ktNLqKek8B2etwY0iTBaEjhmzOQxudo3hMQysDCkgVMNhyfqryQ==
From: Rob Herring <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/8] driver core: add a deferred probe timeout
Date: Thu, 24 May 2018 12:50:18 -0500
Message-Id: <20180524175024.19874-3-robh@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524175024.19874-1-robh@kernel.org>
References: <20180524175024.19874-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferring probe can wait forever on dependencies that may never appear
for a variety of reasons. This can be difficult to debug especially if
the console has dependencies or userspace fails to boot to a shell. Add
a timeout to retry probing without possibly optional dependencies and to
dump out the deferred probe pending list after retrying.

This mechanism is intended for debug purposes. It won't work for the
console which needs to be enabled before userspace starts. However, if
the console's dependencies are resolved, then the kernel log will be
printed (as opposed to no output).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++++
 drivers/base/dd.c                             | 28 ++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11fc28ecdb6d..dd3f40b34a24 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -809,6 +809,13 @@
 			Defaults to the default architecture's huge page size
 			if not specified.
 
+	deferred_probe_timeout=
+			[KNL] Set a timeout in seconds for deferred probe to
+			give up waiting on dependencies to probe. Only specific
+			dependencies (subsystems or drivers) that have opted in
+			will be ignored. This option also dumps out devices
+			still on the deferred probe list after retrying.
+
 	dhash_entries=	[KNL]
 			Set number of hash buckets for dentry cache.
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index d6034718da6f..4133b240c7e4 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -226,9 +226,17 @@ void device_unblock_probing(void)
 	driver_deferred_probe_trigger();
 }
 
+static int deferred_probe_timeout = -1;
+static int __init deferred_probe_timeout_setup(char *str)
+{
+	deferred_probe_timeout = simple_strtol(str, NULL, 0);
+	return 1;
+}
+__setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
+
 int driver_deferred_probe_check_init_done(struct device *dev, bool optional)
 {
-	if (optional && initcalls_done) {
+	if ((optional || !deferred_probe_timeout) && initcalls_done) {
 		dev_WARN(dev, "ignoring dependency for device, assuming no driver");
 		return -ENODEV;
 	}
@@ -236,6 +244,19 @@ int driver_deferred_probe_check_init_done(struct device *dev, bool optional)
 	return -EPROBE_DEFER;
 }
 
+static void deferred_probe_timeout_work_func(struct work_struct *work)
+{
+	struct device_private *private, *p;
+
+	deferred_probe_timeout = 0;
+	driver_deferred_probe_trigger();
+	flush_work(&deferred_probe_work);
+
+	list_for_each_entry_safe(private, p, &deferred_probe_pending_list, deferred_probe)
+		dev_info(private->device, "deferred probe pending");
+}
+static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
+
 /**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
@@ -257,6 +278,11 @@ static int deferred_probe_initcall(void)
 	 */
 	driver_deferred_probe_trigger();
 	flush_work(&deferred_probe_work);
+
+	if (deferred_probe_timeout > 0) {
+		schedule_delayed_work(&deferred_probe_timeout_work,
+			deferred_probe_timeout * HZ);
+	}
 	return 0;
 }
 late_initcall(deferred_probe_initcall);
-- 
2.17.0
