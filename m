Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A83C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A7222419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A7222419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733061AbeKMWps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:45:48 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:48296 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732884AbeKMWps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:45:48 -0500
Received: from ramsan.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id zQnm1y0013XaVaC01QnmF2; Tue, 13 Nov 2018 13:47:46 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1gMY6c-0005r9-0w; Tue, 13 Nov 2018 13:47:46 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gMY6b-000222-VV; Tue, 13 Nov 2018 13:47:45 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] reset: Add reset_control_get_count()
Date:   Tue, 13 Nov 2018 13:47:44 +0100
Message-Id: <20181113124744.7769-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the reset core has internal support for counting the number of
resets for a device described in DT.  Generalize this to devices using
lookup resets, and export it for public use.

This will be used by generic drivers that need to be sure a device is
controlled by a single, dedicated reset line (e.g. vfio-platform).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
See https://lore.kernel.org/lkml/1539003437.11512.20.camel@pengutronix.de/
for the rationale to ensure a single, dedicated reset line.

 drivers/reset/core.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/reset.h |  7 +++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 654e20ff2d5da9d4..c32b755ec373c338 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -859,3 +859,44 @@ devm_reset_control_array_get(struct device *dev, bool shared, bool optional)
 	return rstc;
 }
 EXPORT_SYMBOL_GPL(devm_reset_control_array_get);
+
+static int reset_control_get_count_from_lookup(struct device *dev)
+{
+	const struct reset_control_lookup *lookup;
+	const char *dev_id = dev_name(dev);
+	int count = 0;
+
+	if (!dev)
+		return -EINVAL;
+
+	mutex_lock(&reset_lookup_mutex);
+
+	list_for_each_entry(lookup, &reset_lookup_list, list) {
+		if (!strcmp(lookup->dev_id, dev_id))
+			count++;
+	}
+
+	mutex_unlock(&reset_lookup_mutex);
+
+	if (count == 0)
+		count = -ENOENT;
+
+	return count;
+}
+
+/**
+ * of_reset_control_get_count - Count number of resets available with a device
+ *
+ * @dev: device for which to return the number of resets
+ *
+ * Returns positive reset count on success, or error number on failure and
+ * on count being zero.
+ */
+int reset_control_get_count(struct device *dev)
+{
+	if (dev->of_node)
+		return of_reset_control_get_count(dev->of_node);
+
+	return reset_control_get_count_from_lookup(dev);
+}
+EXPORT_SYMBOL_GPL(reset_control_get_count);
diff --git a/include/linux/reset.h b/include/linux/reset.h
index f0b094130686bf32..2698b36bd1eb3e0c 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -32,6 +32,8 @@ struct reset_control *devm_reset_control_array_get(struct device *dev,
 struct reset_control *of_reset_control_array_get(struct device_node *np,
 						 bool shared, bool optional);
 
+int reset_control_get_count(struct device *dev);
+
 #else
 
 static inline int reset_control_reset(struct reset_control *rstc)
@@ -97,6 +99,11 @@ of_reset_control_array_get(struct device_node *np, bool shared, bool optional)
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
 
+static inline int reset_control_get_count(struct device *dev)
+{
+	return -ENOENT;
+}
+
 #endif /* CONFIG_RESET_CONTROLLER */
 
 static inline int __must_check device_reset(struct device *dev)
-- 
2.17.1

