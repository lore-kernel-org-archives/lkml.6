Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7699C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D9D20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPX17CHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D9D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbeJPMPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbeJPMCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 258AA2147E;
        Tue, 16 Oct 2018 04:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663257;
        bh=l0KeW1fEAlt9N3w6R1jNxRKyf5kO1Gah0LJymy8Y/G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPX17CHsXMmaTrfFj9+brHKWbdISttBhE5Ccw3Zven+IJJE679ze0pCziQh/LE6dI
         QIKUq31laHaBzYqWDaVJf5nSE4KVUZ4Nca1qeAeqbTXSnN0cMe+a1rh3Yz/RTkPgdm
         m+G8y6Cqb3j70D5EV/S2cXOOonqN9RsE7y/J+gVg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Ahern <dsahern@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 14/61] netfilter: bridge: Don't sabotage nf_hook calls from an l3mdev
Date:   Tue, 16 Oct 2018 00:13:16 -0400
Message-Id: <20181016041403.135678-14-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

[ Upstream commit a173f066c7cfc031acb8f541708041e009fc9812 ]

For starters, the bridge netfilter code registers operations that
are invoked any time nh_hook is called. Specifically, ip_sabotage_in
watches for nested calls for NF_INET_PRE_ROUTING when a bridge is in
the stack.

Packet wise, the bridge netfilter hook runs first. br_nf_pre_routing
allocates nf_bridge, sets in_prerouting to 1 and calls NF_HOOK for
NF_INET_PRE_ROUTING. It's finish function, br_nf_pre_routing_finish,
then resets in_prerouting flag to 0 and the packet continues up the
stack. The packet eventually makes it to the VRF driver and it invokes
nf_hook for NF_INET_PRE_ROUTING in case any rules have been added against
the vrf device.

Because of the registered operations the call to nf_hook causes
ip_sabotage_in to be invoked. That function sees the nf_bridge on the
skb and that in_prerouting is not set. Thinking it is an invalid nested
call it steals (drops) the packet.

Update ip_sabotage_in to recognize that the bridge or one of its upper
devices (e.g., vlan) can be enslaved to a VRF (L3 master device) and
allow the packet to go through the nf_hook a second time.

Fixes: 73e20b761acf ("net: vrf: Add support for PREROUTING rules on vrf device")
Reported-by: D'Souza, Nelson <ndsouza@ciena.com>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_netfilter_hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index c2eea1b8737a..7582f28ab306 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -832,7 +832,8 @@ static unsigned int ip_sabotage_in(void *priv,
 				   struct sk_buff *skb,
 				   const struct nf_hook_state *state)
 {
-	if (skb->nf_bridge && !skb->nf_bridge->in_prerouting) {
+	if (skb->nf_bridge && !skb->nf_bridge->in_prerouting &&
+	    !netif_is_l3_master(skb->dev)) {
 		state->okfn(state->net, state->sk, skb);
 		return NF_STOLEN;
 	}
-- 
2.17.1

