Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD584ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BB02088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BB02088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbeIREWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:22:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45310 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbeIREWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:22:01 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E44BFCAD;
        Mon, 17 Sep 2018 22:52:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 45/56] RDMA/cma: Do not ignore net namespace for unbound cm_id
Date:   Tue, 18 Sep 2018 00:42:18 +0200
Message-Id: <20180917213829.778141917@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917213827.913122591@linuxfoundation.org>
References: <20180917213827.913122591@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit 643d213a9a034fa04f5575a40dfc8548e33ce04f ]

Currently if the cm_id is not bound to any netdevice, than for such cm_id,
net namespace is ignored; which is incorrect.

Regardless of cm_id bound to a netdevice or not, net namespace must
match. When a cm_id is bound to a netdevice, in such case net namespace
and netdevice both must match.

Fixes: 4c21b5bcef73 ("IB/cma: Add net_dev and private data checks to RDMA CM")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cma.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1280,9 +1280,16 @@ static bool cma_match_net_dev(const stru
 		       (addr->src_addr.ss_family == AF_IB ||
 			cma_protocol_roce_dev_port(id->device, port_num));
 
-	return !addr->dev_addr.bound_dev_if ||
-	       (net_eq(dev_net(net_dev), addr->dev_addr.net) &&
-		addr->dev_addr.bound_dev_if == net_dev->ifindex);
+	/*
+	 * Net namespaces must match, and if the listner is listening
+	 * on a specific netdevice than netdevice must match as well.
+	 */
+	if (net_eq(dev_net(net_dev), addr->dev_addr.net) &&
+	    (!!addr->dev_addr.bound_dev_if ==
+	     (addr->dev_addr.bound_dev_if == net_dev->ifindex)))
+		return true;
+	else
+		return false;
 }
 
 static struct rdma_id_private *cma_find_listener(


