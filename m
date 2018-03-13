Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933841AbeCMQYP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:24:15 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.35]:33902 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932695AbeCMQYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:24:13 -0400
Date: Tue, 13 Mar 2018 11:24:11 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: David Laight <David.Laight@ACULAB.COM>,
        Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] drm/nouveau/secboot: remove VLA usage
Message-ID: <20180313162411.GA1983@embeddedgus>
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
X-Exim-ID: 1evmii-002mF9-4E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:57352
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
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
Changes in v2:
 - Use sizeof(buf) instead of NVKM_MSGQUEUE_CMDLINE_SIZE. This change
   is based on the feedback provided by David Laight. Thanks David.

 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c
index 6f10b09..1e1f1c6 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c
@@ -80,12 +80,11 @@ acr_ls_msgqueue_post_run(struct nvkm_msgqueue *queue,
 			 struct nvkm_falcon *falcon, u32 addr_args)
 {
 	struct nvkm_device *device = falcon->owner->device;
-	u32 cmdline_size = NVKM_MSGQUEUE_CMDLINE_SIZE;
-	u8 buf[cmdline_size];
+	u8 buf[NVKM_MSGQUEUE_CMDLINE_SIZE];
 
-	memset(buf, 0, cmdline_size);
+	memset(buf, 0, sizeof(buf));
 	nvkm_msgqueue_write_cmdline(queue, buf);
-	nvkm_falcon_load_dmem(falcon, buf, addr_args, cmdline_size, 0);
+	nvkm_falcon_load_dmem(falcon, buf, addr_args, sizeof(buf), 0);
 	/* rearm the queue so it will wait for the init message */
 	nvkm_msgqueue_reinit(queue);
 
-- 
2.7.4
