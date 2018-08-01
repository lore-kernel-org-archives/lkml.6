Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB7AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E35E2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E35E2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbeHAUKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:10:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46076 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404367AbeHATDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 826D112E0;
        Wed,  1 Aug 2018 17:11:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Ran Rozenstein <ranro@mellanox.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 326/336] net: rollback orig value on failure of dev_qdisc_change_tx_queue_len
Date:   Wed,  1 Aug 2018 18:51:01 +0200
Message-Id: <20180801165041.516962296@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit 7effaf06c3cdef6855e127886c7405b9ab62f90d ]

Fix dev_change_tx_queue_len so it rolls back original value
upon a failure in dev_qdisc_change_tx_queue_len.
This is already done for notifirers' failures, share the code.

In case of failure in dev_qdisc_change_tx_queue_len, some tx queues
would still be of the new length, while they should be reverted.
Currently, the revert is not done, and is marked with a TODO label
in dev_qdisc_change_tx_queue_len, and should find some nice solution
to do it.
Yet it is still better to not apply the newly requested value.

Fixes: 48bfd55e7e41 ("net_sched: plug in qdisc ops change_tx_queue_len")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Reported-by: Ran Rozenstein <ranro@mellanox.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7113,16 +7113,19 @@ int dev_change_tx_queue_len(struct net_d
 		dev->tx_queue_len = new_len;
 		res = call_netdevice_notifiers(NETDEV_CHANGE_TX_QUEUE_LEN, dev);
 		res = notifier_to_errno(res);
-		if (res) {
-			netdev_err(dev,
-				   "refused to change device tx_queue_len\n");
-			dev->tx_queue_len = orig_len;
-			return res;
-		}
-		return dev_qdisc_change_tx_queue_len(dev);
+		if (res)
+			goto err_rollback;
+		res = dev_qdisc_change_tx_queue_len(dev);
+		if (res)
+			goto err_rollback;
 	}
 
 	return 0;
+
+err_rollback:
+	netdev_err(dev, "refused to change device tx_queue_len\n");
+	dev->tx_queue_len = orig_len;
+	return res;
 }
 
 /**


