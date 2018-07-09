Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121DFC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C806D208E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C806D208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754544AbeGIEy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:54:26 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38052 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754317AbeGIEyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:54:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fcOBl-0003eS-Qq; Mon, 09 Jul 2018 04:54:17 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 04/27] make sure do_dentry_open() won't return positive as an error
Date:   Mon,  9 Jul 2018 05:53:54 +0100
Message-Id: <20180709045417.13988-4-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
References: <20180709045320.GF30522@ZenIV.linux.org.uk>
 <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
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
index d0e955b558ad..40658ef912d2 100644
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

