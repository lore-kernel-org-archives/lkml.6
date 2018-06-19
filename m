Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67634C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5B420693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5B420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967234AbeFSSVG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:21:06 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34324 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966738AbeFSSVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:21:04 -0400
Received: by mail-wr0-f193.google.com with SMTP id a12-v6so640708wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 11:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F2OcYT/MOlc0iq2dBErH7pItRAqGbgn8aaiSWnOr4PU=;
        b=gKUXCnb0EHjTDbYZETmh4cnYF2iW/VOzFNW/jqZfDLrNG0KsDBUjKEmNGzC4e6eDYT
         UCsOaRjy/otb1kel7d3ZMawLTrO47WClc9OpE10ktEyMEd3e+nAA4LCkLtk2h1QcbKcH
         EzFVGJ757m50GPseF6rI+YWXIHhvZpzSUcvwGWERLFzxVBDf1tnHJz0CBecrWHHUDzyJ
         ABE75lr8yTnnZEgZM4v6PpQi/lIzY4jXNdAzBhN5x+j+GA4wA2uRnnuOtp+zk4knWYV7
         nPgRfk8U0grQzTof5yL8csTQsFrtOcfr+zCqr4yGREXsd+T+30b0XcyRKchCE9sb/uN2
         vLHg==
X-Gm-Message-State: APt69E3tQyc/LKqTwSwaFkZBh1A2yq1zofEeopJ6DxtgGJl3mSCZJ35J
        QxRPYiKNnDJM0rjUWXWwEms8vQhn5p8=
X-Google-Smtp-Source: ADUXVKJxY5IiyzcoEB0BkTPu78CrJFupW0CYeW6PgL1EBg0OO8h2T7nxWdQRMCYh10B1ztSPYA9Pdg==
X-Received: by 2002:adf:878c:: with SMTP id b12-v6mr15708251wrb.92.1529432463497;
        Tue, 19 Jun 2018 11:21:03 -0700 (PDT)
Received: from minerva.home ([90.77.100.34])
        by smtp.gmail.com with ESMTPSA id l84-v6sm1060216wmi.3.2018.06.19.11.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 11:21:02 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC PATCH] driver core: add a debugfs entry to show deferred devices
Date:   Tue, 19 Jun 2018 20:20:51 +0200
Message-Id: <20180619182051.26478-1-javierm@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For debugging purposes it may be useful to know what are the devices whose
probe function was deferred. Add a debugfs entry showing that information.

  $ cat /sys/kernel/debug/deferred_devices
  48070000.i2c:twl@48:bci
  musb-hdrc.0.auto
  omapdrm.0

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---

 drivers/base/dd.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1435d7281c6..98a3ab4a852 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -224,6 +224,43 @@ void device_unblock_probing(void)
 	driver_deferred_probe_trigger();
 }
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+#include <linux/debugfs.h>
+
+static struct dentry *deferred_devices;
+
+/*
+ * deferred_devs_show() - Show the devices in the deferred probe pending list.
+ */
+static int deferred_devs_show(struct seq_file *s, void *data)
+{
+	struct device_private *curr;
+	int ret = 0;
+
+	mutex_lock(&deferred_probe_mutex);
+
+	list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
+		seq_printf(s, "%s\n", dev_name(curr->device));
+
+	mutex_unlock(&deferred_probe_mutex);
+
+	return ret;
+}
+
+static int deferred_devs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, deferred_devs_show, inode->i_private);
+}
+
+static const struct file_operations deferred_devs_fops = {
+	.owner = THIS_MODULE,
+	.open = deferred_devs_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+#endif /* IS_ENABLED(CONFIG_DEBUG_FS) */
+
 /**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
@@ -233,6 +270,14 @@ void device_unblock_probing(void)
  */
 static int deferred_probe_initcall(void)
 {
+	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
+		deferred_devices = debugfs_create_file("deferred_devices",
+						       0444, NULL, NULL,
+						       &deferred_devs_fops);
+		if (!deferred_devices)
+			return -ENOMEM;
+	}
+
 	driver_deferred_probe_enable = true;
 	driver_deferred_probe_trigger();
 	/* Sort as many dependencies as possible before exiting initcalls */
-- 
2.17.1

