Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD43BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DA1208B0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DA1208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389513AbeHPRBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:01:13 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.31]:22694 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387574AbeHPRBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:01:13 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id EF67119A2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 09:02:24 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id qIqOfqfn3PvAdqIqmfqPou; Thu, 16 Aug 2018 09:02:23 -0500
X-Authority-Reason: nr=8
Received: from [189.250.72.226] (port=48026 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fqIqM-000Qr8-QP; Thu, 16 Aug 2018 09:01:42 -0500
Date:   Thu, 16 Aug 2018 09:01:41 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] kdb: kdb_main: refactor code in kdb_md_line
Message-ID: <20180816140141.GA28913@embeddedor.com>
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
X-Source-IP: 189.250.72.226
X-Source-L: No
X-Exim-ID: 1fqIqM-000Qr8-QP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.72.226]:48026
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the whole switch statement with a for loop.
This makes the code much clear and easy to read.

This also addresses the following Coverity warnings:

Addresses-Coverity-ID: 115090 ("Missing break in switch")
Addresses-Coverity-ID: 115091 ("Missing break in switch")
Addresses-Coverity-ID: 114700 ("Missing break in switch")

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Add new variable j and use it for the for loop.

 kernel/debug/kdb/kdb_main.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 2ddfce8..a9ad288 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1493,6 +1493,7 @@ static void kdb_md_line(const char *fmtstr, unsigned long addr,
 	char cbuf[32];
 	char *c = cbuf;
 	int i;
+	int j;
 	unsigned long word;
 
 	memset(cbuf, '\0', sizeof(cbuf));
@@ -1538,25 +1539,9 @@ static void kdb_md_line(const char *fmtstr, unsigned long addr,
 			wc.word = word;
 #define printable_char(c) \
 	({unsigned char __c = c; isascii(__c) && isprint(__c) ? __c : '.'; })
-			switch (bytesperword) {
-			case 8:
+			for (j = 0; j < bytesperword; j++)
 				*c++ = printable_char(*cp++);
-				*c++ = printable_char(*cp++);
-				*c++ = printable_char(*cp++);
-				*c++ = printable_char(*cp++);
-				addr += 4;
-			case 4:
-				*c++ = printable_char(*cp++);
-				*c++ = printable_char(*cp++);
-				addr += 2;
-			case 2:
-				*c++ = printable_char(*cp++);
-				addr++;
-			case 1:
-				*c++ = printable_char(*cp++);
-				addr++;
-				break;
-			}
+			addr += bytesperword;
 #undef printable_char
 		}
 	}
-- 
2.7.4

