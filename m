Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF84ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DAF20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS2ltBvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DAF20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeJYWrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbeJYWrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:46 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 496E22085A;
        Thu, 25 Oct 2018 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476889;
        bh=EWhQ1wTTJXKVJQoCNvQPQGtUtMC2BnQUyYLiwPZ6rvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dS2ltBvZFsrjHdsOYbiK5H2gq0tPMFRmsY/TKf6oOvIbPVpW+oeN/x2a9D7u1RIhE
         mztbhJC4ImzPUNG4S3TCadfkym+FOJJy5xpaKzGHMN8PTBJ11pDeP5cOkpPcZKfxoQ
         dH19iyNXb8XYG+ifageAJrvBclY23x3ar9P033Ac=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Noa Osherovich <noaos@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 15/98] IB/core: Fix the validations of a multicast LID in attach or detach operations
Date:   Thu, 25 Oct 2018 10:13:00 -0400
Message-Id: <20181025141423.213774-15-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Noa Osherovich <noaos@mellanox.com>

[ Upstream commit 5236333592244557a19694a51337df6ac018f0a7 ]

RoCE Annex (A16.9.10/11) declares that during attach (detach) QP to a
multicast group, if the QP is associated with a RoCE port, the
multicast group MLID is unused and is ignored.

During attach or detach multicast, when the QP is associated with a
port, it is enough to check the port's link layer and validate the
LID only if it is Infiniband. Otherwise, avoid validating the
multicast LID.

Fixes: 8561eae60ff9 ("IB/core: For multicast functions, verify that LIDs are multicast LIDs")
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/verbs.c | 44 ++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 0e64b52af5b2..d28c4cf7c1ee 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1510,6 +1510,44 @@ EXPORT_SYMBOL(ib_dealloc_fmr);
 
 /* Multicast groups */
 
+static bool is_valid_mcast_lid(struct ib_qp *qp, u16 lid)
+{
+	struct ib_qp_init_attr init_attr = {};
+	struct ib_qp_attr attr = {};
+	int num_eth_ports = 0;
+	int port;
+
+	/* If QP state >= init, it is assigned to a port and we can check this
+	 * port only.
+	 */
+	if (!ib_query_qp(qp, &attr, IB_QP_STATE | IB_QP_PORT, &init_attr)) {
+		if (attr.qp_state >= IB_QPS_INIT) {
+			if (qp->device->get_link_layer(qp->device, attr.port_num) !=
+			    IB_LINK_LAYER_INFINIBAND)
+				return true;
+			goto lid_check;
+		}
+	}
+
+	/* Can't get a quick answer, iterate over all ports */
+	for (port = 0; port < qp->device->phys_port_cnt; port++)
+		if (qp->device->get_link_layer(qp->device, port) !=
+		    IB_LINK_LAYER_INFINIBAND)
+			num_eth_ports++;
+
+	/* If we have at lease one Ethernet port, RoCE annex declares that
+	 * multicast LID should be ignored. We can't tell at this step if the
+	 * QP belongs to an IB or Ethernet port.
+	 */
+	if (num_eth_ports)
+		return true;
+
+	/* If all the ports are IB, we can check according to IB spec. */
+lid_check:
+	return !(lid < be16_to_cpu(IB_MULTICAST_LID_BASE) ||
+		 lid == be16_to_cpu(IB_LID_PERMISSIVE));
+}
+
 int ib_attach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid)
 {
 	int ret;
@@ -1517,8 +1555,7 @@ int ib_attach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid)
 	if (!qp->device->attach_mcast)
 		return -ENOSYS;
 	if (gid->raw[0] != 0xff || qp->qp_type != IB_QPT_UD ||
-	    lid < be16_to_cpu(IB_MULTICAST_LID_BASE) ||
-	    lid == be16_to_cpu(IB_LID_PERMISSIVE))
+	    !is_valid_mcast_lid(qp, lid))
 		return -EINVAL;
 
 	ret = qp->device->attach_mcast(qp, gid, lid);
@@ -1535,8 +1572,7 @@ int ib_detach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid)
 	if (!qp->device->detach_mcast)
 		return -ENOSYS;
 	if (gid->raw[0] != 0xff || qp->qp_type != IB_QPT_UD ||
-	    lid < be16_to_cpu(IB_MULTICAST_LID_BASE) ||
-	    lid == be16_to_cpu(IB_LID_PERMISSIVE))
+	    !is_valid_mcast_lid(qp, lid))
 		return -EINVAL;
 
 	ret = qp->device->detach_mcast(qp, gid, lid);
-- 
2.17.1

