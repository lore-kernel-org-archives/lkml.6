Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A50C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E104420855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfBHSCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:02:07 -0500
Received: from gateway21.websitewelcome.com ([192.185.46.109]:27136 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727343AbfBHSCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:02:07 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 7C385400CC6B1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 12:02:05 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sATVgz2iH4FKpsATVgKWHV; Fri, 08 Feb 2019 12:02:05 -0600
X-Authority-Reason: nr=8
Received: from [189.250.49.191] (port=57518 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gsATU-0048is-Kx; Fri, 08 Feb 2019 12:02:04 -0600
Date:   Fri, 8 Feb 2019 12:02:02 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mtd: cfi_util: mark expected switch fall-throughs
Message-ID: <20190208180202.GA16603@embeddedor>
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
X-Exim-ID: 1gsATU-0048is-Kx
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.49.191]:57518
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/mtd/chips/cfi_util.c: In function ‘cfi_build_cmd’:
drivers/mtd/chips/cfi_util.c:110:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
   onecmd |= (onecmd << (chip_mode * 32));
   ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mtd/chips/cfi_util.c:112:2: note: here
  case 4:
  ^~~~
drivers/mtd/chips/cfi_util.c:113:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
   onecmd |= (onecmd << (chip_mode * 16));
   ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mtd/chips/cfi_util.c:114:2: note: here
  case 2:
  ^~~~
drivers/mtd/chips/cfi_util.c: In function ‘cfi_merge_status’:
drivers/mtd/chips/cfi_util.c:163:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
   res |= (onestat >> (chip_mode * 32));
   ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mtd/chips/cfi_util.c:165:2: note: here
  case 4:
  ^~~~
drivers/mtd/chips/cfi_util.c:166:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
   res |= (onestat >> (chip_mode * 16));
   ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mtd/chips/cfi_util.c:167:2: note: here
  case 2:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mtd/chips/cfi_util.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/chips/cfi_util.c b/drivers/mtd/chips/cfi_util.c
index 6f16552cd59f..e3b266ee06af 100644
--- a/drivers/mtd/chips/cfi_util.c
+++ b/drivers/mtd/chips/cfi_util.c
@@ -109,10 +109,13 @@ map_word cfi_build_cmd(u_long cmd, struct map_info *map, struct cfi_private *cfi
 	case 8:
 		onecmd |= (onecmd << (chip_mode * 32));
 #endif
+		/* fall through */
 	case 4:
 		onecmd |= (onecmd << (chip_mode * 16));
+		/* fall through */
 	case 2:
 		onecmd |= (onecmd << (chip_mode * 8));
+		/* fall through */
 	case 1:
 		;
 	}
@@ -162,10 +165,13 @@ unsigned long cfi_merge_status(map_word val, struct map_info *map,
 	case 8:
 		res |= (onestat >> (chip_mode * 32));
 #endif
+		/* fall through */
 	case 4:
 		res |= (onestat >> (chip_mode * 16));
+		/* fall through */
 	case 2:
 		res |= (onestat >> (chip_mode * 8));
+		/* fall through */
 	case 1:
 		;
 	}
-- 
2.20.1

