Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CD4C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FF32082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gR1DWZLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FF32082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbeKCDqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:46:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeKCDqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:46:36 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F9472082D;
        Fri,  2 Nov 2018 18:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183905;
        bh=Gj7LeaDeP4mc4fsVtRPU+x+J2Pr1WIzt4wFF/e8c/UE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gR1DWZLt7RXHPkciAf9dBMPx9l0C9iSTjvpGz5D4aE5bWxWAo4nTYs/11Z673R11n
         nAcmoz6lnHrfGZvomnTecvyc0GqYxiCvMMRiyFAgysmXNL6V7jliWOhczEfkGnzYLY
         oVVnvLXtLTr9ekIRl+TFny51tyeev4p1b3AtAHsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "DSouza, Nelson" <ndsouza@ciena.com>,
        David Ahern <dsahern@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 016/150] netfilter: bridge: Dont sabotage nf_hook calls from an l3mdev
Date:   Fri,  2 Nov 2018 19:32:58 +0100
Message-Id: <20181102182903.967057218@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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
index 9b16eaf33819..58240cc185e7 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -834,7 +834,8 @@ static unsigned int ip_sabotage_in(void *priv,
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



