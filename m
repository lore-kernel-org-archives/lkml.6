Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7974FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B9B218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbeLSLwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:52:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729432AbeLSLvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:51:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7AF575277B;
        Wed, 19 Dec 2018 11:51:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 123BA17DC3;
        Wed, 19 Dec 2018 11:51:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 915EC541DD; Wed, 19 Dec 2018 12:51:29 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 12/14] drm/bochs: switch to generic drm fbdev emulation
Date:   Wed, 19 Dec 2018 12:51:25 +0100
Message-Id: <20181219115127.31359-13-kraxel@redhat.com>
In-Reply-To: <20181219115127.31359-1-kraxel@redhat.com>
References: <20181219115127.31359-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 19 Dec 2018 11:51:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index a9c7140e3b..f1f65324bb 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -27,7 +27,6 @@ static void bochs_unload(struct drm_device *dev)
 {
 	struct bochs_device *bochs = dev->dev_private;
 
-	bochs_fbdev_fini(bochs);
 	bochs_kms_fini(bochs);
 	bochs_mm_fini(bochs);
 	bochs_hw_fini(dev);
@@ -58,9 +57,6 @@ static int bochs_load(struct drm_device *dev)
 	if (ret)
 		goto err;
 
-	if (enable_fbdev)
-		bochs_fbdev_init(bochs);
-
 	return 0;
 
 err:
@@ -178,6 +174,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_unload;
 
+	drm_fbdev_generic_setup(dev, 32);
 	return ret;
 
 err_unload:
-- 
2.9.3

