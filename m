Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbeCUFiG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 01:38:06 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35549 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeCUFiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 01:38:01 -0400
X-Google-Smtp-Source: AG47ELtvvgXyUBA9njkyvby+ASY/znRCUIh9ixheCtDR3kDgx63EoBpc1Rn/Lm+U0bXcd4F2AzyX0Q==
Date: Wed, 21 Mar 2018 11:07:09 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: dwmw2@infradead.org
Cc: Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: devices: check mtd_device_register() return code
Message-ID: <20180321053709.GA5611@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stfsm_probe() misses error handling of mtd_device_register().

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/mtd/devices/st_spi_fsm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 7bc29d7..e1aa4f8 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -2125,7 +2125,13 @@ static int stfsm_probe(struct platform_device *pdev)
 		(long long)fsm->mtd.size, (long long)(fsm->mtd.size >> 20),
 		fsm->mtd.erasesize, (fsm->mtd.erasesize >> 10));
 
-	return mtd_device_register(&fsm->mtd, NULL, 0);
+	ret = mtd_device_register(&fsm->mtd, NULL, 0);
+	if (ret) {
+		pr_err("Failed to register device\n");
+		return ret;
+	}
+
+	return 0;
 
 err_clk_unprepare:
 	clk_disable_unprepare(fsm->clk);
-- 
2.7.4
