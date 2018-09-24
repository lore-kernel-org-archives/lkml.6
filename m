Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0B7ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C481A208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C481A208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbeIXSNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:13:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54886 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbeIXSNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:13:44 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 861221086;
        Mon, 24 Sep 2018 12:11:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 078/111] configfs: fix registered group removal
Date:   Mon, 24 Sep 2018 13:52:45 +0200
Message-Id: <20180924113112.656897317@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Christie <mchristi@redhat.com>

[ Upstream commit cc57c07343bd071cdf1915a91a24ab7d40c9b590 ]

This patch fixes a bug where configfs_register_group had added
a group in a tree, and userspace has done a rmdir on a dir somewhere
above that group and we hit a kernel crash. The problem is configfs_rmdir
will detach everything under it and unlink groups on the default_groups
list. It will not unlink groups added with configfs_register_group so when
configfs_unregister_group is called to drop its references to the group/items
we crash when we try to access the freed dentrys.

The patch just adds a check for if a rmdir has been done above
us and if so just does the unlink part of unregistration.

Sorry if you are getting this multiple times. I thouhgt I sent
this to some of you and lkml, but I do not see it.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Joel Becker <jlbec@evilplan.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/configfs/dir.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1777,6 +1777,16 @@ void configfs_unregister_group(struct co
 	struct dentry *dentry = group->cg_item.ci_dentry;
 	struct dentry *parent = group->cg_item.ci_parent->ci_dentry;
 
+	mutex_lock(&subsys->su_mutex);
+	if (!group->cg_item.ci_parent->ci_group) {
+		/*
+		 * The parent has already been unlinked and detached
+		 * due to a rmdir.
+		 */
+		goto unlink_group;
+	}
+	mutex_unlock(&subsys->su_mutex);
+
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
 	spin_lock(&configfs_dirent_lock);
 	configfs_detach_prep(dentry, NULL);
@@ -1791,6 +1801,7 @@ void configfs_unregister_group(struct co
 	dput(dentry);
 
 	mutex_lock(&subsys->su_mutex);
+unlink_group:
 	unlink_group(group);
 	mutex_unlock(&subsys->su_mutex);
 }


