Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D76C7112B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BF320645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tom.com header.i=@tom.com header.b="DNTtvV+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BF320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeJNXr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:47:29 -0400
Received: from smtprz15.163.net ([106.3.154.248]:45279 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbeJNXr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:47:27 -0400
Received: from antispam2.tom.com (unknown [172.25.16.56])
        by freemail02.tom.com (Postfix) with ESMTP id 7BFCEB00D3C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 00:05:46 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1539533146; bh=4Pj7Hr203yGWV6hXF0/bNbg461f2EZsl05lpOZlUfJ0=;
        h=From:To:Cc:Subject:Date:From;
        b=DNTtvV+hVVRXbWIqb2tY7tum5bF2gwY3AINOCKMrRAqo0uwiNTttyJLl9mcl1HdAE
         gxlok7b6u5cPQvzpdHdn5cQocVRI2YYSEWBq3jIDn6V0voUYJ8NAWEZlbXBDKQNpoJ
         7dslHT6qRtW9Zib0v3IH1KL2pumLfb9ODxY/dTXo=
Received: from antispam2.tom.com (antispam2.tom.com [127.0.0.1])
        by antispam2.tom.com (Postfix) with ESMTP id 7A14C813DD
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 00:05:46 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam2.tom.com
Received: from antispam2.tom.com ([127.0.0.1])
        by antispam2.tom.com (antispam2.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jeOh4ymrsVP3 for <linux-kernel@vger.kernel.org>;
        Mon, 15 Oct 2018 00:05:45 +0800 (CST)
Received: from localhost.localdomain (unknown [110.184.205.211])
        by antispam2.tom.com (Postfix) with ESMTPA id 4BB0581341;
        Mon, 15 Oct 2018 00:05:45 +0800 (CST)
From:   liusong@tom.com
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     liu.song11@zte.com.cn, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: direct return when jinode allocate failed in ext4_inode_attach_jinode
Date:   Mon, 15 Oct 2018 00:05:22 +0800
Message-Id: <20181014160522.3395-1-liusong@tom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liu.song11@zte.com.cn>

Allocating memory for jinode do not need protected by *i_lock*.
Should return directly if memory allocation fails without holding
a spinlock.

Signed-off-by: Liu Song <liu.song11@zte.com.cn>
---
 fs/ext4/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d0dd585add6a..341d84521d11 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4382,12 +4382,11 @@ int ext4_inode_attach_jinode(struct inode *inode)
 		return 0;
 
 	jinode = jbd2_alloc_inode(GFP_KERNEL);
+	if (!jinode)
+		return -ENOMEM;
+
 	spin_lock(&inode->i_lock);
 	if (!ei->jinode) {
-		if (!jinode) {
-			spin_unlock(&inode->i_lock);
-			return -ENOMEM;
-		}
 		ei->jinode = jinode;
 		jbd2_journal_init_jbd_inode(ei->jinode, inode);
 		jinode = NULL;
-- 
2.17.1

