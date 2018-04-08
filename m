Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AIpwx4/uISiTFgLv69M23UHGiBGVtDcmzLTu3qiclEZrbbk4EXgmmmjYaOjpWqzGxixjEDEugZLd
ARC-Seal: i=1; a=rsa-sha256; t=1523178322; cv=none;
        d=google.com; s=arc-20160816;
        b=IuYmacFuPxfV0kyVvUSmOv618doCGGUkrW4PTRkl/CI0OXEy2hd9UyF/8XpZ456q3g
         9aCWVvUbbg42bSxMAqP7RvgaM7xRxRTCCA8tkYhpZOJSTOtcFu+UZd5eXlliCDt5tt/3
         tL1OVZ5EyFHsy4AdWf+uyQ5719odrzTjAy045gFgtdOhyI2KZ5Y/E7oo1FJqVJ+Ej/tS
         dszKyB8liOMWVJpF/A0cpZPfuK68T4zEtr7MvuH8tVpekcSS8akaXtQ1CsuedJGgeDzH
         SbLf/ggMKVl/Vj2vqYWQd/9Yf6WXb/ZkMR5wiq9MXNs7f43RLwGqYCbGphMxAKszxP42
         2hYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=7MyG6f4VmHGfuFtkh4FDHnz6TIKdAtaBdDabUYMJ5JA=;
        b=EvdKt6jhq9wtvjEvxOQHTAO8auTEaMLxyCp9S0frcAIav/MmLg9vxwSihRqYQim/oo
         VS+yFuxiymzkhQeIcVOGU7zmMJO0W8SVP/EnnQSfujuv/RVaYBCFR1WTSdqN6hIuCtf5
         P0OuYOu/MUOEcmI+aDxgw9Ctk5zHWv5F7E444xB88VPAtUkwmvYgR1YDoujO8XfEzThS
         /4+lYCfrFcgEh/5/XapkPuvWQQSVFDm/mq44tzrR1FR5JfsvBA48Bv9oGUL0AsH5DKsV
         0NxYqfdNq/2sqQ5FlGZQeSRCH06T3om8fFoOa+uwNzaY0ny6FI3MUiYVa/oj0UT+65vk
         5BlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:1a is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:1a is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Florian Fainelli <f.fainelli@gmail.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Eric Anholt <eric@anholt.net>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH/RFC] soc: bcm2835: Make !RASPBERRYPI_FIRMWARE dummies return failure
Date: Sun,  8 Apr 2018 11:05:15 +0200
Message-Id: <1523178315-30562-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597168233130064314?=
X-GMAIL-MSGID: =?utf-8?q?1597168233130064314?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If CONFIG_RASPBERRYPI_FIRMWARE=n:

    drivers/gpio/gpio-raspberrypi-exp.c: In function ‘rpi_exp_gpio_get_polarity’:
    drivers/gpio/gpio-raspberrypi-exp.c:71: warning: ‘get.polarity’ is used uninitialized in this function
    drivers/gpio/gpio-raspberrypi-exp.c: In function ‘rpi_exp_gpio_get_direction’:
    drivers/gpio/gpio-raspberrypi-exp.c:150: warning: ‘get.direction’ is used uninitialized in this function

The dummy firmware interface functions return 0, which means success,
causing subsequent code to make use of the never initialized output
parameter.

Fix this by making the dummy functions return an error code (-ENOSYS)
instead.

Note that this assumes the firmware always fills in the requested data
in the CONFIG_RASPBERRYPI_FIRMWARE=y case.

Fixes: d45f1a563b92dac7 ("staging: vc04_services: fix up rpi firmware functions")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Should get.polarity resp. get.direction be preinitialized instead,
like is done for get.state?

static int rpi_exp_gpio_get(struct gpio_chip *gc, unsigned int off)
{
        ...
        get.state = 0;          /* storage for returned value */

        ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_GET_GPIO_STATE,
                                         &get, sizeof(get));
        ...
}

This would avoid returning uninitialized data if the firmware did not
fill in the requested data.
---
 include/soc/bcm2835/raspberrypi-firmware.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index 50df5b28d2c9df6e..8ee8991aa099af3a 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -143,13 +143,13 @@ struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node);
 static inline int rpi_firmware_property(struct rpi_firmware *fw, u32 tag,
 					void *data, size_t len)
 {
-	return 0;
+	return -ENOSYS;
 }
 
 static inline int rpi_firmware_property_list(struct rpi_firmware *fw,
 					     void *data, size_t tag_size)
 {
-	return 0;
+	return -ENOSYS;
 }
 
 static inline struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
-- 
2.7.4
