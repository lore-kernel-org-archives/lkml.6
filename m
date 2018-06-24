Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6409EC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F96C24F92
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F96C24F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeFXP1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:27:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58818 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeFXP1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:27:54 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 167492C;
        Sun, 24 Jun 2018 15:27:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 10/52] hv_netvsc: Fix a network regression after ifdown/ifup
Date:   Sun, 24 Jun 2018 23:21:03 +0800
Message-Id: <20180624142744.982236269@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142744.234164867@linuxfoundation.org>
References: <20180624142744.234164867@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit 52acf73b6e9a6962045feb2ba5a8921da2201915 ]

Recently people reported the NIC stops working after
"ifdown eth0; ifup eth0". It turns out in this case the TX queues are not
enabled, after the refactoring of the common detach logic: when the NIC
has sub-channels, usually we enable all the TX queues after all
sub-channels are set up: see rndis_set_subchannel() ->
netif_device_attach(), but in the case of "ifdown eth0; ifup eth0" where
the number of channels doesn't change, we also must make sure the TX queues
are enabled. The patch fixes the regression.

Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc_drv.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -123,8 +123,10 @@ static int netvsc_open(struct net_device
 	}
 
 	rdev = nvdev->extension;
-	if (!rdev->link_state)
+	if (!rdev->link_state) {
 		netif_carrier_on(net);
+		netif_tx_wake_all_queues(net);
+	}
 
 	if (vf_netdev) {
 		/* Setting synthetic device up transparently sets


