Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967095AbeEYQFb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:05:31 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:46701 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966464AbeEYQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:05:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: stm32: enforce dependency on CONFIG_MFD_STM32_TIMERS
Date: Fri, 25 May 2018 18:04:54 +0200
Message-Id: <20180525160523.29124-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:M2xrlDLdXt09+g2kyzE9d+6Gzzat/0GLrqimLZYxRc/pDV40wZZ
 fhXOPPl4UkKKaeEiFR8PQsaHlbqKh0bPO+lthm9bGKhmHTd6swWIZDai+NEZxxbWKUvM4px
 v0v3evRMVd7xqVAjEYK7LmgMYIdok3Y3Pzyq5hspVnDCgNQHa+NQ6aNJTObJwmqLkw4kCgt
 k7tKJcwf+xjrCk+HwnPXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8e5cwQd1bLA=:PUHvJLfHfxElw4sTjv7lT5
 zFoOiCxz3Z0GD4afwm/ACV9u2r1WHP4Z0Pmg4ALfGnB0ZwJnfxlXDhTK45IgADi/9Gi0NbCBS
 4O2CO9kDZvUiYl0gsCC0g2vIlUF9NgfTdnzOo+5xAgUfsZi6qXWsvL1boGennwIQFILuYsbKI
 40oXkvpqzKBzQHzr+44E1Zr+IJ5dfj8sIhnbW3dkh7pc1JMYIqdk5kt4GB9SFtirTx+/AMchG
 1mxYRqgrYltRFnpJapvZ0N4AlAQW0Iu32eMqouoGwEVw8WriV6/mRJkGdD1esNO7kM/1H8Vza
 UrxBB3HyZ66vI/Yi2Ami7MM0q76M9pa2jOG7Ccpw1uZTLxbvv/4BR24DS29z1qiuJVhLsyQNg
 3b3ODKQZDUfkc0iYofkusUd02H2V3lR3l/eJORPVFA6UQqULEBNfpNklGrkLrdrjC7cz+1Mpd
 xp873FuWuuDmRtDMynTZc3P0WfeZCTBn6KT6UNGl03lNgT8rAbhOppEIkmVR/ZdwTAByfiFef
 jQF+4QjoaRFDLTr22nEe7QnMVmKtrMiso7hXP+Gz4JTPE9jXK82jsi6YwSq015qR8eLA/1fMQ
 848Rjbp8SkaEvdSwsK1wSTI3mbAR1J0yG7LFFtW+m1jAsb2nZ4J43vsSUgrca0cQbWeiZ6Riz
 iDaiWwJrbVgikYGF+xDam+ngJ6gAOiUg8fkp0c25Brx07gtJ/6B782M8+J8m1bVd8JuU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compile-testing the pwm driver without also enabling the
stm32_timers MFD, we run into a link error:

drivers/pwm/pwm-stm32.o: In function `stm32_pwm_raw_capture.isra.6':
pwm-stm32.c:(.text+0xcb0): undefined reference to `stm32_timers_dma_burst_read'

We don't need the '|| COMPILE_TEST' here, since stm32_timers itself
can be built with CONFIG_COMPILE_TEST on all architectures, so we do
get the coverage through allmodconfig and randconfig builds even
when we make it a hard dependency.

Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4635cb35008c..a4d262db9945 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -401,7 +401,7 @@ config PWM_STI
 
 config PWM_STM32
 	tristate "STMicroelectronics STM32 PWM"
-	depends on MFD_STM32_TIMERS || COMPILE_TEST
+	depends on MFD_STM32_TIMERS
 	help
 	  Generic PWM framework driver for STM32 SoCs.
 
-- 
2.9.0
