Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ED8ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E3C214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E3C214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbeISRFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:05:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36763 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730967AbeISRFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:05:01 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 589F08047A163;
        Wed, 19 Sep 2018 19:27:30 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 19:27:25 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <akpm@linux-foundation.org>, <dbueso@suse.de>,
        <manfred@colorfullife.com>, <ebiederm@xmission.com>,
        <viro@zeniv.linux.org.uk>, <linux@dominikbrodowski.net>,
        <ebiggers@google.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ipc/shm: Use ERR_CAST to return error code
Date:   Wed, 19 Sep 2018 19:25:47 +0800
Message-ID: <20180919112547.28528-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc warning:
ipc/shm.c: In function 'shm_lock'
ipc/shm.c:210:2: note: randstruct: casting between randomized structure pointer types (ssa): 'struct shmid_kernel' and 'struct kern_ipc_perm'

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 ipc/shm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 4cd402e..1c65fb3 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -206,7 +206,7 @@ static inline struct shmid_kernel *shm_lock(struct ipc_namespace *ns, int id)
 	 * Callers of shm_lock() must validate the status of the returned ipc
 	 * object pointer and error out as appropriate.
 	 */
-	return (void *)ipcp;
+	return ERR_CAST(ipcp);
 }
 
 static inline void shm_lock_by_ptr(struct shmid_kernel *ipcp)
-- 
1.8.3.1


