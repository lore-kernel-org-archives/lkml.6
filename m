Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7198EC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D49B2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfAHRUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:20:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:1194 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728398AbfAHRUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:20:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2019 09:20:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,455,1539673200"; 
   d="scan'208";a="132736565"
Received: from mint-dev.iind.intel.com ([10.223.25.164])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jan 2019 09:20:00 -0800
From:   Ramalingam C <ramalingam.c@intel.com>
To:     intel-gfx-trybot@lists.freedesktop.org
Cc:     Ramalingam C <ramalingam.c@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 03/40] component: alloc component_match without any comp to match
Date:   Tue,  8 Jan 2019 22:44:29 +0530
Message-Id: <1546967706-15195-3-git-send-email-ramalingam.c@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546967706-15195-1-git-send-email-ramalingam.c@intel.com>
References: <1546967706-15195-1-git-send-email-ramalingam.c@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If all the components associated to a component master is not added
to the component framework due to the HW capability or Kconfig
selection, component_match will be NULL at
component_master_add_with_match().

To avoid this, component_match_alloc() is added to the framework,
to allcoate the struct component_match with zero associated components.
Hence component master can be added with a component_match with zero
associated components.

This helps the component master bind call to get triggered,
even if no component is registered for that particular master.

This is meant for big PCI device drivers where small/optional
features are external components, and based on usecases different
combination of components are build as entire driver.

In such PCI device driver Load, if we use the component master for
waiting for few  components(features) availability, only if they are
supported by the underlying HW, then we need to allocate memory for
component_match using the API introduced in this change before
the call to component_master_add_with_match.

Signed-off-by: Ramalingam C <ramalingam.c@intel.com>
Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/component.c  | 30 ++++++++++++++++++++++++++++++
 include/linux/component.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index e8d676fad0c9..0ab36b2255ea 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -312,6 +312,36 @@ static int component_match_realloc(struct device *dev,
 }
 
 /*
+ * Allocate the match without any component_match_array elements.
+ *
+ * This function is useful when the component master might end up
+ * registering itself without any matching components.
+ */
+void component_match_alloc(struct device *master,
+	struct component_match **matchptr)
+{
+	struct component_match *match = *matchptr;
+
+	if (IS_ERR(match))
+		return;
+
+	if (match)
+		return;
+
+	match = devres_alloc(devm_component_match_release,
+			     sizeof(*match), GFP_KERNEL);
+	if (!match) {
+		*matchptr = ERR_PTR(-ENOMEM);
+		return;
+	}
+
+	devres_add(master, match);
+
+	*matchptr = match;
+}
+EXPORT_SYMBOL(component_match_alloc);
+
+/*
  * Add a component to be matched, with a release function.
  *
  * The match array is first created or extended if necessary.
diff --git a/include/linux/component.h b/include/linux/component.h
index e71fbbbc74e2..3f6b420a58f8 100644
--- a/include/linux/component.h
+++ b/include/linux/component.h
@@ -37,6 +37,8 @@ void component_match_add_release(struct device *master,
 	struct component_match **matchptr,
 	void (*release)(struct device *, void *),
 	int (*compare)(struct device *, void *), void *compare_data);
+void component_match_alloc(struct device *master,
+	struct component_match **matchptr);
 
 static inline void component_match_add(struct device *master,
 	struct component_match **matchptr,
-- 
2.7.4

