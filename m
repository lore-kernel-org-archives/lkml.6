Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AC2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F823218A5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151286;
	bh=hnKGnV5MQDsOv4ePtnKlc1/Hfeuo64rECF3DFjHMFDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WuqqzQMiCZpO1c+Dq9r68fyYcryLILmCJvRtL7hZqrstQGJlY8e2XaPQ1LdxyZqpQ
	 eY7Mo2nTjgzIA30YcEepSmyz7luaMBHbWfI3vYF3XtChZK1dBV5woRJ15RRpSpEFqd
	 fP5igCuIy87K+V8NBSX3VPlrKJQddWTP1GMghGWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeLRQlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:41:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbeLRQlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:41:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DACD21873;
        Tue, 18 Dec 2018 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151281;
        bh=hnKGnV5MQDsOv4ePtnKlc1/Hfeuo64rECF3DFjHMFDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlmAyBAoEWmJ7vXKGIX0wKc2zrOcVh2R5E7cVU77zzPqI1k0DpOAEAyYdySXrjC2P
         MtQexyBdG8Nvy8+9HSOTO6/VqA+tHbA52m0o1CUfDSZK6s2FBDA5q34M733VdGCSUG
         oc4wzEhsTQ2ghAZFQQENInlXAmSDVkmo+t+cpLrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 4.19 35/44] Revert "drm/rockchip: Allow driver to be shutdown on reboot/kexec"
Date:   Tue, 18 Dec 2018 17:39:47 +0100
Message-Id: <20181218163931.565097667@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

From: Brian Norris <briannorris@chromium.org>

commit 63238173b2faf3d6b85a416f1c69af6c7be2413f upstream.

This reverts commit 7f3ef5dedb146e3d5063b6845781ad1bb59b92b5.

It causes new warnings [1] on shutdown when running the Google Kevin or
Scarlet (RK3399) boards under Chrome OS. Presumably our usage of DRM is
different than what Marc and Heiko test.

We're looking at a different approach (e.g., [2]) to replace this, but
IMO the revert should be taken first, as it already propagated to
-stable.

[1] Report here:
http://lkml.kernel.org/lkml/20181205030127.GA200921@google.com

WARNING: CPU: 4 PID: 2035 at drivers/gpu/drm/drm_mode_config.c:477 drm_mode_config_cleanup+0x1c4/0x294
...
 Call trace:
  drm_mode_config_cleanup+0x1c4/0x294
  rockchip_drm_unbind+0x4c/0x8c
  component_master_del+0x88/0xb8
  rockchip_drm_platform_remove+0x2c/0x44
  rockchip_drm_platform_shutdown+0x20/0x2c
  platform_drv_shutdown+0x2c/0x38
  device_shutdown+0x164/0x1b8
  kernel_restart_prepare+0x40/0x48
  kernel_restart+0x20/0x68
...
 Memory manager not clean during takedown.
 WARNING: CPU: 4 PID: 2035 at drivers/gpu/drm/drm_mm.c:950 drm_mm_takedown+0x34/0x44
...
  drm_mm_takedown+0x34/0x44
  rockchip_drm_unbind+0x64/0x8c
  component_master_del+0x88/0xb8
  rockchip_drm_platform_remove+0x2c/0x44
  rockchip_drm_platform_shutdown+0x20/0x2c
  platform_drv_shutdown+0x2c/0x38
  device_shutdown+0x164/0x1b8
  kernel_restart_prepare+0x40/0x48
  kernel_restart+0x20/0x68
...

[2] https://patchwork.kernel.org/patch/10556151/
    https://www.spinics.net/lists/linux-rockchip/msg21342.html
    [PATCH] drm/rockchip: shutdown drm subsystem on shutdown

Fixes: 7f3ef5dedb14 ("drm/rockchip: Allow driver to be shutdown on reboot/kexec")
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Vicente Bergas <vicencb@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: stable@vger.kernel.org
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20181205181657.177703-1-briannorris@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -442,11 +442,6 @@ static int rockchip_drm_platform_remove(
 	return 0;
 }
 
-static void rockchip_drm_platform_shutdown(struct platform_device *pdev)
-{
-	rockchip_drm_platform_remove(pdev);
-}
-
 static const struct of_device_id rockchip_drm_dt_ids[] = {
 	{ .compatible = "rockchip,display-subsystem", },
 	{ /* sentinel */ },
@@ -456,7 +451,6 @@ MODULE_DEVICE_TABLE(of, rockchip_drm_dt_
 static struct platform_driver rockchip_drm_platform_driver = {
 	.probe = rockchip_drm_platform_probe,
 	.remove = rockchip_drm_platform_remove,
-	.shutdown = rockchip_drm_platform_shutdown,
 	.driver = {
 		.name = "rockchip-drm",
 		.of_match_table = rockchip_drm_dt_ids,


