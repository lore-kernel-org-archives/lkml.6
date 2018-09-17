Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B51CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF897214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF897214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbeIRE1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:27:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbeIRE1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:27:48 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EC81ECB2;
        Mon, 17 Sep 2018 22:58:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yelena Krivosheev <yelena@marvell.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 45/70] net: mvneta: fix mtu change on port without link
Date:   Tue, 18 Sep 2018 00:42:18 +0200
Message-Id: <20180917211652.798928139@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yelena Krivosheev <yelena@marvell.com>

[ Upstream commit 8466baf788ec3e18836bd9c91ba0b1a07af25878 ]

It is incorrect to enable TX/RX queues (call by mvneta_port_up()) for
port without link. Indeed MTU change for interface without link causes TX
queues to stuck.

Fixes: c5aff18204da ("net: mvneta: driver for Marvell Armada 370/XP
network unit")
Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
[gregory.clement: adding Fixes tags and rewording commit log]
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvneta.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3117,7 +3117,6 @@ static int mvneta_change_mtu(struct net_
 
 	on_each_cpu(mvneta_percpu_enable, pp, true);
 	mvneta_start_dev(pp);
-	mvneta_port_up(pp);
 
 	netdev_update_features(dev);
 


