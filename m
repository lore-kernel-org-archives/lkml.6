Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209A3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC800213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ2gIX8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC800213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbeK2RF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:05:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbeK2RF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:05:26 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81B72208E7;
        Thu, 29 Nov 2018 06:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471275;
        bh=g2E1mk+26LITvAc+2YethgO8nWF9U2fiBQBjh6NL/+A=;
        h=From:To:Cc:Subject:Date:From;
        b=nJ2gIX8IzA9fF7wGLSvpVXMSF+pAricJ7EO30GWvCH371uOveqQoijYcYOdx2i1lO
         5rpOSNkaTA9gw12pE25E6YR9kM1brSJk8ebgMhv0QhJVcjCHcfI/ZDO39JmzeZ3fb4
         6q5Jb4TlqGzvIfn774Ndz+kgxIOe2wAY1z+i46wU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 01/35] media: omap3isp: Unregister media device as first
Date:   Thu, 29 Nov 2018 01:00:35 -0500
Message-Id: <20181129060110.159878-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 30efae3d789cd0714ef795545a46749236e29558 ]

While there are issues related to object lifetime management, unregister the
media device first when the driver is being unbound. This is slightly
safer.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/omap3isp/isp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index 6e6e978263b0..c834fea5f9b0 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -1592,6 +1592,8 @@ static void isp_pm_complete(struct device *dev)
 
 static void isp_unregister_entities(struct isp_device *isp)
 {
+	media_device_unregister(&isp->media_dev);
+
 	omap3isp_csi2_unregister_entities(&isp->isp_csi2a);
 	omap3isp_ccp2_unregister_entities(&isp->isp_ccp2);
 	omap3isp_ccdc_unregister_entities(&isp->isp_ccdc);
@@ -1602,7 +1604,6 @@ static void isp_unregister_entities(struct isp_device *isp)
 	omap3isp_stat_unregister_entities(&isp->isp_hist);
 
 	v4l2_device_unregister(&isp->v4l2_dev);
-	media_device_unregister(&isp->media_dev);
 	media_device_cleanup(&isp->media_dev);
 }
 
-- 
2.17.1

