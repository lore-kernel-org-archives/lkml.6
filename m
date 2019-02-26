Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A8DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4D52147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WSuI6F+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfBZH5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:57:47 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43138 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfBZH5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:57:47 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1Q7sIr3181307;
        Tue, 26 Feb 2019 07:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=06G/DiJzHGAG3BSxNLz7DQYRWU2iaoDWnB/NPG0b+QI=;
 b=WSuI6F+ZKRigGmpT5hVn1cjQA4Kd9hTg0DkXG//GGZi04zDNPt15v+oxhrwvxI7kd/1p
 qMTC6bZoTffZgqUgMzGeVg8D4iBxpimaLnNpogQkB/FUj8LDWU8I6kBcYEdMofF8GNLk
 Un7fk/jBMSs/8xk8PO3m/ta947nT65MQtEywoOEhZio6aEKOQYscpNAx9RII2f2OFSlU
 QajNnx4KzWSQtiC5AEi2UE1WsTMX1Sg8nnHbXhTVsQ6Fi3ykmJNAWTToPBwC2YychiHy
 AvLc9ePa5X8GXYykzMSosr3C3GnGafXOhcDMV793R08UxDSyj1YJ+qj4uZaGb35m5FZH dg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qtupe33fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 07:57:32 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1Q7vWmL002289
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 07:57:32 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1Q7vVlp015254;
        Tue, 26 Feb 2019 07:57:31 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Feb 2019 23:57:31 -0800
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] RDMA/cma: Make CM response timeout and # CM retries configurable
Date:   Tue, 26 Feb 2019 08:57:22 +0100
Message-Id: <20190226075722.1692315-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9178 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902260061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During certain workloads, the default CM response timeout is too
short, leading to excessive retries. Hence, make it configurable
through sysctl. While at it, also make number of CM retries
configurable.

The defaults are not changed.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---
v1 -> v2:
   * Added unregister_net_sysctl_table() in cma_cleanup()
---
 drivers/infiniband/core/cma.c | 52 ++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 68c997be2429..50abce078ff1 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -43,6 +43,7 @@
 #include <linux/inetdevice.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/sysctl.h>
 #include <net/route.h>
 
 #include <net/net_namespace.h>
@@ -68,13 +69,46 @@ MODULE_AUTHOR("Sean Hefty");
 MODULE_DESCRIPTION("Generic RDMA CM Agent");
 MODULE_LICENSE("Dual BSD/GPL");
 
-#define CMA_CM_RESPONSE_TIMEOUT 20
 #define CMA_QUERY_CLASSPORT_INFO_TIMEOUT 3000
-#define CMA_MAX_CM_RETRIES 15
 #define CMA_CM_MRA_SETTING (IB_CM_MRA_FLAG_DELAY | 24)
 #define CMA_IBOE_PACKET_LIFETIME 18
 #define CMA_PREFERRED_ROCE_GID_TYPE IB_GID_TYPE_ROCE_UDP_ENCAP
 
+#define CMA_DFLT_CM_RESPONSE_TIMEOUT 20
+static int cma_cm_response_timeout = CMA_DFLT_CM_RESPONSE_TIMEOUT;
+static int cma_cm_response_timeout_min = 8;
+static int cma_cm_response_timeout_max = 31;
+#undef CMA_DFLT_CM_RESPONSE_TIMEOUT
+
+#define CMA_DFLT_MAX_CM_RETRIES 15
+static int cma_max_cm_retries = CMA_DFLT_MAX_CM_RETRIES;
+static int cma_max_cm_retries_min = 1;
+static int cma_max_cm_retries_max = 100;
+#undef CMA_DFLT_MAX_CM_RETRIES
+
+static struct ctl_table_header *cma_ctl_table_hdr;
+static struct ctl_table cma_ctl_table[] = {
+	{
+		.procname	= "cma_cm_response_timeout",
+		.data		= &cma_cm_response_timeout,
+		.maxlen		= sizeof(cma_cm_response_timeout),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &cma_cm_response_timeout_min,
+		.extra2		= &cma_cm_response_timeout_max,
+	},
+	{
+		.procname	= "cma_max_cm_retries",
+		.data		= &cma_max_cm_retries,
+		.maxlen		= sizeof(cma_max_cm_retries),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &cma_max_cm_retries_min,
+		.extra2		= &cma_max_cm_retries_max,
+	},
+	{ }
+};
+
 static const char * const cma_events[] = {
 	[RDMA_CM_EVENT_ADDR_RESOLVED]	 = "address resolved",
 	[RDMA_CM_EVENT_ADDR_ERROR]	 = "address error",
@@ -3744,8 +3778,8 @@ static int cma_resolve_ib_udp(struct rdma_id_private *id_priv,
 	req.path = id_priv->id.route.path_rec;
 	req.sgid_attr = id_priv->id.route.addr.dev_addr.sgid_attr;
 	req.service_id = rdma_get_service_id(&id_priv->id, cma_dst_addr(id_priv));
-	req.timeout_ms = 1 << (CMA_CM_RESPONSE_TIMEOUT - 8);
-	req.max_cm_retries = CMA_MAX_CM_RETRIES;
+	req.timeout_ms = 1 << (cma_cm_response_timeout - 8);
+	req.max_cm_retries = cma_max_cm_retries;
 
 	ret = ib_send_cm_sidr_req(id_priv->cm_id.ib, &req);
 	if (ret) {
@@ -3815,9 +3849,9 @@ static int cma_connect_ib(struct rdma_id_private *id_priv,
 	req.flow_control = conn_param->flow_control;
 	req.retry_count = min_t(u8, 7, conn_param->retry_count);
 	req.rnr_retry_count = min_t(u8, 7, conn_param->rnr_retry_count);
-	req.remote_cm_response_timeout = CMA_CM_RESPONSE_TIMEOUT;
-	req.local_cm_response_timeout = CMA_CM_RESPONSE_TIMEOUT;
-	req.max_cm_retries = CMA_MAX_CM_RETRIES;
+	req.remote_cm_response_timeout = cma_cm_response_timeout;
+	req.local_cm_response_timeout = cma_cm_response_timeout;
+	req.max_cm_retries = cma_max_cm_retries;
 	req.srq = id_priv->srq ? 1 : 0;
 
 	ret = ib_send_cm_req(id_priv->cm_id.ib, &req);
@@ -4700,6 +4734,9 @@ static int __init cma_init(void)
 		goto err;
 
 	cma_configfs_init();
+	cma_ctl_table_hdr = register_net_sysctl(&init_net, "net/rdma_cm", cma_ctl_table);
+	if (!cma_ctl_table_hdr)
+		pr_warn("rdma_cm: couldn't register sysctl path, using default values\n");
 
 	return 0;
 
@@ -4713,6 +4750,7 @@ static int __init cma_init(void)
 
 static void __exit cma_cleanup(void)
 {
+	unregister_net_sysctl_table(cma_ctl_table_hdr);
 	cma_configfs_exit();
 	ib_unregister_client(&cma_client);
 	unregister_netdevice_notifier(&cma_nb);
-- 
2.20.1

