Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FDFECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A4C2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A4C2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389444AbeIUOSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:18:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeIUOSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:18:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A85830820D9;
        Fri, 21 Sep 2018 08:30:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C289618007;
        Fri, 21 Sep 2018 08:30:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9D3C741A71; Fri, 21 Sep 2018 10:30:13 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] vfio: add edid api for display (vgpu) devices.
Date:   Fri, 21 Sep 2018 10:30:12 +0200
Message-Id: <20180921083013.15028-2-kraxel@redhat.com>
In-Reply-To: <20180921083013.15028-1-kraxel@redhat.com>
References: <20180921083013.15028-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 21 Sep 2018 08:30:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to set EDID monitor information for the vgpu display, for a
more flexible display configuration, using a special vfio region.  Check
the comment describing struct vfio_region_gfx_edid for more details.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/uapi/linux/vfio.h | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 1aa7b82e81..44b66b09c5 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -301,6 +301,56 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
 
+#define VFIO_REGION_TYPE_GFX                    (1)
+#define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
+
+/**
+ * struct vfio_region_gfx_edid - EDID region layout.
+ *
+ * Set display link state and EDID blob.
+ *
+ * The EDID blob has monitor information such as brand, name, serial
+ * number, physical size, supported video modes and more.
+ *
+ * This special region allows userspace (typically qemu) set a virtual
+ * EDID for the virtual monitor, which allows a flexible display
+ * configuration.
+ *
+ * For the edid blob spec look here:
+ *    https://en.wikipedia.org/wiki/Extended_Display_Identification_Data
+ *
+ * On linux systems you can find the EDID blob in sysfs:
+ *    /sys/class/drm/${card}/${connector}/edid
+ *
+ * You can use the edid-decode ulility (comes with xorg-x11-utils) to
+ * decode the EDID blob.
+ *
+ * @edid_offset: location of the edid blob, relative to the
+ *               start of the region (readonly).
+ * @edid_max_size: max size of the edid blob (readonly).
+ * @edid_size: actual edid size (read/write).
+ * @link_state: display link state (read/write).
+ * VFIO_DEVICE_GFX_LINK_STATE_UP: Monitor is turned on.
+ * VFIO_DEVICE_GFX_LINK_STATE_DOWN: Monitor is turned off.
+ * @max_xres: max display width (0 == no limitation, readonly).
+ * @max_yres: max display height (0 == no limitation, readonly).
+ *
+ * EDID update protocol:
+ *   (1) set link-state to down.
+ *   (2) update edid blob and size.
+ *   (3) set link-state to up.
+ */
+struct vfio_region_gfx_edid {
+	__u32 edid_offset;
+	__u32 edid_max_size;
+	__u32 edid_size;
+	__u32 max_xres;
+	__u32 max_yres;
+	__u32 link_state;
+#define VFIO_DEVICE_GFX_LINK_STATE_UP    1
+#define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
+};
+
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
  * which allows direct access to non-MSIX registers which happened to be within
-- 
2.9.3

