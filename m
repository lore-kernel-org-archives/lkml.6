Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5481C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A085C20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmByO3iI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A085C20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbeKIIMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:12:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbeKIHhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:07 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C916420989;
        Thu,  8 Nov 2018 21:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714378;
        bh=s2wTjwOp4XfL50Watvv+rbBMg0eNPhYIacqVfsR8nKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DmByO3iIbgBHc9l9Oxri3lxoBIvarsdo4H7XM6W3rDG96pHMbmzd7OiUpSoEiRJoe
         CAnh4P+KI2hOMJb6EGzrn5ev/84PFXV6iMYtYmG7dttgFmLWb6YxhUsW2+mgh0MQxI
         grOpHfnuTxgZW/OSWdOzbehwxGhLzxVD0n4ce9sk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Johannes Berg <johannes.berg@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 020/114] ipv6: suppress sparse warnings in IP6_ECN_set_ce()
Date:   Thu,  8 Nov 2018 13:50:35 -0800
Message-Id: <20181108215100.973855851@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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



