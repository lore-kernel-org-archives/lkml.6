Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CBFC71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 11:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1792098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 11:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1792098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeJMSdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 14:33:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52806 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeJMSdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 14:33:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id AFC54260B2D
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     David Airlie <airlied@linux.ie>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] drm/rockchip: psr: do not dereference encoder before it is null checked.
Date:   Sat, 13 Oct 2018 12:56:54 +0200
Message-Id: <20181013105654.11827-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'encoder' is deferenced before it is null sanity checked, hence we
potentially have a null pointer dereference bug. Instead, initialise
drm_drv from encoder->dev->dev_private after we are sure 'encoder' is
not null.

Fixes: 5182c1a556d7f ("drm/rockchip: add an common abstracted PSR driver")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index 1635485955d3..22a70ab6e214 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -226,12 +226,14 @@ EXPORT_SYMBOL(rockchip_drm_psr_flush_all);
 int rockchip_drm_psr_register(struct drm_encoder *encoder,
 			int (*psr_set)(struct drm_encoder *, bool enable))
 {
-	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
+	struct rockchip_drm_private *drm_drv;
 	struct psr_drv *psr;
 
 	if (!encoder || !psr_set)
 		return -EINVAL;
 
+	drm_drv = encoder->dev->dev_private;
+
 	psr = kzalloc(sizeof(struct psr_drv), GFP_KERNEL);
 	if (!psr)
 		return -ENOMEM;
-- 
2.19.1

