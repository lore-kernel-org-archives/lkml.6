Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C24ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED28720693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED28720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbeGRR6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:58:03 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.252]:32265 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730897AbeGRR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:58:02 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id C55747A374
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 12:19:09 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fq6XfFQ5XSjJAfq6Xf2HiU; Wed, 18 Jul 2018 12:19:09 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=51436 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ffq6X-002j7U-8j; Wed, 18 Jul 2018 12:19:09 -0500
Date:   Wed, 18 Jul 2018 12:19:08 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] crypto: rmd320 - use swap macro in rmd320_transform
Message-ID: <20180718171908.GA22962@embeddedor.com>
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
X-Exim-ID: 1ffq6X-002j7U-8j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:51436
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the swap macro and remove unnecessary variable *tmp*.
This makes the code easier to read and maintain.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 crypto/rmd320.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/rmd320.c b/crypto/rmd320.c
index ab3cf93..3ae1df5 100644
--- a/crypto/rmd320.c
+++ b/crypto/rmd320.c
@@ -53,7 +53,7 @@ struct rmd320_ctx {
 
 static void rmd320_transform(u32 *state, const __le32 *in)
 {
-	u32 aa, bb, cc, dd, ee, aaa, bbb, ccc, ddd, eee, tmp;
+	u32 aa, bb, cc, dd, ee, aaa, bbb, ccc, ddd, eee;
 
 	/* Initialize left lane */
 	aa = state[0];
@@ -106,7 +106,7 @@ static void rmd320_transform(u32 *state, const __le32 *in)
 	ROUND(aaa, bbb, ccc, ddd, eee, F5, KK1, in[12],  6);
 
 	/* Swap contents of "a" registers */
-	tmp = aa; aa = aaa; aaa = tmp;
+	swap(aa, aaa);
 
 	/* round 2: left lane" */
 	ROUND(ee, aa, bb, cc, dd, F2, K2, in[7],   7);
@@ -145,7 +145,7 @@ static void rmd320_transform(u32 *state, const __le32 *in)
 	ROUND(eee, aaa, bbb, ccc, ddd, F4, KK2, in[2],  11);
 
 	/* Swap contents of "b" registers */
-	tmp = bb; bb = bbb; bbb = tmp;
+	swap(bb, bbb);
 
 	/* round 3: left lane" */
 	ROUND(dd, ee, aa, bb, cc, F3, K3, in[3],  11);
@@ -184,7 +184,7 @@ static void rmd320_transform(u32 *state, const __le32 *in)
 	ROUND(ddd, eee, aaa, bbb, ccc, F3, KK3, in[13],  5);
 
 	/* Swap contents of "c" registers */
-	tmp = cc; cc = ccc; ccc = tmp;
+	swap(cc, ccc);
 
 	/* round 4: left lane" */
 	ROUND(cc, dd, ee, aa, bb, F4, K4, in[1],  11);
@@ -223,7 +223,7 @@ static void rmd320_transform(u32 *state, const __le32 *in)
 	ROUND(ccc, ddd, eee, aaa, bbb, F2, KK4, in[14],  8);
 
 	/* Swap contents of "d" registers */
-	tmp = dd; dd = ddd; ddd = tmp;
+	swap(dd, ddd);
 
 	/* round 5: left lane" */
 	ROUND(bb, cc, dd, ee, aa, F5, K5, in[4],   9);
@@ -262,7 +262,7 @@ static void rmd320_transform(u32 *state, const __le32 *in)
 	ROUND(bbb, ccc, ddd, eee, aaa, F1, KK5, in[11], 11);
 
 	/* Swap contents of "e" registers */
-	tmp = ee; ee = eee; eee = tmp;
+	swap(ee, eee);
 
 	/* combine results */
 	state[0] += aa;
-- 
2.7.4

