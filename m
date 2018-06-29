Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C384FC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8011727980
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UdR9mAoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8011727980
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935950AbeF2A2z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:28:55 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38839 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeF2A2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:28:52 -0400
Received: by mail-pf0-f193.google.com with SMTP id j17-v6so3356667pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aHfzmuE3dXR4IAoiUCBdTyidzm+NOXbAHoWt0SfC0Yk=;
        b=UdR9mAoS/Wp+RLEdrcANBwtdyBkNSaq40jFaJ69AxxHtf+VWplySIlD04o8r2jXeLM
         tOdmVZW4t1rQEnx7tdVClJYwSX7OP5HgcMrJGvQbQXPCmmlFBaZa6ftkaRPFTpuUpzLj
         0JlZZ6uJCFLcVcEDlaMDr8LezDK9fsEEOVyeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aHfzmuE3dXR4IAoiUCBdTyidzm+NOXbAHoWt0SfC0Yk=;
        b=DKkUt2c+j0aMTRCGhObmdbXO4i0sY/ys8vUfMeD+VoM1xvX1LLZ90QQHqzIw4XMOVn
         fuA1Jj3I0KkJ3HyQMtpHldxhqP8oAY+QQhH7j/K6+hx/ZFqgIY1MpjDwdeI7rofXxefW
         8zlc1laWrw/SBOA2/eiwHQhMpjNxkM6X1ub1w6U+1j1o/Y3zQpjMnqfkjfJSfKIhLDxK
         8cyTLnmFc8bN/aHdQloiKsiJ6ygY9gM7z09G5uGN9kLguHyHMXp9zfMEbFPXiSsTQj8z
         K9M6CYSmCztyfl1xrNWUMDHMk3V3AjOnC80gjXdGGyZ6+09gOHZrI7txPqhRNzDn+8TU
         raDQ==
X-Gm-Message-State: APt69E15+Rcq82C3ufiomZce9mJsB2hTyaRfQx6IPv7rMim28BTUkG/m
        XrUlgHsT4D1nt06Fk3KcsZcQWA==
X-Google-Smtp-Source: AAOMgpd60+2CVuyo2L93K8tihz/MQ29GpDfbqJ+eRmd0T+I8YwhoggKDxRlS0uFoFJH4LmeMpikyeQ==
X-Received: by 2002:a65:4acd:: with SMTP id c13-v6mr5843467pgu.436.1530232132260;
        Thu, 28 Jun 2018 17:28:52 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r7-v6sm7956591pfd.154.2018.06.28.17.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 17:28:48 -0700 (PDT)
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
Subject: [PATCH v3 2/9] crypto: cbc: Remove VLA usage
Date:   Thu, 28 Jun 2018 17:28:36 -0700
Message-Id: <20180629002843.31095-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629002843.31095-1-keescook@chromium.org>
References: <20180629002843.31095-1-keescook@chromium.org>
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

