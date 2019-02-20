Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0258BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07D52146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F8H07j44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfBTUUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:20:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54704 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbfBTUUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:20:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK98rL082386;
        Wed, 20 Feb 2019 20:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=jPor7XctkGZCsqvXc242v28Xv2yJ7KWqcRDiRETXPRI=;
 b=F8H07j44UR1tdSp9IX24yuzkWPkmOz7N1HefA6nBH2ZGm0d/i5epC0lBYdUHGt3ufw1F
 CE6uD+ubucHMlnQwjhdTI9MHKcgb0aDCiZW3NG9vS1FE3WFxi6wE8BITz8fjwQU1unbH
 /mFjA/OD2BIyscqlvV1nfjG4Ck28RNljs339RqQUaKcZomkhtl8WthEwf7NZYGjS/0jw
 viANzo+l5MwQKLEZMrQSza7IzGGqPiUn6FEfFkW06HIPzObL3axqkEaPeYmr43zooBBB
 gTJF1PuXjEwAqRpSFuFvN6WiMG6Xp6QUND9uoRzEDo01qD1nDt6NiePgL/ybzle3DnfK rQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qp9xu3xp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:50 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKInTQ008317
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:49 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKInBo012477;
        Wed, 20 Feb 2019 20:18:49 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:48 -0800
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
Subject: [PATCH RFC 36/39] drivers/xen: xen_shim_domain() support
Date:   Wed, 20 Feb 2019 20:16:06 +0000
Message-Id: <20190220201609.28290-37-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=994 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable /dev/xen/{gntdev,evtchn} and /proc/xen/ for xen_shim_domain().

These interfaces will be used by xenstored to initialize its
event channel port and the kva used to communicate with the
xenbus driver.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/xen/evtchn.c           | 4 +++-
 drivers/xen/privcmd.c          | 5 ++++-
 drivers/xen/xenbus/xenbus_xs.c | 2 +-
 drivers/xen/xenfs/super.c      | 7 ++++---
 drivers/xen/xenfs/xensyms.c    | 4 ++++
 5 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index 6d1a5e58968f..367390eb5883 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -708,13 +708,14 @@ static int __init evtchn_init(void)
 {
 	int err;
 
-	if (!xen_domain())
+	if (!xen_domain() && !xen_shim_domain_get())
 		return -ENODEV;
 
 	/* Create '/dev/xen/evtchn'. */
 	err = misc_register(&evtchn_miscdev);
 	if (err != 0) {
 		pr_err("Could not register /dev/xen/evtchn\n");
+		xen_shim_domain_put();
 		return err;
 	}
 
@@ -726,6 +727,7 @@ static int __init evtchn_init(void)
 static void __exit evtchn_cleanup(void)
 {
 	misc_deregister(&evtchn_miscdev);
+	xen_shim_domain_put();
 }
 
 module_init(evtchn_init);
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index b24ddac1604b..a063ad5c8260 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -999,12 +999,13 @@ static int __init privcmd_init(void)
 {
 	int err;
 
-	if (!xen_domain())
+	if (!xen_domain() && !xen_shim_domain_get())
 		return -ENODEV;
 
 	err = misc_register(&privcmd_dev);
 	if (err != 0) {
 		pr_err("Could not register Xen privcmd device\n");
+		xen_shim_domain_put();
 		return err;
 	}
 
@@ -1012,6 +1013,7 @@ static int __init privcmd_init(void)
 	if (err != 0) {
 		pr_err("Could not register Xen hypercall-buf device\n");
 		misc_deregister(&privcmd_dev);
+		xen_shim_domain_put();
 		return err;
 	}
 
@@ -1022,6 +1024,7 @@ static void __exit privcmd_exit(void)
 {
 	misc_deregister(&privcmd_dev);
 	misc_deregister(&xen_privcmdbuf_dev);
+	xen_shim_domain_put();
 }
 
 module_init(privcmd_init);
diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index bd6db3703972..062c0a5fa415 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -735,7 +735,7 @@ static void xs_reset_watches(void)
 {
 	int err;
 
-	if (!xen_hvm_domain() || xen_initial_domain())
+	if (!xen_hvm_domain() || xen_initial_domain() || xen_shim_domain())
 		return;
 
 	if (xen_strict_xenbus_quirk())
diff --git a/drivers/xen/xenfs/super.c b/drivers/xen/xenfs/super.c
index 71ddfb4cf61c..2ef326645880 100644
--- a/drivers/xen/xenfs/super.c
+++ b/drivers/xen/xenfs/super.c
@@ -64,7 +64,8 @@ static int xenfs_fill_super(struct super_block *sb, void *data, int silent)
 	};
 
 	return simple_fill_super(sb, XENFS_SUPER_MAGIC,
-			xen_initial_domain() ? xenfs_init_files : xenfs_files);
+			xen_initial_domain() || xen_shim_domain() ?
+				xenfs_init_files : xenfs_files);
 }
 
 static struct dentry *xenfs_mount(struct file_system_type *fs_type,
@@ -84,7 +85,7 @@ MODULE_ALIAS_FS("xenfs");
 
 static int __init xenfs_init(void)
 {
-	if (xen_domain())
+	if (xen_domain() || xen_shim_domain())
 		return register_filesystem(&xenfs_type);
 
 	return 0;
@@ -92,7 +93,7 @@ static int __init xenfs_init(void)
 
 static void __exit xenfs_exit(void)
 {
-	if (xen_domain())
+	if (xen_domain() || xen_shim_domain())
 		unregister_filesystem(&xenfs_type);
 }
 
diff --git a/drivers/xen/xenfs/xensyms.c b/drivers/xen/xenfs/xensyms.c
index c6c73a33c44d..79bccb53d344 100644
--- a/drivers/xen/xenfs/xensyms.c
+++ b/drivers/xen/xenfs/xensyms.c
@@ -8,6 +8,7 @@
 #include <xen/interface/platform.h>
 #include <asm/xen/hypercall.h>
 #include <xen/xen-ops.h>
+#include <xen/xen.h>
 #include "xenfs.h"
 
 
@@ -114,6 +115,9 @@ static int xensyms_open(struct inode *inode, struct file *file)
 	struct xensyms *xs;
 	int ret;
 
+	if (xen_shim_domain())
+		return -EINVAL;
+
 	ret = seq_open_private(file, &xensyms_seq_ops,
 			       sizeof(struct xensyms));
 	if (ret)
-- 
2.11.0

