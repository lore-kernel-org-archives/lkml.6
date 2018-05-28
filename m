Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932786AbeE1NKi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163811AbeE1KvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:51:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jayachandran C <jnair@caviumnetworks.com>,
        Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 210/496] watchdog: sbsa: use 32-bit read for WCV
Date: Mon, 28 May 2018 11:59:55 +0200
Message-Id: <20180528100328.783258212@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jayachandran C <jnair@caviumnetworks.com>

[ Upstream commit 93ac3deb7c220cbcec032a967220a1f109d58431 ]

According to SBSA spec v3.1 section 5.3:
  All registers are 32 bits in size and should be accessed using
  32-bit reads and writes. If an access size other than 32 bits
  is used then the results are IMPLEMENTATION DEFINED.
  [...]
  The Generic Watchdog is little-endian

The current code uses readq to read the watchdog compare register
which does a 64-bit access. This fails on ThunderX2 which does not
implement 64-bit access to this register.

Fix this by using lo_hi_readq() that does two 32-bit reads.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/sbsa_gwdt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -50,6 +50,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -159,7 +160,7 @@ static unsigned int sbsa_gwdt_get_timele
 	    !(readl(gwdt->control_base + SBSA_GWDT_WCS) & SBSA_GWDT_WCS_WS0))
 		timeleft += readl(gwdt->control_base + SBSA_GWDT_WOR);
 
-	timeleft += readq(gwdt->control_base + SBSA_GWDT_WCV) -
+	timeleft += lo_hi_readq(gwdt->control_base + SBSA_GWDT_WCV) -
 		    arch_counter_get_cntvct();
 
 	do_div(timeleft, gwdt->clk);
