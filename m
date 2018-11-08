Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C6BECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D3E2147D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yODYCIfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D3E2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbeKIHoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:44:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731106AbeKIHoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:44:14 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6298020989;
        Thu,  8 Nov 2018 22:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714803;
        bh=IsN2KrTarpvwjVla9MoPo1abnjYobfpOY8kYXNlcQyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yODYCIfu266LVvrAKtoo18GI27CKyUO1PBxX0VhFrPqnHgc4lwM7yNgwUyyVEmswo
         /yuJhxvO7Uj/9Mj1IgYVCIVqGzawkvCXQcTlDQIyYlgUZ3Rro0Oz4hNiDHt5OOZgc3
         v6pHAMj7LrvmOBltnNsuviAu9QON+cIePH3xVzyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 108/171] macsec: fix memory leaks when skb_to_sgvec fails
Date:   Thu,  8 Nov 2018 13:51:18 -0800
Message-Id: <20181108215135.181426522@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5aba2ba5030b66a6f8c93049b718556f9aacd7c6 ]

Fixes: cda7ea690350 ("macsec: check return value of skb_to_sgvec always")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 365a48cfcbbf..653f0b185a68 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -744,6 +744,7 @@ static struct sk_buff *macsec_encrypt(struct sk_buff *skb,
 	sg_init_table(sg, ret);
 	ret = skb_to_sgvec(skb, sg, 0, skb->len);
 	if (unlikely(ret < 0)) {
+		aead_request_free(req);
 		macsec_txsa_put(tx_sa);
 		kfree_skb(skb);
 		return ERR_PTR(ret);
@@ -956,6 +957,7 @@ static struct sk_buff *macsec_decrypt(struct sk_buff *skb,
 	sg_init_table(sg, ret);
 	ret = skb_to_sgvec(skb, sg, 0, skb->len);
 	if (unlikely(ret < 0)) {
+		aead_request_free(req);
 		kfree_skb(skb);
 		return ERR_PTR(ret);
 	}
-- 
2.17.1



