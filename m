Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009A4FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF79B20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nitj/2r+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF79B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeINMrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:47:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33834 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeINMrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:47:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8E7SdX0121544;
        Fri, 14 Sep 2018 07:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=MUDPqtifER8okcJayyW0ud/NML7PMRpW9j5Cod2Xej8=;
 b=Nitj/2r+5An3X9eIALOa0h3Dzowy68C9/5BONgYPPrTnq6CEvlDZe8hZ+Desv+QILZZs
 T01PZzIz8+8FSbnAhWuDTaqemciekkX3qTgQ76EDAfEfzlwInF63Pb5FeYhJ5PF8rg5X
 /nreumYsTbP75hIV6TBSnCtx4w/+sl8skJPmnB3AsMjGdp2OcCR+SocgPZAEjE8hLH+f
 rVWp+l/WIOQABcy2S/vkTQ0ANzOm2ImzSz198B8foM0KjQBFLnCYjHK2KkQNy5c+SD1G
 l2Rp+xLAZF0+7tytBPUme0527J4d5jLbA/UdDfIFMx3rtGy5aMFRE8TmhnK4CBK6fvLH bQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mc6cq5dkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 07:34:04 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8E7Y4UH015383
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 07:34:04 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8E7Y4lb010334;
        Fri, 14 Sep 2018 07:34:04 GMT
Received: from linux.cn.oracle.com (/10.182.70.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 07:34:03 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        paul.durrant@citrix.com, wei.liu2@citrix.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com,
        srinivas.eeda@oracle.com
Subject: [PATCH 6/6] drivers: enable xenwatch multithreading for xen-netback and xen-blkback driver
Date:   Fri, 14 Sep 2018 15:34:16 +0800
Message-Id: <1536910456-13337-7-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9015 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=785
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 6th patch of a (6-patch) patch set.

As the 'use_mtwatch' for xen-netback and xen-blkback are set to true,
probing any xenbus devices of those two drivers would create the per-domU
xenwatch thread for the domid the new devices belong to, or increment the
reference count  of existing thread.

Xenwatch multithreading might be enabled for more xen backend pv drivers in
the future.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/block/xen-blkback/xenbus.c | 3 ++-
 drivers/net/xen-netback/xenbus.c   | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index a4bc74e..debbbd0 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -1108,7 +1108,8 @@ static struct xenbus_driver xen_blkbk_driver = {
 	.ids  = xen_blkbk_ids,
 	.probe = xen_blkbk_probe,
 	.remove = xen_blkbk_remove,
-	.otherend_changed = frontend_changed
+	.otherend_changed = frontend_changed,
+	.use_mtwatch = true,
 };
 
 int xen_blkif_xenbus_init(void)
diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index cd51492..63d46a7 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -1203,6 +1203,7 @@ static struct xenbus_driver netback_driver = {
 	.remove = netback_remove,
 	.uevent = netback_uevent,
 	.otherend_changed = frontend_changed,
+	.use_mtwatch = true,
 };
 
 int xenvif_xenbus_init(void)
-- 
2.7.4

