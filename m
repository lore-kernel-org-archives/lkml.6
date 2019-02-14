Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A630C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BC42229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439929AbfBNUQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:16:11 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.196]:44462 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391922AbfBNUQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:16:11 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 2C0C0CFA4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 14:16:10 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id uNQYg3z1G90onuNQYgQzWy; Thu, 14 Feb 2019 14:16:10 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=44852 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1guNQS-000AKy-LY; Thu, 14 Feb 2019 14:16:09 -0600
Date:   Thu, 14 Feb 2019 14:16:01 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] watchdog: smsc37b787_wdt: Mark expected switch fall-through
Message-ID: <20190214201601.GA13098@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1guNQS-000AKy-LY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:44852
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/watchdog/smsc37b787_wdt.c: In function ‘wb_smsc_wdt_ioctl’:
drivers/watchdog/smsc37b787_wdt.c:480:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   wb_smsc_wdt_set_timeout(timeout);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/watchdog/smsc37b787_wdt.c:482:2: note: here
  case WDIOC_GETTIMEOUT:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/watchdog/smsc37b787_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/smsc37b787_wdt.c b/drivers/watchdog/smsc37b787_wdt.c
index 445ea1ad1fa9..c768dcd53034 100644
--- a/drivers/watchdog/smsc37b787_wdt.c
+++ b/drivers/watchdog/smsc37b787_wdt.c
@@ -478,7 +478,7 @@ static long wb_smsc_wdt_ioctl(struct file *file,
 			return -EINVAL;
 		timeout = new_timeout;
 		wb_smsc_wdt_set_timeout(timeout);
-		/* fall through and return the new timeout... */
+		/* fall through - and return the new timeout... */
 	case WDIOC_GETTIMEOUT:
 		new_timeout = timeout;
 		if (unit == UNIT_MINUTE)
-- 
2.20.1

