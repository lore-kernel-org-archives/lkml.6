Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A68C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4162083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4162083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbeIHCVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:21:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIHCVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:21:09 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 391BDD6B;
        Fri,  7 Sep 2018 21:38:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 61/63] crypto: vmx - Fix sleep-in-atomic bugs
Date:   Fri,  7 Sep 2018 23:10:32 +0200
Message-Id: <20180907211016.300641554@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
References: <20180907211012.965501324@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Mosnacek <omosnace@redhat.com>

commit 0522236d4f9c5ab2e79889cb020d1acbe5da416e upstream.

This patch fixes sleep-in-atomic bugs in AES-CBC and AES-XTS VMX
implementations. The problem is that the blkcipher_* functions should
not be called in atomic context.

The bugs can be reproduced via the AF_ALG interface by trying to
encrypt/decrypt sufficiently large buffers (at least 64 KiB) using the
VMX implementations of 'cbc(aes)' or 'xts(aes)'. Such operations then
trigger BUG in crypto_yield():

[  891.863680] BUG: sleeping function called from invalid context at include/crypto/algapi.h:424
[  891.864622] in_atomic(): 1, irqs_disabled(): 0, pid: 12347, name: kcapi-enc
[  891.864739] 1 lock held by kcapi-enc/12347:
[  891.864811]  #0: 00000000f5d42c46 (sk_lock-AF_ALG){+.+.}, at: skcipher_recvmsg+0x50/0x530
[  891.865076] CPU: 5 PID: 12347 Comm: kcapi-enc Not tainted 4.19.0-0.rc0.git3.1.fc30.ppc64le #1
[  891.865251] Call Trace:
[  891.865340] [c0000003387578c0] [c000000000d67ea4] dump_stack+0xe8/0x164 (unreliable)
[  891.865511] [c000000338757910] [c000000000172a58] ___might_sleep+0x2f8/0x310
[  891.865679] [c000000338757990] [c0000000006bff74] blkcipher_walk_done+0x374/0x4a0
[  891.865825] [c0000003387579e0] [d000000007e73e70] p8_aes_cbc_encrypt+0x1c8/0x260 [vmx_crypto]
[  891.865993] [c000000338757ad0] [c0000000006c0ee0] skcipher_encrypt_blkcipher+0x60/0x80
[  891.866128] [c000000338757b10] [c0000000006ec504] skcipher_recvmsg+0x424/0x530
[  891.866283] [c000000338757bd0] [c000000000b00654] sock_recvmsg+0x74/0xa0
[  891.866403] [c000000338757c10] [c000000000b00f64] ___sys_recvmsg+0xf4/0x2f0
[  891.866515] [c000000338757d90] [c000000000b02bb8] __sys_recvmsg+0x68/0xe0
[  891.866631] [c000000338757e30] [c00000000000bbe4] system_call+0x5c/0x70

Fixes: 8c755ace357c ("crypto: vmx - Adding CBC routines for VMX module")
Fixes: c07f5d3da643 ("crypto: vmx - Adding support for XTS")
Cc: stable@vger.kernel.org
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/vmx/aes_cbc.c |   30 ++++++++++++++----------------
 drivers/crypto/vmx/aes_xts.c |   21 ++++++++++++++-------
 2 files changed, 28 insertions(+), 23 deletions(-)

