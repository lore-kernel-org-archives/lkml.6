Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207C3C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A8620879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078449;
	bh=xKZztE9LVQqn6LEvGgi4RU3c9RsHwe+jUozl3kJn0Ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OJ4jgbCLF7O6m5bsUUvQ4dLcQFRHwTOQGXQNc9447bieeeIBamt22jNu7aHGYAM3l
	 dXmzEWcU+zzZl4Vk1b3xVSCF91/siA4L4NvHgDK9agfOcEgPkWZGfMtXRSf7fzE/Nb
	 DqeBMJWZhe8hxuA24M69lR7myMd2wrGmT64wDjFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfAUNr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729586AbfAUNrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:47:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E1D820861;
        Mon, 21 Jan 2019 13:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078442;
        bh=xKZztE9LVQqn6LEvGgi4RU3c9RsHwe+jUozl3kJn0Ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NfcsJtMvPUluQK5TQZ8QZAHFzI/nbGfTDaDCBbo2sl0NO+KJExSxpQevkaaDj8JH2
         vSQ64FiUWAwuE2sZBBprkT5NeRw1T3/GCqmkPdT6+18/ucFuzQeDSqY+IIkz/wIuNj
         fW6x/RjBHQrnbfg9JOmPSW4+hw6v09RQgSr3wDdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aymen Sghaier <aymen.sghaier@nxp.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Christoph Hellwig <hch@lst.de>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.20 033/111] crypto: caam - fix zero-length buffer DMA mapping
Date:   Mon, 21 Jan 2019 14:42:27 +0100
Message-Id: <20190121122459.525568289@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aymen Sghaier <aymen.sghaier@nxp.com>

commit 04e6d25c5bb244c1a37eb9fe0b604cc11a04e8c5 upstream.

Recent changes - probably DMA API related (generic and/or arm64-specific) -
exposed a case where driver maps a zero-length buffer:
ahash_init()->ahash_update()->ahash_final() with a zero-length string to
hash

kernel BUG at kernel/dma/swiotlb.c:475!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
Modules linked in:
CPU: 2 PID: 1823 Comm: cryptomgr_test Not tainted 4.20.0-rc1-00108-g00c9fe37a7f2 #1
Hardware name: LS1046A RDB Board (DT)
pstate: 80000005 (Nzcv daif -PAN -UAO)
pc : swiotlb_tbl_map_single+0x170/0x2b8
lr : swiotlb_map_page+0x134/0x1f8
sp : ffff00000f79b8f0
x29: ffff00000f79b8f0 x28: 0000000000000000
x27: ffff0000093d0000 x26: 0000000000000000
x25: 00000000001f3ffe x24: 0000000000200000
x23: 0000000000000000 x22: 00000009f2c538c0
x21: ffff800970aeb410 x20: 0000000000000001
x19: ffff800970aeb410 x18: 0000000000000007
x17: 000000000000000e x16: 0000000000000001
x15: 0000000000000019 x14: c32cb8218a167fe8
x13: ffffffff00000000 x12: ffff80097fdae348
x11: 0000800976bca000 x10: 0000000000000010
x9 : 0000000000000000 x8 : ffff0000091fd6c8
x7 : 0000000000000000 x6 : 00000009f2c538bf
x5 : 0000000000000000 x4 : 0000000000000001
x3 : 0000000000000000 x2 : 00000009f2c538c0
x1 : 00000000f9fff000 x0 : 0000000000000000
Process cryptomgr_test (pid: 1823, stack limit = 0x(____ptrval____))
Call trace:
 swiotlb_tbl_map_single+0x170/0x2b8
 swiotlb_map_page+0x134/0x1f8
 ahash_final_no_ctx+0xc4/0x6cc
 ahash_final+0x10/0x18
 crypto_ahash_op+0x30/0x84
 crypto_ahash_final+0x14/0x1c
 __test_hash+0x574/0xe0c
 test_hash+0x28/0x80
 __alg_test_hash+0x84/0xd0
 alg_test_hash+0x78/0x144
 alg_test.part.30+0x12c/0x2b4
 alg_test+0x3c/0x68
 cryptomgr_test+0x44/0x4c
 kthread+0xfc/0x128
 ret_from_fork+0x10/0x18
Code: d34bfc18 2a1a03f7 1a9f8694 35fff89a (d4210000)

Cc: <stable@vger.kernel.org>
Signed-off-by: Aymen Sghaier <aymen.sghaier@nxp.com>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/caam/caamhash.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -1071,13 +1071,16 @@ static int ahash_final_no_ctx(struct aha
 
 	desc = edesc->hw_desc;
 
-	state->buf_dma = dma_map_single(jrdev, buf, buflen, DMA_TO_DEVICE);
-	if (dma_mapping_error(jrdev, state->buf_dma)) {
-		dev_err(jrdev, "unable to map src\n");
-		goto unmap;
-	}
+	if (buflen) {
+		state->buf_dma = dma_map_single(jrdev, buf, buflen,
+						DMA_TO_DEVICE);
+		if (dma_mapping_error(jrdev, state->buf_dma)) {
+			dev_err(jrdev, "unable to map src\n");
+			goto unmap;
+		}
 
-	append_seq_in_ptr(desc, state->buf_dma, buflen, 0);
+		append_seq_in_ptr(desc, state->buf_dma, buflen, 0);
+	}
 
 	edesc->dst_dma = map_seq_out_ptr_result(desc, jrdev, req->result,
 						digestsize);


