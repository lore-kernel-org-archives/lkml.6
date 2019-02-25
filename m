Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35CEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68EF21848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130339;
	bh=t4WogQlDNQ+eabjgPSGS6RNRWOL71+qnRjKpR4MaVLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wXMsN1BZG80ypiKYwc04Q4BGy13n+Hf0VVNary9DoPEIMmh9J5H6Om2YtvgHbGLYK
	 DQF3r8ZL1q+PbKnh7SgLwg52fVWW3SC/GcEQTbS7714Os0uDpzY1TR2Vno+vw6Ui65
	 cSsCqSSIrfRzSW2hl7Q1PSBFMvuiCMTQzW7UaIU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbfBYVcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:32:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732226AbfBYVcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:32:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BABC21841;
        Mon, 25 Feb 2019 21:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130334;
        bh=t4WogQlDNQ+eabjgPSGS6RNRWOL71+qnRjKpR4MaVLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhqX5n+6jxWT5N0j7ovfEFIE7oWnCDdYi5/cbZBXEOxU/GOXoemzIxIGasvcKSVsq
         bkZiychWrk4w4zO1xmX6mjxZ/zNnpu12zBbwYBKfJ5iyVSsSrdNHrlzYNM1AlxAGRi
         /XW8QXgwB54wTbNBKXuMsRUHCLzBOugAwva/5Xis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, wenxu <wenxu@ucloud.cn>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 061/183] netfilter: nft_flow_offload: Fix reverse route lookup
Date:   Mon, 25 Feb 2019 22:10:34 +0100
Message-Id: <20190225195104.778224920@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 974525eb92df7..ccdb8f5ababbe 100644
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



