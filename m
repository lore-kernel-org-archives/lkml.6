Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 22CFCC5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 16:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50EA208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 16:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50EA208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933953AbeFKQxw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 12:53:52 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:54614 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933911AbeFKQxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:53:51 -0400
Received: from localhost.localdomain ([77.136.205.128])
        by mwinf5d63 with ME
        id xUtj1x0072mkQqM03UtjM5; Mon, 11 Jun 2018 18:53:47 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 11 Jun 2018 18:53:47 +0200
X-ME-IP: 77.136.205.128
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     weiyongjun1@huawei.com, narmstrong@baylibre.com, airlied@linux.ie,
        carlo@caione.org, khilman@baylibre.com
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/meson: Fix an un-handled error path in 'meson_drv_bind_master()'
Date:   Mon, 11 Jun 2018 18:53:35 +0200
Message-Id: <20180611165335.24542-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
X-Antivirus: Avast (VPS 180611-4, 11/06/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'platform_get_resource_byname()' fails, we should release some resources
before leaving, as already done in the other error handling path of the
function.

Fixes: acaa3f13b8dd ("drm/meson: Fix potential NULL dereference in meson_drv_bind_master()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/meson/meson_drv.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 32b1a6cdecfc..d3443125e661 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -197,8 +197,10 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	priv->io_base = regs;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hhi");
-	if (!res)
-		return -EINVAL;
+	if (!res) {
+		ret = -EINVAL;
+		goto free_drm;
+	}
 	/* Simply ioremap since it may be a shared register zone */
 	regs = devm_ioremap(dev, res->start, resource_size(res));
 	if (!regs) {
@@ -215,8 +217,10 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmc");
-	if (!res)
-		return -EINVAL;
+	if (!res) {
+		ret = -EINVAL;
+		goto free_drm;
+	}
 	/* Simply ioremap since it may be a shared register zone */
 	regs = devm_ioremap(dev, res->start, resource_size(res));
 	if (!regs) {
-- 
2.17.0

