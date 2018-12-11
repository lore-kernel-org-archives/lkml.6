Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225C5C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9812145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543523;
	bh=3mTKNvouzh9CKBCtspUE8F03SU40scCsLTSlGghdafU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cmPYRqK1rCp9HvLgNbNCt1vCCbVFCX5XJrzcncj7qqGsHQ7J1IDgOLHT+gh1Vb61U
	 riQlq8pReYD/nkHWRghUjs5xb6MS/XWl1O+/EuEh/L8BwrNPCb/mTJUB6jQgZXicYv
	 9qdbW3XinsvbNXxbBd+MNdltuQX6d9Nckm/8ipnM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9812145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeLKPwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:52:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729605AbeLKPv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:51:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38D652145D;
        Tue, 11 Dec 2018 15:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543517;
        bh=3mTKNvouzh9CKBCtspUE8F03SU40scCsLTSlGghdafU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWyXmFrcdPJBpK770ycDUBYQYB5MlyT/SQlyByxFEO8M3BDE0r1o78B7Hb8HVnRrT
         E3H6+L/zcMJvDyFvUJ7asMK50Xt1GKRtNVttnreW5zfX5r092B9N4YpLUmxHaAXbis
         DiG4IFnVvhxKtxFeWq8aGWtA5o63dLKApl8EMY8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liang Li <liali@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 28/67] team: no need to do team_notify_peers or team_mcast_rejoin when disabling port
Date:   Tue, 11 Dec 2018 16:41:28 +0100
Message-Id: <20181211151631.813369336@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 817451a1efd6..bd455a6cc82c 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -989,8 +989,6 @@ static void team_port_disable(struct team *team,
 	team->en_port_count--;
 	team_queue_override_port_del(team, port);
 	team_adjust_ops(team);
-	team_notify_peers(team);
-	team_mcast_rejoin(team);
 	team_lower_state_changed(port);
 }
 
-- 
2.19.1



