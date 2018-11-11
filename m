Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060CFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56E420818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8cWgum1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56E420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbeKLJ3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:29:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388076AbeKLITt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:49 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C819A223C8;
        Sun, 11 Nov 2018 22:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975392;
        bh=jzVa6bqisiDTjsFdnHu+SwU9mI9vQ/6yJm9VX6IHxRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8cWgum1zxVGkaHp/3FaQAO35U2+rMywq4mSqI2ZL1RaC455ilfA/IHzt3FF2o1P6
         +B4v4+eUk0/JJepBYms57Dm72a2MzrNUQY3B8q4+YNB2/TN1lNldsQpoBEEc0mzvuK
         kESPltVO4IOkPROilYAWPz4xVXhFy8e9mAZdMnFg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pieter Jansen van Vuuren 
        <pieter.jansenvanvuuren@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 051/350] nfp: flower: fix pedit set actions for multiple partial masks
Date:   Sun, 11 Nov 2018 14:18:35 -0800
Message-Id: <20181111221709.291701277@linuxfoundation.org>
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

[ Upstream commit 8913806f166e47c6b3fe8253e9cfb9caabe64341 ]

Previously we did not correctly change headers when using multiple
pedit actions with partial masks. We now take this into account and
no longer just commit the last pedit action.

Fixes: c0b1bd9a8b8a ("nfp: add set ipv4 header action flower offload")
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/action.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/flower/action.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/action.c
@@ -314,12 +314,14 @@ nfp_fl_set_ip4(const struct tc_action *a
 
 	switch (off) {
 	case offsetof(struct iphdr, daddr):
-		set_ip_addr->ipv4_dst_mask = mask;
-		set_ip_addr->ipv4_dst = exact;
+		set_ip_addr->ipv4_dst_mask |= mask;
+		set_ip_addr->ipv4_dst &= ~mask;
+		set_ip_addr->ipv4_dst |= exact & mask;
 		break;
 	case offsetof(struct iphdr, saddr):
-		set_ip_addr->ipv4_src_mask = mask;
-		set_ip_addr->ipv4_src = exact;
+		set_ip_addr->ipv4_src_mask |= mask;
+		set_ip_addr->ipv4_src &= ~mask;
+		set_ip_addr->ipv4_src |= exact & mask;
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -336,8 +338,9 @@ static void
 nfp_fl_set_ip6_helper(int opcode_tag, int idx, __be32 exact, __be32 mask,
 		      struct nfp_fl_set_ipv6_addr *ip6)
 {
-	ip6->ipv6[idx % 4].mask = mask;
-	ip6->ipv6[idx % 4].exact = exact;
+	ip6->ipv6[idx % 4].mask |= mask;
+	ip6->ipv6[idx % 4].exact &= ~mask;
+	ip6->ipv6[idx % 4].exact |= exact & mask;
 
 	ip6->reserved = cpu_to_be16(0);
 	ip6->head.jump_id = opcode_tag;


