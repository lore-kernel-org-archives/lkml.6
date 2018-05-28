Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424947AbeE1Lt3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423869AbeE1LKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:10:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Milton Miller <miltonm@us.ibm.com>,
        Eddie James <eajames@linux.vnet.ibm.com>,
        Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 135/272] watchdog: aspeed: Allow configuring for alternate boot
Date: Mon, 28 May 2018 12:02:48 +0200
Message-Id: <20180528100252.405881036@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Milton Miller <miltonm@us.ibm.com>

[ Upstream commit 6ffa3402211acc30e47e691e14d62f3fd065a54e ]

Allow the device tree to specify a watchdog to fallover to
the alternate boot source.

The aspeeed watchdog can set a latch directing flash chip select 0 to
chip select 1, allowing boot from an alternate media if the watchdog
is not reset in time.  On the ast2400 bank 1 also goes to flash bank 1,
while on the ast2500 the chip selects are swapped.

Also clear the secondary boot bit during the machine restart operation.
Otherwise, the system will switch to the alternate boot after every
reboot, which is not desired.

Signed-off-by: Milton Miller <miltonm@us.ibm.com>
Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/aspeed_wdt.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -46,6 +46,7 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_ta
 #define WDT_RELOAD_VALUE	0x04
 #define WDT_RESTART		0x08
 #define WDT_CTRL		0x0C
+#define   WDT_CTRL_BOOT_SECONDARY	BIT(7)
 #define   WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
 #define   WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
 #define   WDT_CTRL_RESET_MODE_ARM_CPU	(0x10 << 5)
@@ -158,6 +159,7 @@ static int aspeed_wdt_restart(struct wat
 {
 	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
 
+	wdt->ctrl &= ~WDT_CTRL_BOOT_SECONDARY;
 	aspeed_wdt_enable(wdt, 128 * WDT_RATE_1MHZ / 1000);
 
 	mdelay(1000);
@@ -242,6 +244,8 @@ static int aspeed_wdt_probe(struct platf
 	}
 	if (of_property_read_bool(np, "aspeed,external-signal"))
 		wdt->ctrl |= WDT_CTRL_WDT_EXT;
+	if (of_property_read_bool(np, "aspeed,alt-boot"))
+		wdt->ctrl |= WDT_CTRL_BOOT_SECONDARY;
 
 	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
 		/*
