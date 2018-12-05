Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA0DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF39A20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O7BtN5y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF39A20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeLESRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:17:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33676 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeLESRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:17:08 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so9396711pgu.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6vMht8+Ph9JHpETTWF5GW6LB5/gngb0kDvS5i0Ablh0=;
        b=O7BtN5y/jc8pG7n9rlH2yavCcgsXRlYXvkH6x6VfMOtfIbvE4IRjaJ6DgW625xSZ5C
         AsnvmXyNeDYZFKuYvJgpFykWxavJi7lf5tozQfx57/YlBTXQeNdSSw6Jk9aC5j+Ea/Ki
         OtgbIbl6TLsEJpDi9q/yYjUsoxJtLVFtpvIb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6vMht8+Ph9JHpETTWF5GW6LB5/gngb0kDvS5i0Ablh0=;
        b=PVpv/zNpSpf+U0Tk/XQFQ+Rq3Qao1SlMNBVsOTN5jUzNk7PCav4C4UDX1yqMDsKU0T
         CnDyjqjlBF/eEyGDz2F/K7KTsPV5qRqlN7BSiDbzpaeG9NYHArkW+tOyQgwwZrtHSXez
         lHtkqFigaEuaj3meSbeUSlz7w56i0yLBmxzFxq+P3nFniUeCh2H5b1ZJQjIQ+m+9chO/
         GlV63PlY7umQZaTOqvleJ94MbcafLCCvV9Xl6UutvJQk3AnX7xT0JnEI4ZiOvLrexjIu
         k1d2UHz20v+G4aYb9Xl0+UK/efKBw3TmnPhfOWVVTbTrwx84OaQ1GvyCJjuedUpO3vUm
         Hdrg==
X-Gm-Message-State: AA+aEWYvft/IPde9g8aLmgJfsEeVt3WWMq0H+p3ZIkm8bDk0msiBZyGY
        iPSvrlvYYJR8+iFAXpvaXGP7VQ==
X-Google-Smtp-Source: AFSGD/UNOuP1DFWZAhtStiObktfOGcOAV8B2mnfuBvwmMAPxs4uJYKeyjgD7750wF4j4ydZKruQcaA==
X-Received: by 2002:a65:610d:: with SMTP id z13mr21601439pgu.427.1544033827360;
        Wed, 05 Dec 2018 10:17:07 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id w88sm21061483pfk.11.2018.12.05.10.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:17:05 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>
Cc:     dri-devel@lists.freedesktop.org,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sean Paul <seanpaul@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>, stable@vger.kernel.org
Subject: [PATCH for-4.20] Revert "drm/rockchip: Allow driver to be shutdown on reboot/kexec"
Date:   Wed,  5 Dec 2018 10:16:57 -0800
Message-Id: <20181205181657.177703-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 941f35233b1f..5864cb452c5c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -448,11 +448,6 @@ static int rockchip_drm_platform_remove(struct platform_device *pdev)
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
@@ -462,7 +457,6 @@ MODULE_DEVICE_TABLE(of, rockchip_drm_dt_ids);
 static struct platform_driver rockchip_drm_platform_driver = {
 	.probe = rockchip_drm_platform_probe,
 	.remove = rockchip_drm_platform_remove,
-	.shutdown = rockchip_drm_platform_shutdown,
 	.driver = {
 		.name = "rockchip-drm",
 		.of_match_table = rockchip_drm_dt_ids,
-- 
2.20.0.rc1.387.gf8505762e3-goog

