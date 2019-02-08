Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2953CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EBD20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfBHSRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:17:38 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.91]:17570 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727209AbfBHSRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:17:38 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id CFAC7400E7230
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 12:09:12 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sAaOgC9qTYTGMsAaOgrQMS; Fri, 08 Feb 2019 12:09:12 -0600
X-Authority-Reason: nr=8
Received: from [189.250.49.191] (port=57562 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gsAaN-004Dmm-Vw; Fri, 08 Feb 2019 12:09:12 -0600
Date:   Fri, 8 Feb 2019 12:09:11 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Joern Engel <joern@lazybastard.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mtd: phram: Mark expected switch fall-throughs
Message-ID: <20190208180911.GA32525@embeddedor>
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
X-Source-IP: 189.250.49.191
X-Source-L: No
X-Exim-ID: 1gsAaN-004Dmm-Vw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.49.191]:57562
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/mtd/devices/phram.c: In function ‘parse_num64’:
drivers/mtd/devices/phram.c:149:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
     shift += 10;
     ~~~~~~^~~~~
drivers/mtd/devices/phram.c:150:4: note: here
    case 'M':
    ^~~~
drivers/mtd/devices/phram.c:151:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
     shift += 10;
     ~~~~~~^~~~~
drivers/mtd/devices/phram.c:152:4: note: here
    case 'k':
    ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mtd/devices/phram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index 9ee04b5f9311..8a8627c30aed 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -147,8 +147,10 @@ static int parse_num64(uint64_t *num64, char *token)
 			switch (token[len - 2]) {
 			case 'G':
 				shift += 10;
+				/* fall through */
 			case 'M':
 				shift += 10;
+				/* fall through */
 			case 'k':
 				shift += 10;
 				token[len - 2] = 0;
-- 
2.20.1

