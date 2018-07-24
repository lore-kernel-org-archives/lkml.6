Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BCAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B2320875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NUe10EpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B2320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbeGXSDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:03:40 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45440 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388449AbeGXSDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:03:40 -0400
Received: by mail-pl0-f66.google.com with SMTP id j8-v6so1963086pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NcyGQqHeJf08FCzNacBJKb8s2eWekxJenaMH09CYQ7Y=;
        b=NUe10EpSwaK9hTK+tgq8KHU1ZJEoxtFiiin1GLrUvH5befNzNbJp/dbqZtx0wwTjsZ
         S+9uldBhcSPn9UrOn3TzkhsKoKOGNGOHdl2zL3armIVu/iYQm29La09prGGpC6w7v5to
         kzrazNWKQj2c568+uReKEwROKVWqmdLy51RJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NcyGQqHeJf08FCzNacBJKb8s2eWekxJenaMH09CYQ7Y=;
        b=pklOGyzHacql27uWTzYziYqaHi969457rvpqY0Pna/PU+kQ2Ekk2WTb2falQClwmW1
         KrX5WA1FHQRKdHBzDn3QZHEBJ+6/R93KQHCPRY3YUi45VSPfRWf5DySzhOOIJN+ilUjj
         RCNSDzK0+tZ/pQxDf8VQdwycvbEyQV6ZCcLGMYktPbgrP0Q0PdHlfFv8x3MyUDZf5iS2
         73rRnG90fVLJOPaRvJygtewOKsjBQGxPWPpU9le+eFMPV6/vN4OrWzRs6p59ei/LsqVa
         G8s2Im8vBL9oemYPN+244DVv1RzVPufDoUHlP90Pn6UH1sODSyYG3ahgosO+AKqlDyFQ
         Bvvw==
X-Gm-Message-State: AOUpUlFL2CmaTumhpPPU/Y7S3vDb33ISXSbSoG1DRbJFLxKr2ocG+/rF
        FYE4KjweWwRtZCBypxdLXSA4zg==
X-Google-Smtp-Source: AAOMgpdsCSzdgHfeKIerJQZi1yIP1qsAKuD1uCzih3O8Vp+lUv2MyL1OLAAO13EERm9srC2f7xhK+w==
X-Received: by 2002:a17:902:a5:: with SMTP id a34-v6mr18046476pla.60.1532451377375;
        Tue, 24 Jul 2018 09:56:17 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id z4-v6sm21812205pfl.11.2018.07.24.09.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 09:56:16 -0700 (PDT)
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
Subject: [PATCH v6 18/18] crypto: Remove AHASH_REQUEST_ON_STACK
Date:   Tue, 24 Jul 2018 09:49:36 -0700
Message-Id: <20180724164936.37477-19-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724164936.37477-1-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users of AHASH_REQUEST_ON_STACK have been removed from the kernel, so
drop it entirely so no VLAs get reintroduced by future users.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/hash.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 21587011ab0f..fca3e28c77a4 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -64,11 +64,6 @@ struct ahash_request {
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
-#define AHASH_REQUEST_ON_STACK(name, ahash) \
-	char __##name##_desc[sizeof(struct ahash_request) + \
-		crypto_ahash_reqsize(ahash)] CRYPTO_MINALIGN_ATTR; \
-	struct ahash_request *name = (void *)__##name##_desc
-
 /**
  * struct ahash_alg - asynchronous message digest definition
  * @init: **[mandatory]** Initialize the transformation context. Intended only to initialize the
-- 
2.17.1

