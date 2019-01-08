Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDB0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E9F2063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976718;
	bh=8qvoHpKf+Yex+pv8uMx8qz3TgP83ybavqIm1RQyFmZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WAtLw2Pjvpg9mACwHV4XXFNDM6v8ImLPLxHDZmKU0T+wAIWjqHZgp8h7PbtLkyi24
	 prtIa2ICbtwdqu6E/B4VHZK7FVdIoqd02TUzxXg3/ap1VqUczqPuKKZbQP28I2vJJm
	 q+8V8A7sRECFDIFTAVZCe3btk/Nb68FsrX9nv8wA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbfAHTpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:45:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731686AbfAHTdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:33:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52A1D20883;
        Tue,  8 Jan 2019 19:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976003;
        bh=8qvoHpKf+Yex+pv8uMx8qz3TgP83ybavqIm1RQyFmZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ju65xEaObwyRuLWeNsFR6z9HFoaXmSazJxgcw44SAGiKuESQNdTgKqkd123r+hKj4
         +Fazh+p7zXhfjRC3LWw0mDXZWlKEkN7WEIQlmppkF7RTGK4c7uezXpr48lzXBS/zFN
         jsW8VLMc8Hz/bgbfWJ/iolLBv15Vn9eUxWF/mGh4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 37/53] netfilter: ipt_CLUSTERIP: check MAC address when duplicate config is set
Date:   Tue,  8 Jan 2019 14:32:05 -0500
Message-Id: <20190108193222.123316-37-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

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
index cc7c9d67ac19..45f21489f515 100644
--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -492,7 +492,8 @@ static int clusterip_tg_check(const struct xt_tgchk_param *par)
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

