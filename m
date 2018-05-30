Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbeE3VZt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:25:49 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60071 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932268AbeE3VZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:25:47 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pxa, regulator: fix building ezx e680
Date: Wed, 30 May 2018 23:24:58 +0200
Message-Id: <20180530212514.346474-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:c64zjEeWf5mPbFEaRNaX97f8o3RjnKVIIy+lRzqiYu1CDZ8l83E
 qGZMCi5hSVZxHsun9HUx8M8EOYw4zwST/VKPjSFHE7Si4ZoJ3uxei0yCTrQqRami0P9mMAD
 m7igQbJA06uriNJxbkbN3Sy4VwZuUr3MJqCiCdEs/+8YFHAlzQhRkLTsf7OTZwabmAgFvZZ
 bUoMCdsgHr5s2Ht51otaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4NP1JBFWlGc=:L+YqZ5HScOBkz+TjWcRvFL
 CcFtztMocI9rEvmp4nT4EodiOce8rPAW5SbregFm4e6TaV3rOYCEsxPP+94D1V/3oJC7WMa0Q
 93VOhBGV5ZM4S+ARwM1MGJzLkBiP3NsCT3HNP3BsGTIg61BDZu9mAu6i7s2PwDoy5Yat8gUFU
 REtybwO2P3NLgjvlP74rwsB25VQ1xedfv71ORAYyExq46cp8vgBRPVBb2rTdhBV4qF7qW891A
 NsPtrSWNq7UL1SeVI3gp/kPTTeIxc8nx6/cfze/+NWu2XbZ3873S0uev/OpEQ6kvDqJPqbcdU
 gi7FSYwfnxipRjfE0ozanQ0gryIViJt5czbPxjYWD3esi4W9PwaS7DrBB3sEWQ1o/WDFOZwVl
 iiRzAINYyTGdXOmXCtBMRitrOIsCDSULQQ2Z6z6CYojRQMOaouuErMYwZoK2bkq0kVlL/zImE
 4qwFdrscoSoLTyeAq4Juhq+1fgbLfrtncwKp7PsJE/7w9M9hTt8M+ByPeEW13fyCHOzBf5nVl
 lJd7Cw47APf17NRHcXd4qPbKWXg7Mt0dxbmHvykz0Zz0zJkc+yKu/IDUaFz3VBKfyKQKWii8w
 3Qd+imw43WgBsZYIZtIGr4Y0K2Fs8QFgl68xZmlLaIySWb+6VAG6w99NJyS/6RhladNQoN4Nl
 Bm81uRBcUu7Q2Q9CHcp0dwZkTx1zi2tZV0/HZsJZC7OhwR8Lv53yiQFZ5F91KBiE/Mxg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference to camera_supply_gpiod_table was added in the wrong function,
as observed from this randconfig build failure:

arch/arm/mach-pxa/ezx.c: In function 'e680_init':
arch/arm/mach-pxa/ezx.c:905:26: error: 'camera_supply_gpiod_table' undeclared (first use in this function)
  gpiod_add_lookup_table(&camera_supply_gpiod_table);

Fixes: 6059577cb28d ("regulator: fixed: Convert to use GPIO descriptor only")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/ezx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 2b4bd6d94855..4f33eea73f9a 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -902,7 +902,6 @@ static void __init e680_init(void)
 
 	pxa_set_keypad_info(&e680_keypad_platform_data);
 
-	gpiod_add_lookup_table(&camera_supply_gpiod_table);
 	pwm_add_table(ezx_pwm_lookup, ARRAY_SIZE(ezx_pwm_lookup));
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(e680_devices));
@@ -1132,6 +1131,7 @@ static void __init a910_init(void)
 	if (a910_camera_init() == 0)
 		pxa_set_camera_info(&a910_pxacamera_platform_data);
 
+	gpiod_add_lookup_table(&camera_supply_gpiod_table);
 	pwm_add_table(ezx_pwm_lookup, ARRAY_SIZE(ezx_pwm_lookup));
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(a910_devices));
-- 
2.9.0
