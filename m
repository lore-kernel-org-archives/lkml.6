Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84801C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D1D20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tk5u2ZEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D1D20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390378AbeGKUnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:43:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46511 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390297AbeGKUmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:42:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id l123-v6so19127207pfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BYgigRdBSanSiafl9f2cJhj28CjRYh2SZJXlKmlCU5M=;
        b=Tk5u2ZEdgT4GcB9YKGzNz+e0FdL9GVQD2Nj/usRguJdv8ygdh+eZFFyoPjIDxcUv6L
         Pd1XCP6n2ehOtIb+bmW0gQFq2x4MzK2QNabtOeFYwliTZQCSUusOiCZPen7L9TfVN4Nw
         Q3w8iUi9KR62d/WZRx19mNBySN60K5F5Av8VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BYgigRdBSanSiafl9f2cJhj28CjRYh2SZJXlKmlCU5M=;
        b=IpUTN5Zu4HDzyAmEIWeamId/zJEBE2YNRGkGIAZ/giKjyOU1HlMSF3Wxs6WdFnMUjz
         ATTeKVZajHA+SDcV1tyDHOzdxgzHK8qE/GH3OOj/yw3BBT+27D1fOahAjzhSuBlMfNc8
         9VnW+VG0DqI0NuC6ZfszlCJdfmNfa25fBBToUyVuR8SC2k+AsK2svbdkMxe7jgMNhcO6
         Xp/WRZ5MDFCQgVobYmMWB/FPouEN2U4a+TddsB6vpVmqFPX7gQ/6cwvP03A60Tx2Jgrw
         mBOO1YZsl5ROvaBlIm1MKqwMTF/KNv2HWu6s7fB6NVRVH0RVHeW4lv8H6E+6DXlZxdPR
         Cm+g==
X-Gm-Message-State: AOUpUlFcfiVt82DJCl8wXPKkMxj0/3an3udUZVs3W/KkSb9E1isYzZHL
        tGzf7DAJvWMQsQYMSeWPS4rYhg==
X-Google-Smtp-Source: AAOMgpcbGvyaC0663tHSUhyRcsEeM4uUlf1YQYEu5t8vyT6fhQdQq7iAm77AiuUtI2NIBdE+jK1HMA==
X-Received: by 2002:a65:5b08:: with SMTP id y8-v6mr113237pgq.297.1531341395065;
        Wed, 11 Jul 2018 13:36:35 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id u17-v6sm71237117pfa.176.2018.07.11.13.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:36:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/14] crypto: qat: Remove VLA usage
Date:   Wed, 11 Jul 2018 13:36:13 -0700
Message-Id: <20180711203619.1020-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711203619.1020-1-keescook@chromium.org>
References: <20180711203619.1020-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this uses
the new upper bound for the stack buffer. Also adds a sanity check.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

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

