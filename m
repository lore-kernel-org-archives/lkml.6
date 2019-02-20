Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9CAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6ECA2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RyJv7v5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfBTUTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:19:23 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34694 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfBTUTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:19:21 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8e4C087617;
        Wed, 20 Feb 2019 20:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=vahAq3kKddmSkfjcBh53XGqFljJf1oYQypzdVmOyw0Y=;
 b=RyJv7v5K27ef8U03dFrDBbsDxmmO4aIGNBOtI81x2cmx/7TVwwNKoBlZd5brgZA4MTLO
 m17CZsghn/1QSkk+la1M9cfqqGmLGGpo720hasLol/xOPGIFe9inMW28EwUHD/4ppYVk
 NNq67Usy+Gff+2eC/GMNXir30+4EO+ycoRKAZ79gidUi0Ki+ZqzQwqx/qR1fRInSiOAC
 dQN11OuM585EIR+JDDh2WWkVDeqc5zEsV5thOjgpvCDR99ogNQi5TRS0aSaWITeO+ILF
 QkJplgMyVc1q0fPDEKHkAvvxt0p6Y04IstT2mZbtrGm1F7qkmO4AD0ZX0hSc7uZCirBA uw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qp81ec3fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:50 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIidk020563
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:44 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KKIhYb015978;
        Wed, 20 Feb 2019 20:18:43 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:43 -0800
From:   Joao Martins <joao.m.martins@oracle.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH RFC 34/39] xen/gntdev: xen_shim_domain() support
Date:   Wed, 20 Feb 2019 20:16:04 +0000
Message-Id: <20190220201609.28290-35-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=758 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ankur Arora <ankur.a.arora@oracle.com>

GNTTABOP_map_grant_ref treats host_addr as an OUT parameter for
xen_shim_domaim().

Accordingly it's updated in struct gnttab_unmap_grant_ref before it gets
used via GNTTABOP_unmap_grant_ref.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/xen/gntdev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 5efc5eee9544..8540a51f7597 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -351,6 +351,8 @@ int gntdev_map_grant_pages(struct gntdev_grant_map *map)
 		}
 
 		map->unmap_ops[i].handle = map->map_ops[i].handle;
+		if (xen_shim_domain())
+			map->unmap_ops[i].host_addr = map->map_ops[i].host_addr;
 		if (use_ptemod)
 			map->kunmap_ops[i].handle = map->kmap_ops[i].handle;
 #ifdef CONFIG_XEN_GRANT_DMA_ALLOC
@@ -1122,7 +1124,9 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 				(map->flags & GNTMAP_readonly))
 			goto out_unlock_put;
 	} else {
-		map->flags = GNTMAP_host_map;
+		map->flags = 0;
+		if (!xen_shim_domain())
+			map->flags = GNTMAP_host_map;
 		if (!(vma->vm_flags & VM_WRITE))
 			map->flags |= GNTMAP_readonly;
 	}
@@ -1207,7 +1211,7 @@ static int __init gntdev_init(void)
 {
 	int err;
 
-	if (!xen_domain())
+	if (!xen_domain() && !xen_shim_domain_get())
 		return -ENODEV;
 
 	use_ptemod = !xen_feature(XENFEAT_auto_translated_physmap);
@@ -1215,6 +1219,7 @@ static int __init gntdev_init(void)
 	err = misc_register(&gntdev_miscdev);
 	if (err != 0) {
 		pr_err("Could not register gntdev device\n");
+		xen_shim_domain_put();
 		return err;
 	}
 	return 0;
@@ -1223,6 +1228,7 @@ static int __init gntdev_init(void)
 static void __exit gntdev_exit(void)
 {
 	misc_deregister(&gntdev_miscdev);
+	xen_shim_domain_put();
 }
 
 module_init(gntdev_init);
-- 
2.11.0

