Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAA0C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865902073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og4qDv99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865902073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeI3CYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 22:24:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41531 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeI3CYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 22:24:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id z3-v6so6753967pgv.8;
        Sat, 29 Sep 2018 12:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3w5nZy1rTmDq9OehC3BiAguPc8U344n6mmQ65gzZ79w=;
        b=Og4qDv99O9igXtw7Czo9aR4NjaNrj/oqgDWLKtv5Jk7OfghH5fqUriNOuFjdf/1TAy
         Xcjso+dt3k3wXcgPbHBvHYjepbcOt1NB2xlcnWGwNVptQL0Yu1UUFLxHFs2NOQOrV4KK
         B82s4KzRhSf3p0B9oHQ7EZyApDHRceHvK7vuCFvu28by13IRJbFV6D3YUX3FD6m2rB0w
         cOf/put399Fr66wTUuyOQY3yvAqMis2Szd+RYhHTLgHvQTQVhwAR4vhXD+DmCbgL3mCK
         b2Jl2lJuT9kzDqpAkPhc2JyD97rFEj+SI0orOXDf9T3QZpj2+EqR0S705rKObaAZSacr
         xA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3w5nZy1rTmDq9OehC3BiAguPc8U344n6mmQ65gzZ79w=;
        b=lxT50Y5Of+YDMXO/fpWhvhz1m4xcUXJUvd/doOqnv0T6wKRS6KXf0Qe3V8efhlJ9xU
         NhJU9cjjptQN6bKtdZQaXpXsevNJWItM2akQ0SpHCBG72Z01/Jk06jGsziIiIq1GM50y
         x07ybx5o5DyfVGWRjXiKyzA2Jup/LRoFZL72kthRNWP8MoKtYAropqLAgT6AdEb3HfQZ
         j3WHpNsXyTWFmqlMzTSixB2Gk3JNgWZmCOwA43SL6/o+gUlQxB5x+4xvbyoRA8jcBFni
         UKRT527hx/Fo3w8dFPBBkezYy9KLMLhJyqxFsz9nPbMeliioe5bR8C87tg87UdptlC09
         C8Aw==
X-Gm-Message-State: ABuFfoh0v0Qlk+ExpBb+ubfz8n/iRK6XEfzPWnh8cOP4hTk9XldvnBg2
        DqV6zbhcT/SWNo9wohZ726trXxYW
X-Google-Smtp-Source: ACcGV61aYjDvfIv3heaqnIc1Qn2KQ5n97L3K+eWPfWu6VPR82g8hFnccclCeJquPfMZMFLIvRuNXUw==
X-Received: by 2002:a62:438f:: with SMTP id l15-v6mr4377622pfi.196.1538250891552;
        Sat, 29 Sep 2018 12:54:51 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id b126-v6sm18371946pga.49.2018.09.29.12.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:54:50 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sebastian Reichel <sre@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v7 06/17] media: v4l2-fwnode: Add a convenience function for registering subdevs with notifiers
Date:   Sat, 29 Sep 2018 12:54:09 -0700
Message-Id: <20180929195420.28579-7-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929195420.28579-1-slongerbeam@gmail.com>
References: <20180929195420.28579-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds v4l2_async_register_fwnode_subdev(), which is a convenience function
for parsing a sub-device's fwnode port endpoints for connected remote
sub-devices, registering a sub-device notifier, and then registering
the sub-device itself.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
Changes since v6:
- none
Changes since v5:
- add call to v4l2_async_notifier_init().
Changes since v4:
- none
Changes since v3:
- remove support for port sub-devices, such sub-devices will have to
  role their own.
Changes since v2:
- fix error-out path in v4l2_async_register_fwnode_subdev() that forgot
  to put device.
Changes since v1:
- add #include <media/v4l2-subdev.h> to v4l2-fwnode.h for
  'struct v4l2_subdev' declaration.
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 64 +++++++++++++++++++++++++++
 include/media/v4l2-fwnode.h           | 38 ++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 88383d3d5974..be75d9900667 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -876,6 +876,70 @@ int v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd)
 }
 EXPORT_SYMBOL_GPL(v4l2_async_register_subdev_sensor_common);
 
