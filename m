Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754772AbeBGVLm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 16:11:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754531AbeBGVLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 16:11:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6CF217B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=kbingham@kernel.org
From: Kieran Bingham <kbingham@kernel.org>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] media: i2c: adv748x: Fix cleanup jump on chip identification
Date: Wed,  7 Feb 2018 21:11:35 +0000
Message-Id: <1518037895-10921-1-git-send-email-kbingham@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

The error handling for the adv748x_identify_chip() call erroneously
jumps to the err_cleanup_clients label before the clients have been
established.

Correct this by jumping to the next (and correct) label in the cleanup
code: err_cleanup_dt.

Fixes: 3e89586a64df ("media: i2c: adv748x: add adv748x driver")

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/i2c/adv748x/adv748x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/adv748x/adv748x-core.c b/drivers/media/i2c/adv748x/adv748x-core.c
index 6d62b817ed00..6ccaad7e9eca 100644
--- a/drivers/media/i2c/adv748x/adv748x-core.c
+++ b/drivers/media/i2c/adv748x/adv748x-core.c
@@ -651,7 +651,7 @@ static int adv748x_probe(struct i2c_client *client,
 	ret = adv748x_identify_chip(state);
 	if (ret) {
 		adv_err(state, "Failed to identify chip");
-		goto err_cleanup_clients;
+		goto err_cleanup_dt;
 	}
 
 	/* Configure remaining pages as I2C clients with regmap access */
-- 
2.7.4
