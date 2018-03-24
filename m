Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeCXLTS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 07:19:18 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44586 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbeCXLTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 07:19:17 -0400
X-Google-Smtp-Source: AG47ELvqFZXcSgUkSK8mvGjn+eV8eND6pJ7AFi5TIAM7vcGYHsfvtu+dUbcfrA0i0/4JH5Qz1D6BOg==
Date: Sat, 24 Mar 2018 16:48:20 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: dwmw2@infradead.org
Cc: Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: devices: check mtd_device_register() return code
Message-ID: <20180324111820.GA1997@seema-Inspiron-15-3567>
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
index 7bc29d7..4a99a6a 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -2125,7 +2125,13 @@ static int stfsm_probe(struct platform_device *pdev)
 		(long long)fsm->mtd.size, (long long)(fsm->mtd.size >> 20),
 		fsm->mtd.erasesize, (fsm->mtd.erasesize >> 10));
 
-	return mtd_device_register(&fsm->mtd, NULL, 0);
+	ret = mtd_device_register(&fsm->mtd, NULL, 0);
+	if (ret) {
+		pr_err("Failed to register device\n");
+		goto err_clk_unprepare;
+	}
+
+	return 0;
 
 err_clk_unprepare:
 	clk_disable_unprepare(fsm->clk);
-- 
2.7.4
