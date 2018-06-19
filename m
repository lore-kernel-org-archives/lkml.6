Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C739EC5AE5E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BA220661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BA220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030578AbeFSU7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:59:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50389 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030301AbeFSU7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:59:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id e16-v6so2544110wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 13:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mjYHSJbe8beWgs7as0mUAtGZ5vsVj/kppDBdnF8dUmI=;
        b=OFvm4TzSse2NSVGTgEBKuxL2JXikTVUg6zkYBXa1szPPbVHEtMCQCvN2PW6EMnrTLi
         4qCM7hVoqaVZgIKZhZQJS3kLdbF8ZswO9Z+ZOiUeG5RiEWWcbA/dIn1CllOf7tJkv1Ox
         w4nfeaPXAUlfvUkChCSAk5D0LZJt66a1PUyvm/VzSdo+D4nJ6vyTYT2m9STC1Q2vwtZO
         MoZ2A8+slI2x3z87yVjlMvFMgULmeXZc8OB9NYLC1z3lwHdjGrAu1R0yqou28jHq/qFe
         c5zBG+oE8jcquwh03Ee/J+ugLtEwoHL0CBl6VSCvuF7uAi9jUDQfcbY6bNckj4uVqNNF
         b8uw==
X-Gm-Message-State: APt69E0Rrmg2KnhxjcQKE9SPYrGaM6ZKuIYzGWg+LjftBbCexr4jpChL
        THipd0iYvKytTyePDmqXF78KbDfkoTY=
X-Google-Smtp-Source: ADUXVKJ3OddB2fw0ENv1n/k8NWIPeHLJANU2ErgZVkLXbFPXuNs8VpSlklkchMv0fKfj/h5hyQs85g==
X-Received: by 2002:a1c:e6d9:: with SMTP id e86-v6mr12002302wmi.135.1529441957190;
        Tue, 19 Jun 2018 13:59:17 -0700 (PDT)
Received: from minerva.home ([90.77.100.34])
        by smtp.gmail.com with ESMTPSA id k17-v6sm1431150wmc.23.2018.06.19.13.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 13:59:16 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] driver core: add a debugfs entry to show deferred devices
Date:   Tue, 19 Jun 2018 22:59:14 +0200
Message-Id: <20180619205914.21375-1-javierm@redhat.com>
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

Changes since RFC v1:
- Remove unneeded ret variable from deferred_devs_show()

Changes since RFC v2:
- Use DEFINE_SHOW_ATTRIBUTE() macro.
- Don't propagate debugfs_create_file() error.
- Remove IS_ENABLED(CONFIG_DEBUG_FS) guards.
- Drop RFC prefix.

 drivers/base/dd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1435d7281c6..8ec9e3cfbe4 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -16,6 +16,7 @@
  * Copyright (c) 2007-2009 Novell Inc.
  */
 
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -224,6 +225,24 @@ void device_unblock_probing(void)
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
@@ -233,6 +252,9 @@ void device_unblock_probing(void)
  */
 static int deferred_probe_initcall(void)
 {
+	debugfs_create_file("deferred_devices", 0444, NULL, NULL,
+			    &deferred_devs_fops);
+
 	driver_deferred_probe_enable = true;
 	driver_deferred_probe_trigger();
 	/* Sort as many dependencies as possible before exiting initcalls */
-- 
2.17.1

