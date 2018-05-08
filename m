Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754193AbeEHGOR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 02:14:17 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:52330 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754024AbeEHGOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 02:14:15 -0400
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 08 May 2018 08:14:14 +0200
X-ME-IP: 86.244.116.1
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: tharvey@gateworks.com, mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] media: i2c: tda1997: Fix an error handling path 'tda1997x_probe()'
Date: Tue,  8 May 2018 08:14:15 +0200
Message-Id: <20180508061415.10945-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'media_entity_pads_init()' fails, we must free the resources allocated
by 'v4l2_ctrl_handler_init()', as already done in the previous error
handling path.

'goto' the right label to fix it.

Fixes: 9ac0038db9a7 ("media: i2c: Add TDA1997x HDMI receiver driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/i2c/tda1997x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/tda1997x.c b/drivers/media/i2c/tda1997x.c
index 31bdab96f380..039a92c3294a 100644
--- a/drivers/media/i2c/tda1997x.c
+++ b/drivers/media/i2c/tda1997x.c
@@ -2723,7 +2723,7 @@ static int tda1997x_probe(struct i2c_client *client,
 		state->pads);
 	if (ret) {
 		v4l_err(client, "failed entity_init: %d", ret);
-		goto err_free_mutex;
+		goto err_free_handler;
 	}
 
 	ret = v4l2_async_register_subdev(sd);
-- 
2.17.0
