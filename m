Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A724AC04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE0720861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H+bq3zjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE0720861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeINFea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:34:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44654 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeINFe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 01:34:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8E0IuTt005403;
        Fri, 14 Sep 2018 00:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=V8Pb4DlbESbQPYx1hzmXs3hD4/IFmwqn+jYFLhiC9RM=;
 b=H+bq3zjbC0V/ZC5VyPyOMm6ZQTE3j4P4QWOz2kl83nj3d7ZVtKlDVCYzfP5TNty/w2UK
 5Bv+ufus61A2yun3s2JhY4Nbbk0Up8xPiLrhhkdQvNWRQwWqUw7rhJbjkTV1e8EYCcm4
 r++rN5zZp0OEw+EGd21CjePQyqp4YgZbyWUCCJirveTYaNk5mZK3uzfmUNCpUjeLHrS8
 sTdtNkAY8UfuBM1yE2pLPtyXOPSTpRaTU8R3h3zlDhiVkknnp5cyB435kvT9y7rrVpZP
 qlren5ACqWY8n1kZ4DAMVbBrGzYJwJUrPEbo/dDp29ONYrMFPCYmjYNRXkci6yMvP1Lb Lg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mc5utvajp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 00:22:35 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8E0MYgX016101
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 00:22:34 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8E0MXUG018529;
        Fri, 14 Sep 2018 00:22:33 GMT
Received: from qing-ol6-work.us.oracle.com (/10.132.91.103)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Sep 2018 17:22:33 -0700
From:   Qing Huang <qing.huang@oracle.com>
To:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tariqt@mellanox.com, davem@davemloft.net
Subject: [PATCH] net/mlx4_core: print firmware version during driver loading
Date:   Thu, 13 Sep 2018 17:25:14 -0700
Message-Id: <20180914002514.27571-1-qing.huang@oracle.com>
X-Mailer: git-send-email 2.9.3
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9015 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=979
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debugging firmware related issues, it's very helpful to have
the installed FW version info in the kernel log when the driver is
loaded. It's easier to match error/warning messages with different
FW versions in the log other than running a separate tool to get
the information back and forth.

Signed-off-by: Qing Huang <qing.huang@oracle.com>
---
 drivers/net/ethernet/mellanox/mlx4/fw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/fw.c b/drivers/net/ethernet/mellanox/mlx4/fw.c
index babcfd9..e1c5218 100644
--- a/drivers/net/ethernet/mellanox/mlx4/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
@@ -1686,11 +1686,11 @@ int mlx4_QUERY_FW(struct mlx4_dev *dev)
 	MLX4_GET(lg, outbox, QUERY_FW_MAX_CMD_OFFSET);
 	cmd->max_cmds = 1 << lg;
 
-	mlx4_dbg(dev, "FW version %d.%d.%03d (cmd intf rev %d), max commands %d\n",
-		 (int) (dev->caps.fw_ver >> 32),
-		 (int) (dev->caps.fw_ver >> 16) & 0xffff,
-		 (int) dev->caps.fw_ver & 0xffff,
-		 cmd_if_rev, cmd->max_cmds);
+	mlx4_info(dev, "FW version %d.%d.%03d (cmd intf rev %d), max commands %d\n",
+		  (int)(dev->caps.fw_ver >> 32),
+		  (int)(dev->caps.fw_ver >> 16) & 0xffff,
+		  (int)dev->caps.fw_ver & 0xffff,
+		  cmd_if_rev, cmd->max_cmds);
 
 	MLX4_GET(fw->catas_offset, outbox, QUERY_FW_ERR_START_OFFSET);
 	MLX4_GET(fw->catas_size,   outbox, QUERY_FW_ERR_SIZE_OFFSET);
-- 
2.9.3

