Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A67FC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37176206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x6FYsgxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37176206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeLEGVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:21:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbeLEGVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:21:36 -0500
Received: from sol.localdomain (c-24-23-142-8.hsd1.ca.comcast.net [24.23.142.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3063F20892;
        Wed,  5 Dec 2018 06:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543990895;
        bh=kacKhMCV1L48HhZ3P/I76UHRahgYPWsOuE1n4U4DMK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6FYsgxnitrpZG6eaL0p5uwnHZTpWvkHXUNpw6l/+lIyQ7UEWU+Mu1r93yVmk9pvH
         QJ3aQm2cmOoxJdBdfNplKa0gSGY5ICdvxdM7oKw07IZYLjLSYOSCj2+ZxEn8MP2q+X
         lHx6+kNXMRu+De8VUlXZ7Ggxgu+tHVHKYbvEx3qs=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Paul Crowley <paulcrowley@google.com>,
        Martin Willi <martin@strongswan.org>,
        Milan Broz <gmazyland@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] crypto: x86/chacha - yield the FPU occasionally
Date:   Tue,  4 Dec 2018 22:20:05 -0800
Message-Id: <20181205062005.27727-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205062005.27727-1-ebiggers@kernel.org>
References: <20181205062005.27727-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

To improve responsiveness, yield the FPU (temporarily re-enabling
preemption) every 4 KiB encrypted/decrypted, rather than keeping
preemption disabled during the entire encryption/decryption operation.

Alternatively we could do this for every skcipher_walk step, but steps
may be small in some cases, and yielding the FPU is expensive on x86.

Suggested-by: Martin Willi <martin@strongswan.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/chacha_glue.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index d19c2908be90..9b1d3fac4943 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -132,6 +132,7 @@ static int chacha_simd_stream_xor(struct skcipher_request *req,
 {
 	u32 *state, state_buf[16 + 2] __aligned(8);
 	struct skcipher_walk walk;
+	int next_yield = 4096; /* bytes until next FPU yield */
 	int err;
 
 	BUILD_BUG_ON(CHACHA_STATE_ALIGN != 16);
@@ -144,12 +145,21 @@ static int chacha_simd_stream_xor(struct skcipher_request *req,
 	while (walk.nbytes > 0) {
 		unsigned int nbytes = walk.nbytes;
 
-		if (nbytes < walk.total)
+		if (nbytes < walk.total) {
 			nbytes = round_down(nbytes, walk.stride);
+			next_yield -= nbytes;
+		}
 
 		chacha_dosimd(state, walk.dst.virt.addr, walk.src.virt.addr,
 			      nbytes, ctx->nrounds);
 
+		if (next_yield <= 0) {
+			/* temporarily allow preemption */
+			kernel_fpu_end();
+			kernel_fpu_begin();
+			next_yield = 4096;
+		}
+
 		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
 	}
 
-- 
2.19.2

