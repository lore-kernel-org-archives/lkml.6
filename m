Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759A1ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CC020840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEEKaA4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CC020840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbeJYWuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbeJYWuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:10 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 433582083E;
        Thu, 25 Oct 2018 14:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477033;
        bh=3EWczY2HNwlUj9C6IXadVlPs7yIQUKH+3pnvdhK8hlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DEEKaA4JUf9oIZqg3bHfaHvpdEVdR0vllcYIQDNdgCuXXZxb4mwP3NKHqTG7OwcWt
         iq7UZvV1prD3FXD3KXWfl4joXLzfb4ukjV7rNuUaUpRNUF1+m0+GD14bhLqb0Qyk7C
         EeLZcef+tySunHP/CN0ggqYOq8MyO+/Q16WCcRoo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 02/65] ipv6: suppress sparse warnings in IP6_ECN_set_ce()
Date:   Thu, 25 Oct 2018 10:16:02 -0400
Message-Id: <20181025141705.213937-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit c15c0ab12fd62f2b19181d05c62d24bc9fa55a42 ]

Pass the correct type __wsum to csum_sub() and csum_add(). This doesn't
really change anything since __wsum really *is* __be32, but removes the
address space warnings from sparse.

Cc: Eric Dumazet <edumazet@google.com>
Fixes: 34ae6a1aa054 ("ipv6: update skb->csum when CE mark is propagated")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Acked-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_ecn.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/inet_ecn.h b/include/net/inet_ecn.h
index 0dc0a51da38f..dce2d586d9ce 100644
--- a/include/net/inet_ecn.h
+++ b/include/net/inet_ecn.h
@@ -128,7 +128,8 @@ static inline int IP6_ECN_set_ce(struct sk_buff *skb, struct ipv6hdr *iph)
 	to = from | htonl(INET_ECN_CE << 20);
 	*(__be32 *)iph = to;
 	if (skb->ip_summed == CHECKSUM_COMPLETE)
-		skb->csum = csum_add(csum_sub(skb->csum, from), to);
+		skb->csum = csum_add(csum_sub(skb->csum, (__force __wsum)from),
+				     (__force __wsum)to);
 	return 1;
 }
 
-- 
2.17.1

