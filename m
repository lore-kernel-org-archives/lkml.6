Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD2DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A940027E52
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A940027E52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755189AbeF2LQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:16:23 -0400
Received: from foss.arm.com ([217.140.101.70]:60022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755152AbeF2LQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:16:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00FB01529;
        Fri, 29 Jun 2018 04:16:16 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 104AB3F266;
        Fri, 29 Jun 2018 04:16:12 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Peter Maydel <peter.maydell@linaro.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v3 01/20] virtio: mmio-v1: Validate queue PFN
Date:   Fri, 29 Jun 2018 12:15:21 +0100
Message-Id: <1530270944-11351-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio-mmio with virtio-v1 uses a 32bit PFN for the queue.
If the queue pfn is too large to fit in 32bits, which
we could hit on arm64 systems with 52bit physical addresses
(even with 64K page size), we simply miss out a proper link
to the other side of the queue.

Add a check to validate the PFN, rather than silently breaking
the devices.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Cc: Peter Maydel <peter.maydell@linaro.org>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v2:
 - Change errno to -E2BIG
---
 drivers/virtio/virtio_mmio.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 67763d3..82cedc8 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -397,9 +397,21 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 	/* Activate the queue */
 	writel(virtqueue_get_vring_size(vq), vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
 	if (vm_dev->version == 1) {
+		u64 q_pfn = virtqueue_get_desc_addr(vq) >> PAGE_SHIFT;
+
+		/*
+		 * virtio-mmio v1 uses a 32bit QUEUE PFN. If we have something
+		 * that doesn't fit in 32bit, fail the setup rather than
+		 * pretending to be successful.
+		 */
+		if (q_pfn >> 32) {
+			dev_err(&vdev->dev, "virtio-mmio: queue address too large\n");
+			err = -E2BIG;
+			goto error_bad_pfn;
+		}
+
 		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
-		writel(virtqueue_get_desc_addr(vq) >> PAGE_SHIFT,
-				vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
+		writel(q_pfn, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
 	} else {
 		u64 addr;
 
@@ -430,6 +442,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 
 	return vq;
 
+error_bad_pfn:
+	vring_del_virtqueue(vq);
 error_new_virtqueue:
 	if (vm_dev->version == 1) {
 		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
-- 
2.7.4

