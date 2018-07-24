Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD216ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682D020875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lhaX8SZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682D020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388797AbeGXR6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:58:55 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43098 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388654AbeGXR5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:57:15 -0400
Received: by mail-pl0-f67.google.com with SMTP id x6-v6so333575plv.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZI2aob70T18+rSqCI2VmsibkGPFJ6uFylB1GNq8x2tU=;
        b=lhaX8SZbZjzXrl4urHtWAlOw0+5v2jhpiueRSlwInGEIhtnoWEcHkEo2Rti0au0kTK
         cyoLrc1bLLVPJzhNPhaWg6wGX2PhkP0GsTsho7i9AdEKJ58RD3bnmHsEP+YDd8PDv2qc
         cWo7fpA1R05gIRDrThrywOkzK8sPxhD1/Sz/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZI2aob70T18+rSqCI2VmsibkGPFJ6uFylB1GNq8x2tU=;
        b=bBKkbWWGMIwu3kpazmJkbdw6zU1g5ZqDioHCzgyT62G+FovDQXyqwL7ZBSbrTvFMjG
         cKZzSXAmXwnK3pmiHmF3a8BuQ8Mi4O10aVdwP/qQD42lNNVxL+AAorHGCZdIgKqk2Ta0
         rN/OLM11G2Gin8wLtHKoZpjDxzzaHY9IeFFm0fJerUJNIWogADmRThw3EF5WGaAnaovv
         T7JVjYFcPVWWHYmowkzQU86IDJ7JIsHhQ2JqO2ptIhcHI8SaRIKfxolsQvNnSrhcuEU7
         Kp3qvuog0oBBZ/yOJ8HbbffbZKreMNK8aSHDNp3IGVNcjPagooKwfYijQFC6gfFpKIut
         7PxQ==
X-Gm-Message-State: AOUpUlHyE9Cmt+qnHoiPtwbkyjXzMZK8d38a3IeYOEgzjwA5023jB54O
        m49sMGqCdCd9nz5jflrsDA3sZA==
X-Google-Smtp-Source: AAOMgpdDfbfeNYrD5Tke9cwk7/M0KCext81YN1e+mYrixCTTS8+Y3+j2yYZwLCcAE6lQGskPdc0BMA==
X-Received: by 2002:a17:902:8506:: with SMTP id bj6-v6mr17572390plb.210.1532450993856;
        Tue, 24 Jul 2018 09:49:53 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d18-v6sm13530804pgo.74.2018.07.24.09.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 09:49:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Will Deacon <will.deacon@arm.com>, dm-devel@redhat.com,
        linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        qat-linux@intel.com, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-afs@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/18] x86/power/64: Remove VLA usage
Date:   Tue, 24 Jul 2018 09:49:28 -0700
Message-Id: <20180724164936.37477-11-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724164936.37477-1-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org>
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
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/x86/power/hibernate_64.c | 36 ++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index 67ccf64c8bd8..f8e3b668d20b 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -233,29 +233,35 @@ struct restore_data_record {
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
+	desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
+		       GFP_KERNEL);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto free_tfm;
 	}
-	crypto_free_ahash(tfm);
 
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
+
+free_tfm:
+	crypto_free_shash(tfm);
 	return ret;
 }
 
-- 
2.17.1

