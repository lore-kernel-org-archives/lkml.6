Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9024C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C2B21873
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864870;
	bh=s9ZVqHp9+hAaSMZzEzuMAB234LXUT7EBX9Ob3TtGOQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JvHO/F8fhrHaeq/hkeHMWrip9s1IWdCLf839s6NkBhZZFNzf4FNKeph7adY0AvLYi
	 1Ba9YfAATluK2dyNbdi5CHDQJUqRNuz6+U5f9keNM7+nfzg2+S92rqN8WvInMTbPOs
	 Gv+mmCtACB/l0M/3mHrTP9x7zxEYfGNpGOIVFb6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfAGMlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:41:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbfAGMlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:41:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE06F2183E;
        Mon,  7 Jan 2019 12:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864864;
        bh=s9ZVqHp9+hAaSMZzEzuMAB234LXUT7EBX9Ob3TtGOQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvfQwBxV780HyAlHHJJLZ5xIpQvDbiy/orhgeoBnDtO2M5dkC/mft5iUGTeOsTFat
         qPZhlv49UPD0ka6gpY7oOtCocnZ+0GhOyNAo/DxrZfX3DHYjapHtPJFFfZt3eajd+g
         woqNsChDeEvtkrdt3DTPNad+M1Ml+tZU7Z99dius=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Atul Gupta <atul.gupta@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.20 086/145] crypto: chcr - small packet Tx stalls the queue
Date:   Mon,  7 Jan 2019 13:32:03 +0100
Message-Id: <20190107104448.503505492@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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


