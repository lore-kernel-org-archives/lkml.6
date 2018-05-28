Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034990AbeE1PuX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:50:23 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35589 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034914AbeE1PuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:50:17 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH, net-next] net: ethernet: freescale: fix false-positive string overflow warning
Date: Mon, 28 May 2018 17:49:46 +0200
Message-Id: <20180528154958.2684086-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:oiRpTflwG8qWTNHcqsccGwSsouw9oSGsXkiEPP06InkxR7rvH5d
 Zk8NlzfyPtdFJVaXApXdNSh+eQx2xUECQQo1l93JH31DxpFrcZdOhTCC6xTzhX8XuZTEKRf
 v/QAIwH2lweJjSdbVgQiKqqrDZdRORDw+3nIzTcEOvzUJmMP9sJuK4UplPquoBOHStxdD8m
 jaAfqxQffTbaxRo+6RsgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UnpHTsyLKj8=:pXkXjAWeCulxe8haz52UxO
 FZUzwfDBCMQaJn7Atb/C2wy1DTObwGcU9wxvTORIFm9pyN3hVeD0q+OvljuzOaLOgvVIdekVA
 0djzEdoPJast2fB9d13wy+Q4mwbI0xEkruaoto0ec7VsCB0mYRQlBaxIKiMRhqLRvFFJNr7Nc
 TJPBrvjAurmZR1ynxGkXEN68R5iSceWVPi1QeLe9hYy1gopKFDzumrEAl30J+ICVAGwiQcBtd
 uKK2uTUJ9CYVREfFi0XglGTtO26XZjjQBkEJmZNCON9YHAzCMP6B2HxA/2ZH/ZxyNjD3945yG
 f6mFsmSZwt+NmFvmeCtOyvPOh795y0iVe7bKwZJ0hCYMX609hzgZZoM/pa5BtwC9sbgP20Qok
 Z9eqt0mET7eQS50wcI7cxyxKXfq6iNIYmeGK2dllJGgAUbShbQEAKwVRzCDGvpFy6c+x3T5Dm
 YcftJhelCndtDShQPUWM2VVJ6AeCFxQxrzWKGaruwkbcnwuXxhzJtDlidSyP/DgRCSyBeQkN6
 l42wIyeInpZpAByD1WDgqCwgbWcWyhsOON3wKZSek0G7T59VfPJm7JrDY+g7s1VUzUc/qFW8+
 k01kYCX8ImWlxxBsl4l6XgqC0h2A6ntmgbcvcqNnN+W/vSnnzsGBHwmiyvx4sO7frcrOh1QvQ
 zId4lgs8W5mAzn+NrX4YhzGybZjl8piDyB/s7FkgInQ57fJKMA49qZ0dsg4kKKv0iYwk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While compile-testing on arm64 with gcc-8.1, I ran into a build diagnostic:

drivers/net/ethernet/freescale/fec_main.c: In function 'fec_probe':
drivers/net/ethernet/freescale/fec_main.c:3517:25: error: '%d' directive writing between 1 and 10 bytes into a region of size 5 [-Werror=format-overflow=]
   sprintf(irq_name, "int%d", i);
                         ^~
drivers/net/ethernet/freescale/fec_main.c:3517:21: note: directive argument in the range [0, 2147483646]
   sprintf(irq_name, "int%d", i);
                     ^~~~~~~
drivers/net/ethernet/freescale/fec_main.c:3517:3: note: 'sprintf' output between 5 and 14 bytes into a destination of size 8
   sprintf(irq_name, "int%d", i);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It appears this has never shown on ppc32 or arm32 for an unknown reason, but
now gcc fails to identify that the 'irq_cnt' loop index has an upper bound
of 3, and instead uses a bogus range.

To work around the warning, this changes the sprintf to snprintf with the
correct buffer length.

Fixes: 78cc6e7ef957 ("net: ethernet: freescale: Allow FEC with COMPILE_TEST")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index ab7521c04eb2..c729665107f5 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3514,7 +3514,7 @@ fec_probe(struct platform_device *pdev)
 		goto failed_init;
 
 	for (i = 0; i < irq_cnt; i++) {
-		sprintf(irq_name, "int%d", i);
+		snprintf(irq_name, sizeof(irq_name), "int%d", i);
 		irq = platform_get_irq_byname(pdev, irq_name);
 		if (irq < 0)
 			irq = platform_get_irq(pdev, i);
-- 
2.9.0
