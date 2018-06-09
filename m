Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xg9DFsgvHFvrfwAAmS7hNA
	; Sat, 09 Jun 2018 19:51:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3B985608C1; Sat,  9 Jun 2018 19:51:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9A60B601D3;
	Sat,  9 Jun 2018 19:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A60B601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932611AbeFITvb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 15:51:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753449AbeFITva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 15:51:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 899F0857A7;
        Sat,  9 Jun 2018 19:51:29 +0000 (UTC)
Received: from dhcp-12-107.nay.redhat.com (unknown [10.66.12.107])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4AC52156601;
        Sat,  9 Jun 2018 19:51:27 +0000 (UTC)
From: Chunyu Hu <chuhu@redhat.com>
To: viro@zeniv.linux.org.uk, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] proc: add proc_seq_release
Date: Sun, 10 Jun 2018 03:51:24 +0800
Message-Id: <1528573884-9133-1-git-send-email-chuhu@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sat, 09 Jun 2018 19:51:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sat, 09 Jun 2018 19:51:29 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'chuhu@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak reported some memory leak on reading proc files. After adding
some debug lines, find that proc_seq_fops is using seq_release as
release handler, which won't handle the free of 'private' field of
seq_file, while in fact the open handler proc_seq_open could create
the private data with __seq_open_private when state_size is greater
than zero. So after reading files created with proc_create_seq_private,
such as /proc/timer_list and /proc/vmallocinfo, the private mem of a
seq_file is not freed. Fix it by adding the paired proc_seq_release
as the default release handler of proc_seq_ops instead of seq_release.

Fixes: 44414d82cfe0 ("proc: introduce proc_create_seq_private")
CC: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 fs/proc/generic.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 7b4d971..021acc5 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -564,11 +564,20 @@ static int proc_seq_open(struct inode *inode, struct file *file)
 	return seq_open(file, de->seq_ops);
 }
 
+static int proc_seq_release(struct inode *inode, struct file *file)
+{
+	struct proc_dir_entry *de = PDE(inode);
+
+	if (de->state_size)
+		return seq_release_private(inode, file);
+	return seq_release(inode, file);
+}
+
 static const struct file_operations proc_seq_fops = {
 	.open		= proc_seq_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= seq_release,
+	.release	= proc_seq_release,
 };
 
 struct proc_dir_entry *proc_create_seq_private(const char *name, umode_t mode,
-- 
1.8.3.1
