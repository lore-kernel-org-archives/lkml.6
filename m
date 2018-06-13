Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D2325C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889AB208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S2RdlVzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889AB208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935434AbeFMRSz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:18:55 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:46693 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935349AbeFMRSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:18:54 -0400
Received: by mail-wr0-f175.google.com with SMTP id v13-v6so3545300wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfert-encoding;
        bh=W8WN1gaVXifDNIN3QmSq6IzPlR5M7ezVmlYt1YIRF88=;
        b=S2RdlVzkapa08DjEcNSKq5Uy6Mp1RtfQ487pnj8h2wzGPih4IT4CPYxPbU9wSRwIYB
         m+8TWXmFUaPgXLVQkcFNgskLwk2ePrgp6acvSb5PWZ6/WBJdPLYrHIlqhGxNN52gVk9C
         yCc8Bh4mHgDtmstHHYACh9zxl8nsYAWZtVRsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfert-encoding;
        bh=W8WN1gaVXifDNIN3QmSq6IzPlR5M7ezVmlYt1YIRF88=;
        b=Gb7ITBl84JhsOW5kMAInqF1JGd55AL4eBmafyP9a+xya/xDg97j9F+35n+Qjeo1aXx
         g33K9Zckap1ewohVjfOgkadAO3Av+FdiVgF516fbhYV9QBFfdDNbciifZaRHUbqWen/k
         riAKFYvaCG4oR6T8ueCanumTlF7+T7xACJw5Y3jIDGuiH/w4NvYAkFnvGKrQTWl8iWAz
         YptBZ0cWDQerZcTX2hWlrIANn8eZzMU2fCdU14OkODcKxJxa7t+PSwz3ZFhh9g5ViUWf
         YBDUuz7ua24XXsAGfWvwgPMxfk2ZWVV8nfFcnolevPhXaYlynz1HZLqYnfEvgDwGzNEi
         jdbQ==
X-Gm-Message-State: APt69E3ERO4a3zDcmhlhdIwFB/VFWV/0GzkMNroEgv+OQk3keaGLs91t
        y+Ta7VvIq1L2HNFek8w8WZSSuQ==
X-Google-Smtp-Source: ADUXVKLnx4yjmQgXmB4TCkRNTfQhZ08xX/pkq4xmRjMurGKbkjdFI1wxG+XlIx0T8aFpOp5zoDGnRw==
X-Received: by 2002:a5d:4611:: with SMTP id t17-v6mr4657126wrq.74.1528910333531;
        Wed, 13 Jun 2018 10:18:53 -0700 (PDT)
Received: from localhost.localdomain (aig34-1-88-167-228-121.fbx.proxad.net. [88.167.228.121])
        by smtp.gmail.com with ESMTPSA id j131-v6sm6392813wmg.24.2018.06.13.10.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 10:18:52 -0700 (PDT)
From:   Thierry Escande <thierry.escande@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] lib/test_printf.c: accept "ptrval" as valid result for plain 'p' tests
Date:   Wed, 13 Jun 2018 19:18:40 +0200
Message-Id: <20180613171840.29827-1-thierry.escande@linaro.org>
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
and the buffer will contain "(____ptrval____)" or "(ptrval)" instead
(64-bit vs 32-bit).
Since we cannot wait for the crng to be initialized for an undefined
time, both plain 'p' tests now accept the strings "(____ptrval____)" or
"(ptrval)" as a valid result and print a warning message.

Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
---

Changes in v3:
- Use "(____ptrval____)" for 64-bit
- Update commit message headline

Changes in v2:
- Remove wait_for_random_bytes() usage
- Remove Acked-by from Tobin as the proposed solution is not the same
  anymore.

 lib/test_printf.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 71ebfa43ad05..31f00b8ca657 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -206,6 +206,7 @@ test_string(void)
 #define PTR_WIDTH 16
 #define PTR ((void *)0xffff0123456789ab)
 #define PTR_STR "ffff0123456789ab"
+#define PTR_VAL_NO_CRNG "(____ptrval____)"
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

