Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2308AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64AD21567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64AD21567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390852AbeIUW1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:27:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50599 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390433AbeIUW1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:27:54 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0152307D910;
        Fri, 21 Sep 2018 16:38:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 933422010CF7;
        Fri, 21 Sep 2018 16:38:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/5] vfs: Allow fsinfo() to query what's in an fs_context
 [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:38:11 +0100
Message-ID: <153754789135.19213.18110372705954700799.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754786825.19213.16907802981157370740.stgit@warthog.procyon.org.uk>
References: <153754786825.19213.16907802981157370740.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 21 Sep 2018 16:38:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow fsinfo() to be used to query the filesystem attached to an fs_context
once a superblock has been created or if it comes from fspick().

This is done with something like:

	fd = fsopen("ext4", 0);
	...
	fsconfig(fd, fsconfig_cmd_create, ...);
	fsinfo(fd, NULL, ...);

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/statfs.c |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/fs/statfs.c b/fs/statfs.c
index f3cf8aa42a3d..790e21367d70 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -636,7 +636,8 @@ int vfs_fsinfo(struct path *path, struct fsinfo_kparams *params)
 		return ret;
 
 	if (params->request == FSINFO_ATTR_IDS &&
-	    params->buffer) {
+	    params->buffer &&
+	    path->mnt) {
 		struct fsinfo_ids *p = params->buffer;
 
 		p->f_flags |= flags_by_mnt(path->mnt->mnt_flags);
@@ -677,13 +678,40 @@ static int vfs_fsinfo_path(int dfd, const char __user *filename,
 	return ret;
 }
 
+static int vfs_fsinfo_fscontext(struct fs_context *fc,
+				struct fsinfo_kparams *params)
+{
+	int ret;
+
+	if (fc->ops == &legacy_fs_context_ops)
+		return -EOPNOTSUPP;
+
+	ret = mutex_lock_interruptible(&fc->uapi_mutex);
+	if (ret < 0)
+		return ret;
+
+	ret = -EIO;
+	if (fc->root) {
+		struct path path = { .dentry = fc->root };
+
+		ret = vfs_fsinfo(&path, params);
+	}
+
+	mutex_unlock(&fc->uapi_mutex);
+	return ret;
+}
+
 static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_kparams *params)
 {
 	struct fd f = fdget_raw(fd);
 	int ret = -EBADF;
 
 	if (f.file) {
-		ret = vfs_fsinfo(&f.file->f_path, params);
+		if (f.file->f_op == &fscontext_fops)
+			ret = vfs_fsinfo_fscontext(f.file->private_data,
+						   params);
+		else
+			ret = vfs_fsinfo(&f.file->f_path, params);
 		fdput(f);
 	}
 	return ret;

