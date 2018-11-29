Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E25C64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061E920989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ6UH4ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061E920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeK3KKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:10:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbeK3KKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:10:34 -0500
Received: from ebiggers.mtv.corp.google.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91A482146F;
        Thu, 29 Nov 2018 23:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543532606;
        bh=XvF/lMOC0lL0Q4e5HLcoOSHhmcyW66zlM9QPCJmkwGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kJ6UH4llFo77x1Xs8xsh/XitHtePx9VfWwpnyfi3Hkfpn4Me4x5YHFOobgQzqs/s2
         /EvxmYrqeKpdBHR++5CbxSpmhrE28tIor2YwBkz/G6W26nubptjzY8XZ5nKPKXnfGQ
         //B2xYA1wKEaGCtHe0HPIdmLuqsmZRzuLicGKXu8=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Paul Crowley <paulcrowley@google.com>,
        Martin Willi <martin@strongswan.org>,
        Milan Broz <gmazyland@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] crypto: x86/chacha20 - limit the preemption-disabled section
Date:   Thu, 29 Nov 2018 15:02:14 -0800
Message-Id: <20181129230217.158038-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181129230217.158038-1-ebiggers@kernel.org>
References: <20181129230217.158038-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

To improve responsiveness, disable preemption for each step of the walk
(which is at most PAGE_SIZE) rather than for the entire
encryption/decryption operation.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/chacha20_glue.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/crypto/chacha20_glue.c b/arch/x86/crypto/chacha20_glue.c
index 773d075a1483..036de144aab6 100644
--- a/arch/x86/crypto/chacha20_glue.c
+++ b/arch/x86/crypto/chacha20_glue.c
@@ -135,26 +135,24 @@ static int chacha20_simd(struct skcipher_request *req)
 	if (req->cryptlen <= CHACHA_BLOCK_SIZE || !may_use_simd())
 		return crypto_chacha_crypt(req);
 
-	err = skcipher_walk_virt(&walk, req, true);
+	err = skcipher_walk_virt(&walk, req, false);
 
 	crypto_chacha_init(state, ctx, walk.iv);
 
-	kernel_fpu_begin();
-
 	while (walk.nbytes > 0) {
 		unsigned int nbytes = walk.nbytes;
 
 		if (nbytes < walk.total)
 			nbytes = round_down(nbytes, walk.stride);
 
+		kernel_fpu_begin();
 		chacha20_dosimd(state, walk.dst.virt.addr, walk.src.virt.addr,
 				nbytes);
+		kernel_fpu_end();
 
 		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
 	}
 
-	kernel_fpu_end();
-
 	return err;
 }
 
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

