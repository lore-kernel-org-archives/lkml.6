Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D6CECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3608F20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="js2R/0Tp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3608F20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeIRKwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 06:52:39 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:34518 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeIRKwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 06:52:39 -0400
Received: from trochilidae.vc.shawcable.net (unknown [IPv6:2604:3d08:6a80:360::5404])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 2C7CA5C0722;
        Tue, 18 Sep 2018 07:21:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537248104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=aKXUKIAGZJ4f53IcKE8zImYkZIUeVW6QESA4HB8btYk=;
        b=js2R/0Tpw5fA9vRkJ7ZVYTJsCm7KQfpe3b8hqrt9ywcYwIvrTTMWcAXnVaVaYb8ImCXjOn
        d2pO3YfWLOKcFZwO9Qo9oARHq5B41jrS9WlgBitZdjdSvG5dkPgZIIyHQyZGBCO59aHZxr
        FWbEYmYjeSe4kcEeZ9k24Q7eZnd52D8=
From:   Stefan Agner <stefan@agner.ch>
To:     ffmancera@riseup.net, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, davem@davemloft.net
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] netfilter: nft_osf: use enum nft_data_types for nft_validate_register_store
Date:   Mon, 17 Sep 2018 22:21:36 -0700
Message-Id: <20180918052136.25978-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function nft_validate_register_store requires a struct of type
struct nft_data_types. NFTA_DATA_VALUE is of type enum
nft_verdict_attributes. Pass the correct enum type.

This fixes a warning seen with Clang:
  net/netfilter/nft_osf.c:52:8: warning: implicit conversion from
    enumeration type 'enum nft_data_attributes' to different enumeration
    type 'enum nft_data_types' [-Wenum-conversion]
                                          NFTA_DATA_VALUE, NFT_OSF_MAXGENRELEN);
                                          ^~~~~~~~~~~~~~~

Link: https://github.com/ClangBuiltLinux/linux/issues/103
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 net/netfilter/nft_osf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_osf.c b/net/netfilter/nft_osf.c
index 5af74b37f423..a35fb59ace73 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -49,7 +49,7 @@ static int nft_osf_init(const struct nft_ctx *ctx,
 
 	priv->dreg = nft_parse_register(tb[NFTA_OSF_DREG]);
 	err = nft_validate_register_store(ctx, priv->dreg, NULL,
-					  NFTA_DATA_VALUE, NFT_OSF_MAXGENRELEN);
+					  NFT_DATA_VALUE, NFT_OSF_MAXGENRELEN);
 	if (err < 0)
 		return err;
 
-- 
2.19.0

