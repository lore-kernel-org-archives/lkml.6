Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E502FECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9607C20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZflE0wn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9607C20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbeGWWS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:18:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44770 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388089AbeGWWS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:18:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6NLEChe143997;
        Mon, 23 Jul 2018 21:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=mozdt5F9xwfg6CHk/w1BQpTOn4FA7Cz5b/jZYyBPHjA=;
 b=ZflE0wn0Q6lkr5BSl4bK2cA/Y1TSte7k8+3YkvtqonfcJsuXa6e2587vm7HN8Uq3OAUb
 U0/+Q6znaQutIYMGrRNOMzYpnYQfGq8bsTyIjDIT+sO5ylUrNEYC2V+jqlKBuPXWOCB1
 6vpQvF/ckuLzR6m4KkJFkI5iwPeubmjuyab9tCuKSMGrJCb1zbzj3YgQLW7fS2mksOl+
 nZkNX1snAxqPSXWsJMFmPHtIlERqv6aAVtnQYf6XmJzhwHQ8UxKEbkm9rmyPUu9yqMI/
 xu+LYZCtKiHBXmJ/JvWsNRO80kTsUFsbV1OGCB1atjlU+BuBjD/jfy3c7WEKTdC63dJP VA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2kbtbcpfup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jul 2018 21:15:37 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6NLFahx029863
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jul 2018 21:15:36 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6NLFZpn011208;
        Mon, 23 Jul 2018 21:15:35 GMT
Received: from qing-ol6-work.us.oracle.com (/10.132.91.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Jul 2018 14:15:34 -0700
From:   Qing Huang <qing.huang@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, dledford@redhat.com, leon@kernel.org,
        gerald.gibson@oracle.com, qing.huang@oracle.com,
        danielj@mellanox.com, sharon.s.liu@oracle.com
Subject: [PATCH v2] IB/mlx5: avoid excessive warning msgs when creating VFs on 2nd port
Date:   Mon, 23 Jul 2018 14:15:08 -0700
Message-Id: <20180723211508.7078-1-qing.huang@oracle.com>
X-Mailer: git-send-email 2.9.3
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8963 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=868
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807230233
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a CX5 device is configured in dual-port RoCE mode, after creating
many VFs against port 1, creating the same number of VFs against port 2
will flood kernel/syslog with something like
"mlx5_*:mlx5_ib_bind_slave_port:4266:(pid 5269): port 2 already
affiliated."

So basically, when traversing mlx5_ib_dev_list, mlx5_ib_add_slave_port()
repeatedly attempts to bind the new mpi structure to every device
on the list until it finds an unbound device.

Change the log level from warn to dbg to avoid log flooding as the warning
should be harmless.

Signed-off-by: Qing Huang <qing.huang@oracle.com>
---
  v1 -> v2: change the log level instead

 drivers/infiniband/hw/mlx5/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b3ba9a2..f57b8f7 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5127,8 +5127,8 @@ static bool mlx5_ib_bind_slave_port(struct mlx5_ib_dev *ibdev,
 
 	spin_lock(&ibdev->port[port_num].mp.mpi_lock);
 	if (ibdev->port[port_num].mp.mpi) {
-		mlx5_ib_warn(ibdev, "port %d already affiliated.\n",
-			     port_num + 1);
+		mlx5_ib_dbg(ibdev, "port %d already affiliated.\n",
+			    port_num + 1);
 		spin_unlock(&ibdev->port[port_num].mp.mpi_lock);
 		return false;
 	}
-- 
2.9.3

