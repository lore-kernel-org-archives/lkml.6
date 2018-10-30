Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C70CC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD182082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD182082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeJ3PYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:24:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbeJ3PYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:24:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 406F6307D85B;
        Tue, 30 Oct 2018 06:32:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-158.ams2.redhat.com [10.36.116.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73AC81974E;
        Tue, 30 Oct 2018 06:32:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 993A616444F; Tue, 30 Oct 2018 07:32:06 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     virtio-dev@lists.oasis-open.org, dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE, NET
        AND BLOCK DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/2] virtio-gpu: add VIRTIO_GPU_F_EDID feature
Date:   Tue, 30 Oct 2018 07:32:05 +0100
Message-Id: <20181030063206.19528-2-kraxel@redhat.com>
In-Reply-To: <20181030063206.19528-1-kraxel@redhat.com>
References: <20181030063206.19528-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 30 Oct 2018 06:32:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature allows the guest request an EDID blob (describing monitor
capabilities) for a given scanout (aka virtual monitor connector).

It brings a new command message, which has just a scanout field (beside
the standard virtio-gpu header) and a response message which carries the
EDID data.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Dave Airlie <airlied@redhat.com>
---
 include/uapi/linux/virtio_gpu.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index f43c3c6171..8e88eba1fa 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -41,6 +41,7 @@
 #include <linux/types.h>
 
 #define VIRTIO_GPU_F_VIRGL 0
+#define VIRTIO_GPU_F_EDID  1
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
@@ -56,6 +57,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING,
 	VIRTIO_GPU_CMD_GET_CAPSET_INFO,
 	VIRTIO_GPU_CMD_GET_CAPSET,
+	VIRTIO_GPU_CMD_GET_EDID,
 
 	/* 3d commands */
 	VIRTIO_GPU_CMD_CTX_CREATE = 0x0200,
@@ -76,6 +78,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
 	VIRTIO_GPU_RESP_OK_CAPSET_INFO,
 	VIRTIO_GPU_RESP_OK_CAPSET,
+	VIRTIO_GPU_RESP_OK_EDID,
 
 	/* error responses */
 	VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
@@ -291,6 +294,21 @@ struct virtio_gpu_resp_capset {
 	__u8 capset_data[];
 };
 
+/* VIRTIO_GPU_CMD_GET_EDID */
+struct virtio_gpu_cmd_get_edid {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 scanout;
+	__le32 padding;
+};
+
+/* VIRTIO_GPU_RESP_OK_EDID */
+struct virtio_gpu_resp_edid {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 size;
+	__le32 padding;
+	__u8 edid[1024];
+};
+
 #define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
 
 struct virtio_gpu_config {
-- 
2.9.3

