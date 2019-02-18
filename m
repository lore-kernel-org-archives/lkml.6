Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703812147A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bsybkXEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfBRSeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:34:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37960 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBRSeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:34:01 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1IIXTdJ055410;
        Mon, 18 Feb 2019 18:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=ZDKY9hBvJoDtVTqqHQC9ldcs8RYr4DdJB76Ag4dmeII=;
 b=bsybkXEJyoaalvLZRHcRZ0Kg8q35h5CXd/dOVFGF0uB85LRtilxWDntKQo2VP9L4NI6c
 PP6OGSJ19yV+yxGR6cSWzUZD34Rrx7YMLo6G83hRZEBRcVQxuRLm1Uyu9NRMLklpobXo
 +6Z1b6BI2lnzQqbIshb+olfHm64b2QXofdmm1c5sxhzWQYNxOva7DiNFe/XRaE6YtEfY
 gdY/9Ydbzg3CZ7cNjgK3oarlWzGfiGMrT9xBTcRNzVqH8rCq+UWGJMD5WJsLR5NeTTBW
 l/KJdys4bdptqY0YtDcwmfdqiAsrlijZy0LdIZe9bej8/3Lkt7vuZSDCcRm5y93H3wul ig== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qp9xtqhq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 18:33:54 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1IIXq6h027385
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 18:33:52 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1IIXpek025383;
        Mon, 18 Feb 2019 18:33:51 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Feb 2019 10:33:50 -0800
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, jackm@dev.mellanox.co.il,
        majd@mellanox.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/mlx4: Spread completion vectors for proxy CQs
Date:   Mon, 18 Feb 2019 19:33:02 +0100
Message-Id: <20190218183302.1242676-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9171 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902180137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAD packet sending/receiving is not properly virtualized in
CX-3. Hence, these are proxied through the PF driver. The proxying
uses UD QPs. The associated CQs are created with completion vector
zero.

This leads to great imbalance in CPU processing, in particular during
heavy RDMA CM traffic.

Solved by selecting the completion vector on a round-robin base.

The imbalance can be demonstrated in a bare-metal environment, where
two nodes have instantiated 8 VFs each. This using dual ported HCAs,
so we have 16 vPorts per physical server.

64 processes are associated with each vPort and creates and destroys
one QP for each of the remote 64 processes. That is, 1024 QPs per
vPort, all in all 16K QPs. The QPs are created/destroyed using the
CM.

Before this commit, we have (excluding all completion IRQs with zero
interrupts):

396: mlx4-1@0000:94:00.0 199126
397: mlx4-2@0000:94:00.0 1

With this commit:

396: mlx4-1@0000:94:00.0 12568
397: mlx4-2@0000:94:00.0 50772
398: mlx4-3@0000:94:00.0 10063
399: mlx4-4@0000:94:00.0 50753
400: mlx4-5@0000:94:00.0 6127
401: mlx4-6@0000:94:00.0 6114
[]
414: mlx4-19@0000:94:00.0 6122
415: mlx4-20@0000:94:00.0 6117

The added pr_info shows:

create_pv_resources: slave:0 port:1, vector:0, num_comp_vectors:62
create_pv_resources: slave:0 port:1, vector:1, num_comp_vectors:62
create_pv_resources: slave:0 port:2, vector:2, num_comp_vectors:62
create_pv_resources: slave:0 port:2, vector:3, num_comp_vectors:62
create_pv_resources: slave:1 port:1, vector:4, num_comp_vectors:62
create_pv_resources: slave:1 port:2, vector:5, num_comp_vectors:62
[]
create_pv_resources: slave:8 port:2, vector:18, num_comp_vectors:62
create_pv_resources: slave:8 port:1, vector:19, num_comp_vectors:62

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/hw/mlx4/mad.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index 936ee1314bcd..300839e7f519 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -1973,6 +1973,7 @@ static int create_pv_resources(struct ib_device *ibdev, int slave, int port,
 {
 	int ret, cq_size;
 	struct ib_cq_init_attr cq_attr = {};
+	static atomic_t comp_vect = ATOMIC_INIT(-1);
 
 	if (ctx->state != DEMUX_PV_STATE_DOWN)
 		return -EEXIST;
@@ -2002,6 +2003,9 @@ static int create_pv_resources(struct ib_device *ibdev, int slave, int port,
 		cq_size *= 2;
 
 	cq_attr.cqe = cq_size;
+	cq_attr.comp_vector = atomic_inc_return(&comp_vect) % ibdev->num_comp_vectors;
+	pr_info("slave:%d port:%d, vector:%d, num_comp_vectors:%d\n",
+		slave, port, cq_attr.comp_vector, ibdev->num_comp_vectors);
 	ctx->cq = ib_create_cq(ctx->ib_dev, mlx4_ib_tunnel_comp_handler,
 			       NULL, ctx, &cq_attr);
 	if (IS_ERR(ctx->cq)) {
-- 
2.20.1

