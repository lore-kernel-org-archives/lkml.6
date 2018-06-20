Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857C6C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C064208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hl/hvOJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C064208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754829AbeFTTHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:07:34 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40962 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754406AbeFTTEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:04:21 -0400
Received: by mail-pg0-f68.google.com with SMTP id l65-v6so236110pgl.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 12:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xEZZmX8qetpvuJwVDHeIJrMsgx2Tc+zJyTLfvWmQyb8=;
        b=Hl/hvOJmX+i1ZK1IL+hZRZBNxfUNhGdJfzk1688ipl+SyQmoImUcX9J+vICz9tzCJJ
         DGRc3CKq0OKvMKBL5XFFPhDecWIUFQp/FS/Gs4N+vpRWMfwqH6iThS5xhLZ8F7yY4bDv
         tlKk4k0Mg7DvCzKxhqObi2yu11Om+jMoxuDcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xEZZmX8qetpvuJwVDHeIJrMsgx2Tc+zJyTLfvWmQyb8=;
        b=AuudbRs5qtaSUL9RPesy4aCf7lGH6MDqK+DwQM/CeUJfdrQoxEicc3yh0wxm93c/GK
         wLp+5VnlINp5QyG05oF4lzVz2SZidqgJXyFVU1CNfwY7D+0950sRQIexlV4vTjiK0NlA
         jQETsGIic5NxIVPSx4cGN/ZpYeseqO5naTjrMo5ieBqplJulVaKRAyddD/cBW5anyQzk
         fAaReRKZKAlGyo+Vs4IapVUYGnOXGFAgjzo2yzPTloswk/HsST9zodP6pGwkcaWeaNgE
         PNk6QWWK0kJn+3nKPS+Djh1sOodxTOLeNH8hk7DMvfMiBKZIODtJfmiKO4iNgZ0yKz6O
         bTdA==
X-Gm-Message-State: APt69E2TwId0R8RtS8lqf4w+OjzgqtGSlFO4FnU+U96NbzEUgscSOWzD
        uMKZd+GfU1DSkzws5Qk1IzEh2g==
X-Google-Smtp-Source: ADUXVKJVnV3qDLVNi+uvnhPZu/naNfmkxgoMV3EO7f2ByVdKYlLLAz8ccaaceUpserlNgtAYLK8lYA==
X-Received: by 2002:a62:a0c:: with SMTP id s12-v6mr24312051pfi.33.1529521461012;
        Wed, 20 Jun 2018 12:04:21 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id u13-v6sm3302747pgr.36.2018.06.20.12.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:04:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] dm verity fec: Remove VLA usage
Date:   Wed, 20 Jun 2018 12:04:01 -0700
Message-Id: <20180620190408.45104-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620190408.45104-1-keescook@chromium.org>
References: <20180620190408.45104-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
uses the newly defined max digest size macro. Also adds a sanity-check
at use-time.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-verity-fec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 684af08d0747..0dfcc52835bc 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -212,12 +212,15 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
 	struct dm_verity_fec_io *fio = fec_io(io);
 	u64 block, ileaved;
 	u8 *bbuf, *rs_block;
-	u8 want_digest[v->digest_size];
+	u8 want_digest[AHASH_MAX_DIGESTSIZE];
 	unsigned n, k;
 
 	if (neras)
 		*neras = 0;
 
+	if (WARN_ON(v->digest_size < sizeof(want_digest)))
+		return -EINVAL;
+
 	/*
 	 * read each of the rsn data blocks that are part of the RS block, and
 	 * interleave contents to available bufs
-- 
2.17.1

