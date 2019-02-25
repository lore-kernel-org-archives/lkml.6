Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E52C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC5B21871
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129749;
	bh=b14FQ6+ukZqQZ+H/WYNbgTclGpLELGz3P5PzS6oRBlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m3dCo1eAFEmwfKgBu+T29KMqdWP+1dNOd4whaTUHp7nXYso0s4fQBzFgBy3Oyg4eT
	 mLbcDSXYA55SmUiA8zur3nx/l0vOLuJ9YBNwQrAQZn5m+4q8JY3fIxjTFxl4v7TIVw
	 3HlJgsuXyZ3yx39ocWuYis9sFnNVEMkq2bj6NN/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbfBYVW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:22:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730853AbfBYVWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D92621848;
        Mon, 25 Feb 2019 21:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129743;
        bh=b14FQ6+ukZqQZ+H/WYNbgTclGpLELGz3P5PzS6oRBlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRwpJbAHpziFhRWdTKidZZ4FbNoB9fN3iZ6CxUdRPXyt7Tqu/I6kSjmxa22nUuabM
         7pgh5mpJ85JOGQf4jLyyj72pC9g6uPS6CmDhUPfsJ1pHOMvkkHd4UE/pW/jtMtYzg8
         6TMjAuSWuZTOAc2zRMmWODGcyhHit1qg6UY4ojUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, wenxu <wenxu@ucloud.cn>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 052/152] netfilter: nft_flow_offload: Fix reverse route lookup
Date:   Mon, 25 Feb 2019 22:10:44 +0100
Message-Id: <20190225195047.201956640@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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
index 5fd4c57c79cc9..e0c04851a3493 100644
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



