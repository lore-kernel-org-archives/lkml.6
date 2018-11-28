Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F23C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171C52081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDhlED/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171C52081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeK1Rry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbeK1Rry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:47:54 -0500
Received: from sol.localdomain (c-24-23-142-8.hsd1.ca.comcast.net [24.23.142.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C624E208E7;
        Wed, 28 Nov 2018 06:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543387640;
        bh=zruZRgWpuprvW0GZkHoYg2rXAcFG5yh5kyd+4TrbINQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tDhlED/8EQcSJTAk1nNlMnPkyjsaVZKB96a8i73v79JHeoOp9qUM8iFq5owwIe7jQ
         zkuuyt7MO4TmJjOelGg+EEDlPhKq+I9oUAhWkO0NojpVhdhCc9rh6KaakhWkb8zru3
         xhTzOYqngZNIqQKsYdnfrXQ2QcjnVRUav5mkwMgQ=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Paul Crowley <paulcrowley@google.com>,
        Martin Willi <martin@strongswan.org>,
        Milan Broz <gmazyland@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] crypto: x86/chacha20 - limit the preemption-disabled section
Date:   Tue, 27 Nov 2018 22:44:42 -0800
Message-Id: <20181128064445.3813-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181128064445.3813-1-ebiggers@kernel.org>
References: <20181128064445.3813-1-ebiggers@kernel.org>
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
index 1e9e665092264..5928fee7acdd4 100644
--- a/arch/x86/crypto/chacha20_glue.c
+++ b/arch/x86/crypto/chacha20_glue.c
@@ -100,26 +100,24 @@ static int chacha20_simd(struct skcipher_request *req)
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
2.19.2

