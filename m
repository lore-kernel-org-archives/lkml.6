Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755022AbeCRWtE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 18:49:04 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:36996 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754904AbeCRWtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 18:49:01 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Mar 2018 23:49:00 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: maxime.ripard@free-electrons.com, airlied@linux.ie, wens@csie.org
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] drm/sun4i: hdmi: Fix another error handling path in 'sun4i_hdmi_bind()'
Date: Sun, 18 Mar 2018 23:48:10 +0100
Message-Id: <5e0084af4ad57e9eea3bca5bd8e2e95970cd6714.1521413031.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we can not get the HDMI DDC clock, we still need to free some
resources before returning.

Fixes: 939d749ad664 ("drm/sun4i: hdmi: Add support for controller hardware variants")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index d2839727bb0b..fa4bcd092eaf 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -552,7 +552,8 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 		hdmi->ddc_parent_clk = devm_clk_get(dev, "ddc");
 		if (IS_ERR(hdmi->ddc_parent_clk)) {
 			dev_err(dev, "Couldn't get the HDMI DDC clock\n");
-			return PTR_ERR(hdmi->ddc_parent_clk);
+			ret = PTR_ERR(hdmi->ddc_parent_clk);
+			goto err_disable_mod_clk;
 		}
 	} else {
 		hdmi->ddc_parent_clk = hdmi->tmds_clk;
-- 
2.14.1
