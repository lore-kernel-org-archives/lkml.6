Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B31FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B6C20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B6C20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030394AbeFSSeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:34:01 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36166 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030279AbeFSSeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:34:00 -0400
Received: by mail-wr0-f196.google.com with SMTP id f16-v6so664636wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 11:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QtxUyfLucKOe/dBeI7a/kfctRhipQUIczmfKo7SJ/bY=;
        b=RVOwpto3LJq3CX42IgOAFPDCOZ3oZhZRv5taRi8UJXKaLDvqsr8wt73EXwaNHFWK02
         wtW93pWxWZiKI3kGlFHcU7WQgHgIGmMKg1apHaCax9u59WYT3//c8W1GpxNf6Dg7jSUR
         wOWNQRBxWbzCgHNKbGrcP7UJSNxqJiqy0jDrel3TbTx8L7lDo2tj5JYXdGoJThKObotG
         fYPdzVWlqb4cpOzXN2yPoEGsTOnKfQ1ZuYIAEHOqUa184ag6ENkdLkgpRH0SgM3W9nT9
         k9RFvyRq08GDYJCumqkzmrv8Avk0d3xNLjdKD0tSlwepQUBMaSXisv+EOu1O/8ix4FVB
         Irag==
X-Gm-Message-State: APt69E2yDhtdfQhvzQEnrj7aYsOlG5bqlprvCqWai0JyWDsrvy7XBYYe
        FqmV9JbDzaoJ7OCClGqpMCJzBKE2ggU=
X-Google-Smtp-Source: ADUXVKJICeqJHg7CCYgoyqQ9FGWSYLnvlOYQl+nNTyI88WXHz1a+UDt9kqqRy9hFtVGt2pa0jTa4Ow==
X-Received: by 2002:adf:ee0e:: with SMTP id y14-v6mr15950700wrn.63.1529433239000;
        Tue, 19 Jun 2018 11:33:59 -0700 (PDT)
Received: from minerva.home ([90.77.100.34])
        by smtp.gmail.com with ESMTPSA id 127-v6sm1040104wmk.45.2018.06.19.11.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 11:33:58 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC PATCH v2] driver core: add a debugfs entry to show deferred devices
Date:   Tue, 19 Jun 2018 20:33:56 +0200
Message-Id: <20180619183356.32106-1-javierm@redhat.com>
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

Changes in v2:
- Remove unneeded ret variable from deferred_devs_show()

 drivers/base/dd.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1435d7281c6..d95bd4636fc 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -224,6 +224,42 @@ void device_unblock_probing(void)
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
@@ -233,6 +269,14 @@ void device_unblock_probing(void)
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

