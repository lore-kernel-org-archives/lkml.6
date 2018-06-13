Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E117CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4EF2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecOMwxPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4EF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934928AbeFMJ3a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:29:30 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34635 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933498AbeFMJ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:29:29 -0400
Received: by mail-wm0-f50.google.com with SMTP id l15-v6so17945299wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfert-encoding;
        bh=G+u3FEX3sVcxDQLvHTX1yrnc4HzdxVX9v3vb88Fav4Q=;
        b=ecOMwxPV/8v1UVE24c6MiN19qFKIAnAn7SUZdOglBH55EGQC9WKHTaU3zdxS3x1t8w
         o+ey25OPxUh2uC1Set7TE2JL2MVmLE8/ZcZs0LKtpfvOsK95eJkyi1pgpugb+ElpL4AQ
         M6N1W2vv+T6MeRqvHMh+QR+Qp42bkbhuUB8Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfert-encoding;
        bh=G+u3FEX3sVcxDQLvHTX1yrnc4HzdxVX9v3vb88Fav4Q=;
        b=Jb8LNEqDh67snuiK5aIRONo8e2XjEFjVn6ztp2zLLEFtLACxHoYzYxHaFRDC1p1KO+
         4kRFqB5U27qz9jWyYCax6ooJdu4hzEUbeFhTAtwUGHJLJdmfNc5ZQ8rHwWzpSaMJR9D8
         KzhNpo6pnHdJ4NihS/BUxZCgiARQGWF9JaKoTN4bzeVHfUPOqFj/gr+pxJubBc0qdlmA
         c5IIiWE6IqLKwxLFMruayotjfymVq7HWs9xqsMmKGerinkOm+PVxFdQpreuqBwXucQZf
         XuYINnDQoTlh7xrP+/Bw8x5axS8TOqx9WmgqhKoJQWy47unD4G1viikCFND8onzEO5fq
         gCmA==
X-Gm-Message-State: APt69E2LiH/a0SWKjk90AVpNj+ySkZ03rxsLyQoD5ADguKkiJAXrzFPU
        l9o6mM/5WDO2ayS2ZCz5gKLBjA==
X-Google-Smtp-Source: ADUXVKLPlK7PNQXDsKXUMV/aMT/JwWqYkdfnDtXLpYFjLPwgFQV/wUKrIpbKWTUt3LcsL2jlHq7ShQ==
X-Received: by 2002:a1c:124f:: with SMTP id 76-v6mr3011270wms.29.1528882168120;
        Wed, 13 Jun 2018 02:29:28 -0700 (PDT)
Received: from localhost.localdomain (aig34-1-88-167-228-121.fbx.proxad.net. [88.167.228.121])
        by smtp.gmail.com with ESMTPSA id v2-v6sm1514392wmh.41.2018.06.13.02.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 02:29:27 -0700 (PDT)
From:   Thierry Escande <thierry.escande@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] lib/test_printf.c: call wait_for_random_bytes() before plain %p tests
Date:   Wed, 13 Jun 2018 11:29:19 +0200
Message-Id: <20180613092919.24075-1-thierry.escande@linaro.org>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the test_printf module is loaded before the crng is initialized, the
plain 'p' tests will fail because the printed address will not be hashed
and the buffer will contain "(ptrval)" instead.
Since we cannot wait for the crng to be initialized for an undefined
time, both plain 'p' tests now accept the string "(ptrval)" as a valid
result and print a warning message.

Signed-off-by: Thierry Escande <thierry.escande@linaro.org>

---

Change in v2:
- Remove wait_for_random_bytes() usage
- Removed Acked-by from Tobin as the proposed solution is not the same
  anymore.

 lib/test_printf.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 71ebfa43ad05..a625e3749566 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -206,6 +206,7 @@ test_string(void)
 #define PTR_WIDTH 16
 #define PTR ((void *)0xffff0123456789ab)
 #define PTR_STR "ffff0123456789ab"
+#define PTR_VAL_NO_CRNG "        (ptrval)"
 #define ZEROS "00000000"	/* hex 32 zero bits */
 
 static int __init
@@ -216,7 +217,16 @@ plain_format(void)
 
 	nchars = snprintf(buf, PLAIN_BUF_SIZE, "%p", PTR);
 
-	if (nchars != PTR_WIDTH || strncmp(buf, ZEROS, strlen(ZEROS)) != 0)
+	if (nchars != PTR_WIDTH)
+		return -1;
+
+	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
+		pr_warn("crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
+			PTR_VAL_NO_CRNG);
+		return 0;
+	}
+
+	if (strncmp(buf, ZEROS, strlen(ZEROS)) != 0)
 		return -1;
 
 	return 0;
@@ -227,6 +237,7 @@ plain_format(void)
 #define PTR_WIDTH 8
 #define PTR ((void *)0x456789ab)
 #define PTR_STR "456789ab"
+#define PTR_VAL_NO_CRNG "(ptrval)"
 
 static int __init
 plain_format(void)
@@ -245,7 +256,16 @@ plain_hash(void)
 
 	nchars = snprintf(buf, PLAIN_BUF_SIZE, "%p", PTR);
 
-	if (nchars != PTR_WIDTH || strncmp(buf, PTR_STR, PTR_WIDTH) == 0)
+	if (nchars != PTR_WIDTH)
+		return -1;
+
+	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
+		pr_warn("crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
+			PTR_VAL_NO_CRNG);
+		return 0;
+	}
+
+	if (strncmp(buf, PTR_STR, PTR_WIDTH) == 0)
 		return -1;
 
 	return 0;
-- 
2.14.1

