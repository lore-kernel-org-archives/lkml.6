Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A65C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F712080F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfBKWi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:38:26 -0500
Received: from gateway20.websitewelcome.com ([192.185.62.46]:30056 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727325AbfBKWiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:38:22 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 3803A400DC1EE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 16:38:22 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tKDWgJJnvdnCetKDWgIdGJ; Mon, 11 Feb 2019 16:38:22 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=34236 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtKDV-004Ikk-H1; Mon, 11 Feb 2019 16:38:21 -0600
Date:   Mon, 11 Feb 2019 16:38:21 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Karsten Keil <isdn@linux-pingi.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] isdn: i4l: isdn_tty: Mark expected switch fall-through
Message-ID: <20190211223821.GA13158@embeddedor>
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
X-Exim-ID: 1gtKDV-004Ikk-H1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:34236
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 39
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/isdn/i4l/isdn_tty.c: In function ‘isdn_tty_edit_at’:
drivers/isdn/i4l/isdn_tty.c:3644:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
       m->mdmcmdl = 0;
       ~~~~~~~~~~~^~~
drivers/isdn/i4l/isdn_tty.c:3646:5: note: here
     case 0:
     ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/isdn/i4l/isdn_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index dc1cded716c1..43700fc19a31 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -3642,7 +3642,7 @@ isdn_tty_edit_at(const char *p, int count, modem_info *info)
 						break;
 					} else
 						m->mdmcmdl = 0;
-					/* Fall through, check for 'A' */
+					/* Fall through - check for 'A' */
 				case 0:
 					if (c == 'A') {
 						m->mdmcmd[m->mdmcmdl] = c;
-- 
2.20.1

