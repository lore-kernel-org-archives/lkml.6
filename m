Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4331C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4E120870
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRHdRHMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4E120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeJ3WVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbeJ3WVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6819B20838;
        Tue, 30 Oct 2018 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906070;
        bh=+1tt0dcSyRGV6bD6ZXspn95PfM0ZxTWJb7ZbV4X+feY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aRHdRHMr+HbtkJT++qm5UiLRxvhjyqRSRcBmytvafW966tZvNcRD0eedmqSz262/k
         cBR7e8sp4rmIjdMCqJLuriukXDuJdXrxsLwg2Yeqy3mli2G4IEoRFJzpy0wrji2O3O
         eJuKxfGMdYqHXYXyoFQSpH9aK8aspumFhfM3AxbA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 19/33] nfp: flower: use offsets provided by pedit instead of index for ipv6
Date:   Tue, 30 Oct 2018 09:26:43 -0400
Message-Id: <20181030132657.217970-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>

[ Upstream commit 140b6abac26d799f75d772ab5e969b34ad8d68f1 ]

Previously when populating the set ipv6 address action, we incorrectly
made use of pedit's key index to determine which 32bit word should be
set. We now calculate which word has been selected based on the offset
provided by the pedit action.

Fixes: 354b82bb320e ("nfp: add set ipv6 source and destination address")
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/netronome/nfp/flower/action.c    | 26 +++++++++++--------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/action.c b/drivers/net/ethernet/netronome/nfp/flower/action.c
index 35f294bf0cd4..417fbcc64f00 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/action.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/action.c
@@ -335,12 +335,12 @@ nfp_fl_set_ip4(const struct tc_action *action, int idx, u32 off,
 }
 
 static void
-nfp_fl_set_ip6_helper(int opcode_tag, int idx, __be32 exact, __be32 mask,
+nfp_fl_set_ip6_helper(int opcode_tag, u8 word, __be32 exact, __be32 mask,
 		      struct nfp_fl_set_ipv6_addr *ip6)
 {
-	ip6->ipv6[idx % 4].mask |= mask;
-	ip6->ipv6[idx % 4].exact &= ~mask;
-	ip6->ipv6[idx % 4].exact |= exact & mask;
+	ip6->ipv6[word].mask |= mask;
+	ip6->ipv6[word].exact &= ~mask;
+	ip6->ipv6[word].exact |= exact & mask;
 
 	ip6->reserved = cpu_to_be16(0);
 	ip6->head.jump_id = opcode_tag;
@@ -353,6 +353,7 @@ nfp_fl_set_ip6(const struct tc_action *action, int idx, u32 off,
 	       struct nfp_fl_set_ipv6_addr *ip_src)
 {
 	__be32 exact, mask;
+	u8 word;
 
 	/* We are expecting tcf_pedit to return a big endian value */
 	mask = (__force __be32)~tcf_pedit_mask(action, idx);
@@ -361,17 +362,20 @@ nfp_fl_set_ip6(const struct tc_action *action, int idx, u32 off,
 	if (exact & ~mask)
 		return -EOPNOTSUPP;
 
-	if (off < offsetof(struct ipv6hdr, saddr))
+	if (off < offsetof(struct ipv6hdr, saddr)) {
 		return -EOPNOTSUPP;
-	else if (off < offsetof(struct ipv6hdr, daddr))
-		nfp_fl_set_ip6_helper(NFP_FL_ACTION_OPCODE_SET_IPV6_SRC, idx,
+	} else if (off < offsetof(struct ipv6hdr, daddr)) {
+		word = (off - offsetof(struct ipv6hdr, saddr)) / sizeof(exact);
+		nfp_fl_set_ip6_helper(NFP_FL_ACTION_OPCODE_SET_IPV6_SRC, word,
 				      exact, mask, ip_src);
-	else if (off < offsetof(struct ipv6hdr, daddr) +
-		       sizeof(struct in6_addr))
-		nfp_fl_set_ip6_helper(NFP_FL_ACTION_OPCODE_SET_IPV6_DST, idx,
+	} else if (off < offsetof(struct ipv6hdr, daddr) +
+		       sizeof(struct in6_addr)) {
+		word = (off - offsetof(struct ipv6hdr, daddr)) / sizeof(exact);
+		nfp_fl_set_ip6_helper(NFP_FL_ACTION_OPCODE_SET_IPV6_DST, word,
 				      exact, mask, ip_dst);
-	else
+	} else {
 		return -EOPNOTSUPP;
+	}
 
 	return 0;
 }
-- 
2.17.1

