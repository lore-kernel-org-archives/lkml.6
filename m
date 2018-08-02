Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B70C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F253C215E6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YK0sLQ6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F253C215E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbeHCApO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:45:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37677 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbeHCApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:45:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so1894716pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 15:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aHfzmuE3dXR4IAoiUCBdTyidzm+NOXbAHoWt0SfC0Yk=;
        b=YK0sLQ6yx/nNf22z78FvybF7smSHZTnhCRXQxGyslT7EpdDx2alGo3541jQNsGp9vp
         8pDZrDntU+idgZMIW2VDvcaO1N0zhTJCjJZIexUkW5A5TeQmfDQqalbe48DGnFU0buQf
         uEONOy+9a5tJLimhzzgbNSgnmtp8nSNISwRZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aHfzmuE3dXR4IAoiUCBdTyidzm+NOXbAHoWt0SfC0Yk=;
        b=UvD/4z4Hq499eLtwNo9xsw6r/KrPg9q/4oto5QL7afq12TM1qvUx8k+0dyHbIHyep8
         bescvV4TPp8keo0BOBT+O/l6SxPbzIxcOk23uxRRXZw7s7EeoTaSwwKNWTyctsssyeoD
         YSCQL6gB8Vpl3jrmSPFDuAFdZXxgauDvuUgbJI4jfkCIF9fLTHtV+7ToPNAH29aVf8V7
         rPyQKZQO0A9dySbv3hC8Q44xs8lMUw9Iu3zgKodErZVQ0z6/W/mV6c1tq+KNjN46Gtef
         S1uh/h6pboJGpGaT6x8Ur+apWdhKj12e75tKiO6eHPfGOawW9lU+o8c3djEUV5emF4CJ
         NWeA==
X-Gm-Message-State: AOUpUlGXFHUpJxJ5CAM9yTk1xeOBiNl7OVXFBJXt+3BmEYtztJ9bQ9OS
        az+HfaBft778sxdzXV6wE48G9Q==
X-Google-Smtp-Source: AAOMgpdxUZUIZzGXTUAHJB42T93KR5IqwOqZF7WaiQ/FktZbkan+JYAnOI7iUO0ZrKk468r1i6dY3g==
X-Received: by 2002:a63:1902:: with SMTP id z2-v6mr1226160pgl.86.1533250317502;
        Thu, 02 Aug 2018 15:51:57 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y3-v6sm6236173pfi.24.2018.08.02.15.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 15:51:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/9] crypto: cbc: Remove VLA usage
Date:   Thu,  2 Aug 2018 15:51:45 -0700
Message-Id: <20180802225152.19194-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802225152.19194-1-keescook@chromium.org>
References: <20180802225152.19194-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
uses the upper bounds on blocksize. Since this is always a cipher
blocksize, use the existing cipher max blocksize.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/cbc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/crypto/cbc.h b/include/crypto/cbc.h
index f5b8bfc22e6d..47db0aac2ab9 100644
--- a/include/crypto/cbc.h
+++ b/include/crypto/cbc.h
@@ -113,7 +113,9 @@ static inline int crypto_cbc_decrypt_inplace(
 	unsigned int bsize = crypto_skcipher_blocksize(tfm);
 	unsigned int nbytes = walk->nbytes;
 	u8 *src = walk->src.virt.addr;
-	u8 last_iv[bsize];
+	u8 last_iv[MAX_CIPHER_BLOCKSIZE];
+
+	BUG_ON(bsize > sizeof(last_iv));
 
 	/* Start of the last block. */
 	src += nbytes - (nbytes & (bsize - 1)) - bsize;
-- 
2.17.1

