Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D5AC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271F120861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271F120861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeIMKzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:55:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbeIMKzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:55:50 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5119E3086266;
        Thu, 13 Sep 2018 05:47:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C84130912F4;
        Thu, 13 Sep 2018 05:47:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CBD8B2049F; Thu, 13 Sep 2018 07:47:45 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] vfio: add edid support to mbochs sample driver
Date:   Thu, 13 Sep 2018 07:47:45 +0200
Message-Id: <20180913054745.6353-3-kraxel@redhat.com>
In-Reply-To: <20180913054745.6353-1-kraxel@redhat.com>
References: <20180913054745.6353-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 13 Sep 2018 05:47:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 samples/vfio-mdev/mbochs.c | 54 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index 2535c3677c..6331871ff5 100644
--- a/samples/vfio-mdev/mbochs.c
+++ b/samples/vfio-mdev/mbochs.c
@@ -95,16 +95,24 @@ MODULE_PARM_DESC(mem, "megabytes available to " MBOCHS_NAME " devices");
 static const struct mbochs_type {
 	const char *name;
 	u32 mbytes;
+	u32 max_x;
+	u32 max_y;
 } mbochs_types[] = {
 	{
 		.name	= MBOCHS_CLASS_NAME "-" MBOCHS_TYPE_1,
 		.mbytes = 4,
+		.max_x  = 800,
+		.max_y  = 600,
 	}, {
 		.name	= MBOCHS_CLASS_NAME "-" MBOCHS_TYPE_2,
 		.mbytes = 16,
+		.max_x  = 1920,
+		.max_y  = 1440,
 	}, {
 		.name	= MBOCHS_CLASS_NAME "-" MBOCHS_TYPE_3,
 		.mbytes = 64,
+		.max_x  = 0,
+		.max_y  = 0,
 	},
 };
 
@@ -151,6 +159,7 @@ struct mdev_state {
 	u64 memsize;
 	struct page **pages;
 	pgoff_t pagecount;
+	u8 edid[512];
 
 	struct list_head dmabufs;
 	u32 active_id;
@@ -346,6 +355,11 @@ static void handle_mmio_read(struct mdev_state *mdev_state, u16 offset,
 	int index;
 
 	switch (offset) {
+	case 0x000 ... 0x3ff: /* edid block */
+		if (offset + count > sizeof(mdev_state->edid))
+			goto unhandled;
+		memcpy(buf, mdev_state->edid + offset, count);
+		break;
 	case 0x500 ... 0x515: /* bochs dispi interface */
 		if (count != 2)
 			goto unhandled;
@@ -983,9 +997,13 @@ static int mbochs_get_irq_info(struct mdev_device *mdev,
 static int mbochs_get_device_info(struct mdev_device *mdev,
 				  struct vfio_device_info *dev_info)
 {
+	struct mdev_state *mdev_state = mdev_get_drvdata(mdev);
+
 	dev_info->flags = VFIO_DEVICE_FLAGS_PCI;
 	dev_info->num_regions = VFIO_PCI_NUM_REGIONS;
 	dev_info->num_irqs = VFIO_PCI_NUM_IRQS;
+	dev_info->edid_max_x = mdev_state->type->max_x;
+	dev_info->edid_max_y = mdev_state->type->max_y;
 	return 0;
 }
 
@@ -1084,7 +1102,7 @@ static long mbochs_ioctl(struct mdev_device *mdev, unsigned int cmd,
 			unsigned long arg)
 {
 	int ret = 0;
-	unsigned long minsz;
+	unsigned long minsz, outsz;
 	struct mdev_state *mdev_state;
 
 	mdev_state = mdev_get_drvdata(mdev);
@@ -1095,6 +1113,7 @@ static long mbochs_ioctl(struct mdev_device *mdev, unsigned int cmd,
 		struct vfio_device_info info;
 
 		minsz = offsetofend(struct vfio_device_info, num_irqs);
+		outsz = offsetofend(struct vfio_device_info, edid_max_y);
 
 		if (copy_from_user(&info, (void __user *)arg, minsz))
 			return -EFAULT;
@@ -1108,7 +1127,9 @@ static long mbochs_ioctl(struct mdev_device *mdev, unsigned int cmd,
 
 		memcpy(&mdev_state->dev_info, &info, sizeof(info));
 
-		if (copy_to_user((void __user *)arg, &info, minsz))
+		if (outsz > info.argsz)
+			outsz = info.argsz;
+		if (copy_to_user((void __user *)arg, &info, outsz))
 			return -EFAULT;
 
 		return 0;
@@ -1194,6 +1215,35 @@ static long mbochs_ioctl(struct mdev_device *mdev, unsigned int cmd,
 		return mbochs_get_gfx_dmabuf(mdev, dmabuf_id);
 	}
 
+	case VFIO_DEVICE_SET_GFX_EDID:
+	{
+		struct vfio_device_set_gfx_edid *edid;
+
+		edid = kmalloc(sizeof(*edid), GFP_KERNEL);
+
+		minsz = offsetofend(struct vfio_device_set_gfx_edid,
+				    edid_blob);
+
+		if (copy_from_user(edid, (void __user *)arg, minsz)) {
+			kfree(edid);
+			return -EFAULT;
+		}
+
+		if (edid->argsz < minsz ||
+		    edid->edid_size > sizeof(mdev_state->edid)) {
+			kfree(edid);
+			return -EINVAL;
+		}
+
+		memset(mdev_state->edid, 0, sizeof(mdev_state->edid));
+		if (edid->link_state == VFIO_DEVICE_GFX_LINK_STATE_UP) {
+			memcpy(mdev_state->edid, edid->edid_blob, edid->edid_size);
+		}
+		kfree(edid);
+
+		return 0;
+	}
+
 	case VFIO_DEVICE_SET_IRQS:
 		return -EINVAL;
 
-- 
2.9.3

