Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B77C65BA9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FB5208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+cypP9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FB5208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbeJEPLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:11:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36442 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbeJEPLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:11:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so12578534wrw.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 01:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9pEAraO+w5FxZNKwOwU68gCXSvwsp2RrSj23yV0hAkg=;
        b=e+cypP9O6uanr3tyDWz0c6akRdpCzHEznDk/UGqdh0XmBEz5LaG5BHA8TQpA89x4OX
         1yb2GPuTj7EKXgJXcoo8GSSuT10ecGI2deQSCUBfSElkNv+n92lTnZFWQxHmqCgl4FEe
         ouWG6NoD/o9bqb2rorXsdLVQB0OmZTM4XGPlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9pEAraO+w5FxZNKwOwU68gCXSvwsp2RrSj23yV0hAkg=;
        b=Ln62Z9yIE4QMGbmj3gtbmQEyoQ9sDcRS65rWz8CMIrdcXgzAgsyShlU+WcK3AwGie+
         rCpuOUc+/2TwSsvH2X+Uh4S13UaAVfGdgmgOQC/LrcLxUxsPG43I/f3bQQmbem8vFFzp
         81fDgf8DvqysjjvK/wTdbBaZfIqc0XkgDT3LBuYP3anZjM8myBMUZc2L5v5mZQKSSJLE
         74WvEDjaT3h/UEv/86KQQTqOcaFzIrWjhWvTbYnB5St0M1AL31T8d2Mkb/4RR7wYnzzF
         p4NTcZq+sR5MFv4SE3tMKXhsbVcxiG2wCE13ViaVXvV5mhCtl08N+zlZPpq2sHDfgJlN
         NKMA==
X-Gm-Message-State: ABuFfoietSWkFIbTeUf+GYbV9B3FSw2qPAb/94IhmC2JEFJ7RRQpWO1c
        rjjujdH2JUCQGdZI6/ejIzmSkwJYt64=
X-Google-Smtp-Source: ACcGV62ntJ9ibv6XTTbuRRc5lV5zur1H0clIqrdCTZXin3xHDioy7KJrXqpRM0YbS2pFQWeCAQb7kA==
X-Received: by 2002:a5d:610a:: with SMTP id v10-v6mr1391403wrt.308.1538727223269;
        Fri, 05 Oct 2018 01:13:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
        by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 01:13:42 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 3/9] crypto: crc-t10dif - make crc_t10dif a static inline
Date:   Fri,  5 Oct 2018 10:13:27 +0200
Message-Id: <20181005081333.15018-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crc_t10dif() is a trivial wrapper around crc_t10dif_update() so move
it into the header file as a static inline function.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/crc-t10dif.h | 6 +++++-
 lib/crc-t10dif.c           | 6 ------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/crc-t10dif.h b/include/linux/crc-t10dif.h
index 6bb0c0bf357b..4dfe09ff4cf2 100644
--- a/include/linux/crc-t10dif.h
+++ b/include/linux/crc-t10dif.h
@@ -10,7 +10,11 @@
 
 extern __u16 crc_t10dif_generic(__u16 crc, const unsigned char *buffer,
 				size_t len);
-extern __u16 crc_t10dif(unsigned char const *, size_t);
 extern __u16 crc_t10dif_update(__u16 crc, unsigned char const *, size_t);
 
+static inline __u16 crc_t10dif(const unsigned char *buffer, size_t len)
+{
+	return crc_t10dif_update(0, buffer, len);
+}
+
 #endif
diff --git a/lib/crc-t10dif.c b/lib/crc-t10dif.c
index 4d0d47c1ffbd..036ee664c9e1 100644
--- a/lib/crc-t10dif.c
+++ b/lib/crc-t10dif.c
@@ -81,12 +81,6 @@ __u16 crc_t10dif_update(__u16 crc, const unsigned char *buffer, size_t len)
 }
 EXPORT_SYMBOL(crc_t10dif_update);
 
-__u16 crc_t10dif(const unsigned char *buffer, size_t len)
-{
-	return crc_t10dif_update(0, buffer, len);
-}
-EXPORT_SYMBOL(crc_t10dif);
-
 static int __init crc_t10dif_mod_init(void)
 {
 	crypto_register_notifier(&crc_t10dif_nb);
-- 
2.11.0

