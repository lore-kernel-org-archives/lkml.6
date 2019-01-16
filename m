Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71884C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BCC20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405662AbfAPQdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:33:46 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:42724 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405712AbfAPQdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:33:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id D24131855A;
        Wed, 16 Jan 2019 17:33:01 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 1Gt_y9JW0q3D; Wed, 16 Jan 2019 17:32:59 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 3685918557;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B13E1A077;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F7A31A06B;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 0340F2FE6;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id F232580B46; Wed, 16 Jan 2019 17:32:57 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH 2/8] vop: Cast pointers to uintptr_t
Date:   Wed, 16 Jan 2019 17:32:47 +0100
Message-Id: <20190116163253.23780-3-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190116163253.23780-1-vincent.whitchurch@axis.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
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
 drivers/misc/mic/vop/vop_main.c   | 8 ++++----
 drivers/misc/mic/vop/vop_vringh.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 6b212c8b78e7..5a366cf68d95 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -497,7 +497,7 @@ static int _vop_add_device(struct mic_device_desc __iomem *d,
 	vdev->desc = d;
 	vdev->dc = (void __iomem *)d + _vop_aligned_desc_size(d);
 	vdev->dnode = dnode;
-	vdev->vdev.priv = (void *)(u64)dnode;
+	vdev->vdev.priv = (void *)(uintptr_t)dnode;
 	init_completion(&vdev->reset_done);
 
 	vdev->h2c_vdev_db = vpdev->hw_ops->next_db(vpdev);
@@ -519,7 +519,7 @@ static int _vop_add_device(struct mic_device_desc __iomem *d,
 			offset, type);
 		goto free_irq;
 	}
-	writeq((u64)vdev, &vdev->dc->vdev);
+	writeq((uintptr_t)vdev, &vdev->dc->vdev);
 	dev_dbg(_vop_dev(vdev), "%s: registered vop device %u type %u vdev %p\n",
 		__func__, offset, type, vdev);
 
@@ -552,7 +552,7 @@ static void _vop_handle_config_change(struct mic_device_desc __iomem *d,
 {
 	struct mic_device_ctrl __iomem *dc
 		= (void __iomem *)d + _vop_aligned_desc_size(d);
-	struct _vop_vdev *vdev = (struct _vop_vdev *)readq(&dc->vdev);
+	struct _vop_vdev *vdev = (struct _vop_vdev *)(uintptr_t)readq(&dc->vdev);
 
 	if (ioread8(&dc->config_change) != MIC_VIRTIO_PARAM_CONFIG_CHANGED)
 		return;
@@ -571,7 +571,7 @@ static int _vop_remove_device(struct mic_device_desc __iomem *d,
 {
 	struct mic_device_ctrl __iomem *dc
 		= (void __iomem *)d + _vop_aligned_desc_size(d);
-	struct _vop_vdev *vdev = (struct _vop_vdev *)readq(&dc->vdev);
+	struct _vop_vdev *vdev = (struct _vop_vdev *)(uintptr_t)readq(&dc->vdev);
 	u8 status;
 	int ret = -1;
 
diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index 4267fa08b483..ccdfbb652123 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -708,12 +708,12 @@ static int vop_vringh_copy(struct vop_vdev *vdev, struct vringh_kiov *iov,
 		partlen = min(kiov->iov_len, len);
 		if (read)
 			ret = vop_virtio_copy_to_user(vdev, ubuf, partlen,
-						      (u64)kiov->iov_base,
+						      (uintptr_t)kiov->iov_base,
 						      kiov->iov_len,
 						      vr_idx);
 		else
 			ret = vop_virtio_copy_from_user(vdev, ubuf, partlen,
-							(u64)kiov->iov_base,
+							(uintptr_t)kiov->iov_base,
 							kiov->iov_len,
 							vr_idx);
 		if (ret) {
-- 
2.20.0

