Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA7FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7669D214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5GdOQTHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbeLRIUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:20:43 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49908 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRIUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:20:42 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBI8J21T049407;
        Tue, 18 Dec 2018 08:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=ggHsS4nn74FSCoDyln7CGsjbLT8GHtz/WLVR3Xa6oAg=;
 b=5GdOQTHM/Zpfp7m9shaGW5M07OaQIOMfWzn6XhcDuldF5ehh/GkeO2tQo3ymyW5K7NVE
 wZlxMi0A08oREmalUQEV/QGxZb/3Vr0RDNUOqE8MYOMtKM+HVqmzsUvl28CJLIA8gB2U
 Y6bbXkhG/4Ndcsyxcz2WbOEY4wKo33a76rlX5O3oa3fB0SDMKsBho9fFUm0XX+Ab75qw
 bp2wzg3ao3ibO2pGv+7xYx++LpvQozeruKeMA3ZQ1Vi85YDRmUH2K0jpGTOZDLnEJb2y
 DhrLgo1h/ZsFKCPvq5jBRo1gs9+cACZREu5Ra9zM9zz/1T3xU9/cuYfVAjv8TClA4hMU 2A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2pcq4dsvp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 08:20:05 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBI8K4Wg028236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 08:20:04 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBI8K2aP024445;
        Tue, 18 Dec 2018 08:20:03 GMT
Received: from kadam (/197.157.0.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Dec 2018 00:20:02 -0800
Date:   Tue, 18 Dec 2018 11:20:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Timur Tabi <timur@freescale.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Mihai Caraman <mihai.caraman@freescale.com>,
        Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/2] fsl_hypervisor: dereferencing error pointers in ioctl
Message-ID: <20181218082003.GD32567@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9110 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strndup_user() function returns error pointers on error, and then
in the error handling we pass the error pointers to kfree().  It will
cause an Oops.

Fixes: 6db7199407ca ("drivers/virt: introduce Freescale hypervisor management driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/virt/fsl_hypervisor.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index 8ba726e600e9..7b7f8e9a2801 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -331,8 +331,8 @@ static long ioctl_dtprop(struct fsl_hv_ioctl_prop __user *p, int set)
 	struct fsl_hv_ioctl_prop param;
 	char __user *upath, *upropname;
 	void __user *upropval;
-	char *path = NULL, *propname = NULL;
-	void *propval = NULL;
+	char *path, *propname;
+	void *propval;
 	int ret = 0;
 
 	/* Get the parameters from the user. */
@@ -344,32 +344,30 @@ static long ioctl_dtprop(struct fsl_hv_ioctl_prop __user *p, int set)
 	upropval = (void __user *)(uintptr_t)param.propval;
 
 	path = strndup_user(upath, FH_DTPROP_MAX_PATHLEN);
-	if (IS_ERR(path)) {
-		ret = PTR_ERR(path);
-		goto out;
-	}
+	if (IS_ERR(path))
+		return PTR_ERR(path);
 
 	propname = strndup_user(upropname, FH_DTPROP_MAX_PATHLEN);
 	if (IS_ERR(propname)) {
 		ret = PTR_ERR(propname);
-		goto out;
+		goto err_free_path;
 	}
 
 	if (param.proplen > FH_DTPROP_MAX_PROPLEN) {
 		ret = -EINVAL;
-		goto out;
+		goto err_free_propname;
 	}
 
 	propval = kmalloc(param.proplen, GFP_KERNEL);
 	if (!propval) {
 		ret = -ENOMEM;
-		goto out;
+		goto err_free_propname;
 	}
 
 	if (set) {
 		if (copy_from_user(propval, upropval, param.proplen)) {
 			ret = -EFAULT;
-			goto out;
+			goto err_free_propval;
 		}
 
 		param.ret = fh_partition_set_dtprop(param.handle,
@@ -388,7 +386,7 @@ static long ioctl_dtprop(struct fsl_hv_ioctl_prop __user *p, int set)
 			if (copy_to_user(upropval, propval, param.proplen) ||
 			    put_user(param.proplen, &p->proplen)) {
 				ret = -EFAULT;
-				goto out;
+				goto err_free_propval;
 			}
 		}
 	}
@@ -396,10 +394,12 @@ static long ioctl_dtprop(struct fsl_hv_ioctl_prop __user *p, int set)
 	if (put_user(param.ret, &p->ret))
 		ret = -EFAULT;
 
-out:
-	kfree(path);
+err_free_propval:
 	kfree(propval);
+err_free_propname:
 	kfree(propname);
+err_free_path:
+	kfree(path);
 
 	return ret;
 }
-- 
2.17.1

