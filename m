Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545B2C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CA420897
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CA420897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389635AbeG0S6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:58:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730511AbeG0S6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:58:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A4E972622;
        Fri, 27 Jul 2018 17:35:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 600F31C5B9;
        Fri, 27 Jul 2018 17:35:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 37/38] vfs: Allow fsinfo() to query what's in an fs_context
 [ver #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:35:29 +0100
Message-ID: <153271292981.9458.14024775561160883433.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 27 Jul 2018 17:35:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 27 Jul 2018 17:35:31 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
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

 fs/statfs.c |   29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/statfs.c b/fs/statfs.c
index caf0773957e9..480ac4be8c2a 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -669,13 +669,40 @@ static int vfs_fsinfo_path(int dfd, const char __user *filename,
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

