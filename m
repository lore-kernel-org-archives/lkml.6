Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD86C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152B320835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026446;
	bh=uU69lLjoAjMIUv1Q3ZUFQW2q6gybMPFya6IMz1LsPDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wK7s8JxcPr21KRekhMBE+zYJ6Bv+dA393zCwl2EpGRyUGUIsQd+Ey/z6OlTIWk0Nm
	 SLNLTOO4gVSMA3kHCxPbpA1QnrqxQBWs+twAh6hXBPoOdECGgQsPFXItQfEDuxsG+6
	 HafpwshQbY5BArIzTL5A7hx7ojlakJp3exq1gqJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389983AbfBMCyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:54:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388440AbfBMCiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EA40222C2;
        Wed, 13 Feb 2019 02:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025485;
        bh=uU69lLjoAjMIUv1Q3ZUFQW2q6gybMPFya6IMz1LsPDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IunZP/+bA7BnubwNNyLXKXThzCJB2iVFo1JIK67zYLJQHINTKw7jSa1Nh8FZMEHl1
         4iYire707KWJtqqjoS8VgUBKU5FaDa8Dwma3kRVfc/WZSz2jSX/ZAkZX8uHuejnupB
         bUMym5+rYqaxO2dUHw7Y9J2ywayz1ykNWpWIOpXc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     wenxu <wenxu@ucloud.cn>, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 37/83] netfilter: nft_flow_offload: Fix reverse route lookup
Date:   Tue, 12 Feb 2019 21:36:15 -0500
Message-Id: <20190213023701.20286-37-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

[ Upstream commit a799aea0988ea0d1b1f263e996fdad2f6133c680 ]

Using the following example:

	client 1.1.1.7 ---> 2.2.2.7 which dnat to 10.0.0.7 server

The first reply packet (ie. syn+ack) uses an incorrect destination
address for the reverse route lookup since it uses:

	daddr = ct->tuplehash[!dir].tuple.dst.u3.ip;

which is 2.2.2.7 in the scenario that is described above, while this
should be:

	daddr = ct->tuplehash[dir].tuple.src.u3.ip;

that is 10.0.0.7.

Signed-off-by: wenxu <wenxu@ucloud.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_flow_offload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 5fd4c57c79cc..e0c04851a349 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -29,10 +29,10 @@ static int nft_flow_route(const struct nft_pktinfo *pkt,
 	memset(&fl, 0, sizeof(fl));
 	switch (nft_pf(pkt)) {
 	case NFPROTO_IPV4:
-		fl.u.ip4.daddr = ct->tuplehash[!dir].tuple.dst.u3.ip;
+		fl.u.ip4.daddr = ct->tuplehash[dir].tuple.src.u3.ip;
 		break;
 	case NFPROTO_IPV6:
-		fl.u.ip6.daddr = ct->tuplehash[!dir].tuple.dst.u3.in6;
+		fl.u.ip6.daddr = ct->tuplehash[dir].tuple.src.u3.in6;
 		break;
 	}
 
-- 
2.19.1

