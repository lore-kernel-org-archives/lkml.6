Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A535ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4116D208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eh3Y30hF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4116D208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbeGQEwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:52:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35427 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbeGQEwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:52:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6-v6so8393813pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 21:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aHfzmuE3dXR4IAoiUCBdTyidzm+NOXbAHoWt0SfC0Yk=;
        b=eh3Y30hFxq8zzS5bgz1/yisxsCsql22krqLoqnmXb4Os2HAsez72thMO8F0KFWlZ+G
         yu9O72DhS0e/oEp2IWBk7c1XYqnHKZgNB4ATkDOfaeSvkCTkSTkhREVLq3/A4rTVua0O
         wM3mMiuvr63gvXFOO9vCNj7S+BzC0HBtSt0Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aHfzmuE3dXR4IAoiUCBdTyidzm+NOXbAHoWt0SfC0Yk=;
        b=DPSivalU6CUyZdIbeGFhsJcGhJTq6BPMoebjs0WA8VZqbah+7Xr3sGoMK9UWuTo13j
         OJbIyF2y2QafXUxsmD0waKoVAvhK680wBqT/nxW6/pfGi/5f4QbhK/azETqV89d0pS2q
         mx4EX1HdUeJjedQjPOu3wgKbDBxzq4Qw5wOotQ2keDXNLcxK+hf7tTOwjOqd5z1R9qVd
         m/lVQAxWvc9S8cJ9KYKhqt1VugNfOxAt2esRgUg58aybAW/0lAxumVqR4MW9/oHzb3VE
         qMCMGwGMwte7iVy84KaMY96k+TGW2rlP8DkdaqvWRsixdvW769dJLrNfjGbHGd3TCvOC
         WWXw==
X-Gm-Message-State: AOUpUlEMy4K+YOX9IvdluNwscRkL0JdW/fqLeyR1RfeHD6qh5cFXjOk2
        nSm9vlQLpAvybDhpE1UR7lszLA==
X-Google-Smtp-Source: AAOMgpdcO98OZzfhNHC/IsThpw9qR9IIdeYlxq6C/CkJVLA1qGomG2mh4D9IYlvmrVQZsi/xq8JzFQ==
X-Received: by 2002:a63:5463:: with SMTP id e35-v6mr5264pgm.115.1531801317287;
        Mon, 16 Jul 2018 21:21:57 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c9-v6sm43949489pgp.38.2018.07.16.21.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:21:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/11] crypto: cbc: Remove VLA usage
Date:   Mon, 16 Jul 2018 21:21:41 -0700
Message-Id: <20180717042150.37761-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717042150.37761-1-keescook@chromium.org>
References: <20180717042150.37761-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
uses the upper bounds on blocksize. Since this is always a cipher
blocksize, use the existing cipher max blocksize.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/cbc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/crypto/cbc.h b/include/crypto/cbc.h
index f5b8bfc22e6d..47db0aac2ab9 100644
--- a/include/crypto/cbc.h
+++ b/include/crypto/cbc.h
@@ -113,7 +113,9 @@ static inline int crypto_cbc_decrypt_inplace(
 	unsigned int bsize = crypto_skcipher_blocksize(tfm);
 	unsigned int nbytes = walk->nbytes;
 	u8 *src = walk->src.virt.addr;
-	u8 last_iv[bsize];
+	u8 last_iv[MAX_CIPHER_BLOCKSIZE];
+
+	BUG_ON(bsize > sizeof(last_iv));
 
 	/* Start of the last block. */
 	src += nbytes - (nbytes & (bsize - 1)) - bsize;
-- 
2.17.1

