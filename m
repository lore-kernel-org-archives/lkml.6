Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE97AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AE320A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AE320A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbeHWLqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:46:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46204 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeHWLqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:46:36 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 52136C74;
        Thu, 23 Aug 2018 08:18:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 4.14 002/217] drm/i915/kvmgt: Fix potential Spectre v1
Date:   Thu, 23 Aug 2018 09:51:55 +0200
Message-Id: <20180823075505.362706475@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit de5372da605d3bca46e3102bab51b7e1c0e0a6f6 upstream.

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
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gvt/kvmgt.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -42,6 +42,8 @@
 #include <linux/vfio.h>
 #include <linux/mdev.h>
 
+#include <linux/nospec.h>
+
 #include "i915_drv.h"
 #include "gvt.h"
 
@@ -953,7 +955,8 @@ static long intel_vgpu_ioctl(struct mdev
 	} else if (cmd == VFIO_DEVICE_GET_REGION_INFO) {
 		struct vfio_region_info info;
 		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
-		int i, ret;
+		unsigned int i;
+		int ret;
 		struct vfio_region_info_cap_sparse_mmap *sparse = NULL;
 		size_t size;
 		int nr_areas = 1;
@@ -1030,6 +1033,10 @@ static long intel_vgpu_ioctl(struct mdev
 				if (info.index >= VFIO_PCI_NUM_REGIONS +
 						vgpu->vdev.num_regions)
 					return -EINVAL;
+				info.index =
+					array_index_nospec(info.index,
+							VFIO_PCI_NUM_REGIONS +
+							vgpu->vdev.num_regions);
 
 				i = info.index - VFIO_PCI_NUM_REGIONS;
 


