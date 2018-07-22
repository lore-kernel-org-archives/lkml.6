Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE339C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 09:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D1120874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 09:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D1120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeGVKHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 06:07:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50939 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728053AbeGVKHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 06:07:49 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 45C9BD0EB11DE;
        Sun, 22 Jul 2018 17:11:37 +0800 (CST)
Received: from linux-work.huawei.com (10.67.189.174) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.382.0; Sun, 22 Jul 2018 17:11:28 +0800
From:   nixiaoming <nixiaoming@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nixiaoming@huawei.com>
Subject: [PATCH] Delete invalid assignment statements in do_sendfile
Date:   Sun, 22 Jul 2018 16:37:08 +0800
Message-ID: <20180722083708.46865-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assigning value -EINVAL to "retval" here, but that stored value is
overwritten before it can be used.

retval = -EINVAL;
....
retval = rw_verify_area(WRITE, out.file, &out_pos, count);

value_overwrite: Overwriting previous write to "retval" with value
from rw_verify_area

delete invalid assignment statements

Signed-off-by: n00202754 <nixiaoming@huawei.com>
---
 fs/read_write.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 153f8f6..9ab202c 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1407,7 +1407,6 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		goto fput_in;
 	if (!(out.file->f_mode & FMODE_WRITE))
 		goto fput_out;
-	retval = -EINVAL;
 	in_inode = file_inode(in.file);
 	out_inode = file_inode(out.file);
 	out_pos = out.file->f_pos;
-- 
2.10.1