+int v4l2_async_register_fwnode_subdev(
+	struct v4l2_subdev *sd, size_t asd_struct_size,
+	unsigned int *ports, unsigned int num_ports,
+	int (*parse_endpoint)(struct device *dev,
+			      struct v4l2_fwnode_endpoint *vep,
+			      struct v4l2_async_subdev *asd))
+{
+	struct v4l2_async_notifier *notifier;
+	struct device *dev = sd->dev;
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	if (WARN_ON(!dev))
+		return -ENODEV;
+
+	fwnode = dev_fwnode(dev);
+	if (!fwnode_device_is_available(fwnode))
+		return -ENODEV;
+
+	notifier = kzalloc(sizeof(*notifier), GFP_KERNEL);
+	if (!notifier)
+		return -ENOMEM;
+
+	v4l2_async_notifier_init(notifier);
+
+	if (!ports) {
+		ret = v4l2_async_notifier_parse_fwnode_endpoints(
+			dev, notifier, asd_struct_size, parse_endpoint);
+		if (ret < 0)
+			goto out_cleanup;
+	} else {
+		unsigned int i;
+
+		for (i = 0; i < num_ports; i++) {
+			ret = v4l2_async_notifier_parse_fwnode_endpoints_by_port(
+				dev, notifier, asd_struct_size,
+				ports[i], parse_endpoint);
+			if (ret < 0)
+				goto out_cleanup;
+		}
+	}
+
+	ret = v4l2_async_subdev_notifier_register(sd, notifier);
+	if (ret < 0)
+		goto out_cleanup;
+
+	ret = v4l2_async_register_subdev(sd);
+	if (ret < 0)
+		goto out_unregister;
+
+	sd->subdev_notifier = notifier;
+
+	return 0;
+
+out_unregister:
+	v4l2_async_notifier_unregister(notifier);
+out_cleanup:
+	v4l2_async_notifier_cleanup(notifier);
+	kfree(notifier);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(v4l2_async_register_fwnode_subdev);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Sakari Ailus <sakari.ailus@linux.intel.com>");
 MODULE_AUTHOR("Sylwester Nawrocki <s.nawrocki@samsung.com>");
diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
index ea7a8b247e19..031ebb069dcb 100644
--- a/include/media/v4l2-fwnode.h
+++ b/include/media/v4l2-fwnode.h
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 
 #include <media/v4l2-mediabus.h>
+#include <media/v4l2-subdev.h>
 
 struct fwnode_handle;
 struct v4l2_async_notifier;
@@ -360,4 +361,41 @@ int v4l2_async_notifier_parse_fwnode_endpoints_by_port(
 int v4l2_async_notifier_parse_fwnode_sensor_common(
 	struct device *dev, struct v4l2_async_notifier *notifier);
 
+/**
+ * v4l2_async_register_fwnode_subdev - registers a sub-device to the
+ *					asynchronous sub-device framework
+ *					and parses fwnode endpoints
+ *
+ * @sd: pointer to struct &v4l2_subdev
+ * @asd_struct_size: size of the driver's async sub-device struct, including
+ *		     sizeof(struct v4l2_async_subdev). The &struct
+ *		     v4l2_async_subdev shall be the first member of
+ *		     the driver's async sub-device struct, i.e. both
+ *		     begin at the same memory address.
+ * @ports: array of port id's to parse for fwnode endpoints. If NULL, will
+ *	   parse all ports owned by the sub-device.
+ * @num_ports: number of ports in @ports array. Ignored if @ports is NULL.
+ * @parse_endpoint: Driver's callback function called on each V4L2 fwnode
+ *		    endpoint. Optional.
+ *
+ * This function is just like v4l2_async_register_subdev() with the
+ * exception that calling it will also allocate a notifier for the
+ * sub-device, parse the sub-device's firmware node endpoints using
+ * v4l2_async_notifier_parse_fwnode_endpoints() or
+ * v4l2_async_notifier_parse_fwnode_endpoints_by_port(), and
+ * registers the sub-device notifier. The sub-device is similarly
+ * unregistered by calling v4l2_async_unregister_subdev().
+ *
+ * While registered, the subdev module is marked as in-use.
+ *
+ * An error is returned if the module is no longer loaded on any attempts
+ * to register it.
+ */
+int v4l2_async_register_fwnode_subdev(
+	struct v4l2_subdev *sd, size_t asd_struct_size,
+	unsigned int *ports, unsigned int num_ports,
+	int (*parse_endpoint)(struct device *dev,
+			      struct v4l2_fwnode_endpoint *vep,
+			      struct v4l2_async_subdev *asd));
+
 #endif /* _V4L2_FWNODE_H */
-- 
2.17.1

