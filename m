Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB8BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724432184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfBKWmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:42:39 -0500
Received: from gateway20.websitewelcome.com ([192.185.62.46]:34700 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbfBKWmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:42:39 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 8537F400EF005
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 16:42:38 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tKHegRt522PzOtKHegws4n; Mon, 11 Feb 2019 16:42:38 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=34364 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtKHd-004KlQ-Re; Mon, 11 Feb 2019 16:42:37 -0600
Date:   Mon, 11 Feb 2019 16:42:37 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Karsten Keil <isdn@linux-pingi.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] isdn_v110: mark expected switch fall-through
Message-ID: <20190211224237.GA29262@embeddedor>
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
X-Exim-ID: 1gtKHd-004KlQ-Re
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:34364
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 43
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/isdn/i4l/isdn_v110.c: In function ‘EncodeMatrix’:
drivers/isdn/i4l/isdn_v110.c:353:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (line >= mlen) {
       ^
drivers/isdn/i4l/isdn_v110.c:358:3: note: here
   case 128:
   ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/isdn/i4l/isdn_v110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/i4l/isdn_v110.c b/drivers/isdn/i4l/isdn_v110.c
index 2a5f6668756c..d11fe76f138f 100644
--- a/drivers/isdn/i4l/isdn_v110.c
+++ b/drivers/isdn/i4l/isdn_v110.c
@@ -354,7 +354,7 @@ EncodeMatrix(unsigned char *buf, int len, unsigned char *m, int mlen)
 				printk(KERN_WARNING "isdn_v110 (EncodeMatrix): buffer full!\n");
 				return line;
 			}
-			/* else: fall through */
+			/* fall through */
 		case 128:
 			m[line] = 128;	/* leftmost -> set byte to 1000000 */
 			mbit = 64;	/* current bit in the matrix line */
-- 
2.20.1

