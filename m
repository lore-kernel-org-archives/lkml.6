Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363D0C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F2E26153
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zuy9iRPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F2E26153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755528AbeFYVKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:10:49 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40832 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbeFYVKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:10:46 -0400
Received: by mail-pl0-f65.google.com with SMTP id t6-v6so2051483plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4xyqODsFc3n/yIQXn4z6fOObv4jQsUhj2N+PB1wKomI=;
        b=Zuy9iRPa8pghyvXu5shjpfe8FP3W13+cM7Yn9PL8kkWEk4RIxSY5k2w+mAZO5WHgH2
         5ryr9rq8jpWH5QFu8svTnNpcLL+A950ipSLBVTUuV4sgSt1YTZAYd3PM77w/zvDpegta
         ck9lG8CHwxSKS7Z+4OsRv39RBkvqFWHtj4s9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4xyqODsFc3n/yIQXn4z6fOObv4jQsUhj2N+PB1wKomI=;
        b=IWq8L3fS1yDfNgWfQQu0X8hht071CXckaXG+vgJ7VvdQ1a0s0QUob3dJ/FYUrUJuuh
         M0uk7kkZfJuOHRcgCaEIFUNe5ZNHrc0PbUPhz6JXX4RbeM9NbMY33loeuyH65012/4vi
         1m3wSQu514nLx4uzVXoDrKJJ8tedqUKKgisajvpTPt4zmDqNuPau/kyZMKrYwYIrOBbz
         cai7nlQ9YWdD/qCh1DUlIIdoNzPKTXRymM/8uNK8zTiDCfXtPgjdoin4tAiEb4CH201Z
         JDtJeIhbS0Dqug16zbOM9HxmgAPF3hp5snXzKYwyd+31tYqC1oleaXrZK58ohjcidyqd
         h9Bg==
X-Gm-Message-State: APt69E1DjtcOKigTKQkjQflTC3d0PjyhFka8vGWrplR9ydqQxFGNAJXu
        Ro2Ep/VUZSPMasIAXC5jlllUcA==
X-Google-Smtp-Source: ADUXVKJF0nCTcZxBDoealoL1qKvfydHL8+t2hdBFXZJE1pc/WbG7U0TuRQq/hGhuVt5bIT5jMHHqxQ==
X-Received: by 2002:a17:902:758e:: with SMTP id j14-v6mr13721023pll.160.1529961045579;
        Mon, 25 Jun 2018 14:10:45 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id e63-v6sm16509406pfk.133.2018.06.25.14.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 14:10:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/11] crypto: qat: Remove VLA usage
Date:   Mon, 25 Jun 2018 14:10:23 -0700
Message-Id: <20180625211026.15819-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625211026.15819-1-keescook@chromium.org>
References: <20180625211026.15819-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this uses
the new upper bound for the stack buffer. Also adds a sanity check.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: qat-linux@intel.com
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/qat/qat_common/qat_algs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index 1138e41d6805..a28edf7b792f 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -153,8 +153,8 @@ static int qat_alg_do_precomputes(struct icp_qat_hw_auth_algo_blk *hash,
 	struct sha512_state sha512;
 	int block_size = crypto_shash_blocksize(ctx->hash_tfm);
 	int digest_size = crypto_shash_digestsize(ctx->hash_tfm);
-	char ipad[block_size];
-	char opad[block_size];
+	char ipad[MAX_ALGAPI_BLOCKSIZE];
+	char opad[MAX_ALGAPI_BLOCKSIZE];
 	__be32 *hash_state_out;
 	__be64 *hash512_state_out;
 	int i, offset;
@@ -164,6 +164,10 @@ static int qat_alg_do_precomputes(struct icp_qat_hw_auth_algo_blk *hash,
 	shash->tfm = ctx->hash_tfm;
 	shash->flags = 0x0;
 
+	if (WARN_ON(block_size > sizeof(ipad) ||
+		    sizeof(ipad) != sizeof(opad)))
+		return -EINVAL;
+
 	if (auth_keylen > block_size) {
 		int ret = crypto_shash_digest(shash, auth_key,
 					      auth_keylen, ipad);
-- 
2.17.1

