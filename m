Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC38C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C871720849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675730;
	bh=G+L5/7sGcNYeqsY7R04oOkM+glCXHcxjfcbL6vSBwws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RTQ+oCHZpCFk7kNoVr7qmBAB+Pro0DseKiYkXYzuWIKd6iM9Q7L+aANzg/cxCXy0k
	 X/FTb7cCMMFPwsy1cOwrkdqryp+9dMP/aAN7IJY6A/KVuJE/BXhUN8yJUz81cTw2yo
	 ey3zz9EhfHqNcgb5kdYlLZiJblcm4yHcl/rJMQDU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C871720849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbeLMEdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbeLMEdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:33:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85BCD20672;
        Thu, 13 Dec 2018 04:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675630;
        bh=G+L5/7sGcNYeqsY7R04oOkM+glCXHcxjfcbL6vSBwws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bePiMRlZ/s0FwHGDwfnr1QDCaPw3OzAiUBxC9C9rgvy5b+rdaxKBcQXjRNcHA1WAz
         N1ANuU8tdNYapBB1PHWg6Ss4PStyAJE5wb4v9zTOTKk0PkeFGIt8j92DPhkIi8JWui
         LL8kLo/guaISnTtfcWT+TkKsAAoeBkwxqIM+R3yc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Toni Peltonen <peltzi@peltzi.fi>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 04/16] bonding: fix 802.3ad state sent to partner when unbinding slave
Date:   Wed, 12 Dec 2018 23:33:31 -0500
Message-Id: <20181213043343.76896-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043343.76896-1-sashal@kernel.org>
References: <20181213043343.76896-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toni Peltonen <peltzi@peltzi.fi>

[ Upstream commit 3b5b3a3331d141e8f2a7aaae3a94dfa1e61ecbe4 ]

Previously when unbinding a slave the 802.3ad implementation only told
partner that the port is not suitable for aggregation by setting the port
aggregation state from aggregatable to individual. This is not enough. If the
physical layer still stays up and we only unbinded this port from the bond there
is nothing in the aggregation status alone to prevent the partner from sending
traffic towards us. To ensure that the partner doesn't consider this
port at all anymore we should also disable collecting and distributing to
signal that this actor is going away. Also clear AD_STATE_SYNCHRONIZATION to
ensure partner exits collecting + distributing state.

I have tested this behaviour againts Arista EOS switches with mlx5 cards
(physical link stays up even when interface is down) and simulated
the same situation virtually Linux <-> Linux with two network namespaces
running two veth device pairs. In both cases setting aggregation to
individual doesn't alone prevent traffic from being to sent towards this
port given that the link stays up in partners end. Partner still keeps
it's end in collecting + distributing state and continues until timeout is
reached. In most cases this means we are losing the traffic partner sends
towards our port while we wait for timeout. This is most visible with slow
periodic time (LACP rate slow).

Other open source implementations like Open VSwitch and libreswitch, and
vendor implementations like Arista EOS, seem to disable collecting +
distributing to when doing similar port disabling/detaching/removing change.
With this patch kernel implementation would behave the same way and ensure
partner doesn't consider our actor viable anymore.

Signed-off-by: Toni Peltonen <peltzi@peltzi.fi>
Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Acked-by: Jonathan Toppins <jtoppins@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_3ad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 2110215f3528..371cbaa82608 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1906,6 +1906,9 @@ void bond_3ad_unbind_slave(struct slave *slave)
 		   aggregator->aggregator_identifier);
 
 	/* Tell the partner that this port is not suitable for aggregation */
+	port->actor_oper_port_state &= ~AD_STATE_SYNCHRONIZATION;
+	port->actor_oper_port_state &= ~AD_STATE_COLLECTING;
+	port->actor_oper_port_state &= ~AD_STATE_DISTRIBUTING;
 	port->actor_oper_port_state &= ~AD_STATE_AGGREGATION;
 	__update_lacpdu_from_port(port);
 	ad_lacpdu_send(port);
-- 
2.19.1

