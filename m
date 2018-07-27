Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14865C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC8120895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC8120895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388571AbeG0LJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:09:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51732 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388154AbeG0LJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:09:24 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C4AFEAF8;
        Fri, 27 Jul 2018 09:48:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhou Wang <wangzhou1@hisilicon.com>,
        Zhao Chen <zhaochen6@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 18/66] net-next/hinic: fix a problem in hinic_xmit_frame()
Date:   Fri, 27 Jul 2018 11:45:11 +0200
Message-Id: <20180727093811.164723943@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
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

From: Zhao Chen <zhaochen6@huawei.com>

[ Upstream commit f7482683f1f4925c60941dbbd0813ceaa069d106 ]

The calculation of "wqe_size" is not correct when the tx queue is busy in
hinic_xmit_frame().

When there are no free WQEs, the tx flow will unmap the skb buffer, then
ring the doobell for the pending packets. But the "wqe_size" which used
to calculate the doorbell address is not correct. The wqe size should be
cleared to 0, otherwise, it will cause a doorbell error.

This patch fixes the problem.

Reported-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Zhao Chen <zhaochen6@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/huawei/hinic/hinic_tx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
@@ -229,6 +229,7 @@ netdev_tx_t hinic_xmit_frame(struct sk_b
 		txq->txq_stats.tx_busy++;
 		u64_stats_update_end(&txq->txq_stats.syncp);
 		err = NETDEV_TX_BUSY;
+		wqe_size = 0;
 		goto flush_skbs;
 	}
 


