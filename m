Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD99C46467
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48F620844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48F620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406848AbeHATMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:12:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51360 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405036AbeHATMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:12:14 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 781B6CC9;
        Wed,  1 Aug 2018 17:25:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Eric Auger <eric.auger@redhat.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 017/144] vfio: platform: Fix reset module leak in error path
Date:   Wed,  1 Aug 2018 18:50:44 +0200
Message-Id: <20180801164950.549549149@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 28a68387888997e8a7fa57940ea5d55f2e16b594 ]

If the IOMMU group setup fails, the reset module is not released.

Fixes: b5add544d677d363 ("vfio, platform: make reset driver a requirement by default")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vfio/platform/vfio_platform_common.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -696,18 +696,23 @@ int vfio_platform_probe_common(struct vf
 	group = vfio_iommu_group_get(dev);
 	if (!group) {
 		pr_err("VFIO: No IOMMU group for device %s\n", vdev->name);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_reset;
 	}
 
 	ret = vfio_add_group_dev(dev, &vfio_platform_ops, vdev);
-	if (ret) {
-		vfio_iommu_group_put(group, dev);
-		return ret;
-	}
+	if (ret)
+		goto put_iommu;
 
 	mutex_init(&vdev->igate);
 
 	return 0;
+
+put_iommu:
+	vfio_iommu_group_put(group, dev);
+put_reset:
+	vfio_platform_put_reset(vdev);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(vfio_platform_probe_common);
 


