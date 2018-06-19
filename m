Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27226C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D202E205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D202E205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757331AbeFSUZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:25:53 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46259 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967197AbeFSUZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:25:36 -0400
Received: by mail-lf0-f65.google.com with SMTP id u5-v6so1427646lff.13;
        Tue, 19 Jun 2018 13:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7qXKyOGCSgz6ZKMJkgjTNbc5pHK2sr6gkv6DvO7yY6Q=;
        b=kfeurjPtv1eG+f4/5GWeAJKWbNnUP7AWQpOEb09z9IkMgqnbEgadsWyaOpi/RDhuPe
         UM2SHgBbQ0bi3RFQr3RZWOk8/a7MBd0x20tZHgIyMNL3AtF1noyVF4iU7Kf/AY+rABOz
         aTrztcRxDXOAcPv+sPCFaD7opyXr6fX6Oj4jhVzEDAdTDyWKU68wIxS0IGnmf9h8Kmrd
         CX623l9tzeb7MsFvoCQysvGQrlSQmRwtM0IhFuRPBmEfINFUGCTXvB4lBua9zKKIwTwQ
         sccJGresdiXxim3IqDLemUOtRQ8Oly7GzyLpDdrHb9vb7t9hmpBzFOOwFQS27gRThhUf
         YV/g==
X-Gm-Message-State: APt69E3Q9u/7mDlxftHeabIB2qJP+j2JlNZt2tWX/85saqoVyF/V8+bu
        PW7EnkAHZzs8y2jZFZNLLbU=
X-Google-Smtp-Source: ADUXVKLnm+HRLnrOK+YZqjSsbBwoXSKro22gPLBPz8RV2+6BFBuk+lidUovfQRKzDGlUPWQS5WOWbw==
X-Received: by 2002:a19:2a5b:: with SMTP id f88-v6mr2150437lfl.63.1529439934950;
        Tue, 19 Jun 2018 13:25:34 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id 4-v6sm87451ljc.1.2018.06.19.13.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 13:25:34 -0700 (PDT)
From:   efremov@linux.com
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, Denis Efremov <efremov@linux.com>
Subject: [PATCH v2] crypto: skcipher: remove the exporting of skcipher_walk_next
Date:   Tue, 19 Jun 2018 23:23:57 +0300
Message-Id: <20180619202357.10805-1-efremov@linux.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617174959.29864-1-efremov@linux.com>
References: <20180617174959.29864-1-efremov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function skcipher_walk_next declared as static and marked as
EXPORT_SYMBOL_GPL. It's a bit confusing for internal function to be
exported. The area of visibility for such function is its .c file
and all other modules. Other *.c files of the same module can't use it,
despite all other modules can. Relying on the fact that this is the
internal function and it's not a crucial part of the API, the patch
just removes the EXPORT_SYMBOL_GPL marking of skcipher_walk_next.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 crypto/skcipher.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/skcipher.c b/crypto/skcipher.c
index 0fe2a2923ad0..7d6a49fe3047 100644
--- a/crypto/skcipher.c
+++ b/crypto/skcipher.c
@@ -387,7 +387,6 @@ static int skcipher_walk_next(struct skcipher_walk *walk)
 	}
 	return err;
 }
-EXPORT_SYMBOL_GPL(skcipher_walk_next);
 
 static int skcipher_copy_iv(struct skcipher_walk *walk)
 {
-- 
2.17.1

