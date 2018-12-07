Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD28C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FBF20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FBF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLGIvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:51:04 -0500
Received: from mga18.intel.com ([134.134.136.126]:1705 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbeLGIvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:51:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 00:51:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="96888331"
Received: from btwcube1.sh.intel.com ([10.67.104.173])
  by orsmga007.jf.intel.com with ESMTP; 07 Dec 2018 00:50:59 -0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Cc:     wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com,
        tiwei.bie@intel.com
Subject: [RFC 1/3] virtio_ring: define flags as shifts consistently
Date:   Fri,  7 Dec 2018 16:48:40 +0800
Message-Id: <20181207084842.13133-2-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207084842.13133-1-tiwei.bie@intel.com>
References: <20181207084842.13133-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce _SPLIT_ and/or _PACKED_ variants for VRING_DESC_F_*,
VRING_AVAIL_F_NO_INTERRUPT and VRING_USED_F_NO_NOTIFY. These
variants are defined as shifts instead of shifted values for
consistency with other _F_ flags.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 include/uapi/linux/virtio_ring.h | 57 ++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 2414f8af26b3..9b0c0d92ab62 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -37,29 +37,52 @@
 #include <linux/types.h>
 #include <linux/virtio_types.h>
 
-/* This marks a buffer as continuing via the next field. */
+/*
+ * Notice: unlike other _F_ flags, below flags are defined as shifted
+ * values instead of shifts for compatibility.
+ */
+/* Same as VRING_SPLIT_DESC_F_NEXT. */
 #define VRING_DESC_F_NEXT	1
-/* This marks a buffer as write-only (otherwise read-only). */
+/* Same as VRING_SPLIT_DESC_F_WRITE. */
 #define VRING_DESC_F_WRITE	2
-/* This means the buffer contains a list of buffer descriptors. */
+/* Same as VRING_SPLIT_DESC_F_INDIRECT. */
 #define VRING_DESC_F_INDIRECT	4
-
-/*
- * Mark a descriptor as available or used in packed ring.
- * Notice: they are defined as shifts instead of shifted values.
- */
-#define VRING_PACKED_DESC_F_AVAIL	7
-#define VRING_PACKED_DESC_F_USED	15
-
-/* The Host uses this in used->flags to advise the Guest: don't kick me when
- * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
- * will still kick if it's out of buffers. */
+/* Same as VRING_SPLIT_USED_F_NO_NOTIFY. */
 #define VRING_USED_F_NO_NOTIFY	1
-/* The Guest uses this in avail->flags to advise the Host: don't interrupt me
- * when you consume a buffer.  It's unreliable, so it's simply an
- * optimization.  */
+/* Same as VRING_SPLIT_AVAIL_F_NO_INTERRUPT. */
 #define VRING_AVAIL_F_NO_INTERRUPT	1
 
+/* Mark a buffer as continuing via the next field in split ring. */
+#define VRING_SPLIT_DESC_F_NEXT		0
+/* Mark a buffer as write-only (otherwise read-only) in split ring. */
+#define VRING_SPLIT_DESC_F_WRITE	1
+/* Mean the buffer contains a list of buffer descriptors in split ring. */
+#define VRING_SPLIT_DESC_F_INDIRECT	2
+
+/*
+ * The Host uses this in used->flags in split ring to advise the Guest:
+ * don't kick me when you add a buffer.  It's unreliable, so it's simply
+ * an optimization.  Guest will still kick if it's out of buffers.
+ */
+#define VRING_SPLIT_USED_F_NO_NOTIFY		0
+/*
+ * The Guest uses this in avail->flags in split ring to advise the Host:
+ * don't interrupt me when you consume a buffer.  It's unreliable, so it's
+ * simply an optimization.
+ */
+#define VRING_SPLIT_AVAIL_F_NO_INTERRUPT	0
+
+/* Mark a buffer as continuing via the next field in packed ring. */
+#define VRING_PACKED_DESC_F_NEXT	0
+/* Mark a buffer as write-only (otherwise read-only) in packed ring. */
+#define VRING_PACKED_DESC_F_WRITE	1
+/* Mean the buffer contains a list of buffer descriptors in packed ring. */
+#define VRING_PACKED_DESC_F_INDIRECT	2
+
+/* Mark a descriptor as available or used in packed ring. */
+#define VRING_PACKED_DESC_F_AVAIL	7
+#define VRING_PACKED_DESC_F_USED	15
+
 /* Enable events in packed ring. */
 #define VRING_PACKED_EVENT_FLAG_ENABLE	0x0
 /* Disable events in packed ring. */
-- 
2.17.1

