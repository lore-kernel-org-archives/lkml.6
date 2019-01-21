Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF285C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDF42089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078466;
	bh=BBvSMPqd2BrT0MY8eQzFPVJAxk63kQTAEA3CiKmHKg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MnLYvkMq0XYxDhxTxN7uxDj/NciKTkd8cYiGdGW9WY6vBBoh6J8NMJZViTQ7Ar1eX
	 OYO4VpN7t7xt8DWnCitTHa73MmBkMBjWZp5wl8qeEsRjkyYmbtNkLGx1Xq4AH38/CX
	 EDqqge2R096tJydVaCJqUA2sMs2YuZ8nBc+JNJW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfAUNrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:47:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729682AbfAUNrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:47:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0638E20879;
        Mon, 21 Jan 2019 13:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078461;
        bh=BBvSMPqd2BrT0MY8eQzFPVJAxk63kQTAEA3CiKmHKg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sOMkehgr8v8xMV4bkPC7vm4ICzhVCBBP0nO6hxU88OEJEPjkK2rlr4bZ05icIHD76
         T4cfHYlStITFqYUP5rdUajM3U1rJBS3EQvhKKh52Dvs4EH5jcU0p92RRnPjNN8RRBF
         mQ/2ZHXe/Vl9wGFZqcLslu9i7RCZn1Aty+U6Vou8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.20 039/111] crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK
Date:   Mon, 21 Jan 2019 14:42:33 +0100
Message-Id: <20190121122500.150942713@linuxfoundation.org>
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

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 1bea445b0a022ee126ca328b3705cd4df18ebc14 upstream.

[    2.364486] WARNING: CPU: 0 PID: 60 at ./arch/powerpc/include/asm/io.h:837 dma_nommu_map_page+0x44/0xd4
[    2.373579] CPU: 0 PID: 60 Comm: cryptomgr_test Tainted: G        W         4.20.0-rc5-00560-g6bfb52e23a00-dirty #531
[    2.384740] NIP:  c000c540 LR: c000c584 CTR: 00000000
[    2.389743] REGS: c95abab0 TRAP: 0700   Tainted: G        W          (4.20.0-rc5-00560-g6bfb52e23a00-dirty)
[    2.400042] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 24042204  XER: 00000000
[    2.406669]
[    2.406669] GPR00: c02f2244 c95abb60 c6262990 c95abd80 0000256a 00000001 00000001 00000001
[    2.406669] GPR08: 00000000 00002000 00000010 00000010 24042202 00000000 00000100 c95abd88
[    2.406669] GPR16: 00000000 c05569d4 00000001 00000010 c95abc88 c0615664 00000004 00000000
[    2.406669] GPR24: 00000010 c95abc88 c95abc88 00000000 c61ae210 c7ff6d40 c61ae210 00003d68
[    2.441559] NIP [c000c540] dma_nommu_map_page+0x44/0xd4
[    2.446720] LR [c000c584] dma_nommu_map_page+0x88/0xd4
[    2.451762] Call Trace:
[    2.454195] [c95abb60] [82000808] 0x82000808 (unreliable)
[    2.459572] [c95abb80] [c02f2244] talitos_edesc_alloc+0xbc/0x3c8
[    2.465493] [c95abbb0] [c02f2600] ablkcipher_edesc_alloc+0x4c/0x5c
[    2.471606] [c95abbd0] [c02f4ed0] ablkcipher_encrypt+0x20/0x64
[    2.477389] [c95abbe0] [c02023b0] __test_skcipher+0x4bc/0xa08
[    2.483049] [c95abe00] [c0204b60] test_skcipher+0x2c/0xcc
[    2.488385] [c95abe20] [c0204c48] alg_test_skcipher+0x48/0xbc
[    2.494064] [c95abe40] [c0205cec] alg_test+0x164/0x2e8
[    2.499142] [c95abf00] [c0200dec] cryptomgr_test+0x48/0x50
[    2.504558] [c95abf10] [c0039ff4] kthread+0xe4/0x110
[    2.509471] [c95abf40] [c000e1d0] ret_from_kernel_thread+0x14/0x1c
[    2.515532] Instruction dump:
[    2.518468] 7c7e1b78 7c9d2378 7cbf2b78 41820054 3d20c076 8089c200 3d20c076 7c84e850
[    2.526127] 8129c204 7c842e70 7f844840 419c0008 <0fe00000> 2f9e0000 54847022 7c84fa14
[    2.533960] ---[ end trace bf78d94af73fe3b8 ]---
[    2.539123] talitos ff020000.crypto: master data transfer error
[    2.544775] talitos ff020000.crypto: TEA error: ISR 0x20000000_00000040
[    2.551625] alg: skcipher: encryption failed on test 1 for ecb-aes-talitos: ret=22

IV cannot be on stack when CONFIG_VMAP_STACK is selected because the stack
cannot be DMA mapped anymore.

This patch copies the IV into the extended descriptor.

Fixes: 4de9d0b547b9 ("crypto: talitos - Add ablkcipher algorithms")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/talitos.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1416,12 +1416,15 @@ static struct talitos_edesc *talitos_ede
 	/* if its a ahash, add space for a second desc next to the first one */
 	if (is_sec1 && !dst)
 		alloc_len += sizeof(struct talitos_desc);
+	alloc_len += ivsize;
 
 	edesc = kmalloc(alloc_len, GFP_DMA | flags);
 	if (!edesc)
 		return ERR_PTR(-ENOMEM);
-	if (ivsize)
+	if (ivsize) {
+		iv = memcpy(((u8 *)edesc) + alloc_len - ivsize, iv, ivsize);
 		iv_dma = dma_map_single(dev, iv, ivsize, DMA_TO_DEVICE);
+	}
 	memset(&edesc->desc, 0, sizeof(edesc->desc));
 
 	edesc->src_nents = src_nents;


