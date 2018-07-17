Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90BCECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9386D20841
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9386D20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbeGQQ0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:26:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53362 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbeGQQ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:26:21 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ffSHX-00015d-88; Tue, 17 Jul 2018 15:52:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: sr: fix useless rol32 call on hash
Date:   Tue, 17 Jul 2018 16:52:54 +0100
Message-Id: <20180717155254.30367-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The rol32 call is currently rotating hash but the rol'd value is
being discarded. I believe the current code is incorrect and hash
should be assigned the rotated value returned from rol32.

Detected by CoverityScan, CID#1468411 ("Useless call")

Fixes: b5facfdba14c ("ipv6: sr: Compute flowlabel for outer IPv6 header of seg6 encap mode")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/ipv6/seg6_iptunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 19ccf0dc996c..a8854dd3e9c5 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -101,7 +101,7 @@ static __be32 seg6_make_flowlabel(struct net *net, struct sk_buff *skb,
 
 	if (do_flowlabel > 0) {
 		hash = skb_get_hash(skb);
-		rol32(hash, 16);
+		hash = rol32(hash, 16);
 		flowlabel = (__force __be32)hash & IPV6_FLOWLABEL_MASK;
 	} else if (!do_flowlabel && skb->protocol == htons(ETH_P_IPV6)) {
 		flowlabel = ip6_flowlabel(inner_hdr);
-- 
2.17.1

