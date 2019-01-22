Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9084CC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C4A217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170636;
	bh=XWlMwEW6ubD/pj6iYwLPzmfleia66FdkV1XnoJ+lUvs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=umK3fWmYEKh+QsxHnZFHmXigrWDP/WsxrUp0Dt4eSmj7XKlxhYij6+C7Z952wwFbW
	 AOT4wD0c4xyWWXUJkIaEce2q1FQcRWBPycO9kp29PB6Cr/k1sBOkmbaGa6/pI0zuZq
	 TSoOntK4rflImKOL66wLUurdokCZxEV2XIqNDJyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfAVPXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:23:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729939AbfAVPXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A74320879;
        Tue, 22 Jan 2019 15:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170631;
        bh=XWlMwEW6ubD/pj6iYwLPzmfleia66FdkV1XnoJ+lUvs=;
        h=From:To:Cc:Subject:Date:From;
        b=r+dC1cr9dZiM1k9Koa/ic5SQyZ+O/Q3L7KYQA0Rj/nw/AbhbvRa25MHXmMSJ016eX
         eDrxMPV6KMXC9Aa9nATNGoCddsExoIxIt+bv0ZOJU6TUQVRC/5CH36TrMJ/kGvT87b
         jyIpyhZQDv3MuRtq624d3NTMxK6bAdQ4lDoaq550=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH] gcov: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:48 +0100
Message-Id: <20190122152151.16139-49-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Also delete the dentry variable as it is never needed.

Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/gcov/fs.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index 6e40ff6be083..aa9a49f72024 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -64,7 +64,6 @@ struct gcov_node {
 static const char objtree[] = OBJTREE;
 static const char srctree[] = SRCTREE;
 static struct gcov_node root_node;
-static struct dentry *reset_dentry;
 static LIST_HEAD(all_head);
 static DEFINE_MUTEX(node_lock);
 
@@ -387,8 +386,6 @@ static void add_links(struct gcov_node *node, struct dentry *parent)
 			goto out_err;
 		node->links[i] = debugfs_create_symlink(deskew(basename),
 							parent,	target);
-		if (!node->links[i])
-			goto out_err;
 		kfree(target);
 	}
 
@@ -450,11 +447,6 @@ static struct gcov_node *new_node(struct gcov_node *parent,
 					parent->dentry, node, &gcov_data_fops);
 	} else
 		node->dentry = debugfs_create_dir(node->name, parent->dentry);
-	if (!node->dentry) {
-		pr_warn("could not create file\n");
-		kfree(node);
-		return NULL;
-	}
 	if (info)
 		add_links(node, parent->dentry);
 	list_add(&node->list, &parent->children);
@@ -769,24 +761,14 @@ static __init int gcov_fs_init(void)
 	 * and all profiling files.
 	 */
 	root_node.dentry = debugfs_create_dir("gcov", NULL);
-	if (!root_node.dentry)
-		goto err_remove;
 	/*
 	 * Create reset file which resets all profiling counts when written
 	 * to.
 	 */
-	reset_dentry = debugfs_create_file("reset", 0600, root_node.dentry,
-					   NULL, &gcov_reset_fops);
-	if (!reset_dentry)
-		goto err_remove;
+	debugfs_create_file("reset", 0600, root_node.dentry, NULL,
+			    &gcov_reset_fops);
 	/* Replay previous events to get our fs hierarchy up-to-date. */
 	gcov_enable_events();
 	return 0;
-
-err_remove:
-	pr_err("init failed\n");
-	debugfs_remove(root_node.dentry);
-
-	return rc;
 }
 device_initcall(gcov_fs_init);
-- 
2.20.1

