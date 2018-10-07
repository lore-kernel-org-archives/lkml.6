Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D85C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 12:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061AD20882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 12:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061AD20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schupikov.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeJGTIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 15:08:15 -0400
Received: from gravityforest ([185.233.107.85]:47904 "EHLO
        gravity.schupikov.de" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeJGTIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 15:08:15 -0400
Received: from zlid.rus.uni-stuttgart.de (s-8d3a2233.on.site.uni-stuttgart.de [141.58.34.51])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by gravity.schupikov.de (Postfix) with ESMTPSA id 58CB55D146;
        Sun,  7 Oct 2018 14:01:11 +0200 (CEST)
From:   Michael Schupikov <michael@schupikov.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Michael Schupikov <michael@schupikov.de>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto/testmgr.c: fix sizeof() on COMP_BUF_SIZE
Date:   Sun,  7 Oct 2018 13:58:10 +0200
Message-Id: <20181007115810.27779-1-michael@schupikov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After allocation, output and decomp_output both point to memory chunks of
size COMP_BUF_SIZE. Then, only the first bytes are zeroed out using
sizeof(COMP_BUF_SIZE) as parameter to memset(), because
sizeof(COMP_BUF_SIZE) provides the size of the constant and not the size of
allocated memory.

Instead, the whole allocated memory is meant to be zeroed out. Use
COMP_BUF_SIZE as parameter to memset() directly in order to accomplish
this.

Fixes: 336073840a872 ("crypto: testmgr - Allow different compression results")

Signed-off-by: Michael Schupikov <michael@schupikov.de>
---
 crypto/testmgr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index a1d42245082a..790aa3536631 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -1400,8 +1400,8 @@ static int test_comp(struct crypto_comp *tfm,
 		int ilen;
 		unsigned int dlen = COMP_BUF_SIZE;
 
-		memset(output, 0, sizeof(COMP_BUF_SIZE));
-		memset(decomp_output, 0, sizeof(COMP_BUF_SIZE));
+		memset(output, 0, COMP_BUF_SIZE);
+		memset(decomp_output, 0, COMP_BUF_SIZE);
 
 		ilen = ctemplate[i].inlen;
 		ret = crypto_comp_compress(tfm, ctemplate[i].input,
@@ -1445,7 +1445,7 @@ static int test_comp(struct crypto_comp *tfm,
 		int ilen;
 		unsigned int dlen = COMP_BUF_SIZE;
 
-		memset(decomp_output, 0, sizeof(COMP_BUF_SIZE));
+		memset(decomp_output, 0, COMP_BUF_SIZE);
 
 		ilen = dtemplate[i].inlen;
 		ret = crypto_comp_decompress(tfm, dtemplate[i].input,
-- 
2.19.0

