Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FDCC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D21923ECB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DRjWgbwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D21923ECB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753194AbeGCMZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:25:45 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58690 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeGCMZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:25:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w63CO0An171573;
        Tue, 3 Jul 2018 12:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : sender
 : to : cc : subject : message-id : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=c89r3O+GS/ch3kfvhArJvZQ5okCNdMcr8qSshyfhEfo=;
 b=DRjWgbwQBJEIP6hD92GahdrN42bforcnOf+eAAq+F2Sucwi8zzVcdG/3fLBcsQ5dtOf3
 DuOLNuaWf7EBlAW2J9zEMFJNkQtWjjpm4E/fW5nEXCvs4BSnx2r1WUVj2f3J/tHHu+h2
 TUJsiWmTAraunjXkZbTTykOQrrm30ZuPAprfc5bt3pK1bOCUbsxGNEChGDdpKQmW6b2T
 LJHsSjvoxXrOoA3EPSu6zaHkTWhc8caw4ZqpaZJML9z2jCIowKhRoEadrKWifFoNoo76
 ejWae90QjomP+Av/Qza97s8ClHCdg2SMaqFKQQ15TEN6uX7Ud7cZPiYve8x5QT5IqNng Ew== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jwyccrf09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jul 2018 12:25:41 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w63CPeBj017594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 12:25:41 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w63CPeSR027844;
        Tue, 3 Jul 2018 12:25:40 GMT
Received: from mwanda (/197.157.0.57)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Jul 2018 05:25:39 -0700
Date:   Tue, 3 Jul 2018 15:25:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] gnss: fix potential error pointer dereference
Message-ID: <20180703122531.5mgay63srlurlkvo@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703121143.GP9802@localhost>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=846
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807030143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gnss_allocate_device() function returns a mix of NULL and error
pointers on error.  It should only return one or the other.  Since the
callers both check for NULL, I've modified it to return NULL on error.

Fixes: 2b6a44035143 ("gnss: add GNSS receiver subsystem")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Johan Hovold <johan@kernel.org>
---
v2: Use the correct Fixes tag.

diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index f30ef8338b3a..4291a0dd22aa 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -235,7 +235,7 @@ struct gnss_device *gnss_allocate_device(struct device *parent)
 	id = ida_simple_get(&gnss_minors, 0, GNSS_MINORS, GFP_KERNEL);
 	if (id < 0) {
 		kfree(gdev);
-		return ERR_PTR(id);
+		return NULL;
 	}
 
 	gdev->id = id;
@@ -270,7 +270,7 @@ struct gnss_device *gnss_allocate_device(struct device *parent)
 err_put_device:
 	put_device(dev);
 
-	return ERR_PTR(-ENOMEM);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(gnss_allocate_device);
 
