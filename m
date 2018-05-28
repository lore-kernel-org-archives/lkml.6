Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035036AbeE1PvR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:51:17 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:49581 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034909AbeE1PvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:51:10 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Florian Fainelli <f.fainelli@gmail.com>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: davinci: fix building davinci mdio code without CONFIG_OF
Date: Mon, 28 May 2018 17:50:20 +0200
Message-Id: <20180528155059.2736080-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:laYbLfwtkFRugoloOA16dfhOo0aZWP/ZLkfgUgyWktElNUmlMnB
 Jj2ImGl805agh63By3fzBaC4CBiZKEJd3rjKAJ8smCUKIevSUgr4/1b/702vJ9ALGuPk2K3
 TI9uKN984Q61cFhojIZmUA+1dA1t2n6S7EUUM2VlDpQ8vAQBCFafa+SYe/nSOdqSpHDr2Fb
 9pEPBvcHK/12p0bzpqh6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DEd8Fye4Caw=:1Oc9WAhq36axtVZFjJkO6j
 hSC0hh7vrDjV4UAkGGdWqoEc3SN8q3qb7j+u3KCVzTsaztF9VHKOpAVOmcVMAMAYinY6HaGW7
 C1bJWZI3XI2SmFnaMdu0MaNlmaotXEHJxduBIpgMC1oIim78fjUqdk+/tMlJx9YuiMaOHtWdj
 PamLs4ccLZeTep5qCRdvBju8hGfv95jWmIEavJ1mnIdzcSGFij+UdIScRnR53rvkcEcYuxhmM
 9MSuuBPQ3T0hnZYaoBlWFo0Ki64GdI3/ausk7ywne0g03Sk/Fzjw+zv+S0Xdl2xlBdtiII1Ml
 BvBM05iqVNZLMQLICpbQd7vb9yb8Q9+FDt0F630sBW75XhlQ8KNlgLaLEpx5nltVgeCes2yYL
 mvp2xuhcvI2+XZU/kd3vHZzsX7wyQrpmdCd5VORi6DnnnDqZCmfdn4h3aPLCya72Bog8rRbuW
 JHiv/J8dQXxiespJhTIArafZi4g6mTuVNUkdQovdYgc37CutKJmFZYVKmg3R2YP3I4wF9jTr7
 7/cjH/fq4R5ra/sVgbpkNcGMa910pfpsXL1np77A/XnldvG+TqeAmGer5q8gb9QbzQyx4kPvc
 AxhCSqbUGTzlyY5LXiqRtbIi+xFqKDmzusSF2jpxHTRTZPk7eFhBGzolUv4B1r3LkTaQ9ubrH
 dLR2KTTeHRp8IZDXLbnDByQByk/QZFiR8OB5NzxIpEb+j0qwrwpBKMbFfy6Sm8ld2YuI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test-building this driver on targets without CONFIG_OF revealed a build
failure:

drivers/net/ethernet/ti/davinci_mdio.c: In function 'davinci_mdio_probe':
drivers/net/ethernet/ti/davinci_mdio.c:380:9: error: implicit declaration of function 'davinci_mdio_probe_dt'; did you mean 'davinci_mdio_probe'? [-Werror=implicit-function-declaration]

This adjusts the #ifdef logic in the driver to make it build in
all configurations.

Fixes: 2652113ff043 ("net: ethernet: ti: Allow most drivers with COMPILE_TEST")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/ti/davinci_mdio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 8ac72831af05..a98aedae1b41 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -321,7 +321,6 @@ static int davinci_mdio_write(struct mii_bus *bus, int phy_id,
 	return ret;
 }
 
-#if IS_ENABLED(CONFIG_OF)
 static int davinci_mdio_probe_dt(struct mdio_platform_data *data,
 			 struct platform_device *pdev)
 {
@@ -339,7 +338,6 @@ static int davinci_mdio_probe_dt(struct mdio_platform_data *data,
 
 	return 0;
 }
-#endif
 
 #if IS_ENABLED(CONFIG_OF)
 static const struct davinci_mdio_of_param of_cpsw_mdio_data = {
@@ -374,7 +372,7 @@ static int davinci_mdio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	if (dev->of_node) {
+	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
 		const struct of_device_id	*of_id;
 
 		ret = davinci_mdio_probe_dt(&data->pdata, pdev);
-- 
2.9.0
