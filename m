Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADD1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BD42075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BD42075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbeGROaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:30:04 -0400
Received: from gateway20.websitewelcome.com ([192.185.55.25]:20891 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728311AbeGROaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:30:04 -0400
X-Greylist: delayed 1433 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jul 2018 10:30:03 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id F1BF9400D2614
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:28:14 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fmUYfYYeNPvAdfmUrfdd3W; Wed, 18 Jul 2018 08:28:14 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=43124 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ffmUY-000YKo-0q; Wed, 18 Jul 2018 08:27:42 -0500
Date:   Wed, 18 Jul 2018 08:27:41 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] tls: Fix copy-paste error in tls_device_reencrypt
Message-ID: <20180718132741.GA9480@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1ffmUY-000YKo-0q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:43124
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the proper structure to use in this particular
case is *skb_iter* instead of skb.

Addresses-Coverity-ID: 1471906 ("Copy-paste error")
Fixes: 4799ac81e52a ("tls: Add rx inline crypto offload")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/tls/tls_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 4995d84..1e968d2 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -615,7 +615,7 @@ static int tls_device_reencrypt(struct sock *sk, struct sk_buff *skb)
 			     TLS_CIPHER_AES_GCM_128_TAG_SIZE);
 
 		if (skb_iter->decrypted)
-			skb_store_bits(skb, offset, buf, copy);
+			skb_store_bits(skb_iter, offset, buf, copy);
 
 		offset += copy;
 		buf += copy;
-- 
2.7.4

