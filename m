Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3C3C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F772084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F772084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeJZDLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:11:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43582 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJZDLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:11:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: robertfoss)
        with ESMTPSA id A65E4260739
From:   Robert Foss <robert.foss@collabora.com>
To:     airlied@linux.ie, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Robert Foss <robert.foss@collabora.com>
Subject: [PATCH 0/5] virgl: fence fd support
Date:   Thu, 25 Oct 2018 20:37:34 +0200
Message-Id: <20181025183739.9375-1-robert.foss@collabora.com>
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
https://gitlab.collabora.com/robertfoss/linux/commits/virtio_fences_v3

As for mesa, the branch can be found here:
https://gitlab.collabora.com/robertfoss/mesa/commits/virtio_fences_v3


Changes since v2:
 - drm/virtio: add virtio_gpu_alloc_fence()
   - Forward port and fix compilation issues
 - drm/virtio: add uapi for in and out explicit fences
   - Check exbuf->flags for unsupported flags


Gustavo Padovan (4):
  drm/virtio: add virtio_gpu_alloc_fence()
  drm/virtio: add in-fences support for explicit synchronization
  drm/virtio: add out-fences support for explicit synchronization
  drm/virtio: bump driver version after explicit synchronization
    addition

Robert Foss (1):
  drm/virtio: add uapi for in and out explicit fences

 drivers/gpu/drm/virtio/virtgpu_drv.h   |  22 +++--
 drivers/gpu/drm/virtio/virtgpu_fence.c |  41 ++++++---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 118 +++++++++++++++++++++----
 drivers/gpu/drm/virtio/virtgpu_plane.c |  46 ++++++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c    |  16 ++--
 include/uapi/drm/virtgpu_drm.h         |  13 ++-
 6 files changed, 201 insertions(+), 55 deletions(-)

-- 
2.17.1

