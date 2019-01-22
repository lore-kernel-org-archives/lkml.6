Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC99AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4BF21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170879;
	bh=OZ15Qg+o9lnP9e98FZMfLUjygBT49/jWlEWn6ulPnq8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1iGLIM01WMrE5E/nhbE0BniTkr0ErM9LIAdEnhlIqoZeNSYbt1vTrYee8gAJgaKUJ
	 les6X77CDcUoReNnVevJz0brw2h4jv3pAR7VJ6si6hgZMKITIglB5pVWFHO7RNWv8A
	 FltzGt6orM37UyvGZ6PtOa6rgFI2TrGPFlxAh/+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfAVPWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:22:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbfAVPW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:22:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC1FD20879;
        Tue, 22 Jan 2019 15:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170546;
        bh=OZ15Qg+o9lnP9e98FZMfLUjygBT49/jWlEWn6ulPnq8=;
        h=From:To:Cc:Subject:Date:From;
        b=EPc0UMVQErQNbhv2atqpWnOxk2SmgrKPSnZzv+dz1I/UQkZRQOqWRJz7BpMJ7C6Qd
         zfAvy4IMXBa6RwKP1SIkpcT6w6mJwF/JtibOQ8qK1sasrC+XFHTHC5S5WSwT016Pp9
         XJSL42XN0mj8dGwRpGze+G5OSk3Eb2wiql8rIRLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH] opp: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:17 +0100
Message-Id: <20190122152151.16139-18-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/opp/core.c    |  10 +---
 drivers/opp/debugfs.c | 109 +++++++++++-------------------------------
 drivers/opp/opp.h     |  15 +++---
 3 files changed, 37 insertions(+), 97 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 18f1639dbc4a..00b6b436a199 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -805,10 +805,7 @@ static struct opp_device *_add_opp_dev_unlocked(const struct device *dev,
 	list_add(&opp_dev->node, &opp_table->dev_list);
 
 	/* Create debugfs entries for the opp_table */
-	ret = opp_debug_register(opp_dev, opp_table);
-	if (ret)
-		dev_err(dev, "%s: Failed to register opp debugfs (%d)\n",
-			__func__, ret);
+	opp_debug_register(opp_dev, opp_table);
 
 	return opp_dev;
 }
@@ -1229,10 +1226,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	new_opp->opp_table = opp_table;
 	kref_init(&new_opp->kref);
 
-	ret = opp_debug_create_one(new_opp, opp_table);
-	if (ret)
-		dev_err(dev, "%s: Failed to register opp to debugfs (%d)\n",
-			__func__, ret);
+	opp_debug_create_one(new_opp, opp_table);
 
 	if (!_opp_supported_by_regulators(new_opp, opp_table)) {
 		new_opp->available = false;
diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index e6828e5f81b0..baac1ae33c55 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -35,7 +35,7 @@ void opp_debug_remove_one(struct dev_pm_opp *opp)
 	debugfs_remove_recursive(opp->dentry);
 }
 
-static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
+static void opp_debug_create_supplies(struct dev_pm_opp *opp,
 				      struct opp_table *opp_table,
 				      struct dentry *pdentry)
 {
@@ -50,30 +50,21 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
 		/* Create per-opp directory */
 		d = debugfs_create_dir(name, pdentry);
 
-		if (!d)
-			return false;
+		debugfs_create_ulong("u_volt_target", S_IRUGO, d,
+				     &opp->supplies[i].u_volt);
 
-		if (!debugfs_create_ulong("u_volt_target", S_IRUGO, d,
-					  &opp->supplies[i].u_volt))
-			return false;
+		debugfs_create_ulong("u_volt_min", S_IRUGO, d,
+				     &opp->supplies[i].u_volt_min);
 
-		if (!debugfs_create_ulong("u_volt_min", S_IRUGO, d,
-					  &opp->supplies[i].u_volt_min))
-			return false;
+		debugfs_create_ulong("u_volt_max", S_IRUGO, d,
+				     &opp->supplies[i].u_volt_max);
 
-		if (!debugfs_create_ulong("u_volt_max", S_IRUGO, d,
-					  &opp->supplies[i].u_volt_max))
-			return false;
-
-		if (!debugfs_create_ulong("u_amp", S_IRUGO, d,
-					  &opp->supplies[i].u_amp))
-			return false;
+		debugfs_create_ulong("u_amp", S_IRUGO, d,
+				     &opp->supplies[i].u_amp);
 	}
-
-	return true;
 }
 
-int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
+void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 {
 	struct dentry *pdentry = opp_table->dentry;
 	struct dentry *d;
@@ -95,40 +86,22 @@ int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 
 	/* Create per-opp directory */
 	d = debugfs_create_dir(name, pdentry);
-	if (!d)
-		return -ENOMEM;
-
-	if (!debugfs_create_bool("available", S_IRUGO, d, &opp->available))
-		return -ENOMEM;
-
-	if (!debugfs_create_bool("dynamic", S_IRUGO, d, &opp->dynamic))
-		return -ENOMEM;
-
-	if (!debugfs_create_bool("turbo", S_IRUGO, d, &opp->turbo))
-		return -ENOMEM;
-
-	if (!debugfs_create_bool("suspend", S_IRUGO, d, &opp->suspend))
-		return -ENOMEM;
-
-	if (!debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate))
-		return -ENOMEM;
 
