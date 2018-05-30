Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932462AbeE3Vwc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:52:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:53731 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeE3Vwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:52:30 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "David S. Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-gpio@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: ti: cpsw: include gpio/consumer.h
Date: Wed, 30 May 2018 23:51:54 +0200
Message-Id: <20180530215212.1151415-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:VyW7q19B8esGnkW2ldhvzK7x/JoYgcUdgTuPryv9wT+m27vIc6U
 AaDoLgodhrfnl1fGTk9a/XhE5+v1xEvujMxvCcEyfZw77Y1Ktp4cdMfYSMRVQSkqMm7769w
 V2bxR2BLVd+7T5GpPf6i+7osZW/b5LRkPVZIf9Qu5FIcW0odZQ2gM20i08WAGrihPAzkiXo
 lOEoI0j+PVx7RWBkxIqfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yPMVF2pMrDA=:7W0RkLDHqw+b0BHeYbhFxU
 MBxi1FiwBGy7hU5xrYP9YI/DBpYsrMtsjbtKPk9mGyzRgABSWj3qM7Ln28wQ0A8mjHj+fptdN
 8FPCtrS3ZrZTvApRISSvaw61akMjxnS7pDY3KyWZ3M8sOn4GUA0i1TfUefmGBci3Cb7RmpWhs
 eahqtzdEvYfdWty/ihUplfpJ6QBt+92DNWfDSGdn4keCNeU+FfEl6ap76nVLm76zO1X7yYTU4
 UwzE80KUsl4IBgzDpAemya4gdTc6x2wN4I+C3MAi4Gy+6pBoAU7IGxXl/TgeIyOgp6kXqJwPO
 vtqAqSsFjfmtdt8JNGpEFJ8ESooBZSZ7izxOYPH9XxBcUTvRghBs8DrowEoh9rVUPCs7lkgfs
 3i4V/PlJzW4Y7D7gh7qhpNx7wl+1HmHiPLxLA3Oh7Bd2/0STFizeLMpu5O0xzSzV4SbfxEG+R
 mLAW7XYMHeh/DekpMQsDtv2MlQ52qQ/0DksR5xomIwkPBzoBE39bN6BFsZ0z2r65QVp/NP16G
 0NpLKUCdEV8TJ34pUQkKKhRXQqC/IQLZRRlesBehbufT5O5f7tib2u8XK5fQz+Cm534K8xtlQ
 AeUwaL880nCTColT9UYJvQQpaaOLMSnLvJrRQWO48XXQIE7pJ2sTDGoZnYXf96beVY9HLSU74
 xss1Ajuisv4WLWoekmUNI8kacbi7Rli/0CQCPkeLTraDb+nPkoA+29qQ26nh1xQuEmXc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms that don't always enable CONFIG_GPIOLIB, we run into
a build failure:

drivers/net/ethernet/ti/cpsw.c: In function 'cpsw_probe':
drivers/net/ethernet/ti/cpsw.c:3006:9: error: implicit declaration of function 'devm_gpiod_get_array_optional' [-Werror=implicit-function-declaration]
  mode = devm_gpiod_get_array_optional(&pdev->dev, "mode", GPIOD_OUT_LOW);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/ti/cpsw.c:3006:59: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
  mode = devm_gpiod_get_array_optional(&pdev->dev, "mode", GPIOD_OUT_LOW);

Since we cannot rely on this to be visible from gpio.h, we have to include
gpio/consumer.h directly.

Fixes: 2652113ff043 ("net: ethernet: ti: Allow most drivers with COMPILE_TEST")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/ti/cpsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 643cd2d9dfb6..534596ce00d3 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -29,7 +29,7 @@
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
-- 
2.9.0
