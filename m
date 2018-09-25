Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43B3C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3DD214FE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3DD214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbeIYVb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:31:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:46410 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729465AbeIYVb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:31:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 08:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="260120271"
Received: from mint-dev.iind.intel.com ([10.223.25.164])
  by orsmga005.jf.intel.com with ESMTP; 25 Sep 2018 08:23:21 -0700
From:   Ramalingam C <ramalingam.c@intel.com>
To:     intel-gfx-trybot@lists.freedesktop.org
Cc:     Ramalingam C <ramalingam.c@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 06/39] component: alloc component_match without any comp to match
Date:   Tue, 25 Sep 2018 20:50:29 +0530
Message-Id: <1537888862-31081-7-git-send-email-ramalingam.c@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537888862-31081-1-git-send-email-ramalingam.c@intel.com>
References: <1537888862-31081-1-git-send-email-ramalingam.c@intel.com>
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

v2:
  No Change.

Signed-off-by: Ramalingam C <ramalingam.c@intel.com>
Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: linux-kernel@vger.kernel.org
---
 drivers/base/component.c  | 30 ++++++++++++++++++++++++++++++
 include/linux/component.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 8946dfee4768..007fb738263a 100644
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