-	if (!debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate))
-		return -ENOMEM;
+	debugfs_create_bool("available", S_IRUGO, d, &opp->available);
+	debugfs_create_bool("dynamic", S_IRUGO, d, &opp->dynamic);
+	debugfs_create_bool("turbo", S_IRUGO, d, &opp->turbo);
+	debugfs_create_bool("suspend", S_IRUGO, d, &opp->suspend);
+	debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate);
+	debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate);
+	debugfs_create_ulong("clock_latency_ns", S_IRUGO, d, &opp->clock_latency_ns);
 
-	if (!opp_debug_create_supplies(opp, opp_table, d))
-		return -ENOMEM;
-
-	if (!debugfs_create_ulong("clock_latency_ns", S_IRUGO, d,
-				  &opp->clock_latency_ns))
-		return -ENOMEM;
+	opp_debug_create_supplies(opp, opp_table, d);
 
 	opp->dentry = d;
-	return 0;
 }
 
-static int opp_list_debug_create_dir(struct opp_device *opp_dev,
-				     struct opp_table *opp_table)
+static void opp_list_debug_create_dir(struct opp_device *opp_dev,
+				      struct opp_table *opp_table)
 {
 	const struct device *dev = opp_dev->dev;
 	struct dentry *d;
@@ -137,36 +110,21 @@ static int opp_list_debug_create_dir(struct opp_device *opp_dev,
 
 	/* Create device specific directory */
 	d = debugfs_create_dir(opp_table->dentry_name, rootdir);
-	if (!d) {
-		dev_err(dev, "%s: Failed to create debugfs dir\n", __func__);
-		return -ENOMEM;
-	}
 
 	opp_dev->dentry = d;
 	opp_table->dentry = d;
-
-	return 0;
 }
 
-static int opp_list_debug_create_link(struct opp_device *opp_dev,
-				      struct opp_table *opp_table)
+static void opp_list_debug_create_link(struct opp_device *opp_dev,
+				       struct opp_table *opp_table)
 {
-	const struct device *dev = opp_dev->dev;
 	char name[NAME_MAX];
-	struct dentry *d;
 
 	opp_set_dev_name(opp_dev->dev, name);
 
 	/* Create device specific directory link */
-	d = debugfs_create_symlink(name, rootdir, opp_table->dentry_name);
-	if (!d) {
-		dev_err(dev, "%s: Failed to create link\n", __func__);
-		return -ENOMEM;
-	}
-
-	opp_dev->dentry = d;
-
-	return 0;
+	opp_dev->dentry = debugfs_create_symlink(name, rootdir,
+						 opp_table->dentry_name);
 }
 
 /**
@@ -177,20 +135,13 @@ static int opp_list_debug_create_link(struct opp_device *opp_dev,
  * Dynamically adds device specific directory in debugfs 'opp' directory. If the
  * device-opp is shared with other devices, then links will be created for all
  * devices except the first.
- *
- * Return: 0 on success, otherwise negative error.
  */
-int opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table)
+void opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table)
 {
-	if (!rootdir) {
-		pr_debug("%s: Uninitialized rootdir\n", __func__);
-		return -EINVAL;
-	}
-
 	if (opp_table->dentry)
-		return opp_list_debug_create_link(opp_dev, opp_table);
-
-	return opp_list_debug_create_dir(opp_dev, opp_table);
+		opp_list_debug_create_link(opp_dev, opp_table);
+	else
+		opp_list_debug_create_dir(opp_dev, opp_table);
 }
 
 static void opp_migrate_dentry(struct opp_device *opp_dev,
@@ -252,10 +203,6 @@ static int __init opp_debug_init(void)
 {
 	/* Create /sys/kernel/debug/opp directory */
 	rootdir = debugfs_create_dir("opp", NULL);
-	if (!rootdir) {
-		pr_err("%s: Failed to create root directory\n", __func__);
-		return -ENOMEM;
-	}
 
 	return 0;
 }
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index e24d81497375..810a85b9a66d 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -236,18 +236,17 @@ static inline void _of_opp_free_required_opps(struct opp_table *opp_table,
 
 #ifdef CONFIG_DEBUG_FS
 void opp_debug_remove_one(struct dev_pm_opp *opp);
-int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table);
-int opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table);
+void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table);
+void opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table);
 void opp_debug_unregister(struct opp_device *opp_dev, struct opp_table *opp_table);
 #else
 static inline void opp_debug_remove_one(struct dev_pm_opp *opp) {}
 
-static inline int opp_debug_create_one(struct dev_pm_opp *opp,
-				       struct opp_table *opp_table)
-{ return 0; }
-static inline int opp_debug_register(struct opp_device *opp_dev,
-				     struct opp_table *opp_table)
-{ return 0; }
+static inline void opp_debug_create_one(struct dev_pm_opp *opp,
+					struct opp_table *opp_table) { }
+
+static inline void opp_debug_register(struct opp_device *opp_dev,
+				      struct opp_table *opp_table) { }
 
 static inline void opp_debug_unregister(struct opp_device *opp_dev,
 					struct opp_table *opp_table)
-- 
2.20.1

