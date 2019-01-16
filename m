Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF07C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AE520657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405740AbfAPQdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:33:06 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:42719 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbfAPQdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:33:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 2B06C18511;
        Wed, 16 Jan 2019 17:33:01 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id fJxCxp0ph8G9; Wed, 16 Jan 2019 17:32:59 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 3CCA81855A;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 277FD1A084;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1947A1A075;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 06ACB3126;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 04A3880B46; Wed, 16 Jan 2019 17:32:58 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH 5/8] vop: vringh: Do not crash if no DMA channel
Date:   Wed, 16 Jan 2019 17:32:50 +0100
Message-Id: <20190116163253.23780-6-vincent.whitchurch@axis.com>
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

Fallback gracefully if no DMA channel is provided instead of
dereferencing NULL pointers.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/misc/mic/vop/vop_vringh.c | 32 +++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index ccdfbb652123..18d6ecff1834 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -531,12 +531,12 @@ static int vop_virtio_copy_to_user(struct vop_vdev *vdev, void __user *ubuf,
 	void __iomem *dbuf = vpdev->hw_ops->ioremap(vpdev, daddr, len);
 	struct vop_vringh *vvr = &vdev->vvr[vr_idx];
 	struct vop_info *vi = dev_get_drvdata(&vpdev->dev);
-	size_t dma_alignment = 1 << vi->dma_ch->device->copy_align;
-	bool x200 = is_dma_copy_aligned(vi->dma_ch->device, 1, 1, 1);
+	size_t dma_alignment;
+	bool x200;
 	size_t dma_offset, partlen;
 	int err;
 
-	if (!VOP_USE_DMA) {
+	if (!VOP_USE_DMA || !vi->dma_ch) {
 		if (copy_to_user(ubuf, (void __force *)dbuf, len)) {
 			err = -EFAULT;
 			dev_err(vop_dev(vdev), "%s %d err %d\n",
@@ -548,6 +548,9 @@ static int vop_virtio_copy_to_user(struct vop_vdev *vdev, void __user *ubuf,
 		goto err;
 	}
 
+	dma_alignment = 1 << vi->dma_ch->device->copy_align;
+	x200 = is_dma_copy_aligned(vi->dma_ch->device, 1, 1, 1);
+
 	dma_offset = daddr - round_down(daddr, dma_alignment);
 	daddr -= dma_offset;
 	len += dma_offset;
@@ -606,18 +609,23 @@ static int vop_virtio_copy_from_user(struct vop_vdev *vdev, void __user *ubuf,
 	void __iomem *dbuf = vpdev->hw_ops->ioremap(vpdev, daddr, len);
 	struct vop_vringh *vvr = &vdev->vvr[vr_idx];
 	struct vop_info *vi = dev_get_drvdata(&vdev->vpdev->dev);
-	size_t dma_alignment = 1 << vi->dma_ch->device->copy_align;
-	bool x200 = is_dma_copy_aligned(vi->dma_ch->device, 1, 1, 1);
+	size_t dma_alignment;
+	bool x200;
 	size_t partlen;
-	bool dma = VOP_USE_DMA;
+	bool dma = VOP_USE_DMA && vi->dma_ch;
 	int err = 0;
 
-	if (daddr & (dma_alignment - 1)) {
-		vdev->tx_dst_unaligned += len;
-		dma = false;
-	} else if (ALIGN(len, dma_alignment) > dlen) {
-		vdev->tx_len_unaligned += len;
-		dma = false;
+	if (dma) {
+		dma_alignment = 1 << vi->dma_ch->device->copy_align;
+		x200 = is_dma_copy_aligned(vi->dma_ch->device, 1, 1, 1);
+
+		if (daddr & (dma_alignment - 1)) {
+			vdev->tx_dst_unaligned += len;
+			dma = false;
+		} else if (ALIGN(len, dma_alignment) > dlen) {
+			vdev->tx_len_unaligned += len;
+			dma = false;
+		}
 	}
 
 	if (!dma)
-- 
2.20.0

