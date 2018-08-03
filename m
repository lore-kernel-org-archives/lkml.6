Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B05CC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA2821700
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA2821700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbeHCCfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 22:35:10 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:44576 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbeHCCfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 22:35:10 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id CDD10B40C43CBDDFBCBF;
        Fri,  3 Aug 2018 08:41:28 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w730fOiT039692;
        Fri, 3 Aug 2018 08:41:24 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018080308413180-3041620 ;
          Fri, 3 Aug 2018 08:41:31 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     zhenyuw@linux.intel.com
Cc:     zhi.a.wang@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        wang.yi59@zte.com.cn, zhong.weidong@zte.com.cn
Subject: [PATCH] drm/i915/gvt: fix memory leak in intel_vgpu_ioctl()
Date:   Fri, 3 Aug 2018 08:41:19 +0800
Message-Id: <1533256879-10220-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-03 08:41:31,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-03 08:41:09,
        Serialize complete at 2018-08-03 08:41:09
X-MAIL: mse01.zte.com.cn w730fOiT039692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'sparse' variable may leak when return in function
intel_vgpu_ioctl(), and this patch fixes this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index df4e4a0..6a6f199 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1200,6 +1200,7 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 					return ret;
 				break;
 			default:
+				kfree(sparse);
 				return -EINVAL;
 			}
 		}
@@ -1215,6 +1216,7 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 						  sizeof(info), caps.buf,
 						  caps.size)) {
 					kfree(caps.buf);
+					kfree(sparse);
 					return -EFAULT;
 				}
 				info.cap_offset = sizeof(info);
@@ -1223,6 +1225,7 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 			kfree(caps.buf);
 		}
 
+		kfree(sparse);
 		return copy_to_user((void __user *)arg, &info, minsz) ?
 			-EFAULT : 0;
 	} else if (cmd == VFIO_DEVICE_GET_IRQ_INFO) {
-- 
1.8.3.1

