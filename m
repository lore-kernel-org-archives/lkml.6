Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97BCECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601702089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fYMN+Vt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601702089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbeGNAHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 20:07:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40344 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbeGNAHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 20:07:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6DNnEpN097564;
        Fri, 13 Jul 2018 23:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=YFjSMOVddGRigk77mJfFYM9cibGykPkiMTeCxvR5VnI=;
 b=fYMN+Vt939YbtJsTCdQ7lL/AhY9JMcHHTr/xKageHKsTdtfyHEivN+j+bK+NFq84/8Ky
 NPpXSxhMH6l7vmbc2fawK3INxneEfZ2lholqH8Atqa/Q6IeB974pH+7iVy+aETHFZL1q
 Yo+ENX5qtgz0vl6f98n3avsJS5x5RfoPCADQASXVzR0kBjkcow69H56r1r8yqrrUVYsL
 gUz54rgl53SLaV2DixRkdkASzrZwCprZxB4xVyI/Mdf6K1T39KV+cf//Z/4bbpcQa99s
 6ytO11ou1lxCNaugGS+8wVjdtiZ2cfHn3bgmBcHy4ng4sUfUQ1AcruRbeQfb9ruFLwK+ 6Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2k2p7vsgjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 23:50:44 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6DNoiSi019236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 23:50:44 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6DNohFE011460;
        Fri, 13 Jul 2018 23:50:43 GMT
Received: from qing-ol6-work.us.oracle.com (/10.132.91.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Jul 2018 16:50:43 -0700
From:   Qing Huang <qing.huang@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, dledford@redhat.com, leon@kernel.org,
        gerald.gibson@oracle.com, qing.huang@oracle.com
Subject: [PATCH] IB/mlx5: avoid binding a new mpi unit to the same devices repeatedly
Date:   Fri, 13 Jul 2018 16:50:21 -0700
Message-Id: <20180713235021.18141-1-qing.huang@oracle.com>
X-Mailer: git-send-email 2.9.3
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8953 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807130223
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
shouldn't repeatedly attempt to bind the new mpi data unit to every device
on the list until it finds an unbound device.

Reported-by: Gerald Gibson <gerald.gibson@oracle.com>
Signed-off-by: Qing Huang <qing.huang@oracle.com>
---
 drivers/infiniband/hw/mlx5/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b3ba9a2..1ddd1d3 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6068,7 +6068,8 @@ static void *mlx5_ib_add_slave_port(struct mlx5_core_dev *mdev, u8 port_num)
 
 	mutex_lock(&mlx5_ib_multiport_mutex);
 	list_for_each_entry(dev, &mlx5_ib_dev_list, ib_dev_list) {
-		if (dev->sys_image_guid == mpi->sys_image_guid)
+		if (dev->sys_image_guid == mpi->sys_image_guid &&
+		    !dev->port[mlx5_core_native_port_num(mdev) - 1].mp.mpi)
 			bound = mlx5_ib_bind_slave_port(dev, mpi);
 
 		if (bound) {
-- 
2.9.3

