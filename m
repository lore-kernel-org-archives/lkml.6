Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFC2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD1A204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeLSM1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:27:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbeLSM1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:27:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3390A2BE87;
        Wed, 19 Dec 2018 12:27:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDA8727C48;
        Wed, 19 Dec 2018 12:27:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 014377503; Wed, 19 Dec 2018 13:27:09 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 01/10] drm/virtio: log error responses
Date:   Wed, 19 Dec 2018 13:26:59 +0100
Message-Id: <20181219122708.4586-2-kraxel@redhat.com>
In-Reply-To: <20181219122708.4586-1-kraxel@redhat.com>
References: <20181219122708.4586-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 19 Dec 2018 12:27:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we got an error response code from the host, print it to the log.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index e27c4aedb8..6bc2008b0d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -192,8 +192,16 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
 
 	list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
 		resp = (struct virtio_gpu_ctrl_hdr *)entry->resp_buf;
-		if (resp->type != cpu_to_le32(VIRTIO_GPU_RESP_OK_NODATA))
-			DRM_DEBUG("response 0x%x\n", le32_to_cpu(resp->type));
+		if (resp->type != cpu_to_le32(VIRTIO_GPU_RESP_OK_NODATA)) {
+			if (resp->type >= cpu_to_le32(VIRTIO_GPU_RESP_ERR_UNSPEC)) {
+				struct virtio_gpu_ctrl_hdr *cmd;
+				cmd = (struct virtio_gpu_ctrl_hdr *)entry->buf;
+				DRM_ERROR("response 0x%x (command 0x%x)\n",
+					  le32_to_cpu(resp->type),
+					  le32_to_cpu(cmd->type));
+			} else
+				DRM_DEBUG("response 0x%x\n", le32_to_cpu(resp->type));
+		}
 		if (resp->flags & cpu_to_le32(VIRTIO_GPU_FLAG_FENCE)) {
 			u64 f = le64_to_cpu(resp->fence_id);
 
-- 
2.9.3

