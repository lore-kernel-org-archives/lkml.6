Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951E9C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFF321726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfBAIpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:45:14 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:50933 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfBAIpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:45:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 3FF6018622;
        Fri,  1 Feb 2019 09:45:11 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id neyIrvkB5KHp; Fri,  1 Feb 2019 09:45:10 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 65A1A18399;
        Fri,  1 Feb 2019 09:45:10 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F1651E08F;
        Fri,  1 Feb 2019 09:45:10 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 430431E06A;
        Fri,  1 Feb 2019 09:45:10 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Fri,  1 Feb 2019 09:45:10 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 3629E281D;
        Fri,  1 Feb 2019 09:45:10 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 32F5080C3C; Fri,  1 Feb 2019 09:45:10 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        linux-kernel@vger.kernel.org, tiwei.bie@intel.com,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH] mic: vop: Fix crash on remove
Date:   Fri,  1 Feb 2019 09:45:09 +0100
Message-Id: <20190201084509.28004-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remove path contains a hack which depends on internal structures in
other source files, similar to the one which was recently removed from
the registration path.  Since commit 1ce9e6055fa0 ("virtio_ring:
introduce packed ring support"), this leads to a crash when vop devices
are removed.

The structure in question is only examined to get the virtual address of
the allocated used page.  Store that pointer locally instead to fix the
crash.

Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/misc/mic/vop/vop_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index eb8d0937abda..c4517703dc1d 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -48,7 +48,8 @@
  * @dc: Virtio device control
  * @vpdev: VOP device which is the parent for this virtio device
  * @vr: Buffer for accessing the VRING
- * @used: Buffer for used
+ * @used_virt: Virtual address of used ring
+ * @used: DMA address of used ring
  * @used_size: Size of the used buffer
  * @reset_done: Track whether VOP reset is complete
  * @virtio_cookie: Cookie returned upon requesting a interrupt
@@ -62,6 +63,7 @@ struct _vop_vdev {
 	struct mic_device_ctrl __iomem *dc;
 	struct vop_device *vpdev;
 	void __iomem *vr[VOP_MAX_VRINGS];
+	void *used_virt[VOP_MAX_VRINGS];
 	dma_addr_t used[VOP_MAX_VRINGS];
 	int used_size[VOP_MAX_VRINGS];
 	struct completion reset_done;
@@ -261,12 +263,12 @@ static bool vop_notify(struct virtqueue *vq)
 static void vop_del_vq(struct virtqueue *vq, int n)
 {
 	struct _vop_vdev *vdev = to_vopvdev(vq->vdev);
-	struct vring *vr = (struct vring *)(vq + 1);
 	struct vop_device *vpdev = vdev->vpdev;
 
 	dma_unmap_single(&vpdev->dev, vdev->used[n],
 			 vdev->used_size[n], DMA_BIDIRECTIONAL);
-	free_pages((unsigned long)vr->used, get_order(vdev->used_size[n]));
+	free_pages((unsigned long)vdev->used_virt[n],
+		   get_order(vdev->used_size[n]));
 	vring_del_virtqueue(vq);
 	vpdev->hw_ops->unmap(vpdev, vdev->vr[n]);
 	vdev->vr[n] = NULL;
@@ -355,6 +357,7 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 					     le16_to_cpu(config.num));
 	used = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 					get_order(vdev->used_size[index]));
+	vdev->used_virt[index] = used;
 	if (!used) {
 		err = -ENOMEM;
 		dev_err(_vop_dev(vdev), "%s %d err %d\n",
-- 
2.20.0

