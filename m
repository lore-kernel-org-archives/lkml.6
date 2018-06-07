Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cRiYMIIOGVs9CgAAmS7hNA
	; Thu, 07 Jun 2018 10:53:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 849AE608B8; Thu,  7 Jun 2018 10:53:12 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B9I0fe+8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D898060115;
	Thu,  7 Jun 2018 10:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D898060115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeFGKwx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:52:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46802 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752960AbeFGKwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:52:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w57AohXO025529;
        Thu, 7 Jun 2018 10:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=K9BtkV75JM22QTIiHxsHQDSrecEBDRNvGRKz6k6eGek=;
 b=B9I0fe+8wbO3uBRqQj/DiAlX+IabyLfovVExDrcgnD4wm1hygRhPaUYWVFSlZIG2ndcK
 LAWW+dHetbbER8EppFyMWTCxczrIzOwNG1xEpgK4SEuO1q0V3MxTQRZW8i4Yj9mlLBvp
 kFiiC1XgPZ45LH/lfEPiwEG6SWEpGeogQsgfxxp08CGIHl7cok/pIclF62U1X8VpIlqg
 lg3Itbi/y/BNIe5DNDrtSEm9bPKYzdqOn4rcbiYl0GE6VvbDtgGBSJTn0iLN5yowM9Sj
 fmK8Qdlcl8IDsl4wV6BMFiQiuUOFqX7+3IG/YrKYiDO4fxobRS+KVN+8o1UkGLjb+3vx yw==
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jbvyprdpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jun 2018 10:52:25 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w57AqO5k008067
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jun 2018 10:52:24 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w57AqN6w004813;
        Thu, 7 Jun 2018 10:52:23 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jun 2018 03:52:22 -0700
From: Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Hakon Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Wei Wang <wei.w.wang@intel.com>,
        Chris Mi <chrism@mellanox.com>,
        Eric Biggers <ebiggers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] idr: Add ida_simple_get_cyclic
Date: Thu,  7 Jun 2018 12:52:07 +0200
Message-Id: <20180607105208.16332-2-hans.westgaard.ry@oracle.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180607105208.16332-1-hans.westgaard.ry@oracle.com>
References: <20180529073808.27735-1-hans.westgaard.ry@oracle.com>
 <20180607105208.16332-1-hans.westgaard.ry@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8916 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=966
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806070128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orabug: 25571450

Signed-off-by: Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
---
 include/linux/idr.h |  8 +++++--
 lib/idr.c           | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index e856f4e0ab35..f151ce89124a 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -218,10 +218,12 @@ DECLARE_PER_CPU(struct ida_bitmap *, ida_bitmap);
 
 struct ida {
 	struct radix_tree_root	ida_rt;
+	unsigned int		ida_next;
 };
 
-#define IDA_INIT(name)	{						\
-	.ida_rt = RADIX_TREE_INIT(name, IDR_RT_MARKER | GFP_NOWAIT),	\
+#define IDA_INIT(name)	{						     \
+		.ida_rt = RADIX_TREE_INIT(name, IDR_RT_MARKER | GFP_NOWAIT), \
+		.ida_next = 0,						     \
 }
 #define DEFINE_IDA(name)	struct ida name = IDA_INIT(name)
 
@@ -232,6 +234,8 @@ void ida_destroy(struct ida *ida);
 
 int ida_simple_get(struct ida *ida, unsigned int start, unsigned int end,
 		   gfp_t gfp_mask);
+int ida_simple_get_cyclic(struct ida *ida, unsigned int start, unsigned int end,
+			  gfp_t gfp_mask);
 void ida_simple_remove(struct ida *ida, unsigned int id);
 
 static inline void ida_init(struct ida *ida)
diff --git a/lib/idr.c b/lib/idr.c
index 823b813f08f8..3374c3fa4027 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -599,6 +599,72 @@ int ida_simple_get(struct ida *ida, unsigned int start, unsigned int end,
 	return ret;
 }
 EXPORT_SYMBOL(ida_simple_get);
+/**
+ * ida_simple_get_cyclic - get a new id.
+ * @ida: the (initialized) ida.
+ * @start: the minimum id (inclusive, < 0x8000000)
+ * @end: the maximum id (exclusive, < 0x8000000 or 0)
+ * @gfp_mask: memory allocation flags
+ *
+ * Allocates an id in the range start <= id < end, or returns -ENOSPC.
+ * On memory allocation failure, returns -ENOMEM.
+ * The search for an unused id will start at the last id allocated and will
+ * wrap around to @start if no free ids are found before reaching @end.
+ *
+ * Compared to ida_get_new_above() this function does its own locking, and
+ * should be used unless there are special requirements.
+ *
+ * Use ida_simple_remove() to get rid of an id.
+ */
+int ida_simple_get_cyclic(struct ida *ida, unsigned int start, unsigned int end,
+		   gfp_t gfp_mask)
+{
+	int ret, id, next;
+	unsigned int max;
+	unsigned long flags;
+
+	WARN_ON((int)start < 0);
+	WARN_ON((int)end < 0);
+
+	if (end == 0) {
+		max = 0x80000000;
+	} else {
+		WARN_ON(end < start);
+		max = end - 1;
+	}
+
+again:
+	if (!ida_pre_get(ida, gfp_mask))
+		return -ENOMEM;
+
+	spin_lock_irqsave(&simple_ida_lock, flags);
+	next = ida->ida_next;
+	if (next < start || next >= end)
+		next = start;
+
+	ret = ida_get_new_above(ida, next, &id);
+	if (likely(!ret)) {
+		if (unlikely(id >= max)) {
+			ida_remove(ida, id);
+			if (next == start) {
+				ret = -ENOSPC;
+			} else {
+				ida->ida_next = start;
+				spin_unlock_irqrestore(&simple_ida_lock, flags);
+				goto again;
+			}
+		} else {
+			ida->ida_next = id + 1;
+			ret = id;
+		}
+	}
+	spin_unlock_irqrestore(&simple_ida_lock, flags);
+
+	if (unlikely(ret == -EAGAIN))
+		goto again;
+	return ret;
+}
+EXPORT_SYMBOL(ida_simple_get_cyclic);
 
 /**
  * ida_simple_remove - remove an allocated id.
-- 
2.14.3
