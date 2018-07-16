Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC865ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7441C20873
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NK+L67Z8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7441C20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbeGPEWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:22:20 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45513 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbeGPEWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:22:20 -0400
Received: by mail-pf0-f195.google.com with SMTP id i26-v6so14207961pfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 20:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=akYEvHs19WJRAj6KNIr0rURqc8YhNLPEt8XljT6qIEA=;
        b=NK+L67Z8YrbTGWqIbP1tdk/eLN8CZR8/4FwV7rnuVddvD0/qW587gIJLBdShWEkrHf
         eEPi/UAutmFTLk7Et8Ba/gjhMC1Mp/p2/gq0+HhXWZQJVmzr+OEFmCkzCN6/OhiBy3T7
         Cjv9utz8UW9kYy54Q23x4Rwniwz/AdNQxIrSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=akYEvHs19WJRAj6KNIr0rURqc8YhNLPEt8XljT6qIEA=;
        b=jpRo7NmnPYrNBK31eyIv3Qui3YHgd/WcKV4vp0J38tiGlVGjW3S6tZwfN5GP/q08/F
         EUOrYLCOsO5RmigaRXrarVoDDF+Tr4mZkB/y1un2NTKArfJSMt+tkN6TIAANLwb/TFtG
         l4wMHLzMgDfspbNMSIaAaDBdKY4YApbNrlsMksPRoBzcLd6BGcXc4adUm9QkdJVoD13G
         YvF7ElyfZgNKTcSH2wqT73FS727caewEl5uJ1ftZ94fyAbC0yX7NglpUGCTMbhmYdffV
         cBD5jDmY/YFW9F5DFx4IPnSbiJGfYY6jvm5/Q4LlVclMAob5hZTs8guY60mIjlUZ0pJz
         TspQ==
X-Gm-Message-State: AOUpUlF6sifg5EgygcP9jeFDf1wvKAS2K1a7tj7QrkqinFXqtrPKjZm0
        kg+mS1w80EnsHWIEdKBRNPd1OA==
X-Google-Smtp-Source: AAOMgpdTQkScZVJkLsz93f2WZhYAJkaCPnjWnQWvi5XJ51jWQ1LCYv0NxEeMUdixMVQZrRKDyv4I6g==
X-Received: by 2002:a62:9541:: with SMTP id p62-v6mr16361469pfd.152.1531713419276;
        Sun, 15 Jul 2018 20:56:59 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q5-v6sm24985865pfj.27.2018.07.15.20.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 20:56:58 -0700 (PDT)
Date:   Sun, 15 Jul 2018 20:56:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/power/64: Remove VLA usage
Message-ID: <20180716035657.GA32180@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
removes the discouraged use of AHASH_REQUEST_ON_STACK by switching to
shash directly and allocating the descriptor in heap memory (which should
be fine: the tfm has already been allocated there too).

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/power/hibernate_64.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index 67ccf64c8bd8..0ed01bb935a6 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -233,28 +233,31 @@ struct restore_data_record {
  */
 static int get_e820_md5(struct e820_table *table, void *buf)
 {
-	struct scatterlist sg;
-	struct crypto_ahash *tfm;
+	struct crypto_shash *tfm;
+	struct shash_desc *desc;
 	int size;
 	int ret = 0;
 
-	tfm = crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
+	tfm = crypto_alloc_shash("md5", 0, 0);
 	if (IS_ERR(tfm))
 		return -ENOMEM;
 
-	{
-		AHASH_REQUEST_ON_STACK(req, tfm);
-		size = offsetof(struct e820_table, entries) + sizeof(struct e820_entry) * table->nr_entries;
-		ahash_request_set_tfm(req, tfm);
-		sg_init_one(&sg, (u8 *)table, size);
-		ahash_request_set_callback(req, 0, NULL, NULL);
-		ahash_request_set_crypt(req, &sg, buf, size);
-
-		if (crypto_ahash_digest(req))
-			ret = -EINVAL;
-		ahash_request_zero(req);
-	}
-	crypto_free_ahash(tfm);
+	desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
+		       GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+
+	desc->tfm = tfm;
+	desc->flags = 0;
+
+	size = offsetof(struct e820_table, entries) +
+		sizeof(struct e820_entry) * table->nr_entries;
+
+	if (crypto_shash_digest(desc, (u8 *)table, size, buf))
+		ret = -EINVAL;
+
+	kzfree(desc);
+	crypto_free_shash(tfm);
 
 	return ret;
 }
-- 
2.17.1


-- 
Kees Cook
Pixel Security
