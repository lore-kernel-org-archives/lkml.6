Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3698FC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061D821907
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358616;
	bh=LZQHD6q9L8d0Jj9dgzgrnUhe9c86w1o11IB6QqAVXk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zlUgtYJgrxWHzN1+9Y5/ekRaP9vym16It9vfKZds4WCQxBMhyKM+4zHNverFqSb/x
	 Fvc0dDCPLFO3CElhAtiWxmjqT73M2yZ9+P2cSs0a7CIUANNc7iS7ofDEZdSlNWN0Ee
	 tI2gpP2jTvWkKp4rvfXEIwdbvT224IkiW3XC+cRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbfAXTgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:36:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730938AbfAXTgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:36:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FCD9218FC;
        Thu, 24 Jan 2019 19:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358610;
        bh=LZQHD6q9L8d0Jj9dgzgrnUhe9c86w1o11IB6QqAVXk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/n0E9tb79aBL4Bym/mrAzBnY3jBfRnH0mS6eeQzLjjEGVz5kNHd9SMhkobEAX/yn
         ul7ZZgtkTaEVTMklCKBEEsTFdqxguRlyqcCRBnWNUIJ8hjiKm0cG0Eo6DIyNfZg2Ob
         Y1eWbsFiOgk6tH6UFr5smUhEtXmCcNpeGQP7mj2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 070/106] netfilter: ipt_CLUSTERIP: check MAC address when duplicate config is set
Date:   Thu, 24 Jan 2019 20:20:27 +0100
Message-Id: <20190124190210.793810490@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 06aa151ad1fc74a49b45336672515774a678d78d ]

If same destination IP address config is already existing, that config is
just used. MAC address also should be same.
However, there is no MAC address checking routine.
So that MAC address checking routine is added.

test commands:
   %iptables -A INPUT -p tcp -i lo -d 192.168.0.5 --dport 80 \
	   -j CLUSTERIP --new --hashmode sourceip \
	   --clustermac 01:00:5e:00:00:20 --total-nodes 2 --local-node 1
   %iptables -A INPUT -p tcp -i lo -d 192.168.0.5 --dport 80 \
	   -j CLUSTERIP --new --hashmode sourceip \
	   --clustermac 01:00:5e:00:00:21 --total-nodes 2 --local-node 1

After this patch, above commands are disallowed.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/netfilter/ipt_CLUSTERIP.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/netfilter/ipt_CLUSTERIP.c b/net/ipv4/netfilter/ipt_CLUSTERIP.c
index 2c8d313ae216..e40e6795bd20 100644
--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -496,7 +496,8 @@ static int clusterip_tg_check(const struct xt_tgchk_param *par)
 			if (IS_ERR(config))
 				return PTR_ERR(config);
 		}
-	}
+	} else if (memcmp(&config->clustermac, &cipinfo->clustermac, ETH_ALEN))
+		return -EINVAL;
 
 	ret = nf_ct_netns_get(par->net, par->family);
 	if (ret < 0) {
-- 
2.19.1



