Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ED4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227BE206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227BE206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeK2M40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:56:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15611 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727022AbeK2M4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:56:25 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 87A158D1EBA91;
        Thu, 29 Nov 2018 09:52:44 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Thu, 29 Nov 2018 09:52:35 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
CC:     YueHaibing <yuehaibing@huawei.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ocfs2: Use kmemdup rather than duplicating its implementation
Date:   Thu, 29 Nov 2018 02:01:14 +0000
Message-ID: <1543456874-137698-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kmemdup rather than duplicating its implementation

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/ocfs2/localalloc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index 308f05b..3572204 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -433,12 +433,11 @@ void ocfs2_shutdown_local_alloc(struct ocfs2_super *osb)
 	bh = osb->local_alloc_bh;
 	alloc = (struct ocfs2_dinode *) bh->b_data;
 
-	alloc_copy = kmalloc(bh->b_size, GFP_NOFS);
+	alloc_copy = kmemdup(alloc, bh->b_size, GFP_NOFS);
 	if (!alloc_copy) {
 		status = -ENOMEM;
 		goto out_commit;
 	}
-	memcpy(alloc_copy, alloc, bh->b_size);
 
 	status = ocfs2_journal_access_di(handle, INODE_CACHE(local_alloc_inode),
 					 bh, OCFS2_JOURNAL_ACCESS_WRITE);
@@ -1281,13 +1280,12 @@ static int ocfs2_local_alloc_slide_window(struct ocfs2_super *osb,
 	 * local alloc shutdown won't try to double free main bitmap
 	 * bits. Make a copy so the sync function knows which bits to
 	 * free. */
-	alloc_copy = kmalloc(osb->local_alloc_bh->b_size, GFP_NOFS);
+	alloc_copy = kmemdup(alloc, osb->local_alloc_bh->b_size, GFP_NOFS);
 	if (!alloc_copy) {
 		status = -ENOMEM;
 		mlog_errno(status);
 		goto bail;
 	}
-	memcpy(alloc_copy, alloc, osb->local_alloc_bh->b_size);
 
 	status = ocfs2_journal_access_di(handle,
 					 INODE_CACHE(local_alloc_inode),





