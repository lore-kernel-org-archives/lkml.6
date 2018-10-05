Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DE7C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BEE20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WeDWUysr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BEE20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeJEPLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:11:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53522 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbeJEPL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:11:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id b19-v6so981282wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 01:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7ykn0kdpAuelX0ufR1lLCrLMFlIy/5JjP//jovQ6hBA=;
        b=WeDWUysrCM1wTzn7PG9YlepPl9dIJg8fzOw1684WVaduAN0K8vgjCHF+9AEbojUJgw
         a6lay2dDQi7EbALoyTHW5TVZR0JGZnd8dl/TJiMHR5gduxF+udxOeiLpDmYl4u8nrdr4
         Yex3cYKNCM1K4/unt4EPkx1wx8ANl/+NncRN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7ykn0kdpAuelX0ufR1lLCrLMFlIy/5JjP//jovQ6hBA=;
        b=W6k4hUFsvAyIBng1DlE1Q05W019KEnKO4K8fSrGGJTet0HTT+P7EFP5D6Glu0hbDGV
         bDKtiuGqZRom8TadiSzD8p3w05pjywW798i8uyTJh8l+sufFXfWaP/jz/bzih07mhwLD
         nL7LeMqviJQQrvVonDzt4+njroo9aAhRtf/KnfsU01/Ujk5vI1nEi/yKY/fclpft/9FK
         LNEMouZr2y7cQSMjdw3VHINLUCed7s6vQAQy8yP4v7a4mTEdLMd0h76DFdWa6PKETiym
         ybxMwVI3m4GYVQDXaed452HUei/AcCkp8K4THp/acBH+ifIJuXrjl3sNzWInD1pXq7MG
         eKhQ==
X-Gm-Message-State: ABuFfoi3XvigF8BHL6KzK1ggqI0FJKNXwhIEpN7esiwxQ3E3J+U46KBk
        Q9eB7LtzOXs3VQ0oIWUz8XWW4sI7F6c=
X-Google-Smtp-Source: ACcGV63LMyLTdsFROQVq2F8T9xrNbOmEFXJ//dKfIs8ROq4/BvnQT8Qlj0D9nA/4mALqefT70j74+Q==
X-Received: by 2002:a1c:9901:: with SMTP id b1-v6mr4381461wme.15.1538727229699;
        Fri, 05 Oct 2018 01:13:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
        by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 01:13:49 -0700 (PDT)
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
Subject: [RFC PATCH 7/9] crypto: crct10dif/generic - switch crypto API driver to core library
Date:   Fri,  5 Oct 2018 10:13:31 +0200
Message-Id: <20181005081333.15018-8-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 crypto/crct10dif_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/crct10dif_generic.c b/crypto/crct10dif_generic.c
index 8e94e29dc6fc..9ea4242c4921 100644
--- a/crypto/crct10dif_generic.c
+++ b/crypto/crct10dif_generic.c
@@ -53,7 +53,7 @@ static int chksum_update(struct shash_desc *desc, const u8 *data,
 {
 	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
 
-	ctx->crc = crc_t10dif_generic(ctx->crc, data, length);
+	ctx->crc = crc_t10dif_update(ctx->crc, data, length);
 	return 0;
 }
 
@@ -68,7 +68,7 @@ static int chksum_final(struct shash_desc *desc, u8 *out)
 static int __chksum_finup(__u16 *crcp, const u8 *data, unsigned int len,
 			u8 *out)
 {
-	*(__u16 *)out = crc_t10dif_generic(*crcp, data, len);
+	*(__u16 *)out = crc_t10dif_update(*crcp, data, len);
 	return 0;
 }
 
-- 
2.11.0

