Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF54FECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889DC21476
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889DC21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeINRkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:40:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbeINRkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:40:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33C5A310E98C;
        Fri, 14 Sep 2018 12:25:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A5C6101E5A5;
        Fri, 14 Sep 2018 12:25:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 74CBA41A63; Fri, 14 Sep 2018 14:25:52 +0200 (CEST)
Date:   Fri, 14 Sep 2018 14:25:52 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org, kvm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] vfio: add edid api for display (vgpu) devices.
Message-ID: <20180914122552.3xmepqo7azzmx7ky@sirius.home.kraxel.org>
References: <20180913054745.6353-1-kraxel@redhat.com>
 <20180913054745.6353-2-kraxel@redhat.com>
 <20180913115139.02775316@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913115139.02775316@t450s.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 14 Sep 2018 12:25:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> Another possible implementation would be via a vfio region, we already
> support device specific regions via capabilities with vfio_region_info,
> so we could have an edid region which could handle both input and
> output using a defined structure and protocol within the region.  With
> an edid blob of up to 512 bytes now, that means the vendor driver would
> need to buffer writes to that section of the region until some sort of
> activation, possibly using another "register" within the field to
> trigger the link state and only processing the edid blob on link down
> to link up transition.

Hmm, using a virtual register space makes things more complicated for no
good reason.  This is a configuration interface for qemu, not something
we expose to the guest.  So, I'm not a fan ...

New revision of the vfio.h patch attached below, how does that look
like?  If it is ok I'll go continue with that next week (more verbose
docs, update qemu code and test, ...)

cheers,
  Gerd

From 818f2ea4dd756d28908e58a32a2fdd0d197a28da Mon Sep 17 00:00:00 2001
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 6 Sep 2018 16:17:17 +0200
Subject: [PATCH] vfio: add edid api for display (vgpu) devices.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/uapi/linux/vfio.h | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 1aa7b82e81..901f279033 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -200,12 +200,25 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
 #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
 #define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
+#define VFIO_DEVICE_FLAGS_CAPS	(1 << 5)	/* cap_offset present */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
+	__u32   cap_offset;	/* Offset within info struct of first cap */
 };
 #define VFIO_DEVICE_GET_INFO		_IO(VFIO_TYPE, VFIO_BASE + 7)
 
 /*
+ * FIXME: docs ...
+ */
+#define VFIO_DEVICE_INFO_CAP_EDID	1
+
+struct vfio_device_info_edid_cap {
+	struct vfio_info_cap_header header;
+	__u32   max_x;     /* Max display height (zero == no limit) */
+	__u32   max_y;     /* Max display height (zero == no limit) */
+};
+
+/*
  * Vendor driver using Mediated device framework should provide device_api
  * attribute in supported type attribute groups. Device API string should be one
  * of the following corresponding to device flags in vfio_device_info structure.
@@ -602,6 +615,41 @@ struct vfio_device_ioeventfd {
 
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

