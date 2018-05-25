Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967050AbeEYPfe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:35:34 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53991 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964823AbeEYPfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:35:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Quentin Schulz <quentin.schulz@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: sun4i-gpadc: select REGMAP_IRQ
Date: Fri, 25 May 2018 17:34:23 +0200
Message-Id: <20180525153451.3164970-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:pf+DpC+2VVNcYBJE5bLedG1UeFj9+burEl27fLrQWhwNElLuMWk
 rG/YGCLe1gOSt0CNYcbfxUCq3/E5FnPAZ6VF02aDeH4oZmUiCkXjXrgT0Zp6jwSREDZh41E
 PDTbLSxw/fEEoWwGwPnl6f7zyQazkSoVSBpQ0nxRhuqzzA+VYyuMPiD8QGhZRFxIZ37ShhL
 r4rmZWho+qEqmR7n4TkIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OMGm2bA05a0=:C4zON3c8IRgF0WCdQZ/WUB
 bR1Piw7ebAUULa7EVLn8nIrhNtoKKrfGcep4h/sYu5gIR+UTOnMtLb/P+Kfuqdjr+iF4tKU6j
 HqXdN8Y6nol3XH83ksD2ED/WZ45QvpgM5vkmdOvQWRVzNh0OhaVPuUNAhTbliEU29W9OSnI8P
 4t4BaUROb/cIZOaAyua65nBcQsPes4v5ipfIx8zLnTOjwzKHTyc6ThBSMcDx6OL48/28Hbh7l
 3oW62ZM3YToyVrvxJzGDSpXez8HtCUzVumbPdhRzoBRR+dAAhG4BmpaZwZURJfTHCH5dlBlJG
 KEghPVSkvmd/ogLAIcxvKb0Ldp0ju6jwyWTWy7Vg7yviXKCcEQqzEK7FNMre+ZYACB+PMP8V0
 VU7OzjbxbZMuziCCMA1CNP3DuPgn8f4QLzCqcNSACZLqe5ORePJ7itze/tYMdAkx5mPbjPFcV
 T0p4xj1+AaiEBps2w1vu5H4Ap+G0Fb5HMlLO23CNmW1+CPsq16Qo46CUgcfrLFJbm4sOeNoJN
 UOj4kpn1410a6UI3FBKGU5vYyYEEQliluuturJgtBA/hWU+Vfq3AtZL6JGTdPNTTPrMB05DOy
 k0d0Z5bBVtojkYWWbogswjigdWeldeSA9N2WH9Ipt6N00hnrEIPx2Z39iXpObjdLAghVotQ12
 wDiqqZEcDsK65pHkzfRZ9NsUQcGPs0NiSp2SWuhDtDYBxYkx9dCjiyLNrk2DsvZtbKwY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't call regmap_irq_get_virq() unless the regmap-irq support
is enabled:

drivers/iio/adc/sun4i-gpadc-iio.o: In function `sun4i_irq_init':
sun4i-gpadc-iio.c:(.text+0x59c): undefined reference to `regmap_irq_get_virq'

I came across this in a randconfig build now, but I guess this is
a much older problem that I simply never hit before because regmap_irq
is usually enabled by one of the other drivers that need it.

Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 9da79070357c..13922b595503 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -717,6 +717,7 @@ config SUN4I_GPADC
 	depends on IIO
 	depends on MFD_SUN4I_GPADC || MACH_SUN8I
 	depends on THERMAL || !THERMAL_OF
+	select REGMAP_IRQ
 	help
 	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
 	  GPADC. This ADC provides 4 channels which can be used as an ADC or as
-- 
2.9.0
