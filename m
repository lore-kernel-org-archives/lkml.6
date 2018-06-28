Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7DAC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415042570B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415042570B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754872AbeF1Uny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:43:54 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33852 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753637AbeF1Unu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:43:50 -0400
Received: by mail-yw0-f194.google.com with SMTP id n187-v6so2645299ywd.1;
        Thu, 28 Jun 2018 13:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P14tl48maitCw4gJBmoAA3FYbIjRhkYwzWMuVhlBmjc=;
        b=G+AG9BveVNil/5z+rXBvK6S+9s5wGF2fx8f/wbnG1uHAyrQC43NOsYyrtNGdcV8TdC
         shd3VDtjGJs5Puj0xmhoNWg1LFDsp3y/gZBYeLZGTUIFzEldBJeInmkuo3lWdxW6c8bo
         qJnQtlQYf9KPm3pqIhyQYCwyI1YuMBMy66roCQ5VKS+yO4ncq+qWqN5O0o36qrXid77B
         Xb39K6RWx6QFP+/o4e3eUaBZPSQLjj8JG5FQrgbQZDR7guYs3USGoLwhOLlcNLkXUthU
         i1S2g9HLBaZY9PmNquK+KiD38x7Iw23jNB8ESSDp6rhMBPj1OH65EHeo2rvTGMImUzY2
         1Nuw==
X-Gm-Message-State: APt69E3lQN3hBFy0kImXNRcBS3mMknqFcyznyK0ai9aXehLTJ+51z0v+
        VoHe5Sf3DG59RxZusn2oug==
X-Google-Smtp-Source: AAOMgpdEYHhhoG7AQyhd4xhL+7khSaP8lawkMszMnA35fr9x5PVKHKtjDsWGlq0P9IsRRdJg0eFY4w==
X-Received: by 2002:a81:30d0:: with SMTP id w199-v6mr5900127yww.130.1530218629697;
        Thu, 28 Jun 2018 13:43:49 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id o7-v6sm427913ywi.32.2018.06.28.13.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 13:43:49 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/6] driver core: allow stopping deferred probe after init
Date:   Thu, 28 Jun 2018 14:43:39 -0600
Message-Id: <20180628204344.13973-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628204344.13973-1-robh@kernel.org>
References: <20180628204344.13973-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferred probe will currently wait forever on dependent devices to probe,
but sometimes a driver will never exist. It's also not always critical for
a driver to exist. Platforms can rely on default configuration from the
bootloader or reset defaults for things such as pinctrl and power domains.
This is often the case with initial platform support until various drivers
get enabled. There's at least 2 scenarios where deferred probe can render
a platform broken. Both involve using a DT which has more devices and
dependencies than the kernel supports. The 1st case is a driver may be
disabled in the kernel config. The 2nd case is the kernel version may
simply not have the dependent driver. This can happen if using a newer DT
(provided by firmware perhaps) with a stable kernel version. Deferred
probe issues can be difficult to debug especially if the console has
dependencies or userspace fails to boot to a shell.

There are also cases like IOMMUs where only built-in drivers are
supported, so deferring probe after initcalls is not needed. The IOMMU
subsystem implemented its own mechanism to handle this using OF_DECLARE
linker sections.

This commit adds makes ending deferred probe conditional on initcalls
being completed or a debug timeout. Subsystems or drivers may opt-in by
calling driver_deferred_probe_check_init_done() instead of
unconditionally returning -EPROBE_DEFER. They may use additional
information from DT or kernel's config to decide whether to continue to
defer probe or not.

The timeout mechanism is intended for debug purposes and WARNs loudly.
The remaining deferred probe pending list will also be dumped after the
timeout. Not that this timeout won't work for the console which needs
to be enabled before userspace starts. However, if the console's
dependencies are resolved, then the kernel log will be printed (as
opposed to no output).

Cc: Alexander Graf <agraf@suse.de>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
- Merged with timeout patch.
- Clarify that deferred_probe_timeout is a debug option.
- Drop the 'optional' param. The only user was pinctrl, so it has to handle
  that functionality.
- Rename function to driver_deferred_probe_check_state
- Added kerneldoc for driver_deferred_probe_check_state
- Print a 1 line warning if stopping deferred probe after initcalls and a
  WARN on timeout.

 .../admin-guide/kernel-parameters.txt         |  9 +++
 drivers/base/dd.c                             | 57 +++++++++++++++++++
 include/linux/device.h                        |  2 +
 3 files changed, 68 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index efc7aa7a0670..e83ef4648ea4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -804,6 +804,15 @@
 			Defaults to the default architecture's huge page size
 			if not specified.

+	deferred_probe_timeout=
+			[KNL] Debugging option to set a timeout in seconds for
+			deferred probe to give up waiting on dependencies to
+			probe. Only specific dependencies (subsystems or
+			drivers) that have opted in will be ignored. A timeout of 0
+			will timeout at the end of initcalls. This option will also
+			dump out devices still on the deferred probe list after
+			retrying.
+
 	dhash_entries=	[KNL]
 			Set number of hash buckets for dentry cache.

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1435d7281c66..f0bc73a71a25 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -224,6 +224,51 @@ void device_unblock_probing(void)
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
+/**
+ * driver_deferred_probe_check_state() - Check deferred probe state
+ * @dev: device to check
+ *
+ * Returns -ENODEV if init is done and all built-in drivers have had a chance
+ * to probe (i.e. initcalls are done), -ETIMEDOUT if deferred probe debug
+ * timeout has expired, or -EPROBE_DEFER if none of those conditions are met.
+ *
+ * Drivers or subsystems can opt-in to calling this function instead of directly
+ * returning -EPROBE_DEFER.
+ */
+int driver_deferred_probe_check_state(struct device *dev)
+{
+	if (initcalls_done) {
+		if (!deferred_probe_timeout) {
+			dev_WARN(dev, "deferred probe timeout, ignoring dependency");
+			return -ETIMEDOUT;
+		}
+		dev_warn(dev, "ignoring dependency for device, assuming no driver");
+		return -ENODEV;
+	}
+	return -EPROBE_DEFER;
+}
+
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
@@ -238,6 +283,18 @@ static int deferred_probe_initcall(void)
 	/* Sort as many dependencies as possible before exiting initcalls */
 	flush_work(&deferred_probe_work);
 	initcalls_done = true;
+
+	/*
+	 * Trigger deferred probe again, this time we won't defer anything
+	 * that is optional
+	 */
+	driver_deferred_probe_trigger();
+	flush_work(&deferred_probe_work);
+
+	if (deferred_probe_timeout > 0) {
+		schedule_delayed_work(&deferred_probe_timeout_work,
+			deferred_probe_timeout * HZ);
+	}
 	return 0;
 }
 late_initcall(deferred_probe_initcall);
diff --git a/include/linux/device.h b/include/linux/device.h
index 055a69dbcd18..b6d8e0a09ad9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -339,6 +339,8 @@ struct device *driver_find_device(struct device_driver *drv,
 				  struct device *start, void *data,
 				  int (*match)(struct device *dev, void *data));

+int driver_deferred_probe_check_state(struct device *dev);
+
 /**
  * struct subsys_interface - interfaces to device functions
  * @name:       name of the device function
--
2.17.1
