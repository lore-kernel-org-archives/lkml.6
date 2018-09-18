Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E12C04AB8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96FD2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96FD2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbeIRTK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:10:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729867AbeIRTK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:10:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0408E30832E2;
        Tue, 18 Sep 2018 13:38:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D4F81001938;
        Tue, 18 Sep 2018 13:38:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BEF769B312; Tue, 18 Sep 2018 15:38:13 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] vfio: add edid api for display (vgpu) devices.
Date:   Tue, 18 Sep 2018 15:38:12 +0200
Message-Id: <20180918133813.1845-2-kraxel@redhat.com>
In-Reply-To: <20180918133813.1845-1-kraxel@redhat.com>
References: <20180918133813.1845-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 18 Sep 2018 13:38:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/uapi/linux/vfio.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 1aa7b82e81..78e5a37d83 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -301,6 +301,45 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
 
+#define VFIO_REGION_TYPE_PCI_GFX                (1)
+#define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
+
+/**
+ * Set display link state and edid blob.
+ *
+ * For the edid blob spec look here:
+ * https://en.wikipedia.org/wiki/Extended_Display_Identification_Data
+ *
+ * The guest should be notified about edid changes, for example by
+ * setting the link status to down temporarely (emulate monitor
+ * hotplug).
+ *
+ * @link_state:
+ * VFIO_DEVICE_GFX_LINK_STATE_UP: Monitor is turned on.
+ * VFIO_DEVICE_GFX_LINK_STATE_DOWN: Monitor is turned off.
+ *
+ * @edid_size: Size of the edid data blob.
+ * @edid_blob: The actual edid data.
+ *
+ * Returns 0 on success, error code (such as -EINVAL) on failure.
+ */
+struct vfio_region_gfx_edid {
+	/* device capability hints (read only) */
+	__u32 max_xres;
+	__u32 max_yres;
+	__u32 __reserved1[6];
+
+	/* device state (read/write) */
+	__u32 link_state;
+#define VFIO_DEVICE_GFX_LINK_STATE_UP    1
+#define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
+	__u32 edid_size;
+	__u32 __reserved2[6];
+
+	/* edid blob (read/write) */
+	__u8 edid_blob[512];
+};
+
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
  * which allows direct access to non-MSIX registers which happened to be within
-- 
2.9.3

