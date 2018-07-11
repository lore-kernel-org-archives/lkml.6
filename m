Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E640DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B0C208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B0C208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbeGKCYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:24:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45518 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732374AbeGKCYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4la-0003Hr-U3; Wed, 11 Jul 2018 02:22:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 08/42] make sure do_dentry_open() won't return positive as an error
Date:   Wed, 11 Jul 2018 03:21:32 +0100
Message-Id: <20180711022206.12571-8-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

An ->open() instances really, really should not be doing that.  There's
a lot of places e.g. around atomic_open() that could be confused by that,
so let's catch that early.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/open.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 76c56966e297..558802e66e00 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -812,6 +812,10 @@ static int do_dentry_open(struct file *f,
 	return 0;
 
 cleanup_all:
+	if (unlikely(error > 0)) {
+		WARN_ON(1);
+		error = -EINVAL;
+	}
 	fops_put(f->f_op);
 	if (f->f_mode & FMODE_WRITER) {
 		put_write_access(inode);
-- 
2.11.0

