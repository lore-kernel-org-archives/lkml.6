Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52FFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7238D2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbfBLRnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:43:21 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.84]:40895 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728199AbfBLRnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:43:20 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id AE1734B39
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 11:43:19 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tc5Xgiqby2PzOtc5XgDcsA; Tue, 12 Feb 2019 11:43:19 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=49590 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtc5X-001j8L-2e; Tue, 12 Feb 2019 11:43:19 -0600
Date:   Tue, 12 Feb 2019 11:43:18 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] parport: ieee1284: mark expected switch fall-through
Message-ID: <20190212174318.GA22735@embeddedor>
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
X-Exim-ID: 1gtc5X-001j8L-2e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:49590
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/parport/ieee1284.c: In function ‘parport_read’:
drivers/parport/ieee1284.c:722:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (parport_negotiate (port, IEEE1284_MODE_NIBBLE)) {
      ^
drivers/parport/ieee1284.c:726:2: note: here
  case IEEE1284_MODE_NIBBLE:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/parport/ieee1284.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/ieee1284.c b/drivers/parport/ieee1284.c
index f12b9da69255..90fb73575495 100644
--- a/drivers/parport/ieee1284.c
+++ b/drivers/parport/ieee1284.c
@@ -722,7 +722,7 @@ ssize_t parport_read (struct parport *port, void *buffer, size_t len)
 		if (parport_negotiate (port, IEEE1284_MODE_NIBBLE)) {
 			return -EIO;
 		}
-		/* fall through to NIBBLE */
+		/* fall through - to NIBBLE */
 	case IEEE1284_MODE_NIBBLE:
 		DPRINTK (KERN_DEBUG "%s: Using nibble mode\n", port->name);
 		fn = port->ops->nibble_read_data;
-- 
2.20.1

