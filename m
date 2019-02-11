Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D453C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D35C20700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895955;
	bh=8ZCND/XGu6emcmHSkKv/LMP4NPESzn2MTs4xcsdepqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nRf2UZ2nIl4NACfpURMapp3iFemuEEnu7qDvcrJcaLk+/Bp+ZUS3Q6zJ1IWHxl8Jc
	 P+Wp0LJ2NC5R+rI0SuOvawRqVfhGRZrKmAidTx4tZapnj3ihQbKj3kYarVyF/DESJr
	 EYixFI2hdUct0gIihKdINcxOeqCEvQ04UHwVcQyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbfBKOjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:39:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731348AbfBKOjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:39:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E20882054F;
        Mon, 11 Feb 2019 14:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895950;
        bh=8ZCND/XGu6emcmHSkKv/LMP4NPESzn2MTs4xcsdepqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Myu51RazwuMjnBjDF4MHj+apqJSOHxzNVZLKJ5J431BXEi3NOrLQatMk64zN1Sj+
         AH3qqocFVLcqyQp0aHy5Afc8ixaNohRgHXLlu9ZFbbcPpsBqygnG61eSn9j666LlqK
         9P0y97ZfC21r2+jv8Z3N4RX6jmSIRztkDc5tjQC8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 004/313] drm/vgem: Fix vgem_init to get drm device available.
Date:   Mon, 11 Feb 2019 15:14:44 +0100
Message-Id: <20190211141853.073070486@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d5c04dff24870ef07ce6453a3f4e1ffd9cf88d27 ]

Modify vgem_init to take platform dev as parent in drm_dev_init.
This will make drm device available at "/sys/devices/platform/vgem"
in x86 chromebook.

v2: rebase, address checkpatch typo and line over 80 characters

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20181023163550.15211-1-emil.l.velikov@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vgem/vgem_drv.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index 0e5620f76ee0..6887db878b38 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -471,31 +471,31 @@ static int __init vgem_init(void)
 	if (!vgem_device)
 		return -ENOMEM;
 
-	ret = drm_dev_init(&vgem_device->drm, &vgem_driver, NULL);
-	if (ret)
-		goto out_free;
-
 	vgem_device->platform =
 		platform_device_register_simple("vgem", -1, NULL, 0);
 	if (IS_ERR(vgem_device->platform)) {
 		ret = PTR_ERR(vgem_device->platform);
-		goto out_fini;
+		goto out_free;
 	}
 
 	dma_coerce_mask_and_coherent(&vgem_device->platform->dev,
 				     DMA_BIT_MASK(64));
+	ret = drm_dev_init(&vgem_device->drm, &vgem_driver,
+			   &vgem_device->platform->dev);
+	if (ret)
+		goto out_unregister;
 
 	/* Final step: expose the device/driver to userspace */
 	ret  = drm_dev_register(&vgem_device->drm, 0);
 	if (ret)
-		goto out_unregister;
+		goto out_fini;
 
 	return 0;
 
-out_unregister:
-	platform_device_unregister(vgem_device->platform);
 out_fini:
 	drm_dev_fini(&vgem_device->drm);
+out_unregister:
+	platform_device_unregister(vgem_device->platform);
 out_free:
 	kfree(vgem_device);
 	return ret;
-- 
2.19.1



