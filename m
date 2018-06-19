Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA8EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4EC20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rFZwbdLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4EC20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937335AbeFSG7a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:59:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48650 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935908AbeFSG73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:59:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5J6wvrk188768;
        Tue, 19 Jun 2018 06:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2017-10-26;
 bh=PfFA2rBNJvD28yGuA5Ef0100Jii92KvUUKnoSUrwqYY=;
 b=rFZwbdLQzur42jRHL6EB1ZSevMJR2vVHjxirWiJSyEi+fjO4KUpVmJj85qDF5iFSsux4
 PaHLsbl801NfmJpdWtNUELBfLEWcksqR4aitLwXEhuGmtkJUJrCcifo6IM13V7d0/fg6
 e/ns8lgHzCBLn6KbRBnM9T4j4VYAgdv/UenFBc/FY6WUbauUmAVgficPQYpXib0nONsv
 EYAklJ2dWf76k64ZcZKj0X11XElhEJVpLEfx3wgQ4KoSNOrtgYkTOBgmTcwdArUndFrR
 f5o7Q2ii30jgxch09hYu4h24PhZmtdFUBSPT0AVQzWw9/OhKd0+++dnoVyoBX5Cf7JHg rQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2jmt01etye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 06:59:27 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5J6xQoI019407
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 06:59:26 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5J6xQm8003770;
        Tue, 19 Jun 2018 06:59:26 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jun 2018 23:59:26 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: use mutex_trylock to avoid lock inversion
Date:   Tue, 19 Jun 2018 15:00:37 +0800
Message-Id: <1529391637-1704-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=944
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the kobject_del for kobjs of mq, hctx and ctx is invoked
under sysfs_lock, lock inversion will come up when other one is
acessing the associated sysfs file and trying to acquire the
sysfs_lock. To fix it, use mutex_trylock in blk_mq_sysfs_ops and
blk_mq_hw_sysfs_ops, if the lock in on contending, return -EAGAIN.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-sysfs.c | 52 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index aafb442..210804f 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -53,11 +53,14 @@ static ssize_t blk_mq_sysfs_show(struct kobject *kobj, struct attribute *attr,
 	if (!entry->show)
 		return -EIO;
 
-	res = -ENOENT;
-	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
-		res = entry->show(ctx, page);
-	mutex_unlock(&q->sysfs_lock);
+	res = -EAGAIN;
+	if (mutex_trylock(&q->sysfs_lock)) {
+		if (!blk_queue_dying(q))
+			res = entry->show(ctx, page);
+		else
+			res = -ENOENT;
+		mutex_unlock(&q->sysfs_lock);
+	}
 	return res;
 }
 
@@ -76,11 +79,14 @@ static ssize_t blk_mq_sysfs_store(struct kobject *kobj, struct attribute *attr,
 	if (!entry->store)
 		return -EIO;
 
-	res = -ENOENT;
-	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
-		res = entry->store(ctx, page, length);
-	mutex_unlock(&q->sysfs_lock);
+	res = -EAGAIN;
+	if (mutex_trylock(&q->sysfs_lock)) {
+		if (!blk_queue_dying(q))
+			res = entry->store(ctx, page, length);
+		else
+			res = -ENOENT;
+		mutex_unlock(&q->sysfs_lock);
+	}
 	return res;
 }
 
@@ -99,11 +105,14 @@ static ssize_t blk_mq_hw_sysfs_show(struct kobject *kobj,
 	if (!entry->show)
 		return -EIO;
 
-	res = -ENOENT;
-	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
-		res = entry->show(hctx, page);
-	mutex_unlock(&q->sysfs_lock);
+	res = -EAGAIN;
+	if (mutex_trylock(&q->sysfs_lock)) {
+		if (!blk_queue_dying(q))
+			res = entry->show(hctx, page);
+		else
+			res = -ENOENT;
+		mutex_unlock(&q->sysfs_lock);
+	}
 	return res;
 }
 
@@ -123,11 +132,14 @@ static ssize_t blk_mq_hw_sysfs_store(struct kobject *kobj,
 	if (!entry->store)
 		return -EIO;
 
-	res = -ENOENT;
-	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
-		res = entry->store(hctx, page, length);
-	mutex_unlock(&q->sysfs_lock);
+	res = -EAGAIN;
+	if (mutex_trylock(&q->sysfs_lock)) {
+		if (!blk_queue_dying(q))
+			res = entry->store(hctx, page, length);
+		else
+			res = -ENOENT;
+		mutex_unlock(&q->sysfs_lock);
+	}
 	return res;
 }
 
-- 
2.7.4

