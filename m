Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98837C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688F320861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078620;
	bh=47r4ndJCZeAeCK4ugzrLu3/mqFLDFaSnzBUdzxoFPrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VVJt8tY6B1VtJgp3gacpMqwby4XX30SlQeQQqQf/XR/neuoOmB4kRX6tgFYS1xme5
	 KKU9Jth+JbWktYl3nEGl0hL+45ib0XMZbyWcbKEC1p+Uf0X8x9ZAFaNmcaaqyM5Zl9
	 hcuLyudZ7IGEv1lOUCwYrz6ISM4IfGb5hA8W/nQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfAUNuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:32772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729520AbfAUNuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:50:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EC412063F;
        Mon, 21 Jan 2019 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078613;
        bh=47r4ndJCZeAeCK4ugzrLu3/mqFLDFaSnzBUdzxoFPrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXnsM5tNEJCzxKJ/4OuxqzS6O+Qh+dhr27un/uo+jrOmTkX7itqFGrVTZYeNVXuQy
         dO1Lz71fqZQkGs66FnX2T+uNsQtkD2OFbGikKYrpzR/Avgqpb0RXZ3xqbKQdqbA1B7
         zl3Hq0CiFlHguEk4DZ8eSks9LdsruEQTlb8lmBJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Wang <wei.w.wang@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 4.20 046/111] virtio: dont allocate vqs when names[i] = NULL
Date:   Mon, 21 Jan 2019 14:42:40 +0100
Message-Id: <20190121122501.044710396@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Wang <wei.w.wang@intel.com>

commit a229989d975eb926076307c1f2f5e4c6111768e7 upstream.

Some vqs may not need to be allocated when their related feature bits
are disabled. So callers may pass in such vqs with "names = NULL".
Then we skip such vq allocations.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mic/vop/vop_main.c        |    9 +++++++--
 drivers/remoteproc/remoteproc_virtio.c |    9 +++++++--
 drivers/s390/virtio/virtio_ccw.c       |   12 +++++++++---
 drivers/virtio/virtio_mmio.c           |    9 +++++++--
 4 files changed, 30 insertions(+), 9 deletions(-)

--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -381,16 +381,21 @@ static int vop_find_vqs(struct virtio_de
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
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -153,10 +153,15 @@ static int rproc_virtio_find_vqs(struct
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
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -635,7 +635,7 @@ static int virtio_ccw_find_vqs(struct vi
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	unsigned long *indicatorp = NULL;
-	int ret, i;
+	int ret, i, queue_idx = 0;
 	struct ccw1 *ccw;
 
 	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
@@ -643,8 +643,14 @@ static int virtio_ccw_find_vqs(struct vi
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
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -468,7 +468,7 @@ static int vm_find_vqs(struct virtio_dev
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	unsigned int irq = platform_get_irq(vm_dev->pdev, 0);
-	int i, err;
+	int i, err, queue_idx = 0;
 
 	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
 			dev_name(&vdev->dev), vm_dev);
@@ -476,7 +476,12 @@ static int vm_find_vqs(struct virtio_dev
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


