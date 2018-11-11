Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF2BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3D920839
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugfP0x3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3D920839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733155AbeKLJnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:43:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732795AbeKLIS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:26 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FAED22353;
        Sun, 11 Nov 2018 22:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975310;
        bh=H/NGUGH/XNAqBI8nf5ULOnJ8oW7o5j16uaCqYagc0ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugfP0x3WokPZslchXJvT4aOonmiGkykF8I0ryXbdE55AcyfQ3WWeMSBoRasDXXb2G
         KdwKTmwktzFMYJvm31WooWYJI3RtE+7XcDsOeEkaEgVz4k19G5smM0499azlXIMxdG
         Lw8tS3UhptyNlBUTZtonM/nJ/izbky0sllRo/ovc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 245/361] crypto: morus/generic - fix for big endian systems
Date:   Sun, 11 Nov 2018 14:19:52 -0800
Message-Id: <20181111221652.681034206@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 5a8dedfa3276e88c5865f265195d63d72aec3e72 upstream.

Omit the endian swabbing when folding the lengths of the assoc and
crypt input buffers into the state to finalize the tag. This is not
necessary given that the memory representation of the state is in
machine native endianness already.

This fixes an error reported by tcrypt running on a big endian system:

  alg: aead: Test 2 failed on encryption for morus640-generic
  00000000: a8 30 ef fb e6 26 eb 23 b0 87 dd 98 57 f3 e1 4b
  00000010: 21
  alg: aead: Test 2 failed on encryption for morus1280-generic
  00000000: 88 19 1b fb 1c 29 49 0e ee 82 2f cb 97 a6 a5 ee
  00000010: 5f

Fixes: 396be41f16fd ("crypto: morus - Add generic MORUS AEAD implementations")
Cc: <stable@vger.kernel.org> # v4.18+
Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/morus1280.c |    7 ++-----
 crypto/morus640.c  |   16 ++++------------
 2 files changed, 6 insertions(+), 17 deletions(-)

--- a/crypto/morus1280.c
+++ b/crypto/morus1280.c
@@ -385,14 +385,11 @@ static void crypto_morus1280_final(struc
 				   struct morus1280_block *tag_xor,
 				   u64 assoclen, u64 cryptlen)
 {
-	u64 assocbits = assoclen * 8;
-	u64 cryptbits = cryptlen * 8;
-
 	struct morus1280_block tmp;
 	unsigned int i;
 
-	tmp.words[0] = cpu_to_le64(assocbits);
-	tmp.words[1] = cpu_to_le64(cryptbits);
+	tmp.words[0] = assoclen * 8;
+	tmp.words[1] = cryptlen * 8;
 	tmp.words[2] = 0;
 	tmp.words[3] = 0;
 
--- a/crypto/morus640.c
+++ b/crypto/morus640.c
@@ -384,21 +384,13 @@ static void crypto_morus640_final(struct
 				  struct morus640_block *tag_xor,
 				  u64 assoclen, u64 cryptlen)
 {
-	u64 assocbits = assoclen * 8;
-	u64 cryptbits = cryptlen * 8;
-
-	u32 assocbits_lo = (u32)assocbits;
-	u32 assocbits_hi = (u32)(assocbits >> 32);
-	u32 cryptbits_lo = (u32)cryptbits;
-	u32 cryptbits_hi = (u32)(cryptbits >> 32);
-
 	struct morus640_block tmp;
 	unsigned int i;
 
-	tmp.words[0] = cpu_to_le32(assocbits_lo);
-	tmp.words[1] = cpu_to_le32(assocbits_hi);
-	tmp.words[2] = cpu_to_le32(cryptbits_lo);
-	tmp.words[3] = cpu_to_le32(cryptbits_hi);
+	tmp.words[0] = lower_32_bits(assoclen * 8);
+	tmp.words[1] = upper_32_bits(assoclen * 8);
+	tmp.words[2] = lower_32_bits(cryptlen * 8);
+	tmp.words[3] = upper_32_bits(cryptlen * 8);
 
 	for (i = 0; i < MORUS_BLOCK_WORDS; i++)
 		state->s[4].words[i] ^= state->s[0].words[i];


