Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847B8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE9421919
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbeL1DBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 22:01:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:21063 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbeL1DBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 22:01:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2018 19:01:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,407,1539673200"; 
   d="scan'208";a="113768290"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by orsmga003.jf.intel.com with ESMTP; 27 Dec 2018 19:01:31 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        mst@redhat.com, cohuck@redhat.com
Cc:     borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com,
        wei.w.wang@intel.com
Subject: [PATCH v1 2/2] virtio: don't allocate vqs when names[i] = NULL
Date:   Fri, 28 Dec 2018 10:26:26 +0800
Message-Id: <1545963986-11280-3-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some vqs may not need to be allocated when their related feature bits
are disabled. So callers may pass in such vqs with "names = NULL".
Then we skip such vq allocations.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 drivers/misc/mic/vop/vop_main.c        |  9 +++++++--
 drivers/remoteproc/remoteproc_virtio.c |  9 +++++++--
 drivers/s390/virtio/virtio_ccw.c       | 12 +++++++++---
 drivers/virtio/virtio_mmio.c           |  9 +++++++--
 4 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 6b212c8..2bfa3a9 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -394,16 +394,21 @@ static int vop_find_vqs(struct virtio_device *dev, unsigned nvqs,
 	struct _vop_vdev *vdev = to_vopvdev(dev);
 	struct vop_device *vpdev = vdev->vpdev;
 	struct mic_device_ctrl __iomem *dc = vdev->dc;
-	int i, err, retry;
+	int i, err, retry, queue_idx = 0;
 
 	/* We must have this many virtqueues. */
 	if (nvqs > ioread8(&vdev->desc->num_vq))
 		return -ENOENT;
 
 	for (i = 0; i < nvqs; ++i) {
+		if (!names[i]) {
+			vqs[i] = NULL;
+			continue;
+		}
+
 		dev_dbg(_vop_dev(vdev), "%s: %d: %s\n",
 			__func__, i, names[i]);
-		vqs[i] = vop_find_vq(dev, i, callbacks[i], names[i],
+		vqs[i] = vop_find_vq(dev, queue_idx++, callbacks[i], names[i],
 				     ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 183fc42..2d7cd344 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -153,10 +153,15 @@ static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 				 const bool * ctx,
 				 struct irq_affinity *desc)
 {
-	int i, ret;
+	int i, ret, queue_idx = 0;
 
 	for (i = 0; i < nvqs; ++i) {
-		vqs[i] = rp_find_vq(vdev, i, callbacks[i], names[i],
+		if (!names[i]) {
+			vqs[i] = NULL;
+			continue;
+		}
+
+		vqs[i] = rp_find_vq(vdev, queue_idx++, callbacks[i], names[i],
 				    ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
 			ret = PTR_ERR(vqs[i]);
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index fc9dbad..ae1d56d 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -635,7 +635,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	unsigned long *indicatorp = NULL;
-	int ret, i;
+	int ret, i, queue_idx = 0;
 	struct ccw1 *ccw;
 
 	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
@@ -643,8 +643,14 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		return -ENOMEM;
 
 	for (i = 0; i < nvqs; ++i) {
-		vqs[i] = virtio_ccw_setup_vq(vdev, i, callbacks[i], names[i],
-					     ctx ? ctx[i] : false, ccw);
+		if (!names[i]) {
+			vqs[i] = NULL;
+			continue;
+		}
+
+		vqs[i] = virtio_ccw_setup_vq(vdev, queue_idx++, callbacks[i],
+					     names[i], ctx ? ctx[i] : false,
+					     ccw);
 		if (IS_ERR(vqs[i])) {
 			ret = PTR_ERR(vqs[i]);
 			vqs[i] = NULL;
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 4cd9ea5..d9dd0f78 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -468,7 +468,7 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	unsigned int irq = platform_get_irq(vm_dev->pdev, 0);
-	int i, err;
+	int i, err, queue_idx = 0;
 
 	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
 			dev_name(&vdev->dev), vm_dev);
@@ -476,7 +476,12 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		return err;
 
 	for (i = 0; i < nvqs; ++i) {
-		vqs[i] = vm_setup_vq(vdev, i, callbacks[i], names[i],
+		if (!names[i]) {
+			vqs[i] = NULL;
+			continue;
+		}
+
+		vqs[i] = vm_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
 				     ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
 			vm_del_vqs(vdev);
-- 
2.7.4

