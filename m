Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCB2C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7382089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7382089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933873AbeGJOne (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:43:34 -0400
Received: from gateway30.websitewelcome.com ([192.185.147.85]:27565 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933849AbeGJOnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:43:32 -0400
X-Greylist: delayed 1207 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jul 2018 10:43:32 EDT
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 57C1D1BC52
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 09:23:25 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ctXZfP0QKbXuJctXrfYCaG; Tue, 10 Jul 2018 09:23:25 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=59090 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fctXZ-0028AF-IF; Tue, 10 Jul 2018 09:22:53 -0500
Date:   Tue, 10 Jul 2018 09:22:52 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Stephan Mueller <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] crypto: dh - fix memory leak
Message-ID: <20180710142252.GA19600@embeddedor.com>
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
X-Exim-ID: 1fctXZ-0028AF-IF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:59090
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case memory resources for *base* were allocated, release them
before return.

Addresses-Coverity-ID: 1471702 ("Resource leak")
Fixes: e3fe0ae12962 ("crypto: dh - add public key verification test")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 crypto/dh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/dh.c b/crypto/dh.c
index 8f79269..09a44de 100644
--- a/crypto/dh.c
+++ b/crypto/dh.c
@@ -174,7 +174,7 @@ static int dh_compute_value(struct kpp_request *req)
 		}
 		ret = dh_is_pubkey_valid(ctx, base);
 		if (ret)
-			goto err_free_val;
+			goto err_free_base;
 	} else {
 		base = ctx->g;
 	}
-- 
2.7.4

