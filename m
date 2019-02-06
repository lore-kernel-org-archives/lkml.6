Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BA6C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B4520818
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Eo6KG0ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbfBFQrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:47:13 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40125 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbfBFQrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:47:12 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so6453592edr.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 08:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PSAl5Vk5/4xvwry0x6LplDmDORdq7fnY5y2c51DrLvc=;
        b=Eo6KG0ja+E5vVRJhVwXCR0ILHPmmFmnvsJaNXiNSDTcwlVZWFKth8SFhvJpfw+gq58
         UGZ3jK+p2k8B5G350IVk7aiXTXCgW+W27WD77tA1nja/Vva60X2LVPaU5p2wjTlOWkaO
         WdF5G2JtQ5rYSaoE2vxRD8vbHlb2p37ZoiCZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PSAl5Vk5/4xvwry0x6LplDmDORdq7fnY5y2c51DrLvc=;
        b=S7hjUd9wid9/O09SmrvQbAqX65GW6nttSnjD6WwmpNfEJ1k/rMInlxLyjCvIw9DgXh
         iEpk4UMKV8882XNzfx9W5rHCG8T+ZK94jVkyYokDisthbJvAKtrLnSvpZCrEzE+xgbmw
         zwlvYxRG59jDSSS4ROLCdrNbGaQGbXlkyRNVUdsOSjtzMcOdMlN74vA6m2413p6vaPt1
         RpEve7xJgL1bLeJkceRbQzcJl6WitKgLzXhAL/3N+qbCpY3yfBhkzSP07CH7jcDkArN7
         vSJkhzwZuy/jTbh4bYCHxMFybUJiy9qGDlnzj891e1/9I/luNWlD5DpEGVsEyd1UZRGO
         3J+w==
X-Gm-Message-State: AHQUAuatfBs0wZXPriC4l5JUZEh2s5UYOIL6VTWHrlbfalYrfdHWdWmb
        6cAvrd0bERSMJqk3U0gkPc6EbA==
X-Google-Smtp-Source: AHgI3IZGrLuglDXWkIYWZ16tRYG0ijmHjLvEEsKzEVyeIbSovGaKgIBwcXWYy5YNbYFPGA1hOhPCZQ==
X-Received: by 2002:a50:9dc1:: with SMTP id l1mr8956055edk.272.1549471629308;
        Wed, 06 Feb 2019 08:47:09 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a38sm6089154edd.44.2019.02.06.08.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 08:47:07 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "C, Ramalingam" <ramalingam.c@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] component: Add documentation
Date:   Wed,  6 Feb 2019 17:47:02 +0100
Message-Id: <20190206164702.29753-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206164551.29400-1-daniel.vetter@ffwll.ch>
References: <20190206164551.29400-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While typing these I think doing an s/component_master/aggregate/
would be useful:
- it's shorter :-)
- I think component/aggregate is much more meaningful naming than
  component/puppetmaster or something like that. At least to my
  English ear "aggregate" emphasizes much more the "assemble a pile of
  things into something bigger" aspect, and there's not really much
  of a control hierarchy between aggregate and constituing components.

But that's way more than a quick doc typing exercise ...

Thanks to Ram for commenting on an initial draft of these docs.

v2: Review from Rafael:
- git add Documenation/driver-api/component.rst
- lots of polish to the wording + spelling fixes.

v3: Review from Russell:
- s/framework/helper
- clarify the documentation for component_match_add functions.

Cc: "C, Ramalingam" <ramalingam.c@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 Documentation/driver-api/component.rst   |  17 ++++
 Documentation/driver-api/device_link.rst |   3 +
 Documentation/driver-api/index.rst       |   1 +
 drivers/base/component.c                 | 107 ++++++++++++++++++++++-
 include/linux/component.h                |  71 +++++++++++++++
 5 files changed, 196 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/driver-api/component.rst

diff --git a/Documentation/driver-api/component.rst b/Documentation/driver-api/component.rst
new file mode 100644
index 000000000000..2da4a8f20607
--- /dev/null
+++ b/Documentation/driver-api/component.rst
@@ -0,0 +1,17 @@
+======================================
+Component Helper for Aggregate Drivers
+======================================
+
+.. kernel-doc:: drivers/base/component.c
+   :doc: overview
+
+
+API
+===
+
+.. kernel-doc:: include/linux/component.h
+   :internal:
+
+.. kernel-doc:: drivers/base/component.c
+   :export:
+
diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
index d6763272e747..2d5919b2b337 100644
--- a/Documentation/driver-api/device_link.rst
+++ b/Documentation/driver-api/device_link.rst
@@ -1,6 +1,9 @@
 .. |struct dev_pm_domain| replace:: :c:type:`struct dev_pm_domain <dev_pm_domain>`
 .. |struct generic_pm_domain| replace:: :c:type:`struct generic_pm_domain <generic_pm_domain>`
 
