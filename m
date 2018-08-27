Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EE0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49021208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cG7Q1DVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49021208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeH0OtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:49:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36543 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeH0OtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:49:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id f4-v6so7458454edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oAg2MIWmTiuQXPRQuCyO90mfns13N4bEQB8aeiZWMRk=;
        b=cG7Q1DVRhliFRC8rJwRTg+THv+BiFvRwXTWg1V/D5US8FJeQ4S8g1iZjRWiU1cB6Yg
         pnN/Eqx672jHY0XGP/sMDnYqgPKA+BeqiEppEibgXI/eilA6YfVG/MI3xdsKprL0hTIA
         Z2HFE6udh9LVAs+JAlXU8eVwDKuwVnhfdslLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oAg2MIWmTiuQXPRQuCyO90mfns13N4bEQB8aeiZWMRk=;
        b=g4kBgKQeytpiM3WG9n69BRFW9HPnuhs0CQBTcbgYDN2utwpo95nGjI/4LMygiPtLDT
         HOZLCtgpIjPAG73nSVfYWuWZ4cGeK8kqSRbNDhtDOe7mOWroj1Mhunefqzej5zkiFILL
         YxgazCI4B7ikcNSbGRV45EU72k+j+LyimCSUe89lzkVDv/s3BffrVFTZdxBM8nRiiIkY
         8GlSbeeVdJtr+dipUSvuIcXYLude+Xi4QiUb9nDw5fUuqDFH2zoOmBjTs/B6y7LVpct0
         PcO9DWPq7iN9DWeVGKtHLpK2QAg0dl8LcTLzdL2wk/j+fkkxTqQisWfdtDzVurgWS3lG
         IRWg==
X-Gm-Message-State: APzg51CurBab1Qr7r79NToLPoFFLdZDDFbn7Zx2PLgTp19z3BfkSxqkX
        lAM/ZfZpyvSND/d479ngCxuPDQ==
X-Google-Smtp-Source: ANB0Vdb+9LZIseQp6Ydcf1ZGBXMYl0a9yHTImbAWDfdX7s88PcO5TleHrR877p4KMeQchjl52sLPSQ==
X-Received: by 2002:a50:a38a:: with SMTP id s10-v6mr16286374edb.99.1535367781188;
        Mon, 27 Aug 2018 04:03:01 -0700 (PDT)
Received: from rev02.home ([2a02:a212:9283:9800:24b9:e2d6:9acc:50dd])
        by smtp.gmail.com with ESMTPSA id r2-v6sm3114344eda.89.2018.08.27.04.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 04:03:00 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org
Cc:     will.deacon@arm.com, catalin.marinas@arm.com,
        herbert@gondor.apana.org.au, ebiggers@google.com,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 1/4] lib/crc32: make core crc32() routines weak so they can be overridden
Date:   Mon, 27 Aug 2018 13:02:42 +0200
Message-Id: <20180827110245.14812-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
References: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow architectures to drop in accelerated CRC32 routines by making
the crc32_le/__crc32c_le entry points weak, and exposing non-weak
aliases for them that may be used by the accelerated versions as
fallbacks in case the instructions they rely upon are not available.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 lib/crc32.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/crc32.c b/lib/crc32.c
index a6c9afafc8c8..45b1d67a1767 100644
--- a/lib/crc32.c
+++ b/lib/crc32.c
@@ -183,21 +183,21 @@ static inline u32 __pure crc32_le_generic(u32 crc, unsigned char const *p,
 }
 
 #if CRC_LE_BITS == 1
-u32 __pure crc32_le(u32 crc, unsigned char const *p, size_t len)
+u32 __pure __weak crc32_le(u32 crc, unsigned char const *p, size_t len)
 {
 	return crc32_le_generic(crc, p, len, NULL, CRC32_POLY_LE);
 }
-u32 __pure __crc32c_le(u32 crc, unsigned char const *p, size_t len)
+u32 __pure __weak __crc32c_le(u32 crc, unsigned char const *p, size_t len)
 {
 	return crc32_le_generic(crc, p, len, NULL, CRC32C_POLY_LE);
 }
 #else
-u32 __pure crc32_le(u32 crc, unsigned char const *p, size_t len)
+u32 __pure __weak crc32_le(u32 crc, unsigned char const *p, size_t len)
 {
 	return crc32_le_generic(crc, p, len,
 			(const u32 (*)[256])crc32table_le, CRC32_POLY_LE);
 }
-u32 __pure __crc32c_le(u32 crc, unsigned char const *p, size_t len)
+u32 __pure __weak __crc32c_le(u32 crc, unsigned char const *p, size_t len)
 {
 	return crc32_le_generic(crc, p, len,
 			(const u32 (*)[256])crc32ctable_le, CRC32C_POLY_LE);
@@ -206,6 +206,9 @@ u32 __pure __crc32c_le(u32 crc, unsigned char const *p, size_t len)
 EXPORT_SYMBOL(crc32_le);
 EXPORT_SYMBOL(__crc32c_le);
 
+u32 crc32_le_base(u32, unsigned char const *, size_t) __alias(crc32_le);
+u32 __crc32c_le_base(u32, unsigned char const *, size_t) __alias(__crc32c_le);
+
 /*
  * This multiplies the polynomials x and y modulo the given modulus.
  * This follows the "little-endian" CRC convention that the lsbit
-- 
2.18.0

