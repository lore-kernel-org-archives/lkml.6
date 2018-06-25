Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9B3C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825692614F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GsJrtRFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825692614F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeFYVKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:10:41 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41062 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeFYVKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:10:37 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so7408607ply.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qr59vqedVB5klU81m0iZ3WgC5xyfInatalEuZ2Xgijk=;
        b=GsJrtRFxnd71zViqGxB+yJX/mgolSv08xivt744u7NcNz39pW0SgcG2o4mxzvceCNM
         LY9bflwFGjR3p0PRSQG/KxCVedWPbnmYVpXvrIb7xbsZFQdyJBoUWoBZf7lic2fI4/am
         zuKo3uKnAVzZG9HkfTEvesH/q8Eu7dn0YShxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qr59vqedVB5klU81m0iZ3WgC5xyfInatalEuZ2Xgijk=;
        b=OtsSLTuZlOzFO/cGKZoeF2ZFRS3nMt6ecpzW8/nb7HrrLJGoV7cTZ6Ry/h+a9cN4uP
         YtudBTaPdvFRNTjnMMtAjSyRrm/ZeFi7Jr/9zDnpy3Rp/Tneziz3OtE7djUtzIRzjPtS
         FW1yYzxKrlP/XWySmupiDwPNT9DClCgh9672S08Y/rMqtJFOOAOKCqXCYXKfNdUJSIqW
         SoQhfQidzMA0wFHHY4L+ebxdRmO4YZ7daFK1i4IK7t1d4OtEqo8mJ1rh0BUka7+qNuN0
         QMsyHvnNfDNZsD251wDL/GUfn5UtqQP+jHxfTQLoGMLVy3Hl9/c+AqMnwkZew/cggCMj
         Z76g==
X-Gm-Message-State: APt69E1Xz58+dlQvsJFPv5cnL69/9oa2FkKK17Q9a8v488hzHGKuRgJ2
        /00vhQDFAeRGJAkxCSQCPv9IHnzMB2U=
X-Google-Smtp-Source: ADUXVKJ3T7GFvDEofInoLJlM4kjJ82G1eAtXdS7HKqXfS0Yuz9icf9Swmnv+fIoJLgTkmSS6WnP5tg==
X-Received: by 2002:a17:902:788e:: with SMTP id q14-v6mr13775254pll.234.1529961037503;
        Mon, 25 Jun 2018 14:10:37 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y2-v6sm11958636pfa.43.2018.06.25.14.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 14:10:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/11] crypto: cbc: Remove VLA usage
Date:   Mon, 25 Jun 2018 14:10:17 -0700
Message-Id: <20180625211026.15819-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625211026.15819-1-keescook@chromium.org>
References: <20180625211026.15819-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
uses the upper bounds on blocksize. Since this is always a cipher
blocksize, use the existing cipher max blocksize.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
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