+
+.. _device_link:
+
 ============
 Device links
 ============
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index ab38ced66a44..c0b600ed9961 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -22,6 +22,7 @@ available subsections can be seen below.
    device_connection
    dma-buf
    device_link
+   component
    message-based
    sound
    frame-buffer
diff --git a/drivers/base/component.c b/drivers/base/component.c
index ddcea8739c12..f34d4b784709 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -16,6 +16,32 @@
 #include <linux/slab.h>
 #include <linux/debugfs.h>
 
+/**
+ * DOC: overview
+ *
+ * The component helper allows drivers to collect a pile of sub-devices,
+ * including their bound drivers, into an aggregate driver. Various subsystems
+ * already provide functions to get hold of such components, e.g.
+ * of_clk_get_by_name(). The component helper can be used when such a
+ * subsystem-specific way to find a device is not available: The component
+ * helper fills the niche of aggregate drivers for specific hardware, where
+ * further standardization into a subsystem would not be practical. The common
+ * example is when a logical device (e.g. a DRM display driver) is spread around
+ * the SoC on various component (scanout engines, blending blocks, transcoders
+ * for various outputs and so on).
+ *
+ * The component helper also doesn't solve runtime dependencies, e.g. for system
+ * suspend and resume operations. See also :ref:`device links<device_link>`.
+ *
+ * Components are registered using component_add() and unregistered with
+ * component_del(), usually from the driver's probe and disconnect functions.
+ *
+ * Aggregate drivers first assemble a component match list of what they need
+ * using component_match_add(). This is then registered as an aggregate driver
+ * using component_master_add_with_match(), and unregistered using
+ * component_master_del().
+ */
+
 struct component;
 
 struct component_match_array {
@@ -301,10 +327,25 @@ static int component_match_realloc(struct device *dev,
 	return 0;
 }
 
-/*
- * Add a component to be matched, with a release function.
+/**
+ * component_match_add_release - add a component match with release callback
+ * @master: device with the aggregate driver
+ * @matchptr: pointer to the list of component matches
+ * @release: release function for @compare_data
+ * @compare: compare function to match against all components
+ * @compare_data: opaque pointer passed to the @compare function
+ *
+ * This adds a new component match to the list stored in @matchptr, which the
+ * @master aggregate driver needs to function. The list of component matches
+ * pointed to by @matchptr must be initialized to NULL before adding the first
+ * match.
+ *
+ * The allocated match list in @matchptr is automatically released using devm
+ * actions, where upon @release will be called to free any references held by
+ * @compare_data, e.g. when @compare_data is a &device_node that must be
+ * released with of_node_put().
  *
- * The match array is first created or extended if necessary.
+ * See also component_match_add().
  */
 void component_match_add_release(struct device *master,
 	struct component_match **matchptr,
@@ -367,6 +408,18 @@ static void free_master(struct master *master)
 	kfree(master);
 }
 
+/**
+ * component_master_add_with_match - register an aggregate driver
+ * @dev: device with the aggregate driver
+ * @ops: callbacks for the aggregate driver
+ * @match: component match list for the aggregate driver
+ *
+ * Registers a new aggregate driver consisting of the components added to @match
+ * by calling one of the component_match_add() functions. Once all components in
+ * @match are available, it will be assembled by calling
+ * &component_master_ops.bind from @ops. Must be unregistered by calling
+ * component_master_del().
+ */
 int component_master_add_with_match(struct device *dev,
 	const struct component_master_ops *ops,
 	struct component_match *match)
@@ -403,6 +456,15 @@ int component_master_add_with_match(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(component_master_add_with_match);
 
+/**
+ * component_master_del - unregister an aggregate driver
+ * @dev: device with the aggregate driver
+ * @ops: callbacks for the aggregate driver
+ *
+ * Unregisters an aggregate driver registered with
+ * component_master_add_with_match(). If necessary the aggregate driver is first
+ * disassembled by calling &component_master_ops.unbind from @ops.
+ */
 void component_master_del(struct device *dev,
 	const struct component_master_ops *ops)
 {
@@ -430,6 +492,15 @@ static void component_unbind(struct component *component,
 	devres_release_group(component->dev, component);
 }
 
+/**
+ * component_unbind_all - unbind all component to an aggregate driver
+ * @master_dev: device with the aggregate driver
+ * @data: opaque pointer, passed to all components
+ *
+ * Unbinds all components to the aggregate @dev by passing @data to their
+ * &component_ops.unbind functions. Should be called from
+ * &component_master_ops.unbind.
+ */
 void component_unbind_all(struct device *master_dev, void *data)
 {
 	struct master *master;
@@ -503,6 +574,15 @@ static int component_bind(struct component *component, struct master *master,
 	return ret;
 }
 
+/**
+ * component_bind_all - bind all component to an aggregate driver
+ * @master_dev: device with the aggregate driver
+ * @data: opaque pointer, passed to all components
+ *
+ * Binds all components to the aggregate @dev by passing @data to their
+ * &component_ops.bind functions. Should be called from
+ * &component_master_ops.bind.
+ */
 int component_bind_all(struct device *master_dev, void *data)
 {
 	struct master *master;
@@ -537,6 +617,18 @@ int component_bind_all(struct device *master_dev, void *data)
 }
 EXPORT_SYMBOL_GPL(component_bind_all);
 
+/**
+ * component_add - register a component
+ * @dev: component device
+ * @ops: component callbacks
+ *
+ * Register a new component for @dev. Functions in @ops will be called when the
+ * aggregate driver is ready to bind the overall driver by calling
+ * component_bind_all(). See also &struct component_ops.
+ *
+ * The component needs to be unregistered at driver unload/disconnect by calling
+ * component_del().
+ */
 int component_add(struct device *dev, const struct component_ops *ops)
 {
 	struct component *component;
@@ -568,6 +660,15 @@ int component_add(struct device *dev, const struct component_ops *ops)
 }
 EXPORT_SYMBOL_GPL(component_add);
 
+/**
+ * component_del - unregister a component
+ * @dev: component device
+ * @ops: component callbacks
+ *
+ * Unregister a component added with component_add(). If the component is bound
+ * into an aggregate driver, this will force the entire aggregate driver, including
+ * all its components, to be unbound.
+ */
 void component_del(struct device *dev, const struct component_ops *ops)
 {
 	struct component *c, *component = NULL;
diff --git a/include/linux/component.h b/include/linux/component.h
index e71fbbbc74e2..4911598b4c42 100644
--- a/include/linux/component.h
+++ b/include/linux/component.h
@@ -4,11 +4,31 @@
 
 #include <linux/stddef.h>
 
+
 struct device;
 
+/**
+ * struct component_ops - callbacks for component drivers
+ *
+ * Components are registered with component_add() and unregistered with
+ * component_del().
+ */
 struct component_ops {
+	/**
+	 * @bind:
+	 *
+	 * Called through component_bind_all() when the aggregate driver is
+	 * ready to bind the overall driver.
+	 */
 	int (*bind)(struct device *comp, struct device *master,
 		    void *master_data);
+	/**
+	 * @unbind:
+	 *
+	 * Called through component_unbind_all() when the aggregate driver is
+	 * ready to bind the overall driver, or when component_bind_all() fails
+	 * part-ways through and needs to unbind some already bound components.
+	 */
 	void (*unbind)(struct device *comp, struct device *master,
 		       void *master_data);
 };
@@ -21,8 +41,42 @@ void component_unbind_all(struct device *master, void *master_data);
 
 struct master;
 
+/**
+ * struct component_master_ops - callback for the aggregate driver
+ *
+ * Aggregate drivers are registered with component_master_add_with_match() and
+ * unregistered with component_master_del().
+ */
 struct component_master_ops {
+	/**
+	 * @bind:
+	 *
+	 * Called when all components or the aggregate driver, as specified in
+	 * the match list passed to component_master_add_with_match(), are
+	 * ready. Usually there are 3 steps to bind an aggregate driver:
+	 *
+	 * 1. Allocate a structure for the aggregate driver.
+	 *
+	 * 2. Bind all components to the aggregate driver by calling
+	 *    component_bind_all() with the aggregate driver structure as opaque
+	 *    pointer data.
+	 *
+	 * 3. Register the aggregate driver with the subsystem to publish its
+	 *    interfaces.
+	 *
+	 * Note that the lifetime of the aggregate driver does not align with
+	 * any of the underlying &struct device instances. Therefore devm cannot
+	 * be used and all resources acquired or allocated in this callback must
+	 * be explicitly released in the @unbind callback.
+	 */
 	int (*bind)(struct device *master);
+	/**
+	 * @unbind:
+	 *
+	 * Called when either the aggregate driver, using
+	 * component_master_del(), or one of its components, using
+	 * component_del(), is unregistered.
+	 */
 	void (*unbind)(struct device *master);
 };
 
@@ -38,6 +92,23 @@ void component_match_add_release(struct device *master,
 	void (*release)(struct device *, void *),
 	int (*compare)(struct device *, void *), void *compare_data);
 
+/**
+ * component_match_add - add a compent match
+ * @master: device with the aggregate driver
+ * @matchptr: pointer to the list of component matches
+ * @compare: compare function to match against all components
+ * @compare_data: opaque pointer passed to the @compare function
+ *
+ * This adds a new component match to the list stored in @matchptr, which the
+ * @master aggregate driver needs to function. The list of component matches
+ * pointed to by @matchptr must be initialized to NULL before adding the first
+ * match.
+ *
+ * The allocated match list in @matchptr is automatically released using devm
+ * actions.
+ *
+ * See also component_match_add_release().
+ */
 static inline void component_match_add(struct device *master,
 	struct component_match **matchptr,
 	int (*compare)(struct device *, void *), void *compare_data)
-- 
2.20.1

