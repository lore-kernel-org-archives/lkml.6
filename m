Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FB7C64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E81020673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mHPZL/rh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E81020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeK3KQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:16:06 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44804 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeK3KQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:16:05 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so1596165pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2klnBPLZef60qy5uM5/LdXKrX1GqPbSTQ0lUDrVthn8=;
        b=mHPZL/rhOCEwdiyDQ59TWR1YHjYbDDEwUfWxGbqG5PgOn4MBTvsGu8trn9Jk0/6sc3
         B7ERdsGvNcrbFrsBgDumPfoN8vsKzW0/QnE4OG65rCzvj1O/0NZ4sOP7efoZ0GYQ1Zo5
         i7RL2+YMW9PDjnqnXRJwQjy5z5ho4Y9Wx69Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2klnBPLZef60qy5uM5/LdXKrX1GqPbSTQ0lUDrVthn8=;
        b=MuICCMgPRfg6tKPiKp58v70zAeZnAkqlommv3LmxN57hhZtGDyRBP1CxmXa/Yr3Pjv
         QT6DbM11YaNhfQWs7YemOK80CgYP3tajcG5OGlUZesJB4geuETe36haD1/IeMM3Isfzh
         pdKv/6b3YSCZstDmFvQjqIlQyHWRpmxjh7l0fPOxMaVsIP0yL9Y/OWeqlMd5Xb2Odrry
         k34lXG/WhVzlRPlEhyvF6hmfsVneGY7lmFydD/0QBGg3CRjXTXK369CJ3liRzzjTFW5O
         9HRX2WIuzH0057YZWhIbbT/0sZq9EU0GH034CnOt1U+hNFqx2hMcECiNPU97JWMqKHyI
         C56w==
X-Gm-Message-State: AA+aEWY1wMm2drjsBStK2PCI7G0uBBIrNE3Dxgty9rXI7dB0cPjicvbJ
        rshyMVEFNtHvVYr+GKmGl3dAAg==
X-Google-Smtp-Source: AFSGD/Wt8n3o93xbSSnnQ0XhuZLLM8eNxwCNM1EOp27fqh4LNsIRiyXHA4Ul6ubwc1uBxfksVjC0ow==
X-Received: by 2002:a63:5664:: with SMTP id g36mr2839081pgm.313.1543532935960;
        Thu, 29 Nov 2018 15:08:55 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d16sm3456633pgj.21.2018.11.29.15.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:08:51 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -next v2 02/12] pstore: Do not use crash buffer for decompression
Date:   Thu, 29 Nov 2018 15:08:31 -0800
Message-Id: <20181129230841.29955-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129230841.29955-1-keescook@chromium.org>
References: <20181129230841.29955-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pre-allocated compression buffer used for crash dumping was also
being used for decompression. This isn't technically safe, since it's
possible the kernel may attempt a crashdump while pstore is populating the
pstore filesystem (and performing decompression). Instead, just allocate
a separate buffer for decompression. Correctness is preferred over
performance here.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 56 ++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index b821054ca3ed..8b6028948cf3 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -258,20 +258,6 @@ static int pstore_compress(const void *in, void *out,
 	return outlen;
 }
 
-static int pstore_decompress(void *in, void *out,
-			     unsigned int inlen, unsigned int outlen)
-{
-	int ret;
-
-	ret = crypto_comp_decompress(tfm, in, inlen, out, &outlen);
-	if (ret) {
-		pr_err("crypto_comp_decompress failed, ret = %d!\n", ret);
-		return ret;
-	}
-
-	return outlen;
-}
-
 static void allocate_buf_for_compression(void)
 {
 	struct crypto_comp *ctx;
@@ -656,8 +642,9 @@ EXPORT_SYMBOL_GPL(pstore_unregister);
 
 static void decompress_record(struct pstore_record *record)
 {
+	int ret;
 	int unzipped_len;
-	char *decompressed;
+	char *unzipped, *workspace;
 
 	if (!record->compressed)
 		return;
@@ -668,35 +655,42 @@ static void decompress_record(struct pstore_record *record)
 		return;
 	}
 
-	/* No compression method has created the common buffer. */
+	/* Missing compression buffer means compression was not initialized. */
 	if (!big_oops_buf) {
-		pr_warn("no decompression buffer allocated\n");
+		pr_warn("no decompression method initialized!\n");
 		return;
 	}
 
-	unzipped_len = pstore_decompress(record->buf, big_oops_buf,
-					 record->size, big_oops_buf_sz);
-	if (unzipped_len <= 0) {
-		pr_err("decompression failed: %d\n", unzipped_len);
+	/* Allocate enough space to hold max decompression and ECC. */
+	unzipped_len = big_oops_buf_sz;
+	workspace = kmalloc(unzipped_len + record->ecc_notice_size,
+			    GFP_KERNEL);
+	if (!workspace)
 		return;
-	}
 
-	/* Build new buffer for decompressed contents. */
-	decompressed = kmalloc(unzipped_len + record->ecc_notice_size,
-			       GFP_KERNEL);
-	if (!decompressed) {
-		pr_err("decompression ran out of memory\n");
+	/* After decompression "unzipped_len" is almost certainly smaller. */
+	ret = crypto_comp_decompress(tfm, record->buf, record->size,
+					  workspace, &unzipped_len);
+	if (ret) {
+		pr_err("crypto_comp_decompress failed, ret = %d!\n", ret);
+		kfree(workspace);
 		return;
 	}
-	memcpy(decompressed, big_oops_buf, unzipped_len);
 
 	/* Append ECC notice to decompressed buffer. */
-	memcpy(decompressed + unzipped_len, record->buf + record->size,
+	memcpy(workspace + unzipped_len, record->buf + record->size,
 	       record->ecc_notice_size);
 
-	/* Swap out compresed contents with decompressed contents. */
+	/* Copy decompressed contents into an minimum-sized allocation. */
+	unzipped = kmemdup(workspace, unzipped_len + record->ecc_notice_size,
+			   GFP_KERNEL);
+	kfree(workspace);
+	if (!unzipped)
+		return;
+
+	/* Swap out compressed contents with decompressed contents. */
 	kfree(record->buf);
-	record->buf = decompressed;
+	record->buf = unzipped;
 	record->size = unzipped_len;
 	record->compressed = false;
 }
-- 
2.17.1

