Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbeDPIt0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:49:26 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42727 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754037AbeDPItZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:49:25 -0400
X-Google-Smtp-Source: AIpwx4966wxGVfNcbghN6euRFs0sErqPI1gjtTtrwkoHcY2QrfKSVLTMkc22CrvEhGm9r9TUHeg+5w==
From: Tobias Regnery <tobias.regnery@gmail.com>
To: cw00.choi@samsung.com, myungjoo.ham@samsung.com, wens@csie.org,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org
Cc: Tobias Regnery <tobias.regnery@gmail.com>
Subject: [PATCH] extcon: axp288: fix link error
Date: Mon, 16 Apr 2018 10:40:03 +0200
Message-Id: <20180416084003.13847-1-tobias.regnery@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_AXP288=y and CONFIG_USB_COMMON=n there is the following link
error:

drivers/extcon/extcon-axp288.o: In function `axp288_put_role_sw':
extcon-axp288.c:(.text+0xa0): undefined reference to `usb_role_switch_put'
drivers/extcon/extcon-axp288.o: In function `axp288_usb_role_work':
extcon-axp288.c:(.text+0xec): undefined reference to `usb_role_switch_get_role'
extcon-axp288.c:(.text+0x12c): undefined reference to `usb_role_switch_set_role'
drivers/extcon/extcon-axp288.o: In function `axp288_extcon_probe':
extcon-axp288.c:(.text+0x59d): undefined reference to `usb_role_switch_get'

The above functions are defined in drivers/usb/common/roles.c, but the build
system only enters the common directory depending on CONFIG_USB_COMMON. Fix
this by selecting the USB_COMMON symbol.

Fixes: d54f063cdbe4 ("extcon: axp288: Set USB role where necessary")
Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
---
Hi,

there is another solution for this problem: replace depends on USB_SUPPORT
with depends on USB, but since CONFIG_USB selects other symbols I went 
with the minimal fix and select the USB_COMMON symbol.
---
 drivers/extcon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index de15bf55895b..0897bee54c2b 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -31,6 +31,7 @@ config EXTCON_ARIZONA
 config EXTCON_AXP288
 	tristate "X-Power AXP288 EXTCON support"
 	depends on MFD_AXP20X && USB_SUPPORT && X86
+	select USB_COMMON
 	select USB_ROLE_SWITCH
 	help
 	  Say Y here to enable support for USB peripheral detection
-- 
2.17.0
