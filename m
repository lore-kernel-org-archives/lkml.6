Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C14FC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C0D214AE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfAGJxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:53:44 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:8570 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbfAGJxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:53:44 -0500
X-IronPort-AV: E=Sophos;i="5.56,450,1539619200"; 
   d="scan'208";a="51466253"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Jan 2019 17:53:26 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 175374B7EC72;
        Mon,  7 Jan 2019 17:53:22 +0800 (CST)
Received: from ubuntu.g08.fujitsu.local (10.167.225.53) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 7 Jan 2019 17:53:24 +0800
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
To:     <darrick.wong@oracle.com>
CC:     <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suyj.fnst@cn.fujitsu.com>, <suyanjun218@gmail.com>
Subject: [PATCH] xfs: correct statx's result_mask value
Date:   Mon, 7 Jan 2019 04:53:10 -0500
Message-ID: <1546854790-5233-1-git-send-email-suyj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.53]
X-yoursite-MailScanner-ID: 175374B7EC72.AE56C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For statx syscall, xfs return the wrong result_mask.

Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
---
 fs/xfs/xfs_iops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index f48ffd7..3811457 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -521,6 +521,9 @@ xfs_vn_getattr(
 			stat->btime.tv_nsec = ip->i_d.di_crtime.t_nsec;
 		}
 	}
+	
+	/* Only return mask that we care */
+	stat->result_mask &= request_mask;
 
 	if (ip->i_d.di_flags & XFS_DIFLAG_IMMUTABLE)
 		stat->attributes |= STATX_ATTR_IMMUTABLE;
-- 
2.7.4



