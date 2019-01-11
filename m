Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687FDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA042177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216549;
	bh=eBNcwRIAHZaa+loVhCV6eb6jHJNGvuVtSAhVbvasb3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BdJBkjq/g1HvtK3RyJ+r3fXfzVBH9jtBN5jLLZJFLLhXpUkf4aai7SPUL161GzYbb
	 sEVuyCDc0g6jDTpVbRzzp97JrhOKa0RmJyPBm2qUlrWtdq2/NorQDlH0DYr0PmtYV3
	 hBcm4ofdjGqegHQae5w9q0LGlA/FmYpchmQFF+TU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfAKOTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:19:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731635AbfAKOTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:19:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 612272184A;
        Fri, 11 Jan 2019 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216355;
        bh=eBNcwRIAHZaa+loVhCV6eb6jHJNGvuVtSAhVbvasb3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmyl2b8xukEPjGAfthkTsMrAOMcgTC5PTc74+bwukylf1+mUE+G/XgXrazj82mP1g
         lXPJrp8BNQkUOd46Axf/HxzYVilHMl27YorDVcXOiMVrwtGU2EQX9TepnMnzzHVSnC
         Ty2Yc4MPWpcUcQyLDp+C89W3Mw0UXFSJsI2sJLAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-crypto@vger.kernel.org,
        Martin Willi <martin@strongswan.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.4 70/88] crypto: x86/chacha20 - avoid sleeping with preemption disabled
Date:   Fri, 11 Jan 2019 15:08:39 +0100
Message-Id: <20190111131057.758071155@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Eric Biggers <ebiggers@google.com>

In chacha20-simd, clear the MAY_SLEEP flag in the blkcipher_desc to
prevent sleeping with preemption disabled, under kernel_fpu_begin().

This was fixed upstream incidentally by a large refactoring,
commit 9ae433bc79f9 ("crypto: chacha20 - convert generic and x86
versions to skcipher").  But syzkaller easily trips over this when
running on older kernels, as it's easily reachable via AF_ALG.
Therefore, this patch makes the minimal fix for older kernels.

Fixes: c9320b6dcb89 ("crypto: chacha20 - Add a SSSE3 SIMD variant for x86_64")
Cc: linux-crypto@vger.kernel.org
Cc: Martin Willi <martin@strongswan.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/crypto/chacha20_glue.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/crypto/chacha20_glue.c
+++ b/arch/x86/crypto/chacha20_glue.c
@@ -77,6 +77,7 @@ static int chacha20_simd(struct blkciphe
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt_block(desc, &walk, CHACHA20_BLOCK_SIZE);
+	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	crypto_chacha20_init(state, crypto_blkcipher_ctx(desc->tfm), walk.iv);
 


