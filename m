Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524591082; cv=none;
        d=google.com; s=arc-20160816;
        b=yv9X0m1WVjWWwAPE+yBeasQ8ZIyORvRJgb8ulAFeR4hRuhNFd/kgUXuT1YZct6pBhz
         ZoiVAjXvVzSZW1xoUQtNY3JN0H1DBvmmOy48Mzj6E3PBu7in1P9vyL8O0k8ySh3dUGeU
         a4d4evDVR71fydWzN29cBJ5gjmxGA9QNjg3yNtQlvF0C+LlGf48SxXA2xMsNb01vXZ2i
         C1tVy3ofGYj2tl+qAsfCVYkciYunQHIhO3+eLJWc6Sdk1j5lL5zWFUxBJg6eEdZwMP/E
         RZ+4SMjAvfvHpQ8DF0JolQBZ8Xd3rKPeQlnl2YjIVBudgdEFz/ZIvCRJ7VqIBhaBf+bY
         kLQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=mFkhQOQC+Fk3FInSZVezP59hGVKRpZf8Fa8c5p953qQ=;
        b=c1QM8OWnN/H5wFVG2utBekPMc/6bSxn0V8SCG76s6FAF1CMSyK9dqGYygDj0lfPNZ0
         Qc9qh09IuMJZk0lW5VlnMd6D2bpV8ebOGjoiFeyfLI+oiJ2FJxKvPuwJLsqLZmiLrSFL
         PeZ175Oo5JkGRSYardzI5lrp1l//cRzFW+MiT8F8whgSZOcQ8XD1MIKlxrBRQ/jwfTmS
         pAfZDmIO9kJEtvj5oPC7T178jfLSDVvGvaJr1pYK6cg3Ep7oHjopaouMFGRCu49KlbjL
         tSWiiwf9BqZ4keR+q+ITRMrA3QKmHuqyPiDSGRvAjg7KXMeXEutglhSiEXeVRJthpffU
         ykkw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=kKybjF0Q;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=kKybjF0Q;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AIpwx4+VomzryyPDYimEB7kFZh0y5Bsu8xywZs+aWfSeM8MdAY1GlJ+WQZnGqRyyjDqxV1ClehbbeQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 08/11] of: platform: provide of_early_platform_populate()
Date: Tue, 24 Apr 2018 19:30:48 +0200
Message-Id: <20180424173051.15099-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649619086579530?=
X-GMAIL-MSGID: =?utf-8?q?1598649619086579530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Implement a variant of of_platform_populate() which scans child nodes
of the root device node for the "earlydev" compatible fallback and
registers the corresponding platform devices as early platform devices.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/of/device.c         | 14 +++++-
 drivers/of/platform.c       | 89 +++++++++++++++++++++++++++++++------
 include/linux/of_device.h   |  5 +++
 include/linux/of_platform.h | 17 +++++++
 4 files changed, 110 insertions(+), 15 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 064c818105bd..cef13538d539 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -53,7 +53,7 @@ void of_dev_put(struct platform_device *dev)
 }
 EXPORT_SYMBOL(of_dev_put);
 
-int of_device_add(struct platform_device *ofdev)
+static void of_device_add_prepare(struct platform_device *ofdev)
 {
 	BUG_ON(ofdev->dev.of_node == NULL);
 
@@ -68,10 +68,22 @@ int of_device_add(struct platform_device *ofdev)
 	 * device is on the same node as the parent.
 	 */
 	set_dev_node(&ofdev->dev, of_node_to_nid(ofdev->dev.of_node));
+}
 
+int of_device_add(struct platform_device *ofdev)
+{
+	of_device_add_prepare(ofdev);
 	return device_add(&ofdev->dev);
 }
 
