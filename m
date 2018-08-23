Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCDAC04E86
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013C1214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013C1214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbeHWMHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:07:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49324 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbeHWMHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:07:54 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C02A2BC1;
        Thu, 23 Aug 2018 08:39:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ariel Elior <Ariel.Elior@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Parav Pandit <parav@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 006/324] RDMA/qedr: Fix NULL pointer dereference when running over iWARP without RDMA-CM
Date:   Thu, 23 Aug 2018 09:51:12 +0200
Message-Id: <20180823074956.238563732@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
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

From: "Kalderon, Michal" <Michal.Kalderon@cavium.com>

[ Upstream commit 425cf5c1350a98b81f3ddda160b99c3be613a213 ]

Some RoCE specific code in qedr_modify_qp was run over an iWARP device
when running perftest benchmarks without the -R option.

The commit 3e44e0ee0893 ("IB/providers: Avoid null netdev check for RoCE")
exposed this. Dropping the check for NULL pointer on ndev in
qedr_modify_qp lead to a null pointer dereference when running over
iWARP. Before the code would identify ndev as being NULL and return an
error.

Fixes: 3e44e0ee0893 ("IB/providers: Avoid null netdev check for RoCE")
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/qedr/verbs.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1957,6 +1957,9 @@ int qedr_modify_qp(struct ib_qp *ibqp, s
 	}
 
 	if (attr_mask & (IB_QP_AV | IB_QP_PATH_MTU)) {
+		if (rdma_protocol_iwarp(&dev->ibdev, 1))
+			return -EINVAL;
+
 		if (attr_mask & IB_QP_PATH_MTU) {
 			if (attr->path_mtu < IB_MTU_256 ||
 			    attr->path_mtu > IB_MTU_4096) {


