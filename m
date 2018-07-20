Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D468DECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6802084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6802084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbeGTNPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:15:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35400 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbeGTNPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:15:48 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 86184BC8;
        Fri, 20 Jul 2018 12:27:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Dmitry Tunin <hanipouspilot@gmail.com>
Subject: [PATCH 4.4 06/31] Revert "sit: reload iphdr in ipip6_rcv"
Date:   Fri, 20 Jul 2018 14:13:36 +0200
Message-Id: <20180720121340.387941475@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121340.158484922@linuxfoundation.org>
References: <20180720121340.158484922@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David S. Miller <davem@davemloft.net>

commit f4eb17e1efe538d4da7d574bedb00a8dafcc26b7 upstream.

This reverts commit b699d0035836f6712917a41e7ae58d84359b8ff9.

As per Eric Dumazet, the pskb_may_pull() is a NOP in this
particular case, so the 'iph' reload is unnecessary.

Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Dmitry Tunin <hanipouspilot@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv6/sit.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -692,7 +692,6 @@ static int ipip6_rcv(struct sk_buff *skb
 
 		if (iptunnel_pull_header(skb, 0, htons(ETH_P_IPV6)))
 			goto out;
-		iph = ip_hdr(skb);
 
 		err = IP_ECN_decapsulate(iph, skb);
 		if (unlikely(err)) {