--- a/drivers/crypto/vmx/aes_cbc.c
+++ b/drivers/crypto/vmx/aes_cbc.c
@@ -111,24 +111,23 @@ static int p8_aes_cbc_encrypt(struct blk
 		ret = crypto_blkcipher_encrypt(&fallback_desc, dst, src,
 					       nbytes);
 	} else {
-		preempt_disable();
-		pagefault_disable();
-		enable_kernel_vsx();
-
 		blkcipher_walk_init(&walk, dst, src, nbytes);
 		ret = blkcipher_walk_virt(desc, &walk);
 		while ((nbytes = walk.nbytes)) {
+			preempt_disable();
+			pagefault_disable();
+			enable_kernel_vsx();
 			aes_p8_cbc_encrypt(walk.src.virt.addr,
 					   walk.dst.virt.addr,
 					   nbytes & AES_BLOCK_MASK,
 					   &ctx->enc_key, walk.iv, 1);
+			disable_kernel_vsx();
+			pagefault_enable();
+			preempt_enable();
+
 			nbytes &= AES_BLOCK_SIZE - 1;
 			ret = blkcipher_walk_done(desc, &walk, nbytes);
 		}
-
-		disable_kernel_vsx();
-		pagefault_enable();
-		preempt_enable();
 	}
 
 	return ret;
@@ -152,24 +151,23 @@ static int p8_aes_cbc_decrypt(struct blk
 		ret = crypto_blkcipher_decrypt(&fallback_desc, dst, src,
 					       nbytes);
 	} else {
-		preempt_disable();
-		pagefault_disable();
-		enable_kernel_vsx();
-
 		blkcipher_walk_init(&walk, dst, src, nbytes);
 		ret = blkcipher_walk_virt(desc, &walk);
 		while ((nbytes = walk.nbytes)) {
+			preempt_disable();
+			pagefault_disable();
+			enable_kernel_vsx();
 			aes_p8_cbc_encrypt(walk.src.virt.addr,
 					   walk.dst.virt.addr,
 					   nbytes & AES_BLOCK_MASK,
 					   &ctx->dec_key, walk.iv, 0);
+			disable_kernel_vsx();
+			pagefault_enable();
+			preempt_enable();
+
 			nbytes &= AES_BLOCK_SIZE - 1;
 			ret = blkcipher_walk_done(desc, &walk, nbytes);
 		}
-
-		disable_kernel_vsx();
-		pagefault_enable();
-		preempt_enable();
 	}
 
 	return ret;
--- a/drivers/crypto/vmx/aes_xts.c
+++ b/drivers/crypto/vmx/aes_xts.c
@@ -123,32 +123,39 @@ static int p8_aes_xts_crypt(struct blkci
 		ret = enc ? crypto_blkcipher_encrypt(&fallback_desc, dst, src, nbytes) :
                             crypto_blkcipher_decrypt(&fallback_desc, dst, src, nbytes);
 	} else {
+		blkcipher_walk_init(&walk, dst, src, nbytes);
+
+		ret = blkcipher_walk_virt(desc, &walk);
+
 		preempt_disable();
 		pagefault_disable();
 		enable_kernel_vsx();
 
-		blkcipher_walk_init(&walk, dst, src, nbytes);
-
-		ret = blkcipher_walk_virt(desc, &walk);
 		iv = walk.iv;
 		memset(tweak, 0, AES_BLOCK_SIZE);
 		aes_p8_encrypt(iv, tweak, &ctx->tweak_key);
 
+		disable_kernel_vsx();
+		pagefault_enable();
+		preempt_enable();
+
 		while ((nbytes = walk.nbytes)) {
+			preempt_disable();
+			pagefault_disable();
+			enable_kernel_vsx();
 			if (enc)
 				aes_p8_xts_encrypt(walk.src.virt.addr, walk.dst.virt.addr,
 						nbytes & AES_BLOCK_MASK, &ctx->enc_key, NULL, tweak);
 			else
 				aes_p8_xts_decrypt(walk.src.virt.addr, walk.dst.virt.addr,
 						nbytes & AES_BLOCK_MASK, &ctx->dec_key, NULL, tweak);
+			disable_kernel_vsx();
+			pagefault_enable();
+			preempt_enable();
 
 			nbytes &= AES_BLOCK_SIZE - 1;
 			ret = blkcipher_walk_done(desc, &walk, nbytes);
 		}
-
-		disable_kernel_vsx();
-		pagefault_enable();
-		preempt_enable();
 	}
 	return ret;
 }


