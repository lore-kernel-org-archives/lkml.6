Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FD8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388E32192B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406794AbfBNUUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:20:44 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.172]:35883 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390579AbfBNUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:20:42 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 623068A26
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 14:20:18 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id uNUYg5aGz2qH7uNUYgdKRi; Thu, 14 Feb 2019 14:20:18 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=44888 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1guNUO-000CeD-Fa; Thu, 14 Feb 2019 14:20:17 -0600
Date:   Thu, 14 Feb 2019 14:20:08 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Zwane Mwaikambo <zwanem@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] watchdog: sc1200: Mark expected switch fall-through
Message-ID: <20190214202008.GA15525@embeddedor>
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
X-Exim-ID: 1guNUO-000CeD-Fa
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:44888
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/watchdog/sc1200wdt.c: In function ‘sc1200wdt_ioctl’:
drivers/watchdog/sc1200wdt.c:241:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   sc1200wdt_write_data(WDTO, timeout);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/watchdog/sc1200wdt.c:244:2: note: here
  case WDIOC_GETTIMEOUT:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/watchdog/sc1200wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sc1200wdt.c b/drivers/watchdog/sc1200wdt.c
index 8e4e2fc13f87..e035a4d4b299 100644
--- a/drivers/watchdog/sc1200wdt.c
+++ b/drivers/watchdog/sc1200wdt.c
@@ -239,7 +239,7 @@ static long sc1200wdt_ioctl(struct file *file, unsigned int cmd,
 			return -EINVAL;
 		timeout = new_timeout;
 		sc1200wdt_write_data(WDTO, timeout);
-		/* fall through and return the new timeout */
+		/* fall through - and return the new timeout */
 
 	case WDIOC_GETTIMEOUT:
 		return put_user(timeout * 60, p);
-- 
2.20.1

