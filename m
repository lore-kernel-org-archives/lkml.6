Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755006AbeCRWtB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 18:49:01 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:39530 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754706AbeCRWs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 18:48:59 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Mar 2018 23:48:58 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: maxime.ripard@free-electrons.com, airlied@linux.ie, wens@csie.org
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] drm/sun4i: hdmi: Fix an error handling path in 'sun4i_hdmi_bind()'
Date: Sun, 18 Mar 2018 23:48:09 +0100
Message-Id: <14c42391e1b562c7495bda6ad6fa1d24ec8dc052.1521413031.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we can not allocate the HDMI encoder regmap, we still need to free some
resources before returning.

Fixes: 4b1c924b1fc1 ("drm/sun4i: hdmi: create a regmap for later use")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 500b6fb3e028..d2839727bb0b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -538,7 +538,8 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 					     &sun4i_hdmi_regmap_config);
 	if (IS_ERR(hdmi->regmap)) {
 		dev_err(dev, "Couldn't create HDMI encoder regmap\n");
-		return PTR_ERR(hdmi->regmap);
+		ret = PTR_ERR(hdmi->regmap);
+		goto err_disable_mod_clk;
 	}
 
 	ret = sun4i_tmds_create(hdmi);
-- 
2.14.1
