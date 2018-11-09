Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE0FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5021920840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kbY6k3E8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5021920840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeKIKsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 05:48:11 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60966 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbeKIKsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 05:48:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA918v5l194260;
        Fri, 9 Nov 2018 01:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=eVTwJ6ChUDGYX2iDKW1/ywBewnaUyN2dWZrdpD930e4=;
 b=kbY6k3E8GqNEZcRCxiuDNNwV3uJfkICaUgBBsvBzISub4DL5Z+RCQDGYmg2Xrj6IvSWI
 eqI0n0DDbSdY/fjKetYRJoTHTGK2IB/0Arbx2DRFa7Q4QcTK1WE6z74CFbErJHG6N7p3
 ZR9W0U8ycrNJl8QNZKbHYq5KAQZHCyXIiPSP/Ye9odiRoWXuGBotejcIorGwH89KOW8c
 g9IElf9yC9hrow/9vsk193KdZmnXdjMOgnkitjdYsAOTGX9pHwBe7qIBa5Xngy7tcvKZ
 dNWTFGA4PvaEVFd2cf415yNjiJCfsKBl7p8bCbcMItjmJ+NzbOJ+9/iFbMOfqoX2pjnD LQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2nh3mq4men-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Nov 2018 01:09:46 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA919jmo012132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Nov 2018 01:09:45 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA919icb024541;
        Fri, 9 Nov 2018 01:09:44 GMT
Received: from manjunathpatil.us.oracle.com (/10.211.44.52)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Nov 2018 17:09:44 -0800
From:   Manjunath Patil <manjunath.b.patil@oracle.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com
Cc:     axboe@kernel.dk, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2] xen-blkfront: fix kernel panic with blkfront_remove()
Date:   Thu,  8 Nov 2018 17:10:43 -0800
Message-Id: <1541725843-2019-1-git-send-email-manjunath.b.patil@oracle.com>
X-Mailer: git-send-email 1.7.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9071 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=916
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811090009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we try to detach the device, blkfront_remove() tries to access
blkfront_info leading to kernel panic.

Typical call stack involving panic -
 #10 page_fault at ffffffff816f25df
     [exception RIP: blkif_free+46]
 #11 blkfront_remove at ffffffffa004de47 [xen_blkfront]
 #12 xenbus_dev_remove at ffffffff813faa4c
 #13 __device_release_driver at ffffffff814769aa
 #14 device_release_driver at ffffffff81476a63
 #15 bus_remove_device at ffffffff814762eb
 #16 device_del at ffffffff81472684
 #17 device_unregister at ffffffff814727e2
 #18 xenbus_dev_changed at ffffffff813fa89f
 #19 frontend_changed at ffffffff813fca19
 #20 xenwatch_thread at ffffffff813f88f9
 #21 kthread at ffffffff810a486b
 #22 ret_from_fork at ffffffff816ed2a8

Cc: stable@vger.kernel.org
Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
---
v2: style change. added the missing space b/w if and (
---
 drivers/block/xen-blkfront.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index dc8fe25..2d8b10d 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2496,6 +2496,9 @@ static int blkfront_remove(struct xenbus_device *xbdev)
 
 	dev_dbg(&xbdev->dev, "%s removed", xbdev->nodename);
 
+	if (!info)
+		return 0;
+
 	blkif_free(info, 0);
 
 	mutex_lock(&info->mutex);
-- 
1.7.1

