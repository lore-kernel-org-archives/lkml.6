Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76D1C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F99A20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q0uZbiyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F99A20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJaBmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:42:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33172 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeJaBmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:42:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9UGi5U6072601;
        Tue, 30 Oct 2018 16:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=PB85NKJjKMonzJ73It+n0xbsJw1mcSok7DC4lIgeBjY=;
 b=Q0uZbiyRg6agko3o1VXUrhemjQNIVpFJTiBQP2R8YNNv0kENOOYdN+vkBQrKUlyIBSlF
 JU4janxIdkP5dQfPgbIgzqDBSIUZ1Xc1BfYdl00uhs870JJaRxJKG3HLGLt4eiQA8bKL
 /kHXRJ1KS++0Q/AgzteQIqYajSRupQm4Su1nv32qutsrgPUs9fFrf/H+sLBLO20An+Sc
 GsZIqTmyZqICdj+GJZW4cyauox2kqONhu1bXjkFWPyN8hr3n4paoZoDHkCuHhM4OGK0N
 /3QheHYycc5v8abWAsk9sRdym/lpyPQ+GWFX+FaXDNoXG0DzFFnphwtrkIQPhzLRhzeF uA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nducm2anx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 16:48:34 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9UGmXx6026605
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 16:48:33 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9UGmXEv001185;
        Tue, 30 Oct 2018 16:48:33 GMT
Received: from manjunathpatil.us.oracle.com (/10.211.44.52)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Oct 2018 09:48:33 -0700
From:   Manjunath Patil <manjunath.b.patil@oracle.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com
Cc:     axboe@kernel.dk, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2] xen-blkfront: fix kernel panic with negotiate_mq error path
Date:   Tue, 30 Oct 2018 09:49:21 -0700
Message-Id: <1540918161-31283-1-git-send-email-manjunath.b.patil@oracle.com>
X-Mailer: git-send-email 1.7.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9062 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=996
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810300142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

info->nr_rings isn't adjusted in case of ENOMEM error from
negotiate_mq(). This leads to kernel panic in error path.

Typical call stack involving panic -
 #8 page_fault at ffffffff8175936f
    [exception RIP: blkif_free_ring+33]
    RIP: ffffffffa0149491  RSP: ffff8804f7673c08  RFLAGS: 00010292
 ...
 #9 blkif_free at ffffffffa0149aaa [xen_blkfront]
 #10 talk_to_blkback at ffffffffa014c8cd [xen_blkfront]
 #11 blkback_changed at ffffffffa014ea8b [xen_blkfront]
 #12 xenbus_otherend_changed at ffffffff81424670
 #13 backend_changed at ffffffff81426dc3
 #14 xenwatch_thread at ffffffff81422f29
 #15 kthread at ffffffff810abe6a
 #16 ret_from_fork at ffffffff81754078

Cc: stable@vger.kernel.org
Fixes: 7ed8ce1c5fc7 ("xen-blkfront: move negotiate_mq to cover all cases of new VBDs")
Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
---
 drivers/block/xen-blkfront.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 429d201..5d84da2 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1919,6 +1919,7 @@ static int negotiate_mq(struct blkfront_info *info)
 			      GFP_KERNEL);
 	if (!info->rinfo) {
 		xenbus_dev_fatal(info->xbdev, -ENOMEM, "allocating ring_info structure");
+		info->nr_rings = 0;
 		return -ENOMEM;
 	}
 
-- 
1.7.1

