Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B85CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8184821A18
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8184821A18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeHHRb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:31:27 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:34172 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbeHHRb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:31:27 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 3392C5B174FDB6A8085F;
        Wed,  8 Aug 2018 23:11:18 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w78FBCXP062956;
        Wed, 8 Aug 2018 23:11:12 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018080823111941-3593745 ;
          Wed, 8 Aug 2018 23:11:19 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     zhenyuw@linux.intel.com
Cc:     zhi.a.wang@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        wang.yi59@zte.com.cn, zhong.weidong@zte.com.cn
Subject: [PATCH v2] drm/i915/gvt: fix memory leak in intel_vgpu_ioctl()
Date:   Wed, 8 Aug 2018 23:10:57 +0800
Message-Id: <1533741057-47617-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-08 23:11:19,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-08 23:11:04,
        Serialize complete at 2018-08-08 23:11:04
X-MAIL: mse01.zte.com.cn w78FBCXP062956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'sparse' variable may leak when return in function
intel_vgpu_ioctl(), and this patch fix this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
v2: fix a double-free error. Thanks to Zhenyu Wang.

 drivers/gpu/drm/i915/gvt/kvmgt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index df4e4a0..bce60cc 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1195,11 +1195,13 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 					&sparse->header, sizeof(*sparse) +
 					(sparse->nr_areas *
 						sizeof(*sparse->areas)));
-				kfree(sparse);
-				if (ret)
+				if (ret) {
+					kfree(sparse);
 					return ret;
+				}
 				break;
 			default:
+				kfree(sparse);
 				return -EINVAL;
 			}
 		}
@@ -1215,6 +1217,7 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 						  sizeof(info), caps.buf,
 						  caps.size)) {
 					kfree(caps.buf);
+					kfree(sparse);
 					return -EFAULT;
 				}
 				info.cap_offset = sizeof(info);
@@ -1223,6 +1226,7 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 			kfree(caps.buf);
 		}
 
+		kfree(sparse);
 		return copy_to_user((void __user *)arg, &info, minsz) ?
 			-EFAULT : 0;
 	} else if (cmd == VFIO_DEVICE_GET_IRQ_INFO) {
-- 
1.8.3.1

