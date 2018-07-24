Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80527ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23F920856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23F920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388574AbeGXPUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:20:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52312 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388460AbeGXPUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:20:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28DFD7A9;
        Tue, 24 Jul 2018 07:14:01 -0700 (PDT)
Received: from sugar.kfn.arm.com (E110176.Emea.Arm.com [10.50.4.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B04F63F237;
        Tue, 24 Jul 2018 07:13:59 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] crypto: ccree: allow bigger than sector XTS op
Date:   Tue, 24 Jul 2018 15:12:46 +0100
Message-Id: <1532441567-11694-5-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532441567-11694-1-git-send-email-gilad@benyossef.com>
References: <1532441567-11694-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ccree driver had a sanity check that we are not asked
to encrypt an XTS buffer bigger than a sane sector size
since XTS IV needs to include the sector number in the IV
so this is not expected in any real use case.

Unfortunately, this breaks cryptsetup benchmark test which
has a synthetic performance test using 64k buffer of data
with the same IV.

Remove the sanity check and allow the user to hang themselves
and/or run benchmarks if they so wish.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_cipher.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index 9da0ecc..7623b299 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -19,8 +19,6 @@
 
 #define template_skcipher	template_u.skcipher
 
-#define CC_MIN_AES_XTS_SIZE 0x10
-#define CC_MAX_AES_XTS_SIZE 0x2000
 struct cc_cipher_handle {
 	struct list_head alg_list;
 };
@@ -98,8 +96,7 @@ static int validate_data_size(struct cc_cipher_ctx *ctx_p,
 	case S_DIN_to_AES:
 		switch (ctx_p->cipher_mode) {
 		case DRV_CIPHER_XTS:
-			if (size >= CC_MIN_AES_XTS_SIZE &&
-			    size <= CC_MAX_AES_XTS_SIZE &&
+			if (size >= AES_BLOCK_SIZE &&
 			    IS_ALIGNED(size, AES_BLOCK_SIZE))
 				return 0;
 			break;
-- 
2.7.4

