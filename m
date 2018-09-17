Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53B2ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D93214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D93214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbeIRE2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:28:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47842 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbeIRE2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:28:46 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 45BACC49;
        Mon, 17 Sep 2018 22:59:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+87c3c541582e56943277@syzkaller.appspotmail.com,
        Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.9 69/70] autofs: fix autofs_sbi() does not check super block type
Date:   Tue, 18 Sep 2018 00:42:42 +0200
Message-Id: <20180917211654.482468299@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
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

From: Ian Kent <raven@themaw.net>

commit 0633da48f0793aeba27f82d30605624416723a91 upstream.

autofs_sbi() does not check the superblock magic number to verify it has
been given an autofs super block.

Backport Note: autofs4 has been renamed to autofs upstream. As a result
the upstream patch does not apply cleanly onto 4.14.y.

Link: http://lkml.kernel.org/r/153475422934.17131.7563724552005298277.stgit@pluto.themaw.net
Reported-by: <syzbot+87c3c541582e56943277@syzkaller.appspotmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/autofs4/autofs_i.h |    4 +++-
 fs/autofs4/inode.c    |    1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -14,6 +14,7 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/magic.h>
 
 /* This is the range of ioctl() numbers we claim as ours */
 #define AUTOFS_IOC_FIRST     AUTOFS_IOC_READY
@@ -123,7 +124,8 @@ struct autofs_sb_info {
 
 static inline struct autofs_sb_info *autofs4_sbi(struct super_block *sb)
 {
-	return (struct autofs_sb_info *)(sb->s_fs_info);
+	return sb->s_magic != AUTOFS_SUPER_MAGIC ?
+		NULL : (struct autofs_sb_info *)(sb->s_fs_info);
 }
 
 static inline struct autofs_info *autofs4_dentry_ino(struct dentry *dentry)
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -14,7 +14,6 @@
 #include <linux/pagemap.h>
 #include <linux/parser.h>
 #include <linux/bitops.h>
-#include <linux/magic.h>
 #include "autofs_i.h"
 #include <linux/module.h>
 


