Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0229C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920C6204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920C6204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbeJBUiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:38:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34328 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729495AbeJBUPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:15:16 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EE21C5AA;
        Tue,  2 Oct 2018 13:31:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tarick Bedeir <tarick@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 024/137] IB/mlx4: Test port number before querying type.
Date:   Tue,  2 Oct 2018 06:23:45 -0700
Message-Id: <20181002132500.192249010@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tarick Bedeir <tarick@google.com>

[ Upstream commit f1228867adaf8890826f2b59e4caddb1c5cc2df7 ]

rdma_ah_find_type() can reach into ib_device->port_immutable with a
potentially out-of-bounds port number, so check that the port number is
valid first.

Fixes: 44c58487d51a ("IB/core: Define 'ib' and 'roce' rdma_ah_attr types")
Signed-off-by: Tarick Bedeir <tarick@google.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx4/qp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4014,9 +4014,9 @@ static void to_rdma_ah_attr(struct mlx4_
 	u8 port_num = path->sched_queue & 0x40 ? 2 : 1;
 
 	memset(ah_attr, 0, sizeof(*ah_attr));
-	ah_attr->type = rdma_ah_find_type(&ibdev->ib_dev, port_num);
 	if (port_num == 0 || port_num > dev->caps.num_ports)
 		return;
+	ah_attr->type = rdma_ah_find_type(&ibdev->ib_dev, port_num);
 
 	if (ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE)
 		rdma_ah_set_sl(ah_attr, ((path->sched_queue >> 3) & 0x7) |


