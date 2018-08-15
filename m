Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5D9C43615
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CE520C09
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CE520C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbeHOR7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:59:34 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.80]:15681 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729329AbeHOR7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:59:34 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 7B1371D3BB4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 10:07:02 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id pxNJfinjfbXuJpxNkf6Wvw; Wed, 15 Aug 2018 10:07:02 -0500
X-Authority-Reason: nr=8
Received: from [189.250.37.72] (port=58842 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fpxNJ-0036rO-2U; Wed, 15 Aug 2018 10:06:17 -0500
Date:   Wed, 15 Aug 2018 10:06:16 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] kdb: kdb_main: refactor code in kdb_md_line
Message-ID: <20180815150616.GA31173@embeddedor.com>
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
X-Source-IP: 189.250.37.72
X-Source-L: No
X-Exim-ID: 1fpxNJ-0036rO-2U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.37.72]:58842
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
 kernel/debug/kdb/kdb_main.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 2ddfce8..4b896a6 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1538,25 +1538,9 @@ static void kdb_md_line(const char *fmtstr, unsigned long addr,
 			wc.word = word;
 #define printable_char(c) \
 	({unsigned char __c = c; isascii(__c) && isprint(__c) ? __c : '.'; })
-			switch (bytesperword) {
-			case 8:
+			for (i = 0; i < bytesperword; i++)
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

