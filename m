Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA19DC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64636214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64636214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbeHUThG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:37:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51754 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbeHUThG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:37:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 338E87A9;
        Tue, 21 Aug 2018 09:16:20 -0700 (PDT)
Received: from e107564-lin.cambridge.arm.com (e107564-lin.cambridge.arm.com [10.2.131.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF6673F5BC;
        Tue, 21 Aug 2018 09:16:17 -0700 (PDT)
From:   Brian Starkey <brian.starkey@arm.com>
To:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexandru-cosmin.gheorghe@arm.com,
        liviu.dudau@arm.com, ayan.halder@arm.com
Subject: [PATCH] drm/fourcc: Add DOC: overview comment
Date:   Tue, 21 Aug 2018 17:16:11 +0100
Message-Id: <20180821161611.10424-1-brian.starkey@arm.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a number of things which haven't previously been documented
around the usage of format modifiers. Capture the current
understanding in an overview comment and add it to the rst
documentation.

Ideally, the generated documentation would also include documentation
of all of the #defines, but the kernel-doc system doesn't currently
support kernel-doc comments on #define constants.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Brian Starkey <brian.starkey@arm.com>
---
 Documentation/gpu/drm-kms.rst |  6 ++++++
 include/uapi/drm/drm_fourcc.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
index 1dffd1ac4cd4..1dd9f4824d3b 100644
--- a/Documentation/gpu/drm-kms.rst
+++ b/Documentation/gpu/drm-kms.rst
@@ -322,6 +322,12 @@ Frame Buffer Functions Reference
 DRM Format Handling
 ===================
 
+.. kernel-doc:: include/uapi/drm/drm_fourcc.h
+   :doc: overview
+
+Format Functions Reference
+--------------------------
+
 .. kernel-doc:: include/drm/drm_fourcc.h
    :internal:
 
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 894fa2da32fd..3f6c0b499323 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -30,6 +30,42 @@
 extern "C" {
 #endif
 
+/**
+ * DOC: overview
+ *
+ * In the DRM subsystem, framebuffer pixel formats are described using the
+ * fourcc codes defined in `include/uapi/drm/drm_fourcc.h`. In addition to the
+ * fourcc code, a Format Modifier may optionally be provided, in order to
+ * further describe the buffer's format - for example tiling or compression.
+ *
+ * Format Modifiers
+ * ----------------
+ *
+ * Format modifiers are used in conjunction with a fourcc code, forming a
+ * unique fourcc:modifier pair. This format:modifier pair must fully define the
+ * format and data layout of the buffer, and should be the only way to describe
+ * that particular buffer.
+ *
+ * Having multiple fourcc:modifier pairs which describe the same layout should
+ * be avoided, as such aliases run the risk of different drivers exposing
+ * different names for the same data format, forcing userspace to understand
+ * that they are aliases.
+ *
+ * Format modifiers may change any property of the buffer, including the number
+ * of planes and/or the required allocation size. Format modifiers are
+ * vendor-namespaced, and as such the relationship between a fourcc code and a
+ * modifier is specific to the modifer being used. For example, some modifiers
+ * may preserve meaning - such as number of planes - from the fourcc code,
+ * whereas others may not.
+ *
+ * Vendors are encouraged to document their modifier usage in as much detail as
+ * possible, to ensure maximum compatibility across devices, drivers and
+ * applications.
+ *
+ * The authoritative list of format modifier codes is found in
+ * `include/uapi/drm/drm_fourcc.h`
+ */
+
 #define fourcc_code(a, b, c, d) ((__u32)(a) | ((__u32)(b) << 8) | \
 				 ((__u32)(c) << 16) | ((__u32)(d) << 24))
 
-- 
2.16.1

