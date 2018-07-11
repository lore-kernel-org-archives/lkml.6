Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B630C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C228B208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C228B208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732734AbeGKCYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:24:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45722 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732493AbeGKCYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:08 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4lf-0003Lq-GJ; Wed, 11 Jul 2018 02:22:11 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 39/42] document alloc_file() changes
Date:   Wed, 11 Jul 2018 03:22:03 +0100
Message-Id: <20180711022206.12571-39-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/porting | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/filesystems/porting b/Documentation/filesystems/porting
index c68ea9294b5f..77e2d623e115 100644
--- a/Documentation/filesystems/porting
+++ b/Documentation/filesystems/porting
@@ -610,3 +610,15 @@ in your dentry operations instead.
 	value for 'called finish_no_open(), open it yourself' case has become
 	0, not 1.  Since finish_no_open() itself is returning 0 now, that part
 	does not need any changes in ->atomic_open() instances.
+--
+[mandatory]
+	alloc_file() has become static now; two wrappers are to be used instead.
+	alloc_file_pseudo(inode, vfsmount, name, mode, ops) is for the cases
+	when dentry needs to be created; that's the majority of old alloc_file()
+	users.  Calling conventions: on success a reference to new struct file
+	is returned and callers reference to inode is subsumed by that.  On
+	failure, ERR_PTR() is returned and no caller's references are affected,
+	so the caller needs to drop the inode reference it held.
+	alloc_file_clone(file, mode, ops) does not affect any caller's references.
+	On success you get a new struct file sharing the mount/dentry with the
+	original, on failure - ERR_PTR().
-- 
2.11.0

