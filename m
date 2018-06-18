Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8B9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7C0208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7C0208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967844AbeFRIzX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:55:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35772 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967706AbeFRIeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:34:31 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D3F7AC8A;
        Mon, 18 Jun 2018 08:34:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 115/189] RDMA/cma: Do not query GID during QP state transition to RTR
Date:   Mon, 18 Jun 2018 10:13:31 +0200
Message-Id: <20180618081213.876959590@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
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

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit 9aa169213d1166d30ae357a44abbeae93459339d ]

When commit [1] was added, SGID was queried to derive the SMAC address.
Then, later on during a refactor [2], SMAC was no longer needed. However,
the now useless GID query remained.  Then during additional code changes
later on, the GID query was being done in such a way that it caused iWARP
queries to start breaking.  Remove the useless GID query and resolve the
iWARP breakage at the same time.

This is discussed in [3].

[1] commit dd5f03beb4f7 ("IB/core: Ethernet L2 attributes in verbs/cm structures")
[2] commit 5c266b2304fb ("IB/cm: Remove the usage of smac and vid of qp_attr and cm_av")
[3] https://www.spinics.net/lists/linux-rdma/msg63951.html

Suggested-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cma.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -900,7 +900,6 @@ static int cma_modify_qp_rtr(struct rdma
 {
 	struct ib_qp_attr qp_attr;
 	int qp_attr_mask, ret;
-	union ib_gid sgid;
 
 	mutex_lock(&id_priv->qp_mutex);
 	if (!id_priv->id.qp) {
@@ -923,12 +922,6 @@ static int cma_modify_qp_rtr(struct rdma
 	if (ret)
 		goto out;
 
-	ret = ib_query_gid(id_priv->id.device, id_priv->id.port_num,
-			   rdma_ah_read_grh(&qp_attr.ah_attr)->sgid_index,
-			   &sgid, NULL);
-	if (ret)
-		goto out;
-
 	BUG_ON(id_priv->cma_dev->device != id_priv->id.device);
 
 	if (conn_param)


