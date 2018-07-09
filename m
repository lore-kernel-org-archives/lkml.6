Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E8C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40ACB2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40ACB2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933757AbeGIPoF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:44:05 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:56285 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932789AbeGIPoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:44:03 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MhUV0-1fOt5P1DwQ-00MfON; Mon, 09 Jul 2018 17:43:05 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>, Arnd Bergmann <arnd@arndb.de>,
        Vadim Pasternak <vadimp@mellanox.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: rpi: fix link error against rpi_firmware module
Date:   Mon,  9 Jul 2018 17:42:44 +0200
Message-Id: <20180709154301.1781663-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:OYy7pX97fzG4UBSw2+aByheZikuJ3InD60HQ1xbFGn0SdNMyLy1
 m4OhAWss6CkeKbMcOvOJgo3SUVnVqPkxqxAzkAXheHExZcEJHInGzHmqNv2TXvCtBq8L4Eo
 sUszQRmv23Awrjy5G05+nrR3H6shXLunDWwefaURELGNgrKGbnLwfMB4hqsQzsMql4N7uIh
 d1WyqFJul9Dd2bzNkZW7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HtDR2jYM5v8=:4o6sIHfJaJny1JNgew6ZGb
 lZPyM4Arrrm/Zt/6BY43Q7TFxCA51l8qQCosrQttm8rByO35foyJx3dehBWXGdTc9trDj0HQO
 kVSIh+qrcHURxmIWqbpdTiAkWSTPNzRcaOX7BaGVK5Dw0BJSGNaJPyv9weTSdgodItGipKfxt
 DZrsbAYnvzd9jtz5BKYZAkI1cMhTyCb0hqyG4EaM7KZtzk9rI8dNaNAFq5Bk37nJKW7cIa4Lp
 JE5CWVsHm86B/tL9rlATST+XGsug+5V9zyIVsoULhO8ijp0dlHeODkpkIV8fA6vzF70OS2Sh2
 iXt2rJlfzE8fQDiuuik5ZaAzaH3Y14waZZUgmqymvFZxF9e2uxc1q5HFedfEpBGa7zQ+cAiX4
 J/fsaR6IRPh3mFkKwBGd8EbyrJ0dXI79O9ub19MYTSoIoUTs9BDZZdr60ffKcWfDVuyjzLet7
 YAwt1EobVKjz8V2N9qpmso7NV5Rdd6usAZNchFcTwThfJrthMvvuwXDSqvz43YzVB1UhnVX99
 MKsID/sKWZUVzZgzFxprHQN54Ix22oCuncnebsFqZwBpGy6jZt/ReCGmpfLMAe5mEv/FkTq0h
 7a8BC1iPLuO9KW1NCsHr4wuEQ4d9vF0CMfin81o8PAaUgGmwgtlSaFskROCMDLOPP+Go1ATF0
 OXqBL2cujmBEGFKONhNu3nbo6DqJlcPBCd9YJb4KTpujiS5qsIPGs2Cect8YXof6Fx6s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compile-testing without CONFIG_RASPBERRYPI_FIRMWARE is possible, but we
cannot build the rpi hwmon driver into the kernel if the firmware code
is a loadable module:

drivers/hwmon/raspberrypi-hwmon.o: In function `rpi_hwmon_probe':
raspberrypi-hwmon.c:(.text+0x140): undefined reference to `rpi_firmware_property'
drivers/hwmon/raspberrypi-hwmon.o: In function `get_values_poll':
raspberrypi-hwmon.c:(.text+0x350): undefined reference to `rpi_firmware_property'

This adapts the dependency to disallow that combination.

Fixes: 3c493c885cf8 ("hwmon: Add support for RPi voltage sensor")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwmon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a4e5d3c9fc71..81da17a42dc9 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1322,7 +1322,7 @@ config SENSORS_PWM_FAN
 
 config SENSORS_RASPBERRYPI_HWMON
 	tristate "Raspberry Pi voltage monitor"
-	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
+	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
 	help
 	  If you say yes here you get support for voltage sensor on the
 	  Raspberry Pi.
-- 
2.9.0

