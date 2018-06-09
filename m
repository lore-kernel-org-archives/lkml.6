Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Kw+dObfyG1v4XwAAmS7hNA
	; Sat, 09 Jun 2018 15:31:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D274D608C9; Sat,  9 Jun 2018 15:31:03 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAOfz7V4"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1BABC608B8;
	Sat,  9 Jun 2018 15:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1BABC608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753444AbeFIPbA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753194AbeFIPa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:30:57 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CADE20896;
        Sat,  9 Jun 2018 15:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558256;
        bh=gPfq2VvmCzP+exT0TpoDpcslstdE1lwGWNvYsi+uZkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAOfz7V4JgF7mlZPyiMha9QaksCKAQKpx5+U3ahl6hw6lFK2JaU5e3vtzaIzxyIWd
         zTg1YgSbVBmJermiYdRardc9/Wifq8I7RfpgYqFVt1OzHHnkCMYeSPQqrRXMS8OB34
         nIPjXOrkGUbhHrW+JNfeYA5cuYAimvxqU2KXJg98=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Suryaputra <ssuryaextr@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 12/15] vrf: check the original netdevice for generating redirect
Date: Sat,  9 Jun 2018 17:29:47 +0200
Message-Id: <20180609150001.363543243@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609150000.746833461@linuxfoundation.org>
References: <20180609150000.746833461@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

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
