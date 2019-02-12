Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40D2C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A111C222BE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfBLV2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:28:23 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.101]:45500 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729783AbfBLV2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:28:22 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id CD8D417F7ED
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 15:28:21 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tfbJgel8GdnCetfbJgdtPd; Tue, 12 Feb 2019 15:28:21 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=59222 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtfbJ-003iet-07; Tue, 12 Feb 2019 15:28:21 -0600
Date:   Tue, 12 Feb 2019 15:28:20 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] drbd_receiver: mark expected switch fall-throughs
Message-ID: <20190212212820.GA15942@embeddedor>
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
X-Exim-ID: 1gtfbJ-003iet-07
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:59222
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 23
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/block/drbd/drbd_receiver.c: In function ‘drbd_asb_recover_0p’:
drivers/block/drbd/drbd_receiver.c:3093:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (self == 1 && peer == 0) {
      ^
drivers/block/drbd/drbd_receiver.c:3098:2: note: here
  case ASB_DISCARD_OLDER_PRI:
  ^~~~
drivers/block/drbd/drbd_receiver.c:3120:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (after_sb_0p == ASB_DISCARD_ZERO_CHG)
      ^
drivers/block/drbd/drbd_receiver.c:3123:2: note: here
  case ASB_DISCARD_LEAST_CHG:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that in some cases, the code comment is modified in
accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/drbd/drbd_receiver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index c7ad88d91a09..78bb763a367d 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3094,7 +3094,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold
 			rv =  1;
 			break;
 		}
-		/* Else fall through to one of the other strategies... */
+		/* Else fall through - to one of the other strategies... */
 	case ASB_DISCARD_OLDER_PRI:
 		if (self == 0 && peer == 1) {
 			rv = 1;
@@ -3119,7 +3119,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold
 		}
 		if (after_sb_0p == ASB_DISCARD_ZERO_CHG)
 			break;
-		/* else: fall through */
+		/* Else fall through */
 	case ASB_DISCARD_LEAST_CHG:
 		if	(ch_self < ch_peer)
 			rv = -1;
-- 
2.20.1

