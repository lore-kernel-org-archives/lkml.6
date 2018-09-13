Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C489C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D793720881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D793720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbeIMS7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:59:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33148 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeIMS7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:59:54 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AAAC8D1A;
        Thu, 13 Sep 2018 13:50:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kodanev <alexey.kodanev@oracle.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 010/197] vti6: remove !skb->ignore_df check from vti6_xmit()
Date:   Thu, 13 Sep 2018 15:29:19 +0200
Message-Id: <20180913131841.978519827@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <alexey.kodanev@oracle.com>

[ Upstream commit 9f2895461439fda2801a7906fb4c5fb3dbb37a0a ]

Before the commit d6990976af7c ("vti6: fix PMTU caching and reporting
on xmit") '!skb->ignore_df' check was always true because the function
skb_scrub_packet() was called before it, resetting ignore_df to zero.

In the commit, skb_scrub_packet() was moved below, and now this check
can be false for the packet, e.g. when sending it in the two fragments,
this prevents successful PMTU updates in such case. The next attempts
to send the packet lead to the same tx error. Moreover, vti6 initial
MTU value relies on PMTU adjustments.

This issue can be reproduced with the following LTP test script:
    udp_ipsec_vti.sh -6 -p ah -m tunnel -s 2000

Fixes: ccd740cbc6e0 ("vti6: Add pmtu handling to vti6_xmit.")
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_vti.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -481,7 +481,7 @@ vti6_xmit(struct sk_buff *skb, struct ne
 	}
 
 	mtu = dst_mtu(dst);
-	if (!skb->ignore_df && skb->len > mtu) {
+	if (skb->len > mtu) {
 		skb_dst_update_pmtu(skb, mtu);
 
 		if (skb->protocol == htons(ETH_P_IPV6)) {


