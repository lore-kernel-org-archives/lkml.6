Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86D3C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9258E2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx4xGywf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9258E2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeJ3WVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbeJ3WVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C8B42084A;
        Tue, 30 Oct 2018 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906069;
        bh=GDT28+SQc8KuMEvII3abXHG8IiPwtWaLRGEQoIERt7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rx4xGywfBxY0BZI0HQ3ESg4/aoc4eUt5NMmNq4fihLj6JvVycvp4uAOH7jLSlbd1W
         Do5jljrBkZe2Z+BqtT4rduuahn1ef/+iezpM+gLziwaMCi/gF7LTku7aISNvH+IiDH
         0kEXs47tFfiK5lE0pIwov5aHzVhSpSsPnNe9f234=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 18/33] nfp: flower: fix pedit set actions for multiple partial masks
Date:   Tue, 30 Oct 2018 09:26:42 -0400
Message-Id: <20181030132657.217970-18-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 .../net/ethernet/netronome/nfp/flower/action.c    | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/action.c b/drivers/net/ethernet/netronome/nfp/flower/action.c
index 4a6d2db75071..35f294bf0cd4 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/action.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/action.c
@@ -314,12 +314,14 @@ nfp_fl_set_ip4(const struct tc_action *action, int idx, u32 off,
 
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
-- 
2.17.1

