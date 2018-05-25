Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030333AbeEYVJK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:09:10 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:41281 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968376AbeEYVJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:09:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: stm32: fix build warning with CONFIG_DMA_ENGINE disabled
Date: Fri, 25 May 2018 23:08:30 +0200
Message-Id: <20180525210843.1821071-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:+Fim8R0Ja3k85HCmDb2GmNGWMnqJJ1t1nOxSudEQgTeNt+z27hn
 fJaDp0W87fPuD7M+I1xV/nxs6hSC4wbPGHROZ6oLX2onGqaAJBGsuu/NPHw+feDhkFlV/MU
 EQYcouHPYL4O4YiU4FWzMKMEbnTG4ydkpCNxUIhRdJH9A8MCUjXGP8EZ0UrxM21rv131t/A
 Ssn0OHbol9HNyH2R1QrNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Opm8/xm9O6A=:+ykAXxA/oiYU2O+3yLc/i3
 XmhUyfD3lF4MnY8HhqlZYkBHW+XxpsYF0ktV5IVCC6WsZL9letPxWO7SQzuXrlQODgUq6VVJk
 Pvj/DZ1bKFxMabWdbDEnmEHT4eWUTEfYYD4xscJxQCC4q5cN7JzTizjZJPWS3xLXhMvcylkgy
 /ABGE/TFQ43wyOxrcMhceNXsViHl8ktv3NDUiNHkQQfprzXftFyb7q4gAAFxapj0HXuWQ2mbs
 nT1BASnUtu8pqVaKCKQpwWclaYUhuxgmMMVVjBHjGzvgi0+8NXa0VFOs578QtsBNaOT+dHuua
 bmtSx6gbfKFtF+sItkcmtVoy9KO0asoOplEE0fXVUlqpVaiaBQuqLIGSbpM5xOqJHmybEkOPG
 TXLvKGPxTD949Se73QnjpPu3dt9U53ka0FbXm4+oXBLe3VelVMogJXifdZaeKcl3Twcdk0LjT
 dyeWf8+c9jryaG65K7sPaFo6MkjHfAatzAyY/zqBt1CrcYGfEptFoWZYMX8K0bq3SssNy/TMS
 sLCCuP58Bo1EKcJS7MMC9G94jNktPAAzmvu8prI+VZ8Z5U/SgNoApQmL+9eAKaTeSvKlsu1/S
 B+7KMC9M+j+YcT7IKATnq/6xO2IShtd0AVJGIJlwAk3ohBh+e6SQLEJsn8sDzKVWIegZSjVRV
 i9A+/sYTXqa4fQqwdQjoRPnPCWR+hXN08ckzDOy2FTUv64ee1ds+1ybJLKvznJC7C+B4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without dmaengine support, we get a harmless warning about an
unused function:

drivers/pwm/pwm-stm32.c:166:12: error: 'stm32_pwm_capture' defined but not used [-Werror=unused-function]

Changing the #ifdef to an IS_ENABLED() check shuts up that warning
and is slightly nicer to read.

Fixes: 53e38fe73f94 ("pwm: stm32: Add capture support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pwm/pwm-stm32.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 60bfc07c4912..97bbc1f18fd6 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -484,9 +484,7 @@ static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
 static const struct pwm_ops stm32pwm_ops = {
 	.owner = THIS_MODULE,
 	.apply = stm32_pwm_apply_locked,
-#if IS_ENABLED(CONFIG_DMA_ENGINE)
-	.capture = stm32_pwm_capture,
-#endif
+	.capture = IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
 };
 
 static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
-- 
2.9.0
