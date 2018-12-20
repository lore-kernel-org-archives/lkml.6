Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0D5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3810120449
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298386;
	bh=+zzHOdpaOL5QYjnZzQWb40OLq4TWt1xsthFO9ObiFD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PLwZ087gpngWm2eivhXuYthgij38SzFvBSkuWb8FsTTOLE3AnZfhOm1Rzl3eHuciF
	 s/Av/WR9cQrDwwSlxZjXvyevDFUPjX7qVkLbjd/A4UsDoYVdNyEI37eff3TWDl23WE
	 9kktWWkhzIZoP1lSz8EzYwe/Y+PD6Hi3/0jHAhak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732992AbeLTJap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:30:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732971AbeLTJak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46AAD21741;
        Thu, 20 Dec 2018 09:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298239;
        bh=+zzHOdpaOL5QYjnZzQWb40OLq4TWt1xsthFO9ObiFD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hpfc7iVcaDMXDi18FfIU/B9raHCud4WHI1Flo++n5oNFhT2iCq2BcPGUS337qaxCC
         L3BsJGG8yN7fVkiydzqCBFR6FAoADhQ0IWIwiXb/k2C9mEFLXGjOdeqw6GFl8MQEoH
         5DdYZZKMkz2m8TPhr9iAmoAriOWTgL0NpZXgdxvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Toni Peltonen <peltzi@peltzi.fi>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Jonathan Toppins <jtoppins@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 24/67] bonding: fix 802.3ad state sent to partner when unbinding slave
Date:   Thu, 20 Dec 2018 10:18:36 +0100
Message-Id: <20181220085904.507458210@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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
index f43fb2f958a5..93dfcef8afc4 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -2086,6 +2086,9 @@ void bond_3ad_unbind_slave(struct slave *slave)
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



