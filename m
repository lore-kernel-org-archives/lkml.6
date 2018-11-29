Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A92CC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4820208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgLxkNlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4820208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbeK2RFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727643AbeK2RFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:05:07 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D742133F;
        Thu, 29 Nov 2018 06:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471256;
        bh=9jzQTRPDL56lVu935vFr8IFeqEgntt8cinuJX3KoWto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgLxkNlpzslJ6Z5h0JJKXihy50ocZzLqZkBL2HNeOORpu63V4Ls0nsg1S9aZQqfZx
         7dpW5gyscT7U7hQNocWanqE6INp0vKCYT8uvXGlQyZrgOnDHnl8C32Z/hmcibZcqhL
         xCJu385DJQvELeA52r6pLb3vf1WVQ1uJRecK6e8A=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hangbin Liu <liuhangbin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 65/68] team: no need to do team_notify_peers or team_mcast_rejoin when disabling port
Date:   Thu, 29 Nov 2018 00:55:56 -0500
Message-Id: <20181129055559.159228-65-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 5ed9dc99107144f83b6c1bb52a69b58875baf540 ]

team_notify_peers() will send ARP and NA to notify peers. team_mcast_rejoin()
will send multicast join group message to notify peers. We should do this when
enabling/changed to a new port. But it doesn't make sense to do it when a port
is disabled.

On the other hand, when we set mcast_rejoin_count to 2, and do a failover,
team_port_disable() will increase mcast_rejoin.count_pending to 2 and then
team_port_enable() will increase mcast_rejoin.count_pending to 4. We will send
4 mcast rejoin messages at latest, which will make user confused. The same
with notify_peers.count.

Fix it by deleting team_notify_peers() and team_mcast_rejoin() in
team_port_disable().

Reported-by: Liang Li <liali@redhat.com>
Fixes: fc423ff00df3a ("team: add peer notification")
Fixes: 492b200efdd20 ("team: add support for sending multicast rejoins")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/team/team.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index d887016e54b6..4b6572f0188a 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -985,8 +985,6 @@ static void team_port_disable(struct team *team,
 	team->en_port_count--;
 	team_queue_override_port_del(team, port);
 	team_adjust_ops(team);
-	team_notify_peers(team);
-	team_mcast_rejoin(team);
 	team_lower_state_changed(port);
 }
 
-- 
2.17.1

