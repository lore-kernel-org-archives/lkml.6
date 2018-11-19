Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31F0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 03:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F192086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 03:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F192086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeKSN4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 08:56:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726995AbeKSN4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 08:56:44 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 143D19AB8F24A;
        Mon, 19 Nov 2018 11:34:27 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Mon, 19 Nov 2018
 11:34:19 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mszeredi@redhat.com>, <amir73il@gmail.com>, <neilb@suse.com>,
        <bfields@redhat.com>, <viro@zeniv.linux.org.uk>
CC:     <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <matt.helsley@gmail.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] exportfs: fix 'passing zero to ERR_PTR()' warning
Date:   Mon, 19 Nov 2018 11:32:41 +0800
Message-ID: <20181119033241.20264-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a static code checker warning:
  fs/exportfs/expfs.c:171 reconnect_one() warn: passing zero to 'ERR_PTR'

The error path for lookup_one_len_unlocked failure
should set err to PTR_ERR.

Fixes: bbf7a8a3562f ("exportfs: move most of reconnect_path to helper function")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/exportfs/expfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 645158d..c8a3dfd 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -147,6 +147,7 @@ static struct dentry *reconnect_one(struct vfsmount *mnt,
 	tmp = lookup_one_len_unlocked(nbuf, parent, strlen(nbuf));
 	if (IS_ERR(tmp)) {
 		dprintk("%s: lookup failed: %d\n", __func__, PTR_ERR(tmp));
+		err = PTR_ERR(tmp);
 		goto out_err;
 	}
 	if (tmp != dentry) {
-- 
2.7.0