+#ifdef CONFIG_EARLY_PLATFORM_DEVICES
+void of_device_add_early(struct platform_device *ofdev)
+{
+	of_device_add_prepare(ofdev);
+	early_platform_add_device(ofdev);
+}
+#endif /* CONFIG_EARLY_PLATFORM_DEVICES */
+
 /**
  * of_dma_configure - Setup DMA configuration
  * @dev:	Device to apply DMA configuration
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 60342209fbd8..4b55e568fe77 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -160,6 +160,7 @@ EXPORT_SYMBOL(of_device_alloc);
  * @bus_id: name to assign device
  * @platform_data: pointer to populate platform_data pointer with
  * @parent: Linux device model parent device.
+ * @early: create as an early platform device
  *
  * Returns pointer to created platform device, or NULL if a device was not
  * registered.  Unavailable devices will not get registered.
@@ -168,9 +169,11 @@ static struct platform_device *of_platform_device_create_pdata(
 					struct device_node *np,
 					const char *bus_id,
 					void *platform_data,
-					struct device *parent)
+					struct device *parent,
+					bool early)
 {
 	struct platform_device *pdev;
+	int rc;
 
 	if (!of_device_is_available(np) ||
 	    of_node_test_and_set_flag(np, OF_POPULATED))
@@ -184,9 +187,14 @@ static struct platform_device *of_platform_device_create_pdata(
 	pdev->dev.platform_data = platform_data;
 	of_msi_configure(&pdev->dev, pdev->dev.of_node);
 
-	if (of_device_add(pdev) != 0) {
-		platform_device_put(pdev);
-		goto err_clear_flag;
+	if (unlikely(early)) {
+		of_device_add_early(pdev);
+	} else {
+		rc = of_device_add(pdev);
+		if (rc) {
+			platform_device_put(pdev);
+			goto err_clear_flag;
+		}
 	}
 
 	return pdev;
@@ -209,7 +217,7 @@ struct platform_device *of_platform_device_create(struct device_node *np,
 					    const char *bus_id,
 					    struct device *parent)
 {
-	return of_platform_device_create_pdata(np, bus_id, NULL, parent);
+	return of_platform_device_create_pdata(np, bus_id, NULL, parent, false);
 }
 EXPORT_SYMBOL(of_platform_device_create);
 
@@ -333,6 +341,7 @@ static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *l
  * @lookup: auxdata table for matching id and platform_data with device nodes
  * @parent: parent for new device, or NULL for top level.
  * @strict: require compatible property
+ * @early: register sub-devices as early platform devices
  *
  * Creates a platform_device for the provided device_node, and optionally
  * recursively create devices for all the child nodes.
@@ -340,7 +349,8 @@ static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *l
 static int of_platform_bus_create(struct device_node *bus,
 				  const struct of_device_id *matches,
 				  const struct of_dev_auxdata *lookup,
-				  struct device *parent, bool strict)
+				  struct device *parent,
+				  bool strict, bool early)
 {
 	const struct of_dev_auxdata *auxdata;
 	struct device_node *child;
@@ -377,13 +387,15 @@ static int of_platform_bus_create(struct device_node *bus,
 		return 0;
 	}
 
-	pdev = of_platform_device_create_pdata(bus, bus_id, platform_data, parent);
+	pdev = of_platform_device_create_pdata(bus, bus_id,
+					       platform_data, parent, early);
 	if (!pdev || !of_match_node(matches, bus))
 		return 0;
 
 	for_each_child_of_node(bus, child) {
 		pr_debug("   create child: %pOF\n", child);
-		rc = of_platform_bus_create(child, matches, lookup, &pdev->dev, strict);
+		rc = of_platform_bus_create(child, matches, lookup,
+					    &pdev->dev, strict, early);
 		if (rc) {
 			of_node_put(child);
 			break;
@@ -418,11 +430,13 @@ int of_platform_bus_probe(struct device_node *root,
 
 	/* Do a self check of bus type, if there's a match, create children */
 	if (of_match_node(matches, root)) {
-		rc = of_platform_bus_create(root, matches, NULL, parent, false);
+		rc = of_platform_bus_create(root, matches, NULL,
+					    parent, false, false);
 	} else for_each_child_of_node(root, child) {
 		if (!of_match_node(matches, child))
 			continue;
-		rc = of_platform_bus_create(child, matches, NULL, parent, false);
+		rc = of_platform_bus_create(child, matches, NULL,
+					    parent, false, false);
 		if (rc) {
 			of_node_put(child);
 			break;
@@ -454,9 +468,9 @@ EXPORT_SYMBOL(of_platform_bus_probe);
  * Returns 0 on success, < 0 on failure.
  */
 int of_platform_populate(struct device_node *root,
-			const struct of_device_id *matches,
-			const struct of_dev_auxdata *lookup,
-			struct device *parent)
+			 const struct of_device_id *matches,
+			 const struct of_dev_auxdata *lookup,
+			 struct device *parent)
 {
 	struct device_node *child;
 	int rc = 0;
@@ -469,7 +483,8 @@ int of_platform_populate(struct device_node *root,
 	pr_debug(" starting at: %pOF\n", root);
 
 	for_each_child_of_node(root, child) {
-		rc = of_platform_bus_create(child, matches, lookup, parent, true);
+		rc = of_platform_bus_create(child, matches, lookup,
+					    parent, false, false);
 		if (rc) {
 			of_node_put(child);
 			break;
@@ -482,6 +497,52 @@ int of_platform_populate(struct device_node *root,
 }
 EXPORT_SYMBOL_GPL(of_platform_populate);
 
+/**
+ * of_early_platform_populate() - Populate platform_devices from device tree
+ *                                data early in the boot process
+ * @root: parent of the first level to probe or NULL for the root of the tree
+ * @matches: match table, NULL to use the default
+ * @lookup: auxdata table for matching id and platform_data with device nodes
+ * @parent: parent to hook devices from, NULL for toplevel
+ *
+ * Virtually the same as of_platform_populate() except that it adds devices
+ * as early platform devices.
+ *
+ * Returns 0 on success, < 0 on failure.
+ */
+#ifdef CONFIG_EARLY_PLATFORM_DEVICES
+int of_early_platform_populate(struct device_node *root,
+			       const struct of_device_id *matches,
+			       const struct of_dev_auxdata *lookup,
+			       struct device *parent)
+{
+	struct device_node *child;
+	int rc = 0;
+
+	root = root ? of_node_get(root) : of_find_node_by_path("/");
+	if (!root)
+		return -EINVAL;
+
+	pr_debug("%s()\n", __func__);
+	pr_debug(" starting at: %pOF\n", root);
+
+	for_each_compatible_child_node(child, NULL,
+				       EARLY_PLATFORM_DEFAULT_CLASS, root) {
+		rc = of_platform_bus_create(child, matches, lookup,
+					    parent, false, true);
+		if (rc) {
+			of_node_put(child);
+			break;
+		}
+	}
+	of_node_set_flag(root, OF_POPULATED_BUS);
+
+	of_node_put(root);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(of_early_platform_populate);
+#endif /* CONFIG_EARLY_PLATFORM_DEVICES */
+
 int of_platform_default_populate(struct device_node *root,
 				 const struct of_dev_auxdata *lookup,
 				 struct device *parent)
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 8da5a1b31ece..8a59a054a434 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -30,6 +30,11 @@ extern struct platform_device *of_dev_get(struct platform_device *dev);
 extern void of_dev_put(struct platform_device *dev);
 
 extern int of_device_add(struct platform_device *pdev);
+#ifdef CONFIG_EARLY_PLATFORM_DEVICES
+extern void of_device_add_early(struct platform_device *pdev);
+#else /* CONFIG_EARLY_PLATFORM_DEVICES */
+static inline void of_device_add_early(struct platform_device *pdev) {}
+#endif /* CONFIG_EARLY_PLATFORM_DEVICES */
 extern int of_device_register(struct platform_device *ofdev);
 extern void of_device_unregister(struct platform_device *ofdev);
 
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 84a966623e78..2bf1013a3e89 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -75,6 +75,23 @@ extern int of_platform_populate(struct device_node *root,
 				const struct of_device_id *matches,
 				const struct of_dev_auxdata *lookup,
 				struct device *parent);
+
+#ifdef CONFIG_EARLY_PLATFORM_DEVICES
+extern int of_early_platform_populate(struct device_node *root,
+				      const struct of_device_id *matches,
+				      const struct of_dev_auxdata *lookup,
+				      struct device *parent);
+#else /* CONFIG_EARLY_PLATFORM_DEVICES */
+static inline int
+of_early_platform_populate(struct device_node *root,
+			   const struct of_device_id *matches,
+			   const struct of_dev_auxdata *lookup,
+			   struct device *parent)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_EARLY_PLATFORM_DEVICES */
+
 extern int of_platform_default_populate(struct device_node *root,
 					const struct of_dev_auxdata *lookup,
 					struct device *parent);
-- 
2.17.0
