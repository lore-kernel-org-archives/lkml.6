Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424150AbeE1LLz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424132AbeE1LLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:11:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Milton Miller <miltonm@us.ibm.com>,
        Eddie James <eajames@linux.vnet.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 172/272] watchdog: aspeed: Fix translation of reset mode to ctrl register
Date: Mon, 28 May 2018 12:03:25 +0200
Message-Id: <20180528100255.226306153@linuxfoundation.org>
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

[ Upstream commit d2fc8db691bf3197d43b2afb553311a9bf257bff ]

Assert RESET_SYSTEM bit for any reset and set MODE field from reset
type.

The watchdog control register has a RESET_SYSTEM bit that is really
closer to activate a reset, and RESET_SYSTEM_MODE field that chooses
how much to reset.

Before this patch, a node without these optional property would do a
SOC reset, but a node with properties requesting a cpu or SOC reset
would do nothing and a node requesting a system reset would do a
SOC reset.

Fixes: b7f0b8ad25f3 ("drivers/watchdog: ASPEED reference dev tree properties for config")
Signed-off-by: Milton Miller <miltonm@us.ibm.com>
Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/aspeed_wdt.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -234,11 +234,14 @@ static int aspeed_wdt_probe(struct platf
 		wdt->ctrl |= WDT_CTRL_RESET_MODE_SOC | WDT_CTRL_RESET_SYSTEM;
 	} else {
 		if (!strcmp(reset_type, "cpu"))
-			wdt->ctrl |= WDT_CTRL_RESET_MODE_ARM_CPU;
+			wdt->ctrl |= WDT_CTRL_RESET_MODE_ARM_CPU |
+				     WDT_CTRL_RESET_SYSTEM;
 		else if (!strcmp(reset_type, "soc"))
-			wdt->ctrl |= WDT_CTRL_RESET_MODE_SOC;
+			wdt->ctrl |= WDT_CTRL_RESET_MODE_SOC |
+				     WDT_CTRL_RESET_SYSTEM;
 		else if (!strcmp(reset_type, "system"))
-			wdt->ctrl |= WDT_CTRL_RESET_SYSTEM;
+			wdt->ctrl |= WDT_CTRL_RESET_MODE_FULL_CHIP |
+				     WDT_CTRL_RESET_SYSTEM;
 		else if (strcmp(reset_type, "none"))
 			return -EINVAL;
 	}
