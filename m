Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6095C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4AB2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfBVPcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:32:21 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:45361 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfBVPb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:31:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 4A68318691;
        Fri, 22 Feb 2019 16:31:24 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id nJZ65fsu_Jjs; Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 8A0C618684;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 554461A069;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4978A1A077;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 3C81B1EC4;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 3789780095; Fri, 22 Feb 2019 16:31:21 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH v2 char-misc-next 1/7] mic: vop: Cast pointers to unsigned long
Date:   Fri, 22 Feb 2019 16:30:47 +0100
Message-Id: <20190222153056.18878-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190222153056.18878-1-vincent.whitchurch@axis.com>
References: <20190222153056.18878-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix these on 32-bit:

 vop_vringh.c:711:13: error: cast from pointer to integer of different
 size [-Werror=pointer-to-int-cast]

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/misc/mic/vop/vop_main.c   | 13 +++++++++----
 drivers/misc/mic/vop/vop_vringh.c |  5 +++--
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 3f96e19e57eb..263e0c3fa7c6 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -514,7 +514,7 @@ static int _vop_add_device(struct mic_device_desc __iomem *d,
 	vdev->desc = d;
 	vdev->dc = (void __iomem *)d + _vop_aligned_desc_size(d);
 	vdev->dnode = dnode;
-	vdev->vdev.priv = (void *)(u64)dnode;
+	vdev->vdev.priv = (void *)(unsigned long)dnode;
 	init_completion(&vdev->reset_done);
 
 	vdev->h2c_vdev_db = vpdev->hw_ops->next_db(vpdev);
@@ -536,7 +536,7 @@ static int _vop_add_device(struct mic_device_desc __iomem *d,
 			offset, type);
 		goto free_irq;
 	}
-	writeq((u64)vdev, &vdev->dc->vdev);
+	writeq((unsigned long)vdev, &vdev->dc->vdev);
 	dev_dbg(_vop_dev(vdev), "%s: registered vop device %u type %u vdev %p\n",
 		__func__, offset, type, vdev);
 
@@ -563,13 +563,18 @@ static int vop_match_desc(struct device *dev, void *data)
 	return vdev->desc == (void __iomem *)data;
 }
 
+static struct _vop_vdev *vop_dc_to_vdev(struct mic_device_ctrl *dc)
+{
+	return (struct _vop_vdev *)(unsigned long)readq(&dc->vdev);
+}
+
 static void _vop_handle_config_change(struct mic_device_desc __iomem *d,
 				      unsigned int offset,
 				      struct vop_device *vpdev)
 {
 	struct mic_device_ctrl __iomem *dc
 		= (void __iomem *)d + _vop_aligned_desc_size(d);
-	struct _vop_vdev *vdev = (struct _vop_vdev *)readq(&dc->vdev);
+	struct _vop_vdev *vdev = vop_dc_to_vdev(dc);
 
 	if (ioread8(&dc->config_change) != MIC_VIRTIO_PARAM_CONFIG_CHANGED)
 		return;
@@ -588,7 +593,7 @@ static int _vop_remove_device(struct mic_device_desc __iomem *d,
 {
 	struct mic_device_ctrl __iomem *dc
 		= (void __iomem *)d + _vop_aligned_desc_size(d);
-	struct _vop_vdev *vdev = (struct _vop_vdev *)readq(&dc->vdev);
+	struct _vop_vdev *vdev = vop_dc_to_vdev(dc);
 	u8 status;
 	int ret = -1;
 
diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index 0bac8bce933c..73d9fe6bc18d 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -712,16 +712,17 @@ static int vop_vringh_copy(struct vop_vdev *vdev, struct vringh_kiov *iov,
 
 	while (len && iov->i < iov->used) {
 		struct kvec *kiov = &iov->iov[iov->i];
+		unsigned long daddr = (unsigned long)kiov->iov_base;
 
 		partlen = min(kiov->iov_len, len);
 		if (read)
 			ret = vop_virtio_copy_to_user(vdev, ubuf, partlen,
-						      (u64)kiov->iov_base,
+						      daddr,
 						      kiov->iov_len,
 						      vr_idx);
 		else
 			ret = vop_virtio_copy_from_user(vdev, ubuf, partlen,
-							(u64)kiov->iov_base,
+							daddr,
 							kiov->iov_len,
 							vr_idx);
 		if (ret) {
-- 
2.20.0

