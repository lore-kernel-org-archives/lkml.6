Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180B6C18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC9F2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC9F2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbeKUAuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:50:04 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbeKUAuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:50:04 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 276697643F042;
        Tue, 20 Nov 2018 22:20:39 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 20 Nov
 2018 22:20:32 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 03/10] staging: erofs: atomic_cond_read_relaxed on ref-locked workgroup
Date:   Tue, 20 Nov 2018 22:34:18 +0800
Message-ID: <20181120143425.43637-4-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181120143425.43637-1-gaoxiang25@huawei.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's better to use atomic_cond_read_relaxed, which is implemented
in hardware instructions to monitor a variable changes currently
for ARM64, instead of open-coded busy waiting.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 89dbd0888e53..eb80ba44d072 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -221,23 +221,29 @@ static inline void erofs_workgroup_unfreeze(
 	preempt_enable();
 }
 
+#if defined(CONFIG_SMP)
+static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
+{
+	return atomic_cond_read_relaxed(&grp->refcount,
+					VAL != EROFS_LOCKED_MAGIC);
+}
+#else
+static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
+{
+	int v = atomic_read(&grp->refcount);
+
+	/* workgroup is never freezed on uniprocessor systems */
+	DBG_BUGON(v == EROFS_LOCKED_MAGIC);
+	return v;
+}
+#endif
+
 static inline bool erofs_workgroup_get(struct erofs_workgroup *grp, int *ocnt)
 {
-	const int locked = (int)EROFS_LOCKED_MAGIC;
 	int o;
 
 repeat:
-	o = atomic_read(&grp->refcount);
-
-	/* spin if it is temporarily locked at the reclaim path */
-	if (unlikely(o == locked)) {
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-		do
-			cpu_relax();
-		while (atomic_read(&grp->refcount) == locked);
-#endif
-		goto repeat;
-	}
+	o = erofs_wait_on_workgroup_freezed(grp);
 
 	if (unlikely(o <= 0))
 		return -1;
-- 
2.14.4

