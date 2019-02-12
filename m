Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA8EC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3646222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbfBLVq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:46:56 -0500
Received: from gateway20.websitewelcome.com ([192.185.67.41]:11891 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728690AbfBLVqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:46:53 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id CDC3D400D22B9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 15:46:52 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tftEgNlJQ2qH7tftEgvt5I; Tue, 12 Feb 2019 15:46:52 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=60240 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtftD-003s62-UE; Tue, 12 Feb 2019 15:46:52 -0600
Date:   Tue, 12 Feb 2019 15:46:51 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] ide: hpt366: mark expected switch fall-throughs
Message-ID: <20190212214651.GA7476@embeddedor>
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
X-Exim-ID: 1gtftD-003s62-UE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:60240
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

This patch fixes the following warning:

drivers/ide/hpt366.c: In function ‘hpt3xx_udma_filter’:
drivers/ide/hpt366.c:574:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (!HPT370_ALLOW_ATA100_5 ||
      ^
drivers/ide/hpt366.c:578:2: note: here
  case HPT372 :
  ^~~~
drivers/ide/hpt366.c: In function ‘hpt3xx_mdma_filter’:
drivers/ide/hpt366.c:602:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (ata_id_is_sata(drive->id))
      ^
drivers/ide/hpt366.c:605:2: note: here
  default:
  ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/ide/hpt366.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index 4d565b0c5a6e..0a3f9bcc8b04 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -574,7 +574,7 @@ static u8 hpt3xx_udma_filter(ide_drive_t *drive)
 		if (!HPT370_ALLOW_ATA100_5 ||
 		    check_in_drive_list(drive, bad_ata100_5))
 			return ATA_UDMA4;
-		/* else: fall through */
+		/* fall through */
 	case HPT372 :
 	case HPT372A:
 	case HPT372N:
@@ -601,7 +601,7 @@ static u8 hpt3xx_mdma_filter(ide_drive_t *drive)
 	case HPT374 :
 		if (ata_id_is_sata(drive->id))
 			return 0x00;
-		/* else: fall through */
+		/* fall through */
 	default:
 		return 0x07;
 	}
-- 
2.20.1

