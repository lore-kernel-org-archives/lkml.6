Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95881C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB3020989
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543339;
	bh=bfLBEq7UWJoOLy2NWISd5Xw9CUSfcD9d54gEJW6ibl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q99BbXJr4MKerMSqiBhwy4y0Wqj90rekUVss04KteJexD4DcMZFIF6JjQbtS4N5NN
	 WhPlh79jyzwhyxfy6ahjj0KvsG7pIHww9d+lOxE/Ahca8KPHhepJi3zOz5s3IroOn/
	 BvfKQAnarEcqUfFSW4m3mTW7oEARhuccrID0h2QQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB3020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbeLKPs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:48:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbeLKPst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:48:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B555920870;
        Tue, 11 Dec 2018 15:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543329;
        bh=bfLBEq7UWJoOLy2NWISd5Xw9CUSfcD9d54gEJW6ibl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQ6hW/b/mKqXQvjxMqyYqWDa88ZTtfJQbQ1oASXSscQOqON7YVbR/pAZric4yXpUV
         RuqK91zrWw8q6+CSO7R2eLTa9AyiAzUVjZHlFq7kfBslzpbKIwCR0lJXYZHWLIsj41
         8RaBu1uzcWJMhWkKV9zJn5/n0eBnjQVC2VysB2TY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 01/51] media: omap3isp: Unregister media device as first
Date:   Tue, 11 Dec 2018 16:41:09 +0100
Message-Id: <20181211151612.471076044@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 1e98b4845ea1..a21b12c5c085 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -1591,6 +1591,8 @@ static void isp_pm_complete(struct device *dev)
 
 static void isp_unregister_entities(struct isp_device *isp)
 {
+	media_device_unregister(&isp->media_dev);
+
 	omap3isp_csi2_unregister_entities(&isp->isp_csi2a);
 	omap3isp_ccp2_unregister_entities(&isp->isp_ccp2);
 	omap3isp_ccdc_unregister_entities(&isp->isp_ccdc);
@@ -1601,7 +1603,6 @@ static void isp_unregister_entities(struct isp_device *isp)
 	omap3isp_stat_unregister_entities(&isp->isp_hist);
 
 	v4l2_device_unregister(&isp->v4l2_dev);
-	media_device_unregister(&isp->media_dev);
 	media_device_cleanup(&isp->media_dev);
 }
 
-- 
2.19.1



