Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11775C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2E12146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VpdkMv1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfBTUTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:19:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36708 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfBTUTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:19:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8c9Z087605;
        Wed, 20 Feb 2019 20:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=77QyT0phQkeZUA6ZmD10vXuqjVPqFaqksd3QgbzVgcE=;
 b=VpdkMv1bV3DD6gUFdqPFCR+s/5qiMvSTU6egNXo5eskWdCjlpH7Pc3p1u9v9BTn4Dvyj
 GS3WMCVZfIa/AgRBQWC/eBtNEbZEQsbwEY60yBa+KGQNpxBFKfyIBRdNqZA5jjtL0nOK
 +zo5l0AEagcNHPQ/Y5JCWMJpoal74XhAZTmo3MggSrSMajzZiwKmTBBhcltMWkWtn6/U
 Yfpojqn8WBblNy/veaQq/QflH0sVXLDoKD+rST7fLIXTTsJwPpjvGb78CQ3ZFi1qSlBk
 iubArrqmcyp4l55QLarPbme+MgDFypFru3cnoBO7mMwa454c6EEJXDuTx3VBSsOoWiDk kw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qpb5rktsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:59 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHwrh022956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:58 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHvwI012065;
        Wed, 20 Feb 2019 20:17:57 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:57 -0800
From:   Joao Martins <joao.m.martins@oracle.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Subject: [PATCH RFC 20/39] xen-blkback: module_exit support
Date:   Wed, 20 Feb 2019 20:15:50 +0000
Message-Id: <20190220201609.28290-21-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement module_exit to allow users to do module unload of blkback.
We prevent users from module unload whenever there are still interfaces
allocated, in other words, do module_get on xen_blkif_alloc() and
module_put on xen_blkif_free().

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/block/xen-blkback/blkback.c |  8 ++++++++
 drivers/block/xen-blkback/common.h  |  2 ++
 drivers/block/xen-blkback/xenbus.c  | 14 ++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index fd1e19f1a49f..d51d88be88e1 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1504,5 +1504,13 @@ static int __init xen_blkif_init(void)
 
 module_init(xen_blkif_init);
 
+static void __exit xen_blkif_exit(void)
+{
+	xen_blkif_interface_exit();
+	xen_blkif_xenbus_exit();
+}
+
+module_exit(xen_blkif_exit);
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("xen-backend:vbd");
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 1d3002d773f7..3415c558e115 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -376,8 +376,10 @@ struct phys_req {
 	blkif_sector_t		sector_number;
 };
 int xen_blkif_interface_init(void);
+void xen_blkif_interface_exit(void);
 
 int xen_blkif_xenbus_init(void);
+void xen_blkif_xenbus_exit(void);
 
 irqreturn_t xen_blkif_be_int(int irq, void *dev_id);
 int xen_blkif_schedule(void *arg);
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index a4bc74e72c39..424e2efebe85 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -181,6 +181,8 @@ static struct xen_blkif *xen_blkif_alloc(domid_t domid)
 	init_completion(&blkif->drain_complete);
 	INIT_WORK(&blkif->free_work, xen_blkif_deferred_free);
 
+	__module_get(THIS_MODULE);
+
 	return blkif;
 }
 
@@ -328,6 +330,8 @@ static void xen_blkif_free(struct xen_blkif *blkif)
 
 	/* Make sure everything is drained before shutting down */
 	kmem_cache_free(xen_blkif_cachep, blkif);
+
+	module_put(THIS_MODULE);
 }
 
 int __init xen_blkif_interface_init(void)
@@ -341,6 +345,11 @@ int __init xen_blkif_interface_init(void)
 	return 0;
 }
 
+void xen_blkif_interface_exit(void)
+{
+	kmem_cache_destroy(xen_blkif_cachep);
+}
+
 /*
  *  sysfs interface for VBD I/O requests
  */
@@ -1115,3 +1124,8 @@ int xen_blkif_xenbus_init(void)
 {
 	return xenbus_register_backend(&xen_blkbk_driver);
 }
+
+void xen_blkif_xenbus_exit(void)
+{
+	xenbus_unregister_driver(&xen_blkbk_driver);
+}
-- 
2.11.0

