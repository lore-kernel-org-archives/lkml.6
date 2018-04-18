Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbeDROZY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:25:24 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33642 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753745AbeDROZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:25:21 -0400
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To: Doug Ledford <dledford@redhat.com>, Don Hiatt <don.hiatt@intel.com>,
        Dasaratharaman Chandramouli
        <dasaratharaman.chandramouli@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Sean Hefty <sean.hefty@intel.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
Subject: [PATCH] IB/core: Make ib_mad_client_id atomic
Date: Wed, 18 Apr 2018 16:24:50 +0200
Message-Id: <20180418142450.15581-1-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8866 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804180131
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two kernel threads may get the same value for agent.hi_tid, if the
agents are registered for different ports. As of now, this works, as
the agent list is per port.

It is however confusing and not future robust. Hence, making it
atomic.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
---
 drivers/infiniband/core/mad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index c50596f7f98a..b28452a55a08 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -59,7 +59,7 @@ module_param_named(recv_queue_size, mad_recvq_size, int, 0444);
 MODULE_PARM_DESC(recv_queue_size, "Size of receive queue in number of work requests");
 
 static struct list_head ib_mad_port_list;
-static u32 ib_mad_client_id = 0;
+static atomic_t ib_mad_client_id = ATOMIC_INIT(0);
 
 /* Port list lock */
 static DEFINE_SPINLOCK(ib_mad_port_list_lock);
@@ -377,7 +377,7 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 	}
 
 	spin_lock_irqsave(&port_priv->reg_lock, flags);
-	mad_agent_priv->agent.hi_tid = ++ib_mad_client_id;
+	mad_agent_priv->agent.hi_tid = atomic_inc_return(&ib_mad_client_id);
 
 	/*
 	 * Make sure MAD registration (if supplied)
-- 
2.13.6
