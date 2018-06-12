Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E3C3FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F574208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vnz6KFpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F574208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934840AbeFLQvP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934829AbeFLQrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:47:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3E67208B7;
        Tue, 12 Jun 2018 16:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822067;
        bh=wNvpJc+D8q9Nmmw6e6eDB3KfEtbzYaqPMNmQzYjvKMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vnz6KFpV2/xtaRsmqBKjNt+6Lg78uaD3xBHs2NQYzsy5Y67k1AXa6nH/cYdRZT/EH
         gNa+ZXk97mhqlrBi4miM0Cs8vK3DvLaCLRPRFEW3VIy526jKnWLMQxwS9t2ziYxldA
         XHzWiQcG65+WhlsUruFsbC34YZbkRWA4CxIhvQQA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Suryaputra <ssuryaextr@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 23/31] vrf: check the original netdevice for generating redirect
Date:   Tue, 12 Jun 2018 18:46:26 +0200
Message-Id: <20180612164621.703872905@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
References: <20180612164620.797338191@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Suryaputra <ssuryaextr@gmail.com>

[ Upstream commit 2f17becfbea5e9a0529b51da7345783e96e69516 ]

Use the right device to determine if redirect should be sent especially
when using vrf. Same as well as when sending the redirect.

Signed-off-by: Stephen Suryaputra <ssuryaextr@gmail.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_output.c |    3 ++-
 net/ipv6/ndisc.c      |    6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -487,7 +487,8 @@ int ip6_forward(struct sk_buff *skb)
 	   send redirects to source routed frames.
 	   We don't send redirects to frames decapsulated from IPsec.
 	 */
-	if (skb->dev == dst->dev && opt->srcrt == 0 && !skb_sec_path(skb)) {
+	if (IP6CB(skb)->iif == dst->dev->ifindex &&
+	    opt->srcrt == 0 && !skb_sec_path(skb)) {
 		struct in6_addr *target = NULL;
 		struct inet_peer *peer;
 		struct rt6_info *rt;
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1538,6 +1538,12 @@ void ndisc_send_redirect(struct sk_buff
 	   ops_data_buf[NDISC_OPS_REDIRECT_DATA_SPACE], *ops_data = NULL;
 	bool ret;
 
+	if (netif_is_l3_master(skb->dev)) {
+		dev = __dev_get_by_index(dev_net(skb->dev), IPCB(skb)->iif);
+		if (!dev)
+			return;
+	}
+
 	if (ipv6_get_lladdr(dev, &saddr_buf, IFA_F_TENTATIVE)) {
 		ND_PRINTK(2, warn, "Redirect: no link-local address on %s\n",
 			  dev->name);


