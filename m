Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5ACC169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6A22177B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBDNHARm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfBIAJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:09:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35134 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBIAJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:09:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so6175302wmt.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 16:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oYZRhi80jnWf5lvJ9rxSq8k+5uIG9VwWaCu5KNmb2Io=;
        b=fBDNHARmMKhmm+ePaNJj9txjNbOdazSkbZWB/n5YjOQJiidCJgtPUkWYcWKtUsrySa
         trWv7EzzGxFKTM9ccHPDsc7WS8wtoOlUSU00LZPieepciKS24buQhuHPZFvVIRn+531E
         WXI4lpQh/8WxwUBQRjxoDJhdHoBt66E/f63atN5vJMnc3ThZSTsQ4Sfu52xF44sOuN/B
         TE10KX4vZtqb0SGWn2TObNYiAWh6hRVzo8h9o1Ako8t4KyfHIuMFlVsnHfG/afjhbNIN
         haKI0M5yLUxjlEGqljgCH6x51eoDN5o5GVzckrZ1zUZDuRe5854+1nj6iZ4SKOFLM5/t
         hg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oYZRhi80jnWf5lvJ9rxSq8k+5uIG9VwWaCu5KNmb2Io=;
        b=EaydbtrOBjU5ArDWvIEICz9CCbooh+J6TlXBqzt2APusJL1ADHL7AiL3IFoZYivKAy
         dLXHrxdC+hMc+C0rufUF1wvkTxF6SPYKcJTAUvfCoH1wkqarOXxObgmGmjeijAuUz288
         VjD5hgExmBvZ+o66edIlkKQJsAWsIuDqXusyYilSoN5QYBYSBmB530Y2yfX+6gXM5Tn7
         9ZrYp/qiujklOWITA1apRD4MMpP2b3P32zxvG/HzP33sm4EZVf935TaUlcjJkan7UqIs
         ycdaD3KcYyiAbxn6hv0RrFV+bX2V7IaurX3cnF5iGt12WTYOtC2UizjA9vjC6Ns2zS+1
         uejQ==
X-Gm-Message-State: AHQUAuY6BHyRa9wiG2h1k9f9xax3Up2BqnNZu3xueFVVQc0q4ArgMZlr
        s+LA0mz9JF3YQMPyfq9jGdJkNupaJ8fp5g==
X-Google-Smtp-Source: AHgI3IbP7F6OnN6J3jwdNsAPLLKsA8GObtlao2W2lxU4EKIzxT9TvoA9f9ljD5W+YZ8ax1/9FCi/xw==
X-Received: by 2002:adf:f487:: with SMTP id l7mr531117wro.86.1549670944704;
        Fri, 08 Feb 2019 16:09:04 -0800 (PST)
Received: from localhost.localdomain (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id 65sm10483171wrb.62.2019.02.08.16.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:09:04 -0800 (PST)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        Martin Sebor <msebor@gcc.gnu.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 1/3] lib/crc32.c: mark crc32_le_base/__crc32c_le_base aliases as __pure
Date:   Sat,  9 Feb 2019 01:08:38 +0100
Message-Id: <20190209000840.11018-2-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
References: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upcoming GCC 9 release extends the -Wmissing-attributes warnings
(enabled by -Wall) to C and aliases: it warns when particular function
attributes are missing in the aliases but not in their target.

In particular, it triggers here because crc32_le_base/__crc32c_le_base
aren't __pure while their target crc32_le/__crc32c_le are.

These aliases are used by architectures as a fallback in accelerated
versions of CRC32. See commit 9784d82db3eb ("lib/crc32: make core crc32()
routines weak so they can be overridden").

Therefore, being fallbacks, it is likely that even if the aliases
were called from C, there wouldn't be any optimizations possible.
Currently, the only user is arm64, which calls this from asm.

Still, marking the aliases as __pure makes sense and is a good idea
for documentation purposes and possible future optimizations,
which also silences the warning.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 lib/crc32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/crc32.c b/lib/crc32.c
index 45b1d67a1767..4a20455d1f61 100644
--- a/lib/crc32.c
+++ b/lib/crc32.c
@@ -206,8 +206,8 @@ u32 __pure __weak __crc32c_le(u32 crc, unsigned char const *p, size_t len)
 EXPORT_SYMBOL(crc32_le);
 EXPORT_SYMBOL(__crc32c_le);
 
-u32 crc32_le_base(u32, unsigned char const *, size_t) __alias(crc32_le);
-u32 __crc32c_le_base(u32, unsigned char const *, size_t) __alias(__crc32c_le);
+u32 __pure crc32_le_base(u32, unsigned char const *, size_t) __alias(crc32_le);
+u32 __pure __crc32c_le_base(u32, unsigned char const *, size_t) __alias(__crc32c_le);
 
 /*
  * This multiplies the polynomials x and y modulo the given modulus.
-- 
2.17.1

