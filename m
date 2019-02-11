Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F253AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE68C20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549894865;
	bh=kS3XJ9se4IjeX7P+syNaFpmpj6AtaHgO0KH1P7StpTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dbrgabWRvNmn7S7P0jo2hZTNIhM6qOnxo/iUSLidz/M4f9JKMzNJ0Fm2zugOdFvKm
	 QIbQE0STxcoxF0ELMgFQ/ROhOOReRByMxLWoA8PVNUlsP9fi7Rmp8/Sfkq7Iil2z/A
	 g97aJzBtz9SgddmHC0SNlbo5ZBjLOhsTvqqJ7qlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfBKOVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:21:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728389AbfBKOVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:21:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0171A2073F;
        Mon, 11 Feb 2019 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894860;
        bh=kS3XJ9se4IjeX7P+syNaFpmpj6AtaHgO0KH1P7StpTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oY521As6xjr6LSYl6hIdgGAM7Yk8eXaoSIQ8gvEAlGX2rr9WUhWd2Kq+cXOyL7rq2
         BuIqIhP29mwGp2Gp+Pkm/wr8fPvoyZNaozHbEZLA7He5syOBJvv9wfTrCnCV1iBA0I
         xEXn10SkcD1XJmSUMgHdEyIfvP7fJH3g+/8J4UXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 004/352] drm/vgem: Fix vgem_init to get drm device available.
Date:   Mon, 11 Feb 2019 15:13:51 +0100
Message-Id: <20190211141846.783223749@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index ec6af8b920da..f1f7ab9dcdbf 100644
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



