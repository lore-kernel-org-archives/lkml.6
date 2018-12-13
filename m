Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E77C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A4820880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675536;
	bh=a28rzqIivBEl3DNS04g+b2AjW+UgAshzfOEjUU36iIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=afAnlazyvIJwCisZEr0vu6tAXYo6mf0aLtquFVSRjgAC2fwPVNtiAc62JP5tfeo8L
	 i0qtONtWk9/NhlMoPRCKxgDzziy2w6O50yHf4gy6vslO98+StZY+Q1lmFo/Mz0i48z
	 b4HBd0Kk7vPbbw95ZC+L56ofk7fotT/D6kOckALs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A4820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbeLMEcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:32:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbeLMEcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:32:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BADC120873;
        Thu, 13 Dec 2018 04:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675532;
        bh=a28rzqIivBEl3DNS04g+b2AjW+UgAshzfOEjUU36iIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z9m6ram/I3zOPVy54Q3hBdXC3yXBMjc1C8xuzN/4yXXvXaHWOHvSkipyQdrpzD52J
         xEiZFYAzzXtqOgJUxdWWxxQHYvFx9LVISOutHQ2caS7a+MQP5XZDaHS1bMZCA5Ayaw
         Vhd49R43VvlQ9CDbApmwcgQSHSVLNNo36D+TJtbM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Toni Peltonen <peltzi@peltzi.fi>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 07/34] bonding: fix 802.3ad state sent to partner when unbinding slave
Date:   Wed, 12 Dec 2018 23:31:33 -0500
Message-Id: <20181213043200.76295-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043200.76295-1-sashal@kernel.org>
References: <20181213043200.76295-1-sashal@kernel.org>
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
index 6dcc42d79cab..1e2ee97b9240 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -2050,6 +2050,9 @@ void bond_3ad_unbind_slave(struct slave *slave)
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

