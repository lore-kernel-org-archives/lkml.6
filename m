Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79704C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B71321711
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B71321711
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeHCF6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 01:58:05 -0400
Received: from gateway36.websitewelcome.com ([50.116.124.69]:33946 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726128AbeHCF6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 01:58:04 -0400
X-Greylist: delayed 1408 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Aug 2018 01:58:04 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 638CE400E7A32
        for <linux-kernel@vger.kernel.org>; Thu,  2 Aug 2018 21:42:54 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id lQwuf6kO0PvAdlQwuf8xdz; Thu, 02 Aug 2018 22:40:21 -0500
X-Authority-Reason: nr=8
Received: from [189.250.50.82] (port=49190 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1flQwu-0019BB-6R; Thu, 02 Aug 2018 22:40:20 -0500
Date:   Thu, 2 Aug 2018 22:40:19 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/i915/kvmgt: Fix potential Spectre v1
Message-ID: <20180803034019.GA18366@embeddedor.com>
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
X-Source-IP: 189.250.50.82
X-Source-L: No
X-Exim-ID: 1flQwu-0019BB-6R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.50.82]:49190
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

info.index can be indirectly controlled by user-space, hence leading
to a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/gpu/drm/i915/gvt/kvmgt.c:1232 intel_vgpu_ioctl() warn:
potential spectre issue 'vgpu->vdev.region' [r]

Fix this by sanitizing info.index before indirectly using it to index
vgpu->vdev.region

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 4d2f53a..b703f20 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -43,6 +43,8 @@
 #include <linux/mdev.h>
 #include <linux/debugfs.h>
 
+#include <linux/nospec.h>
+
 #include "i915_drv.h"
 #include "gvt.h"
 
@@ -1139,7 +1141,8 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 	} else if (cmd == VFIO_DEVICE_GET_REGION_INFO) {
 		struct vfio_region_info info;
 		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
-		int i, ret;
+		unsigned int i;
+		int ret;
 		struct vfio_region_info_cap_sparse_mmap *sparse = NULL;
 		size_t size;
 		int nr_areas = 1;
@@ -1224,6 +1227,10 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 				if (info.index >= VFIO_PCI_NUM_REGIONS +
 						vgpu->vdev.num_regions)
 					return -EINVAL;
+				info.index =
+					array_index_nospec(info.index,
+							VFIO_PCI_NUM_REGIONS +
+							vgpu->vdev.num_regions);
 
 				i = info.index - VFIO_PCI_NUM_REGIONS;
 
-- 
2.7.4

