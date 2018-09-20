Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6078CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6C22152F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VWI8JahK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6C22152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbeITP7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:59:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39728 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730654AbeITP7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:59:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8KAF83N102169;
        Thu, 20 Sep 2018 10:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=WdQMwdwP5PFLQVcMIQw7SAoiypQcZmo6xCJvd0x/t84=;
 b=VWI8JahKe1e4RbVNE16/jvXl27wIpScuUv91fj2SX+yEedyuLFs1HtTqCKv0+JTAgkcM
 fIbRYLT2BaTtlfRvVZUUGuUkzeDCM2BXH3FaxjCt2t6uqk18HrDEguj3JSKXUGKYqf5S
 O7mqAC/V2kmmTYnAGHL02o4pKpn6dr8XiKasWzpXu51Bgz+AjTZTaTqrRNOa1JQGlSvC
 K6V6Z5F4AJViUzgZWN6LlLKAkIYh27ucNQYattlpxaD9KVzbwRkpkUynX0qVPGqBiqRE
 0JH5g4n5DXWlJN/dmoFoh1w0VVON+8mM696QQtmFjyW3f+g9zIoyZVjPyH/bpZEinY7e /g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mgsgu1udk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Sep 2018 10:16:32 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8KAGVRc017125
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Sep 2018 10:16:31 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8KAGUDR001252;
        Thu, 20 Sep 2018 10:16:30 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Sep 2018 03:16:30 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, tj@kernel.org, kent.overstreet@gmail.com,
        ming.lei@redhat.com, bart.vanassche@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] percpu_ref: add a new helper interface __percpu_ref_get_many
Date:   Thu, 20 Sep 2018 18:18:21 +0800
Message-Id: <1537438703-25217-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9021 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809200105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This __percpu_ref_get_many is almost same with the percpu_ref_get_many,
except for the caller need to provide a sched rcu critical section
for it. We want to do some other condition checking under the sched
rcu lock. With this interface, one extra rcu_read_lock/unlock_sched
could be saved.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 include/linux/percpu-refcount.h | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 009cdf3..b86e03b 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -169,21 +169,32 @@ static inline bool __ref_is_percpu(struct percpu_ref *ref,
  * @ref: percpu_ref to get
  * @nr: number of references to get
  *
- * Analogous to atomic_long_add().
- *
- * This function is safe to call as long as @ref is between init and exit.
+ * This function is same with percpu_ref_get_many except for the caller need to
+ * provide a sched rcu critical section for it.
  */
-static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
+static inline void __percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
 {
 	unsigned long __percpu *percpu_count;
 
-	rcu_read_lock_sched();
-
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_add(*percpu_count, nr);
 	else
 		atomic_long_add(nr, &ref->count);
+}
 
+/**
+ * percpu_ref_get_many - increment a percpu refcount
+ * @ref: percpu_ref to get
+ * @nr: number of references to get
+ *
+ * Analogous to atomic_long_add().
+ *
+ * This function is safe to call as long as @ref is between init and exit.
+ */
+static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
+{
+	rcu_read_lock_sched();
+	__percpu_ref_get_many(ref, nr);
 	rcu_read_unlock_sched();
 }
 
-- 
2.7.4

