Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A46C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF759205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z2S00Yj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF759205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbeKBI5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:57:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34737 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbeKBI5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:57:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id k1-v6so119107pgq.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 16:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2klnBPLZef60qy5uM5/LdXKrX1GqPbSTQ0lUDrVthn8=;
        b=Z2S00Yj0FLMEqBs+c3b6ec/EmEEFdp7fAyvoeUDNBWoc0QrcnuUKhzUhBq0TnoMTpI
         /oUStYeXSlfkRZvjmsFXYMCwatEd437qKhOzRYXIG+38Yps3K1htSsdo8nGW3CvdPA0E
         5WWIi8Itp/I8QAGdtwAtcISCBD7XlRpxO0Qhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2klnBPLZef60qy5uM5/LdXKrX1GqPbSTQ0lUDrVthn8=;
        b=P+fFzxkol5QmWiRgS12c4lWyhu5MDd1piKRAZJGEZmuizgtvR7UslC9rYkAmaXtIud
         yrNwJIfPBAzdJvLR3HKSOt7758eSCsrZyhw20a3+GXEK2+Q+u17m7p16hNDqy3Z+LM4f
         zx+5Ja1MPotG1mA5tAsRzso/I97I1W9ZosXchPkjs4U2gvQRxL4cejaGtGD5JTpl6sYw
         6EAk7ojyTeDZz74S9Ym6dClw5xtH6tq3Wh24dkFahAZJjfeJCMyptRJHFhTQhnliKEXO
         pkkWdv/td9sy3htXaJHchNRqP5bCPvpaJ1fU/RadIFdUBmsgLCqSodr0Mt/ylrkCLZvF
         ztXw==
X-Gm-Message-State: AGRZ1gKVy6LsklUhkw9ZbuvoenFHFreE53c/5bgdehDT72NviTMh/V6H
        /wWODPjSIqiMN34UKZHtpJ5mxA==
X-Google-Smtp-Source: AJdET5c/cAA/2YItwHTptFfjeWEGNpPH6F1UraWQIxgioHBc0P77Tl9GV9H9C39iAkc6FE23N8lhhg==
X-Received: by 2002:a65:4646:: with SMTP id k6mr8800602pgr.153.1541116326392;
        Thu, 01 Nov 2018 16:52:06 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 27-v6sm46761870pfm.36.2018.11.01.16.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 16:52:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 2/8] pstore: Do not use crash buffer for decompression
Date:   Thu,  1 Nov 2018 16:51:54 -0700
Message-Id: <20181101235200.28584-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181101235200.28584-1-keescook@chromium.org>
References: <20181101235200.28584-1-keescook@chromium.org>
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

