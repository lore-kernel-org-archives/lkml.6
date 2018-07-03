Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DC6C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEA0247F2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEA0247F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932455AbeGCWsS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:48:18 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.46]:48146 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932378AbeGCWsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:48:15 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 0F28D2CC2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jul 2018 17:48:15 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id aU5Gfpj46bXuJaU5Zf05J9; Tue, 03 Jul 2018 17:48:14 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=51470 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1faU5D-004Dm9-0y; Tue, 03 Jul 2018 17:47:42 -0500
Date:   Tue, 3 Jul 2018 17:47:36 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] eeprom: at25: mark expected switch fall-throughs
Message-ID: <20180703224736.GA13316@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1faU5D-004Dm9-0y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:51470
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/misc/eeprom/at25.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 6a7d4a2..840afb3 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -94,8 +94,10 @@ static int at25_ee_read(void *priv, unsigned int offset,
 	switch (at25->addrlen) {
 	default:	/* case 3 */
 		*cp++ = offset >> 16;
+		/* fall through */
 	case 2:
 		*cp++ = offset >> 8;
+		/* fall through */
 	case 1:
 	case 0:	/* can't happen: for better codegen */
 		*cp++ = offset >> 0;
@@ -180,8 +182,10 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 		switch (at25->addrlen) {
 		default:	/* case 3 */
 			*cp++ = offset >> 16;
+			/* fall through */
 		case 2:
 			*cp++ = offset >> 8;
+			/* fall through */
 		case 1:
 		case 0:	/* can't happen: for better codegen */
 			*cp++ = offset >> 0;
-- 
2.7.4

