Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CB0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B512083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfBUQhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:37:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfBUQhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:37:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95A6B811D3;
        Thu, 21 Feb 2019 16:37:31 +0000 (UTC)
Received: from laptop.jcline.org (ovpn-124-228.rdu2.redhat.com [10.10.124.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67A4227C4B;
        Thu, 21 Feb 2019 16:37:31 +0000 (UTC)
Received: from laptop.jcline.org.com (localhost [IPv6:::1])
        by laptop.jcline.org (Postfix) with ESMTP id 86B437045B3B;
        Thu, 21 Feb 2019 11:37:30 -0500 (EST)
From:   Jeremy Cline <jcline@redhat.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>,
        David Both <dboth@millennium-technology.com>
Subject: [PATCH] proc: update i_atime when reading files
Date:   Thu, 21 Feb 2019 11:37:14 -0500
Message-Id: <20190221163714.22330-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 21 Feb 2019 16:37:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to commit 1da4d377f943 ("proc: revalidate misc dentries"), the
access, modify, and change times of files in /proc were just the current
time. Now the mtime and ctime values change mostly as a user would
expect, but the atime isn't updated when the file read. This patch
updates the access time of /proc files when they are read.

Reported-by: David Both <dboth@millennium-technology.com>
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 fs/proc/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index da649ccd6804..34d8603b9aa1 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -221,12 +221,17 @@ static loff_t proc_reg_llseek(struct file *file, loff_t offset, int whence)
 static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	ssize_t (*read)(struct file *, char __user *, size_t, loff_t *);
-	struct proc_dir_entry *pde = PDE(file_inode(file));
+	struct inode *inode = file_inode(file);
+	struct proc_dir_entry *pde = PDE(inode);
 	ssize_t rv = -EIO;
 	if (use_pde(pde)) {
 		read = pde->proc_fops->read;
-		if (read)
+		if (read) {
 			rv = read(file, buf, count, ppos);
+			if (rv >= 0)
+				inode->i_atime = current_time(inode);
+		}
+
 		unuse_pde(pde);
 	}
 	return rv;
-- 
2.20.1

