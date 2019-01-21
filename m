Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A36C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFA02085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079643;
	bh=4y/ELLAHrrxDsXhegWJW6mpHDr5B6oQ1PRm/axThNc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=17S6s0czvM0QHctMhRRpBsDvwHmA+JZU/eRZxWrAfVYsbl9W767Y87qgLuEdYahtS
	 33pAOE4eAK8wks/FHmk0MruNwHbSZuL/N1hovYfKtAGqeR7j0l/bry04d/ggcOslrG
	 TrVeRhAV8n17j6faQvJyrOXy3bD0UQfHH3eRh5lU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbfAUN7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:59:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732214AbfAUN7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:59:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52FBA2087F;
        Mon, 21 Jan 2019 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079175;
        bh=4y/ELLAHrrxDsXhegWJW6mpHDr5B6oQ1PRm/axThNc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p54IVxfx3YR7KZRf+Y96E5/bJpIMyFLTorb6eoJQgXPb/JJP8hVn76SJ18n94gBCr
         57BJhkiX1TeZLhYQupbQwaZr+PZ7err+6adrlsBJrxm7bAACBgghUYgdRiwaqEvmnp
         +NTQZRd/mNm/BDoX07LXoA1rtH77sTjosu5aJZFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harsh Jain <harsh@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 33/99] crypto: authencesn - Avoid twice completion call in decrypt path
Date:   Mon, 21 Jan 2019 14:48:25 +0100
Message-Id: <20190121134915.157123894@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harsh Jain <harsh@chelsio.com>

commit a7773363624b034ab198c738661253d20a8055c2 upstream.

Authencesn template in decrypt path unconditionally calls aead_request_complete
after ahash_verify which leads to following kernel panic in after decryption.

[  338.539800] BUG: unable to handle kernel NULL pointer dereference at 0000000000000004
[  338.548372] PGD 0 P4D 0
[  338.551157] Oops: 0000 [#1] SMP PTI
[  338.554919] CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Tainted: G        W I       4.19.7+ #13
[  338.564431] Hardware name: Supermicro X8ST3/X8ST3, BIOS 2.0        07/29/10
[  338.572212] RIP: 0010:esp_input_done2+0x350/0x410 [esp4]
[  338.578030] Code: ff 0f b6 68 10 48 8b 83 c8 00 00 00 e9 8e fe ff ff 8b 04 25 04 00 00 00 83 e8 01 48 98 48 8b 3c c5 10 00 00 00 e9 f7 fd ff ff <8b> 04 25 04 00 00 00 83 e8 01 48 98 4c 8b 24 c5 10 00 00 00 e9 3b
[  338.598547] RSP: 0018:ffff911c97803c00 EFLAGS: 00010246
[  338.604268] RAX: 0000000000000002 RBX: ffff911c4469ee00 RCX: 0000000000000000
[  338.612090] RDX: 0000000000000000 RSI: 0000000000000130 RDI: ffff911b87c20400
[  338.619874] RBP: 0000000000000000 R08: ffff911b87c20498 R09: 000000000000000a
[  338.627610] R10: 0000000000000001 R11: 0000000000000004 R12: 0000000000000000
[  338.635402] R13: ffff911c89590000 R14: ffff911c91730000 R15: 0000000000000000
[  338.643234] FS:  0000000000000000(0000) GS:ffff911c97800000(0000) knlGS:0000000000000000
[  338.652047] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  338.658299] CR2: 0000000000000004 CR3: 00000001ec20a000 CR4: 00000000000006f0
[  338.666382] Call Trace:
[  338.669051]  <IRQ>
[  338.671254]  esp_input_done+0x12/0x20 [esp4]
[  338.675922]  chcr_handle_resp+0x3b5/0x790 [chcr]
[  338.680949]  cpl_fw6_pld_handler+0x37/0x60 [chcr]
[  338.686080]  chcr_uld_rx_handler+0x22/0x50 [chcr]
[  338.691233]  uldrx_handler+0x8c/0xc0 [cxgb4]
[  338.695923]  process_responses+0x2f0/0x5d0 [cxgb4]
[  338.701177]  ? bitmap_find_next_zero_area_off+0x3a/0x90
[  338.706882]  ? matrix_alloc_area.constprop.7+0x60/0x90
[  338.712517]  ? apic_update_irq_cfg+0x82/0xf0
[  338.717177]  napi_rx_handler+0x14/0xe0 [cxgb4]
[  338.722015]  net_rx_action+0x2aa/0x3e0
[  338.726136]  __do_softirq+0xcb/0x280
[  338.730054]  irq_exit+0xde/0xf0
[  338.733504]  do_IRQ+0x54/0xd0
[  338.736745]  common_interrupt+0xf/0xf

Fixes: 104880a6b470 ("crypto: authencesn - Convert to new AEAD...")
Signed-off-by: Harsh Jain <harsh@chelsio.com>
Cc: stable@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/authencesn.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/authencesn.c
+++ b/crypto/authencesn.c
@@ -279,7 +279,7 @@ static void authenc_esn_verify_ahash_don
 	struct aead_request *req = areq->data;
 
 	err = err ?: crypto_authenc_esn_decrypt_tail(req, 0);
-	aead_request_complete(req, err);
+	authenc_esn_request_complete(req, err);
 }
 
 static int crypto_authenc_esn_decrypt(struct aead_request *req)


