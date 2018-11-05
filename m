Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59908C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299AE20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299AE20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbeKEVB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:01:26 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48646 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbeKEVBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:01:25 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8109:92c0:207d:59be:d485:5b1c:9e22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robertfoss)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D0D2B261F9E;
        Mon,  5 Nov 2018 11:42:04 +0000 (GMT)
From:   Robert Foss <robert.foss@collabora.com>
To:     airlied@linux.ie, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Robert Foss <robert.foss@collabora.com>
Subject: [PATCH v4 0/4] virgl: fence fd support
Date:   Mon,  5 Nov 2018 12:41:48 +0100
Message-Id: <20181105114152.2088-1-robert.foss@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements fence support for drm/virtio and
has been tested using qemu, kmscube and the below branches.

Rob Herring solved a reference counting issue and
suggested a context check for the execbuf ioctl, his
changes have been included in the below commits to
keep the tree working at all commits.


The linux series can be found here:
https://gitlab.collabora.com/robertfoss/linux/commits/virtio_fences_v4

As for mesa, the branch can be found here:
https://gitlab.collabora.com/robertfoss/mesa/commits/virtio_fences_v3



Changes since v3:
 - Rebased on drm-misc-next
 - drm/virtio: add virtio_gpu_alloc_fence()
   - Gerd: Clarified and extended commit message
   - Emil: Fixed whitespace issue
   - Emil: Changed label name from fail_fence to fail_backoff
   - Emil: Remove special case for !fence->drv in virtio_gpu_fence_cleanup()
 - drm/virtio: add uapi for in and out explicit fences
   - Emil: Added r-b
   - Emil: Move fence_fd assignment to after sanity checks
 - drm/virtio: add in-fences support for explicit synchronization
   - Move all in_fence handling to the same VIRTGPU_EXECBUF_FENCE_FD_IN block
   - Emil: Make sure to always call dma_fence_put()
   - Emil: Added r-b
 - drm/virtio: add out-fences support for explicit synchronization
   - Emil: Combine with in-fences patch
 -  drm/virtio: bump driver version after explicit synchronization addition
   - Emil: Added r-b

Changes since v2:
 - drm/virtio: add virtio_gpu_alloc_fence()
   - Forward port and fix compilation issues
 - drm/virtio: add uapi for in and out explicit fences
   - Check exbuf->flags for unsupported flags
 - drm/virtio: add in-fences support for explicit synchronization



Gustavo Padovan (1):
  drm/virtio: bump driver version after explicit synchronization
    addition

Robert Foss (3):
  drm/virtio: add virtio_gpu_alloc_fence()
  drm/virtio: add uapi for in and out explicit fences
  drm/virtio: add in/out fence support for explicit synchronization

 drivers/gpu/drm/virtio/virtgpu_drv.h   |   8 +-
 drivers/gpu/drm/virtio/virtgpu_fence.c |  29 +++++--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 108 +++++++++++++++++++++----
 drivers/gpu/drm/virtio/virtgpu_plane.c |  46 +++++++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c    |   2 +-
 include/uapi/drm/virtgpu_drm.h         |  13 ++-
 6 files changed, 173 insertions(+), 33 deletions(-)

-- 
2.17.1

