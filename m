Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75849C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37528223C8
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hpwt0/nO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37528223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbeKLITy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732189AbeKLITx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:53 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A96602154B;
        Sun, 11 Nov 2018 22:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975396;
        bh=BEXbDUfrJmsKCk8J1/ydrSu1k396f5xbrQfuRbTQ0OU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hpwt0/nO4kjnNP2LAGiJaS+xsybZbt+I8w6PjWXxMyT1qQx/q9BWZcUXFK3eAAyml
         y3QSfipp1yHaTAPUrWLzB7/V4GwWLPDHb6vBdxvhoB4eBvlYCStwk2zNuCQXlyb3Ir
         cA4+Lh8lMj6MI9POkBgbMGHmWgjelW70+XBon6A4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pieter Jansen van Vuuren 
        <pieter.jansenvanvuuren@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 052/350] nfp: flower: use offsets provided by pedit instead of index for ipv6
Date:   Sun, 11 Nov 2018 14:18:36 -0800
Message-Id: <20181111221709.328770006@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/action.c |   26 ++++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/flower/action.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/action.c
@@ -335,12 +335,12 @@ nfp_fl_set_ip4(const struct tc_action *a
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
@@ -353,6 +353,7 @@ nfp_fl_set_ip6(const struct tc_action *a
 	       struct nfp_fl_set_ipv6_addr *ip_src)
 {
 	__be32 exact, mask;
+	u8 word;
 
 	/* We are expecting tcf_pedit to return a big endian value */
 	mask = (__force __be32)~tcf_pedit_mask(action, idx);
@@ -361,17 +362,20 @@ nfp_fl_set_ip6(const struct tc_action *a
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


