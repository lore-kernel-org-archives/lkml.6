Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8169CC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA1C20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1UQE8StH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA1C20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeINMrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:47:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33664 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeINMrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:47:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8E7Snnq121834;
        Fri, 14 Sep 2018 07:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=xD9RNf55VjXYotdtUrrcvp7g4O4DR4H4y52f6YyPCkY=;
 b=1UQE8StHBuMKOw+O00/73pSQVVuktlmKPigcsvtrDwcsSZr5eabEgFirV5OgTLeeeBcr
 ifyzE1QojF1zCHq9r16Vvz6RlROuoppoltP86gtXUWYcUygq7DRsAQWc/dtLivPOaMvP
 8RPGbGhyiEA9OfEZdk55rZxFwpTTyrEgeo6WXF5QraxrutcW3R9+czXyw75f2RW+wyzl
 iMxrlxzjZmDKNxcM5KaODGT26rC5rkB4LHpzw45GMxBwduQzztt9IIBtDXGDZAKSid37
 uW4UIOVEajeWdE5ttKuaHgrJNLiISu/+0zHcLXAn4ja1uaDiW/mblfxAC/n4UIMt0oDK Bw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2mc6cq5dk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 07:33:59 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8E7XxIt005137
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 07:33:59 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8E7Xwif023930;
        Fri, 14 Sep 2018 07:33:58 GMT
Received: from linux.cn.oracle.com (/10.182.70.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 07:33:58 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        paul.durrant@citrix.com, wei.liu2@citrix.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com,
        srinivas.eeda@oracle.com
Subject: [PATCH 4/6] xenbus: process otherend_watch event at 'state' entry in xenwatch multithreading
Date:   Fri, 14 Sep 2018 15:34:14 +0800
Message-Id: <1536910456-13337-5-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9015 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 4th patch of a (6-patch) patch set.

With this patch, watch event in absolute path pattern
'/local/domain/<domid>/device/<pvdev>/<handle>/state' can be processed in
per-domU xenwatch thread.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/xen/xenbus/xenbus_probe.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 5755596..ba0644c 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -129,11 +129,27 @@ static int talk_to_otherend(struct xenbus_device *dev)
 }
 
 
+static domid_t otherend_get_domid(struct xenbus_watch *watch,
+				  const char *path,
+				  const char *token)
+{
+	struct xenbus_device *xendev =
+		container_of(watch, struct xenbus_device, otherend_watch);
+
+	return xendev->otherend_id;
+}
+
 
 static int watch_otherend(struct xenbus_device *dev)
 {
 	struct xen_bus_type *bus =
 		container_of(dev->dev.bus, struct xen_bus_type, bus);
+	struct xenbus_driver *drv = to_xenbus_driver(dev->dev.driver);
+
+	if (xen_mtwatch && drv->use_mtwatch) {
+		dev->otherend_watch.get_domid = otherend_get_domid;
+		dev->otherend_watch.owner_id = dev->otherend_id;
+	}
 
 	return xenbus_watch_pathfmt(dev, &dev->otherend_watch,
 				    bus->otherend_changed,
-- 
2.7.4

