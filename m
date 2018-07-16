Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFC5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923C6208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923C6208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbeGPIFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:05:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeGPIFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:05:31 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C6850CA1;
        Mon, 16 Jul 2018 07:39:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        syzbot+37035ccfa9a0a017ffcf@syzkaller.appspotmail.com,
        syzbot+e073e4740cfbb3ae200b@syzkaller.appspotmail.com,
        linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.17 55/67] crypto: dont optimize keccakf()
Date:   Mon, 16 Jul 2018 09:35:24 +0200
Message-Id: <20180716073452.383199246@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Vyukov <dvyukov@google.com>

commit f044a84e040b85cd609851ac88ae8b54b2cc0b75 upstream.

keccakf() is the only function in kernel that uses __optimize() macro.
__optimize() breaks frame pointer unwinder as optimized code uses RBP,
and amusingly this always lead to degraded performance as gcc does not
inline across different optimizations levels, so keccakf() wasn't inlined
into its callers and keccakf_round() wasn't inlined into keccakf().

Drop __optimize() to resolve both problems.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Fixes: 83dee2ce1ae7 ("crypto: sha3-generic - rewrite KECCAK transform to help the compiler optimize")
Reported-by: syzbot+37035ccfa9a0a017ffcf@syzkaller.appspotmail.com
Reported-by: syzbot+e073e4740cfbb3ae200b@syzkaller.appspotmail.com
Cc: linux-crypto@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/sha3_generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/sha3_generic.c
+++ b/crypto/sha3_generic.c
@@ -152,7 +152,7 @@ static SHA3_INLINE void keccakf_round(u6
 	st[24] ^= bc[ 4];
 }
 
-static void __optimize("O3") keccakf(u64 st[25])
+static void keccakf(u64 st[25])
 {
 	int round;
 


