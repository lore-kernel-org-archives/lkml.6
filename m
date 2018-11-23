Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5112C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C1A20664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C1A20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409441AbeKWVZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:25:46 -0500
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:13399
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390243AbeKWVZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:25:46 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ANAACP2Pdb/7650XYNVRwBAQEEAQE?=
 =?us-ascii?q?HBAEBgVEHAQELAYQSg3mIGIxJAQEBAQEBBoEQg2eFV4krhHeBeoR0AwIChDU?=
 =?us-ascii?q?0CQ0BAwEBAQEBAQKGUgIBAyMEIDIQGAEMAiYCAkcQBhOFFqY7cHwzGoMQhm2?=
 =?us-ascii?q?BC4FziSJ4gQeBETOKYYJXAokfhj0zj3MJkUcKAolpA4cQLIJMln6CDU0uCoM?=
 =?us-ascii?q?ngicXjilljSgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2ANAACP2Pdb/7650XYNVRwBAQEEAQEHBAEBgVEHAQELA?=
 =?us-ascii?q?YQSg3mIGIxJAQEBAQEBBoEQg2eFV4krhHeBeoR0AwIChDU0CQ0BAwEBAQEBA?=
 =?us-ascii?q?QKGUgIBAyMEIDIQGAEMAiYCAkcQBhOFFqY7cHwzGoMQhm2BC4FziSJ4gQeBE?=
 =?us-ascii?q?TOKYYJXAokfhj0zj3MJkUcKAolpA4cQLIJMln6CDU0uCoMngicXjilljSgBA?=
 =?us-ascii?q?Q?=
X-IronPort-AV: E=Sophos;i="5.56,269,1539619200"; 
   d="scan'208";a="122563350"
Received: from unknown (HELO [192.168.1.28]) ([118.209.185.190])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 23 Nov 2018 18:41:59 +0800
Subject: [PATCH v2 2/5] autofs - fix possible inode leak in
 autofs_fill_super()
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 23 Nov 2018 18:41:57 +0800
Message-ID: <154296971705.9889.9822861969081020188.stgit@pluto-themaw-net>
In-Reply-To: <154296962626.9889.644199825100770992.stgit@pluto-themaw-net>
References: <154296962626.9889.644199825100770992.stgit@pluto-themaw-net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no check at all for a failure to allocate the root inode
in autofs_fill_super(), handle it.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 846c052569dd..e5c06b5a7371 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -254,9 +254,13 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 		goto fail_free;
 	}
 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
+	if (!root_inode) {
+		ret = -ENOMEM;
+		goto fail_ino;
+	}
 	root = d_make_root(root_inode);
 	if (!root)
-		goto fail_ino;
+		goto fail_iput;
 	pipe = NULL;
 
 	root->d_fsdata = ino;
@@ -304,8 +308,8 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	root_inode->i_op = &autofs_dir_inode_operations;
 
 	pr_debug("pipe fd = %d, pgrp = %u\n", pipefd, pid_nr(sbi->oz_pgrp));
-	pipe = fget(pipefd);
 
+	pipe = fget(pipefd);
 	if (!pipe) {
 		pr_err("could not open pipe file descriptor\n");
 		goto fail_put_pid;
@@ -334,6 +338,8 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 fail_dput:
 	dput(root);
 	goto fail_free;
+fail_iput:
+	iput(root_inode);
 fail_ino:
 	autofs_free_ino(ino);
 fail_free:

