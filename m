Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DAAC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654A820841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654A820841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733240AbeHAI6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:58:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733096AbeHAI6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:58:39 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1E51A1395F176;
        Wed,  1 Aug 2018 15:14:22 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 15:14:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <santosh.shilimkar@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <rds-devel@oss.oracle.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] rds: remove redundant variable 'rds_ibdev'
Date:   Wed, 1 Aug 2018 15:14:07 +0800
Message-ID: <20180801071407.22044-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable 'rds_ibdev' is being assigned but never used,
so can be removed.

fix this clang warning:
 net/rds/ib_send.c:762:24: warning: variable ‘rds_ibdev’ set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/rds/ib_send.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/rds/ib_send.c b/net/rds/ib_send.c
index c4cdfe49..c8dd312 100644
--- a/net/rds/ib_send.c
+++ b/net/rds/ib_send.c
@@ -759,14 +759,11 @@ int rds_ib_xmit_atomic(struct rds_connection *conn, struct rm_atomic_op *op)
 	struct rds_ib_connection *ic = conn->c_transport_data;
 	struct rds_ib_send_work *send = NULL;
 	struct ib_send_wr *failed_wr;
-	struct rds_ib_device *rds_ibdev;
 	u32 pos;
 	u32 work_alloc;
 	int ret;
 	int nr_sig = 0;
 
-	rds_ibdev = ib_get_client_data(ic->i_cm_id->device, &rds_ib_client);
-
 	work_alloc = rds_ib_ring_alloc(&ic->i_send_ring, 1, &pos);
 	if (work_alloc != 1) {
 		rds_ib_stats_inc(s_ib_tx_ring_full);
-- 
2.7.0


