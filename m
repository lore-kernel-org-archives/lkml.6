Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228FEC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F6527986
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iE927FQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F6527986
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030358AbeF2A3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:29:52 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34676 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934370AbeF2A24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:28:56 -0400
Received: by mail-pl0-f66.google.com with SMTP id z9-v6so3564333plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OPrbhpf+OtJBDX2eteghpLvngwKyDU3zwKMrVHOinl0=;
        b=iE927FQLC/dtuYydLTtjp16Fy5TCCWYrfPl2Mb/N3NlnlctG0thJWdzO9v/u7mpBDg
         Fv1tYqWu/YbdNkwIZabAgIIDNoIsFDL7IxVBL2EJBg4qQhbtclFKBc0Ib2HrwhHbT30R
         5u0y0+ESiMR3J60jXiHYCO2crm/bkSoudMwuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OPrbhpf+OtJBDX2eteghpLvngwKyDU3zwKMrVHOinl0=;
        b=X8O13tnLYKbtBMMFf4NgzjURO162BZSwmZI04PfaMyblaSPCzQDKdVfSphg2mudrgS
         TEaRBfTblTfKNWNl2dDBUal1GZwZLAo+UwNAvjNKvuL1cwuImSIlMvm/X+CrK7jw+XxW
         LvAnauETU0ep+iw/HCMHpP8Ou7De4tyBTrh6EiV5Jufuk5opiiAUWPtrTNk6z2QvSsc9
         Kx2qOKARq/RGkdSfQhxaU/WhzlBpF/tnEctgzpx85Okw6s+T1r7vt4EUdqcqMIut4yeD
         XmzmVKn5GmLkDVusMiphkYPphDA7uLcwtxKQ05z4s9ZWd8IUfPkX/Czm8IOFyRwVWVMY
         BmWQ==
X-Gm-Message-State: APt69E1dYH1BhTxzoz7oQEqfQTtDJOqsBJcJr1uSIyKV1cTIpNegN5Mo
        OVXsfJw9Y+hMusiG5/A6abWWpg==
X-Google-Smtp-Source: ADUXVKKv3Ac/J0bhslSL15fpr22AUtyT4hY6o3rUWEyCxI/vh7ssRBymBPxY8544qwy3yHu07d08uA==
X-Received: by 2002:a17:902:bcc3:: with SMTP id o3-v6mr12442696pls.336.1530232135778;
        Thu, 28 Jun 2018 17:28:55 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v13-v6sm17327904pfa.131.2018.06.28.17.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 17:28:53 -0700 (PDT)
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
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/9] crypto: ahash: Remove VLA usage
Date:   Thu, 28 Jun 2018 17:28:39 -0700
Message-Id: <20180629002843.31095-6-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629002843.31095-1-keescook@chromium.org>
References: <20180629002843.31095-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
introduces max size macros for ahash, as already done for shash, and
adjust the crypto user to max state size.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/ahash.c        | 4 ++--
 crypto/algif_hash.c   | 2 +-
 include/crypto/hash.h | 3 +++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/crypto/ahash.c b/crypto/ahash.c
index a64c143165b1..6435bdbe42fd 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -550,8 +550,8 @@ static int ahash_prepare_alg(struct ahash_alg *alg)
 {
 	struct crypto_alg *base = &alg->halg.base;
 
-	if (alg->halg.digestsize > PAGE_SIZE / 8 ||
-	    alg->halg.statesize > PAGE_SIZE / 8 ||
+	if (alg->halg.digestsize > AHASH_MAX_DIGESTSIZE ||
+	    alg->halg.statesize > AHASH_MAX_STATESIZE ||
 	    alg->halg.statesize == 0)
 		return -EINVAL;
 
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index bfcf595fd8f9..8974ee8ebead 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -239,7 +239,7 @@ static int hash_accept(struct socket *sock, struct socket *newsock, int flags,
 	struct alg_sock *ask = alg_sk(sk);
 	struct hash_ctx *ctx = ask->private;
 	struct ahash_request *req = &ctx->req;
-	char state[crypto_ahash_statesize(crypto_ahash_reqtfm(req)) ? : 1];
+	char state[AHASH_MAX_STATESIZE];
 	struct sock *sk2;
 	struct alg_sock *ask2;
 	struct hash_ctx *ctx2;
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 804e87a9510e..5d79e2f0936e 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -64,6 +64,9 @@ struct ahash_request {
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
+#define AHASH_MAX_DIGESTSIZE	512
+#define AHASH_MAX_STATESIZE	512
+
 #define AHASH_REQUEST_ON_STACK(name, ahash) \
 	char __##name##_desc[sizeof(struct ahash_request) + \
 		crypto_ahash_reqsize(ahash)] CRYPTO_MINALIGN_ATTR; \
-- 
2.17.1

