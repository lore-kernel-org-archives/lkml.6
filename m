Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD008C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9381721841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216932;
	bh=9ES5nj9/RJdo1PbDyJC1bdkX/CHN7CEIzipdXkPOxWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N13/mHM83BBOB6WBfTH591K8iD2ZigWrGkhEezVrzoYKPGgzsOvYIrjYjHAe0XtmS
	 Q+HLbofQ5ZMblLYEK8+oASlSMZ9A/hdHW1m18I+zwuUakEhT+UeVHSufYHJgrmr5yG
	 NVpxJ2l/ticgWdUAgxgfDEx9xS/gTOC0Fe+dvAAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388588AbfAKO2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:28:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388214AbfAKO2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:28:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D6952133F;
        Fri, 11 Jan 2019 14:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216927;
        bh=9ES5nj9/RJdo1PbDyJC1bdkX/CHN7CEIzipdXkPOxWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1aqaCrUgrpmAYtDcJrfSq3GSGio8eHzuu1f0/CtlHiJbDSIoNVFlJVx7aG9NyiI1
         /ROmzJSmEXx+UAhrJZR4wFlhTLceGRK40Qh4HH/WLOYSz/ss0GcetfCiEV9yQ95ycc
         FjQjhsJm8b4rirmkRH2yF6SJr04oQj3a2mmng7OA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-crypto@vger.kernel.org,
        Martin Willi <martin@strongswan.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.9 42/63] crypto: x86/chacha20 - avoid sleeping with preemption disabled
Date:   Fri, 11 Jan 2019 15:14:45 +0100
Message-Id: <20190111131052.654348898@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 


