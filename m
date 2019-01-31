Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DE3C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AE72087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YItzPgIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbfAaRKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:10:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55982 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfAaRKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:10:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0VH99PZ152668;
        Thu, 31 Jan 2019 17:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=5+oXQlPlgn3evHPHYH+8uZ4+X3c1QIrSjvdBTRYX1eo=;
 b=YItzPgIwKRh5ZJpmWxE0AG+CVODNyPcTU/qf5AGBeuluDme/lTTKd9CjK8FVAefRs75T
 z85ihexUfsTG02uiQQ5mnzCqEXU00sMNWd3pFlYz+Fvjb12efq856nrcKTS40eNZ/uZm
 4hAqls+V3EFp3rNlaSN8NRi5xIbxyifCffrfNyRIPK3h1fcCkwXXeHiuDxGJNubiQvWn
 KHtxxbo9E0aF8fNkvTUfEhPpGlenrhFcyGbh3EtMhbIqcVyPWcdAyzxUsnUZQ97X8C3S
 HsUQW5ZqbIkzq7TKGfqPly5uXqCM7kz6MHmSxW0ugk0GC/oWeA1n0WYBcSHuxsK7cfv5 Ag== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2q8g6rhytm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 17:10:09 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0VHA35B017217
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 17:10:03 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0VHA1LM014437;
        Thu, 31 Jan 2019 17:10:03 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Jan 2019 09:10:01 -0800
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] mlx4_ib: Increase the timeout for CM cache
Date:   Thu, 31 Jan 2019 18:09:51 +0100
Message-Id: <20190131170951.178676-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9152 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=755 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901310132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using CX-3 virtual functions, either from a bare-metal machine or
pass-through from a VM, MAD packets are proxied through the PF driver.

Since the VMs have separate name spaces for MAD Transaction Ids
(TIDs), the PF driver has to re-map the TIDs and keep the book keeping
in a cache.

Following the RDMA CM protocol, it is clear when an entry has to
evicted form the cache. But life is not perfect, remote peers may die
or be rebooted. Hence, it's a timeout to wipe out a cache entry, when
the PF driver assumes the remote peer has gone.

We have experienced excessive amount of DREQ retries during fail-over
testing, when running with eight VMs per database server.

The problem has been reproduced in a bare-metal system using one VM
per physical node. In this environment, running 256 processes in each
VM, each process uses RDMA CM to create an RC QP between himself and
all (256) remote processes. All in all 16K QPs.

When tearing down these 16K QPs, excessive DREQ retries (and
duplicates) are observed. With some cat/paste/awk wizardry on the
infiniband_cm sysfs, we observe:

      dreq:       5007
cm_rx_msgs:
      drep:       3838
      dreq:      13018
       rep:       8128
       req:       8256
       rtu:       8256
cm_tx_msgs:
      drep:       8011
      dreq:      68856
       rep:       8256
       req:       8128
       rtu:       8128
cm_tx_retries:
      dreq:      60483

Note that the active/passive side is distributed.

Enabling pr_debug in cm.c gives tons of:

[171778.814239] <mlx4_ib> mlx4_ib_multiplex_cm_handler: id{slave:
1,sl_cm_id: 0xd393089f} is NULL!

By increasing the CM_CLEANUP_CACHE_TIMEOUT from 5 to 30 seconds, the
tear-down phase of the application is reduced from 113 to 67
seconds. Retries/duplicates are also significantly reduced:

cm_rx_duplicates:
      dreq:       7726
[]
cm_tx_retries:
      drep:          1
      dreq:       7779

Increasing the timeout further didn't help, as these duplicates and
retries stem from a too short CMA timeout, which was 20 (~4 seconds)
on the systems. By increasing the CMA timeout to 22 (~17 seconds), the
numbers fell down to about one hundred for both of them.

Adjustment of the CMA timeout is _not_ part of this commit.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/hw/mlx4/cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index fedaf8260105..8c79a480f2b7 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -39,7 +39,7 @@
 
 #include "mlx4_ib.h"
 
-#define CM_CLEANUP_CACHE_TIMEOUT  (5 * HZ)
+#define CM_CLEANUP_CACHE_TIMEOUT  (30 * HZ)
 
 struct id_map_entry {
 	struct rb_node node;
-- 
2.20.1

