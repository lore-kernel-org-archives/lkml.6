Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeCMPJ5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:09:57 -0400
Received: from gateway30.websitewelcome.com ([192.185.160.12]:35835 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751494AbeCMPJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:09:54 -0400
Date: Tue, 13 Mar 2018 09:48:12 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/nouveau/secboot: remove VLA usage
Message-ID: <20180313144812.GA30043@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1evlDr-0016AN-Bw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:55832
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wvla, remove VLA. In this particular
case directly use macro NVKM_MSGQUEUE_CMDLINE_SIZE instead of local
variable cmdline_size. Also, remove cmdline_size as it is not
actually useful anymore.

The use of stack Variable Length Arrays needs to be avoided, as they
can be a vector for stack exhaustion, which can be both a runtime bug
or a security flaw. Also, in general, as code evolves it is easy to
lose track of how big a VLA can get. Thus, we can end up having runtime
failures that are hard to debug.

Also, fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c
index 6f10b09..2da147b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c
@@ -80,12 +80,12 @@ acr_ls_msgqueue_post_run(struct nvkm_msgqueue *queue,
 			 struct nvkm_falcon *falcon, u32 addr_args)
 {
 	struct nvkm_device *device = falcon->owner->device;
-	u32 cmdline_size = NVKM_MSGQUEUE_CMDLINE_SIZE;
-	u8 buf[cmdline_size];
+	u8 buf[NVKM_MSGQUEUE_CMDLINE_SIZE];
 
-	memset(buf, 0, cmdline_size);
+	memset(buf, 0, NVKM_MSGQUEUE_CMDLINE_SIZE);
 	nvkm_msgqueue_write_cmdline(queue, buf);
-	nvkm_falcon_load_dmem(falcon, buf, addr_args, cmdline_size, 0);
+	nvkm_falcon_load_dmem(falcon, buf, addr_args,
+			      NVKM_MSGQUEUE_CMDLINE_SIZE, 0);
 	/* rearm the queue so it will wait for the init message */
 	nvkm_msgqueue_reinit(queue);
 
-- 
2.7.4
