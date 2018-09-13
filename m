Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48195C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C2620861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C2620861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeIMKzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:55:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeIMKzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:55:47 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75C34811B7;
        Thu, 13 Sep 2018 05:47:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2801F2010CAA;
        Thu, 13 Sep 2018 05:47:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B388620491; Thu, 13 Sep 2018 07:47:45 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] vfio: add edid api for display (vgpu) devices.
Date:   Thu, 13 Sep 2018 07:47:44 +0200
Message-Id: <20180913054745.6353-2-kraxel@redhat.com>
In-Reply-To: <20180913054745.6353-1-kraxel@redhat.com>
References: <20180913054745.6353-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 13 Sep 2018 05:47:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/uapi/linux/vfio.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 1aa7b82e81..38b591e909 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -200,8 +200,11 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
 #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
 #define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
+#define VFIO_DEVICE_FLAGS_EDID	(1 << 5)	/* Device supports edid */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
+	__u32   edid_max_x;     /* Max display width (zero == no limit) */
+	__u32   edid_max_y;     /* Max display height (zero == no limit) */
 };
 #define VFIO_DEVICE_GET_INFO		_IO(VFIO_TYPE, VFIO_BASE + 7)
 
@@ -602,6 +605,41 @@ struct vfio_device_ioeventfd {
 
 #define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
 
+/**
+ * VFIO_DEVICE_SET_GFX_EDID - _IOW(VFIO_TYPE, VFIO_BASE + 17,
+ *                                 struct vfio_device_set_gfx_edid)
+ *
+ * Set display link state and edid blob (for UP state).
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
+struct vfio_device_set_gfx_edid {
+	__u32 argsz;
+	__u32 flags;
+	/* in */
+	__u32 link_state;
+#define VFIO_DEVICE_GFX_LINK_STATE_UP    1
+#define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
+	__u32 edid_size;
+	__u8  edid_blob[512];
+};
+
+#define VFIO_DEVICE_SET_GFX_EDID _IO(VFIO_TYPE, VFIO_BASE + 17)
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.9.3

