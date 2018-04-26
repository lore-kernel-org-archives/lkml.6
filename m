Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932212AbeDZOI5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:08:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51047 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756536AbeDZOI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:08:28 -0400
X-Google-Smtp-Source: AIpwx4+cc72ajMMhLspxpiO/9AMNkQx5kiTKGTuQanP0C2Sg9X8jAMJ4cihajVAcPTn+lYdf89Xs7w==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [RFC PATCH 1/3] of: base: Introduce of_alias_check_id() to check alias IDs
Date: Thu, 26 Apr 2018 16:08:17 +0200
Message-Id: <6045807691c310ccdd57ab16524b7525f26a1dc1.1524751696.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1524751696.git.michal.simek@xilinx.com>
References: <cover.1524751696.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1524751696.git.michal.simek@xilinx.com>
References: <cover.1524751696.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function travers the lookup table to check if the request alias
id is compatible with the device driver match structure.
This function will be used by serial drivers to check if requested alias
is allocated or free to use.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/of/base.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h |  2 ++
 2 files changed, 51 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 848f549164cd..382de01acc72 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1892,6 +1892,55 @@ int of_alias_get_id(struct device_node *np, const char *stem)
 }
 EXPORT_SYMBOL_GPL(of_alias_get_id);
 
+/**
+ * of_alias_check_id - Check alias id for the give compatibility
+ * @matches:	Array of of device match structures to search in
+ * @stem:	Alias stem of the given device_node
+ * @id:		Alias ID for checking
+ *
+ * The function travers the lookup table to check if the request alias id
+ * is compatible with the device driver match structure
+ *
+ * Return true if ID is allocated, return false if not
+ */
+bool of_alias_check_id(const struct of_device_id *matches, const char *stem,
+		       int id)
+{
+	struct alias_prop *app;
+	bool ret = false;
+
+	mutex_lock(&of_mutex);
+	pr_debug("%s: Looking for stem: %s, id: %d\n", __func__, stem, id);
+	list_for_each_entry(app, &aliases_lookup, link) {
+		pr_debug("%s: stem: %s, id: %d\n",
+			 __func__, app->stem, app->id);
+
+		if (strcmp(app->stem, stem) != 0) {
+			pr_debug("%s: stem comparison doesn't passed %s\n",
+				 __func__, app->stem);
+			continue;
+		}
+
+		if (app->id != id) {
+			pr_debug("%s: id comparison doesn't passed %d\n",
+				 __func__, app->id);
+			continue;
+		}
+
+		if (of_match_node(matches, app->np)) {
+			pr_debug("%s: Allocated ID %d\n", __func__, app->id);
+			ret = true;
+			break;
+		}
+		pr_debug("%s: Free ID %d\n", __func__, app->id);
+		break;
+	}
+	mutex_unlock(&of_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_alias_check_id);
+
 /**
  * of_alias_get_highest_id - Get highest alias id for the given stem
  * @stem:	Alias stem to be examined
diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f952d9..a18a390a6129 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -387,6 +387,8 @@ extern int of_phandle_iterator_args(struct of_phandle_iterator *it,
 extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
 extern int of_alias_get_id(struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
+extern bool of_alias_check_id(const struct of_device_id *matches,
+			      const char *stem, int id);
 
 extern int of_machine_is_compatible(const char *compat);
 
-- 
2.17.0
