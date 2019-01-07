Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F854C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DB920651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865773;
	bh=oUt48OUEkP8iSF8hr2GRIV1Tk9Dtb+bzuvJkUcS4M9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fnhR2YBBryVaakTqMy0NvKtftAlWdr6jNn3pSnaghgQEFxqzcXwq5eBiBdco+oUux
	 JxtpTyjUVQFdRSYgo7pKYpLTm67oI/s3d53i5XXPezBaPIBaBEodcw1As50G+xHoNE
	 gTk9kVm1BAY38wFGnUsPhDP+QZQlT1+f9rMVAINA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbfAGM4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:56:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbfAGM4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:56:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F295720651;
        Mon,  7 Jan 2019 12:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865769;
        bh=oUt48OUEkP8iSF8hr2GRIV1Tk9Dtb+bzuvJkUcS4M9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zknp9G/59mrWIPAjPjXlRmbfQ9zhkmyUNaOci+NWBE2AJ3plSuWN6NuetWHiX28cI
         sFwfl4PDwLLVBOm3g9Tb75qsa/12VIWVE4+k4gHj2H4G+TndRKTyhwXaoRb8aCB+uh
         54k3E0etLleMqllCZ3qHz/xRo2ruvaRZxSmrpZ9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Atul Gupta <atul.gupta@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 121/170] crypto: chcr - small packet Tx stalls the queue
Date:   Mon,  7 Jan 2019 13:32:28 +0100
Message-Id: <20190107104507.239388342@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Atul Gupta <atul.gupta@chelsio.com>

commit c35828ea906a7c76632a0211e59c392903cd4615 upstream.

Immediate packets sent to hardware should include the work
request length in calculating the flits. WR occupy one flit and
if not accounted result in invalid request which stalls the HW
queue.

Cc: stable@vger.kernel.org
Signed-off-by: Atul Gupta <atul.gupta@chelsio.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/chelsio/chcr_ipsec.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/crypto/chelsio/chcr_ipsec.c
+++ b/drivers/crypto/chelsio/chcr_ipsec.c
@@ -303,7 +303,10 @@ static bool chcr_ipsec_offload_ok(struct
 
 static inline int is_eth_imm(const struct sk_buff *skb, unsigned int kctx_len)
 {
-	int hdrlen = sizeof(struct chcr_ipsec_req) + kctx_len;
+	int hdrlen;
+
+	hdrlen = sizeof(struct fw_ulptx_wr) +
+		 sizeof(struct chcr_ipsec_req) + kctx_len;
 
 	hdrlen += sizeof(struct cpl_tx_pkt);
 	if (skb->len <= MAX_IMM_TX_PKT_LEN - hdrlen)


