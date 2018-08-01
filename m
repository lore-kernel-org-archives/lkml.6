Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2302C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B26C208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B26C208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406139AbeHATIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:08:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50080 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406040AbeHATIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:41 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AE5B5CC9;
        Wed,  1 Aug 2018 17:21:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Suman Anna <s-anna@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 202/246] media: omap3isp: fix unbalanced dma_iommu_mapping
Date:   Wed,  1 Aug 2018 18:51:52 +0200
Message-Id: <20180801165021.393705242@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
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

From: Suman Anna <s-anna@ti.com>

[ Upstream commit b7e1e6859fbf60519fd82d7120cee106a6019512 ]

The OMAP3 ISP driver manages its MMU mappings through the IOMMU-aware
ARM DMA backend. The current code creates a dma_iommu_mapping and
attaches this to the ISP device, but never detaches the mapping in
either the probe failure paths or the driver remove path resulting
in an unbalanced mapping refcount and a memory leak. Fix this properly.

Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Suman Anna <s-anna@ti.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/omap3isp/isp.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -1945,6 +1945,7 @@ error_csi2:
 
 static void isp_detach_iommu(struct isp_device *isp)
 {
+	arm_iommu_detach_device(isp->dev);
 	arm_iommu_release_mapping(isp->mapping);
 	isp->mapping = NULL;
 }
@@ -1961,8 +1962,7 @@ static int isp_attach_iommu(struct isp_d
 	mapping = arm_iommu_create_mapping(&platform_bus_type, SZ_1G, SZ_2G);
 	if (IS_ERR(mapping)) {
 		dev_err(isp->dev, "failed to create ARM IOMMU mapping\n");
-		ret = PTR_ERR(mapping);
-		goto error;
+		return PTR_ERR(mapping);
 	}
 
 	isp->mapping = mapping;
@@ -1977,7 +1977,8 @@ static int isp_attach_iommu(struct isp_d
 	return 0;
 
 error:
-	isp_detach_iommu(isp);
+	arm_iommu_release_mapping(isp->mapping);
+	isp->mapping = NULL;
 	return ret;
 }
 


