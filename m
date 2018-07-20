Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEDFECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF67420652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF67420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390137AbeGTNbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:31:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389978AbeGTNbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:31:05 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 93C10BD8;
        Fri, 20 Jul 2018 12:37:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 049/101] net: use dev_change_tx_queue_len() for SIOCSIFTXQLEN
Date:   Fri, 20 Jul 2018 14:13:55 +0200
Message-Id: <20180720121425.101020647@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
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

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 3f76df198288ceec92fc9eddecad1e73c52769b0 ]

As noticed by Eric, we need to switch to the helper
dev_change_tx_queue_len() for SIOCSIFTXQLEN call path too,
otheriwse still miss dev_qdisc_change_tx_queue_len().

Fixes: 6a643ddb5624 ("net: introduce helper dev_change_tx_queue_len()")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev_ioctl.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -285,16 +285,9 @@ static int dev_ifsioc(struct net *net, s
 		if (ifr->ifr_qlen < 0)
 			return -EINVAL;
 		if (dev->tx_queue_len ^ ifr->ifr_qlen) {
-			unsigned int orig_len = dev->tx_queue_len;
-
-			dev->tx_queue_len = ifr->ifr_qlen;
-			err = call_netdevice_notifiers(
-					NETDEV_CHANGE_TX_QUEUE_LEN, dev);
-			err = notifier_to_errno(err);
-			if (err) {
-				dev->tx_queue_len = orig_len;
+			err = dev_change_tx_queue_len(dev, ifr->ifr_qlen);
+			if (err)
 				return err;
-			}
 		}
 		return 0;
 


