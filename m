Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA147C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E17D20866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj8s7TwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E17D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbeKLISP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732568AbeKLISO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:14 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D0B021508;
        Sun, 11 Nov 2018 22:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975298;
        bh=zca4I/sBX6U7/TIEu8dVvsjR7mnMVt0VQLM+iImvAVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qj8s7TwA12SWa1EkvsO9bRxkX3YHOBoScw8bHeVfyLVJ+lDWCKNvJCpI/RC5dRs2V
         T8HgBV9vNKRfRK9Kns5V5zuwtKIeaVKfEwqg2WeAy5xncLb/eD+uRLGiCwV+d9ggO1
         0rYlBLrvE3wfplUHmDOPFS/Jd71u/REfrLsIH0V0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 246/361] crypto: aegis/generic - fix for big endian systems
Date:   Sun, 11 Nov 2018 14:19:53 -0800
Message-Id: <20181111221652.769967198@linuxfoundation.org>
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

commit 4a34e3c2f2f48f47213702a84a123af0fe21ad60 upstream.

Use the correct __le32 annotation and accessors to perform the
single round of AES encryption performed inside the AEGIS transform.
Otherwise, tcrypt reports:

  alg: aead: Test 1 failed on encryption for aegis128-generic
  00000000: 6c 25 25 4a 3c 10 1d 27 2b c1 d4 84 9a ef 7f 6e
  alg: aead: Test 1 failed on encryption for aegis128l-generic
  00000000: cd c6 e3 b8 a0 70 9d 8e c2 4f 6f fe 71 42 df 28
  alg: aead: Test 1 failed on encryption for aegis256-generic
  00000000: aa ed 07 b1 96 1d e9 e6 f2 ed b5 8e 1c 5f dc 1c

Fixes: f606a88e5823 ("crypto: aegis - Add generic AEGIS AEAD implementations")
Cc: <stable@vger.kernel.org> # v4.18+
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/aegis.h |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

--- a/crypto/aegis.h
+++ b/crypto/aegis.h
@@ -21,7 +21,7 @@
 
 union aegis_block {
 	__le64 words64[AEGIS_BLOCK_SIZE / sizeof(__le64)];
-	u32 words32[AEGIS_BLOCK_SIZE / sizeof(u32)];
+	__le32 words32[AEGIS_BLOCK_SIZE / sizeof(__le32)];
 	u8 bytes[AEGIS_BLOCK_SIZE];
 };
 
@@ -57,24 +57,22 @@ static void crypto_aegis_aesenc(union ae
 				const union aegis_block *src,
 				const union aegis_block *key)
 {
-	u32 *d = dst->words32;
 	const u8  *s  = src->bytes;
-	const u32 *k  = key->words32;
 	const u32 *t0 = crypto_ft_tab[0];
 	const u32 *t1 = crypto_ft_tab[1];
 	const u32 *t2 = crypto_ft_tab[2];
 	const u32 *t3 = crypto_ft_tab[3];
 	u32 d0, d1, d2, d3;
 
-	d0 = t0[s[ 0]] ^ t1[s[ 5]] ^ t2[s[10]] ^ t3[s[15]] ^ k[0];
-	d1 = t0[s[ 4]] ^ t1[s[ 9]] ^ t2[s[14]] ^ t3[s[ 3]] ^ k[1];
-	d2 = t0[s[ 8]] ^ t1[s[13]] ^ t2[s[ 2]] ^ t3[s[ 7]] ^ k[2];
-	d3 = t0[s[12]] ^ t1[s[ 1]] ^ t2[s[ 6]] ^ t3[s[11]] ^ k[3];
-
-	d[0] = d0;
-	d[1] = d1;
-	d[2] = d2;
-	d[3] = d3;
+	d0 = t0[s[ 0]] ^ t1[s[ 5]] ^ t2[s[10]] ^ t3[s[15]];
+	d1 = t0[s[ 4]] ^ t1[s[ 9]] ^ t2[s[14]] ^ t3[s[ 3]];
+	d2 = t0[s[ 8]] ^ t1[s[13]] ^ t2[s[ 2]] ^ t3[s[ 7]];
+	d3 = t0[s[12]] ^ t1[s[ 1]] ^ t2[s[ 6]] ^ t3[s[11]];
+
+	dst->words32[0] = cpu_to_le32(d0) ^ key->words32[0];
+	dst->words32[1] = cpu_to_le32(d1) ^ key->words32[1];
+	dst->words32[2] = cpu_to_le32(d2) ^ key->words32[2];
+	dst->words32[3] = cpu_to_le32(d3) ^ key->words32[3];
 }
 
 #endif /* _CRYPTO_AEGIS_H */


