Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8CDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05183206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7gHW/jW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbfAKLuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:50:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41656 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbfAKLuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:50:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so6229810pgq.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 03:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6abORcUabUlyQ/4AP1uyvPR1q2RgpmyN10/gdUhWenU=;
        b=g7gHW/jWIMatBO2ENQA5SeXRuUX/6+SBSitd2LC02rG48Qav0QUTKMPvKqhqp+PIPo
         B17vysB8REO2mwgTVcJS2rLsQUkjzmafkzovfO4ZR04o7Xu8yIs58dZIcLV1fQ9oIFHf
         KRaGg5tEbFErZjiuevko6B4g1rStpuLJoimOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6abORcUabUlyQ/4AP1uyvPR1q2RgpmyN10/gdUhWenU=;
        b=s2bX7N84+CzywPj8dazGU5wvffmwttKnyt2jUOsn660XBrEkLU5bYKYYcQKqJON9iV
         ftu45Zg2uJr0VX5mTA5z5SjjfqMeSFK2VZnx1emJdh6YZhetT5Ygxk3Vxy5gd73IMGS5
         1337KFe4bST71lZjUPqpgM9Afcge8nMqSomlGhvCOjae/XBsqOgMIVB1MRSZK8yb0vN/
         5JRCHpHNUU5sYtlAOx09zdyOZe9v77sNXtbQFshvkzW4e91qzHLkKHcBpWphbGG9CrLp
         sQDmxbu72PgBQnLD3THxSL5r416dH1OmBAhHOpnyNzEXrnnQXbLsK7yXEsEWlXhJVlq7
         4Gsw==
X-Gm-Message-State: AJcUukdLh07UB5E14g/C9EHMs16dbizCS/OnK26Iefy1E2dBuNMz/VTb
        jclmtErCy4MBOaMVNTzNd8AhLg==
X-Google-Smtp-Source: ALg8bN7XYNUYJM7hDizvK2p4tYdBY6+A0ZJZjunM2Hc/7vNmrrdGjYmjvidWWZisWpHamDADz/6l+g==
X-Received: by 2002:a62:8e19:: with SMTP id k25mr14208417pfe.185.1547207405038;
        Fri, 11 Jan 2019 03:50:05 -0800 (PST)
Received: from localhost.localdomain ([117.196.233.251])
        by smtp.gmail.com with ESMTPSA id b2sm143199988pfm.3.2019.01.11.03.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 03:50:04 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jens.wiklander@linaro.org,
        mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        daniel.thompson@linaro.org, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 1/4] tee: add bus driver framework for TEE based devices
Date:   Fri, 11 Jan 2019 17:17:28 +0530
Message-Id: <1547207251-9372-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547207251-9372-1-git-send-email-sumit.garg@linaro.org>
References: <1547207251-9372-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a generic TEE bus driver concept for TEE based kernel drivers
which would like to communicate with TEE based devices/services.

In this TEE bus concept, devices/services are identified via Universally
Unique Identifier (UUID) and drivers register a table of device UUIDs
which they can support.

So this TEE bus framework registers a match() callback function which
iterates over the driver UUID table to find a corresponding match for
device UUID. If a match is found, then this particular device is probed
via corresponding probe api registered by the driver. This process
happens whenever a device or a driver is registered with TEE bus.

Also this framework allows for device enumeration to be specific to
corresponding TEE implementation like OP-TEE etc.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/tee_core.c  | 43 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/tee_drv.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 7b2bb4c..a685940 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -15,7 +15,6 @@
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/cdev.h>
-#include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/module.h>
@@ -1027,6 +1026,30 @@ int tee_client_invoke_func(struct tee_context *ctx,
 }
 EXPORT_SYMBOL_GPL(tee_client_invoke_func);
 
+static int tee_client_device_match(struct device *dev,
+				   struct device_driver *drv)
+{
+	struct tee_client_device *tee_device;
+	const struct tee_client_device_id *id_table;
+
+	tee_device = to_tee_client_device(dev);
+	id_table = to_tee_client_driver(drv)->id_table;
+
+	while (!uuid_is_null(&id_table->uuid)) {
+		if (uuid_equal(&tee_device->id.uuid, &id_table->uuid))
+			return 1;
+		id_table++;
+	}
+
+	return 0;
+}
+
+struct bus_type tee_bus_type = {
+	.name		= "tee",
+	.match		= tee_client_device_match,
+};
+EXPORT_SYMBOL_GPL(tee_bus_type);
+
 static int __init tee_init(void)
 {
 	int rc;
@@ -1040,10 +1063,23 @@ static int __init tee_init(void)
 	rc = alloc_chrdev_region(&tee_devt, 0, TEE_NUM_DEVICES, "tee");
 	if (rc) {
 		pr_err("failed to allocate char dev region\n");
-		class_destroy(tee_class);
-		tee_class = NULL;
+		goto chrdev_err;
 	}
 
+	rc = bus_register(&tee_bus_type);
+	if (rc) {
+		pr_err("failed to register tee bus\n");
+		goto bus_err;
+	}
+
+	return 0;
+
+bus_err:
+	unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
+chrdev_err:
+	class_destroy(tee_class);
+	tee_class = NULL;
+
 	return rc;
 }
 
@@ -1052,6 +1088,7 @@ static void __exit tee_exit(void)
 	class_destroy(tee_class);
 	tee_class = NULL;
 	unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
+	bus_unregister(&tee_bus_type);
 }
 
 subsys_initcall(tee_init);
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 6cfe058..ed16bf1 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -20,6 +20,8 @@
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/tee.h>
+#include <linux/device.h>
+#include <linux/uuid.h>
 
 /*
  * The file describes the API provided by the generic TEE driver to the
@@ -538,4 +540,38 @@ static inline bool tee_param_is_memref(struct tee_param *param)
 	}
 }
 
+extern struct bus_type tee_bus_type;
+
+/**
+ * struct tee_client_device_id - tee based device identifier
+ * @uuid:		For TEE based client devices we use the device uuid
+ *			as the identifier.
+ */
+struct tee_client_device_id {
+	uuid_t uuid;
+};
+
+/**
+ * struct tee_client_device - tee based device
+ * @id:			device identifier
+ * @dev:		device structure
+ */
+struct tee_client_device {
+	struct tee_client_device_id id;
+	struct device dev;
+};
+#define to_tee_client_device(d) container_of(d, struct tee_client_device, dev)
+
+/**
+ * struct tee_client_driver - tee client driver
+ * @id_table:		device id table supported by this driver
+ * @driver:		driver structure
+ */
+struct tee_client_driver {
+	const struct tee_client_device_id *id_table;
+	struct device_driver driver;
+};
+#define to_tee_client_driver(d) \
+		container_of(d, struct tee_client_driver, driver)
+
 #endif /*__TEE_DRV_H*/
-- 
2.7.4

