Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BA7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2087222BE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfBLVb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:31:28 -0500
Received: from gateway20.websitewelcome.com ([192.185.67.41]:37380 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbfBLVb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:31:28 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 94AD0400D38AB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 15:31:27 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tfeJgnOyD2PzOtfeJgI8fU; Tue, 12 Feb 2019 15:31:27 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=59366 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtfeI-003kN6-Rp; Tue, 12 Feb 2019 15:31:27 -0600
Date:   Tue, 12 Feb 2019 15:31:26 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] char: lp: mark expected switch fall-through
Message-ID: <20190212213126.GA7625@embeddedor>
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
X-Exim-ID: 1gtfeI-003kN6-Rp
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:59366
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 27
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/char/lp.c: In function ‘lp_compat_ioctl’:
drivers/char/lp.c:756:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (!COMPAT_USE_64BIT_TIME) {
      ^
drivers/char/lp.c:761:2: note: here
  case LPSETTIMEOUT_NEW:
  ^~~~
drivers/char/lp.c: In function ‘lp_ioctl’:
drivers/char/lp.c:728:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (BITS_PER_LONG == 32) {
      ^
drivers/char/lp.c:733:2: note: here
  case LPSETTIMEOUT_NEW:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that in some cases, the code comment is modified in
accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/char/lp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 5c8d780637bd..3406852f67ff 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -729,7 +729,7 @@ static long lp_ioctl(struct file *file, unsigned int cmd,
 			ret = lp_set_timeout32(minor, (void __user *)arg);
 			break;
 		}
-		/* fallthrough for 64-bit */
+		/* fall through - for 64-bit */
 	case LPSETTIMEOUT_NEW:
 		ret = lp_set_timeout64(minor, (void __user *)arg);
 		break;
@@ -757,7 +757,7 @@ static long lp_compat_ioctl(struct file *file, unsigned int cmd,
 			ret = lp_set_timeout32(minor, (void __user *)arg);
 			break;
 		}
-		/* fallthrough for x32 mode */
+		/* fall through - for x32 mode */
 	case LPSETTIMEOUT_NEW:
 		ret = lp_set_timeout64(minor, (void __user *)arg);
 		break;
-- 
2.20.1

