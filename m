Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeDYLWb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:22:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34122 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbeDYLWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:22:25 -0400
From: Dag Moxnes <dag.moxnes@oracle.com>
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rds: ib: Fix missing call to rds_ib_dev_put in rds_ib_setup_qp
Date: Wed, 25 Apr 2018 13:22:01 +0200
Message-Id: <1524655321-8379-1-git-send-email-dag.moxnes@oracle.com>
X-Mailer: git-send-email 1.7.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8873 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=698
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804250108
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rds_ib_setup_qp is calling rds_ib_get_client_data and
should correspondingly call rds_ib_dev_put. This call was lost in
the non-error path with the introduction of error handling done in
commit 3b12f73a5c29 ("rds: ib: add error handle")

Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
---
 net/rds/ib_cm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index eea1d86..13b38ad 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -547,7 +547,7 @@ static int rds_ib_setup_qp(struct rds_connection *conn)
 	rdsdebug("conn %p pd %p cq %p %p\n", conn, ic->i_pd,
 		 ic->i_send_cq, ic->i_recv_cq);
 
-	return ret;
+	goto out;
 
 sends_out:
 	vfree(ic->i_sends);
@@ -572,6 +572,7 @@ static int rds_ib_setup_qp(struct rds_connection *conn)
 		ic->i_send_cq = NULL;
 rds_ibdev_out:
 	rds_ib_remove_conn(rds_ibdev, conn);
+out:
 	rds_ib_dev_put(rds_ibdev);
 
 	return ret;
-- 
1.7.1
