Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5FmOK+LvG1trSAAAmS7hNA
	; Sat, 09 Jun 2018 15:48:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D5551608C8; Sat,  9 Jun 2018 15:48:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKadMrTJ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5617F608B8;
	Sat,  9 Jun 2018 15:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5617F608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932703AbeFIPsH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932335AbeFIPcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:32:55 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9771204EC;
        Sat,  9 Jun 2018 15:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558375;
        bh=/HoD78kDGCl8rUehahanx74LjI3635V1O/wuHzA8/PQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKadMrTJsJQv2x3QShtTDLvmb+Pw6ky8X+gXRPHaHTSYjgOfIKWAaRGt1qq1ir4OZ
         xYn/FaQ3t7aIGjQLDKGBeJp6U0SGIIzyaAKPMD0k/f+ZI498v7wBiE2N1lLYM9QlEt
         6pV5X/BQofjgbxVU/vdMe8joUGIy5pMAyJ/4kZYA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Suryaputra <ssuryaextr@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 32/48] vrf: check the original netdevice for generating redirect
Date: Sat,  9 Jun 2018 17:29:44 +0200
Message-Id: <20180609145949.894480951@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -507,7 +507,8 @@ int ip6_forward(struct sk_buff *skb)
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
@@ -1576,6 +1576,12 @@ void ndisc_send_redirect(struct sk_buff
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
