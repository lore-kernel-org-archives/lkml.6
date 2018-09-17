Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FEEECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E182146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E182146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbeIREmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:42:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbeIREmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:42:05 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C67C6C49;
        Mon, 17 Sep 2018 23:12:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Drozdov <denisd@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Feras Daoud <ferasda@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 076/158] IB/IPoIB: Set ah valid flag in multicast send flow
Date:   Tue, 18 Sep 2018 00:41:46 +0200
Message-Id: <20180917211714.773008217@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Denis Drozdov <denisd@mellanox.com>

[ Upstream commit 75da96067ade4e7854379ec2f7834f3497652b1a ]

The change of ipoib_ah data structure with adding "valid" flag and
checks of ah->valid in ipoib_start_xmit affected multicast packet flow.

Since the multicast flow doesn't invoke path_rec_start, "ah->valid" flag
remains unset, so that ipoib_start_xmit end up with neigh_refresh_path
instead of sending the packet using neigh.

"ah->valid" has to be set in multicast send flow. As a result IPoIB
starts sending packets via neigh immediately and eliminates 60sec delay
of neigh keep alive interval.

The typical example of this issue are two sequential arpings:

arping 11.134.208.9 -> got response (mcast_send)
arping 11.134.208.9 -> no response  (ah->valid = 0)

Fixes: fa9391dbad4b ("RDMA/ipoib: Update paths on CLIENT_REREG/SM_CHANGE events")
Signed-off-by: Denis Drozdov <denisd@mellanox.com>
Reviewed-by: Erez Shitrit <erezsh@mellanox.com>
Reviewed-by: Feras Daoud <ferasda@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -822,6 +822,7 @@ void ipoib_mcast_send(struct net_device
 			if (neigh && list_empty(&neigh->list)) {
 				kref_get(&mcast->ah->ref);
 				neigh->ah	= mcast->ah;
+				neigh->ah->valid = 1;
 				list_add_tail(&neigh->list, &mcast->neigh_list);
 			}
 		}


