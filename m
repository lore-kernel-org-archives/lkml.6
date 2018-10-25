Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A311DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C14E20868
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkO9S72i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C14E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbeJYWtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbeJYWtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:17 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C28A20848;
        Thu, 25 Oct 2018 14:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476981;
        bh=1dJXb5Jp6q8vEzHmNR2YTXAEwyGVIVv93MW9pLXhqzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkO9S72ivnSrv6d9H8WwAWxufr7EUg/P63hLgWQ4SNgbqHxEjTv2zQtqUCbce9g26
         mjsX43Nt2P5xSLhCgDJvJ1Tq0KF75XOa1sea4G3WLsl/Vl4VUiYmXKv4pw7KBH4QM7
         un7pzO+XEfdOcQ++2+29IpPesqOfcul6HkIJKSAg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sabrina Dubroca <sd@queasysnail.net>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 80/98] macsec: fix memory leaks when skb_to_sgvec fails
Date:   Thu, 25 Oct 2018 10:14:05 -0400
Message-Id: <20181025141423.213774-80-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>

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

