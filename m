Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C83C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 03:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39232217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 03:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V9rT6sJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeLXDRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 22:17:11 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60426 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbeLXDRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 22:17:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBO34uCL055719;
        Mon, 24 Dec 2018 03:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2018-07-02;
 bh=JnnYKmIbl5Rn8lBu8ATpLFAB8468rSt5dHcFWArSOz0=;
 b=V9rT6sJdj1G8UqK++sS7g1NG3VcZ4tIK0kyzY5GDYyrhYqcSGRPz4gv9GaJgYmGnGdkm
 7wC1CSdLi2yxlKpiqHhz7wlwZV/D+FvYIWP5fvGbW1MMoVsFdHwEn10foFdqEJiecDRo
 MJIQEfMbQ3QV9G9it5e8Lr0TPN/CentKPlk4MlJgDeBbbpe9L3Kz5LNz0dIBX3lubsZO
 d9kFLDT32j2x0r54IRk9jyqY+ynTov5Ck2IRGfLbZiHBoxHeQGVrIJ6k3+UIbs/oqHp7
 Dz6cYgitVotjt/7yIeCktFqWf99vtbOspSrJzxc9/HlfvpYHWPw12QuUAP0TijUPeI+2 GA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2phdwqk4wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Dec 2018 03:16:39 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBO3GYtp004238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Dec 2018 03:16:34 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBO3GWkF028727;
        Mon, 24 Dec 2018 03:16:32 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Dec 2018 19:16:32 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: fix the wrong setting of nr_maps
Date:   Mon, 24 Dec 2018 11:15:53 +0800
Message-Id: <1545621353-1443-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9116 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812240027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only set the nr_maps to 3 if poll queues are supported.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a0bf6a..cc65fa8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2294,7 +2294,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		dev->tagset.nr_maps = 2; /* default + read */
 		if (dev->io_queues[HCTX_TYPE_POLL])
 			dev->tagset.nr_maps++;
-		dev->tagset.nr_maps = HCTX_MAX_TYPES;
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
 		dev->tagset.numa_node = dev_to_node(dev->dev);
 		dev->tagset.queue_depth =
-- 
2.7.4

