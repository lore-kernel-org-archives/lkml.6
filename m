Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A831C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAD5207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278564;
	bh=KJ9WeQfJEpKfeE9XIRXQTGXFK4VL8Rg3ivyvB9Q0NGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fozNyKxH75D71LtD23AKHFdKIzgxod/+KWjv8W960LGKJZ2zxwLIinXokX/tC976A
	 uNW3oJsEtlrookc15/T0CSwi4vPYEDJoIvacxFa858mrGH8s1PDMvR5i8b0RiQu86k
	 NCkkC1pKtAkB7lJ0gxYI/TB9Yqc5x2pmLe70CZv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfBDLJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:09:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730076AbfBDKkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:40:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 477312075B;
        Mon,  4 Feb 2019 10:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276841;
        bh=KJ9WeQfJEpKfeE9XIRXQTGXFK4VL8Rg3ivyvB9Q0NGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AhrUV2rzPGel/fE+zFcakXJciGDYxvUbla8OsR6u3U0D++f0bIpRHRGJmDgDCIdMp
         EYcQt3NS2rPx6zis2PPz6Rn3plHwBINwxGasbOU2kugq2EN3jINDCqnlu8Mb5kWLRr
         jc/uXelGhMpEJQVXYxouU7/act1r6eog+OFLS9j0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Li <richardpku@gmail.com>,
        Chad Miller <millchad@amazon.com>,
        Stefan Nuernberger <snu@amazon.de>,
        Frank Becker <becke@amazon.de>,
        Jimmy Durand Wesolowski <jdw@amazon.de>
Subject: [PATCH 4.4 33/65] fs: add the fsnotify call to vfs_iter_write
Date:   Mon,  4 Feb 2019 11:36:26 +0100
Message-Id: <20190204103616.442911772@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jimmy Durand Wesolowski <jdw@amazon.de>

A bug has been discovered when redirecting splice output to regular files
on EXT4 and tmpfs. Other filesystems might be affected.
This commit fixes the issue for stable series kernel, using one of the
change introduced during the rewrite and refactoring of vfs_iter_write in
4.13, specifically in the
commit abbb65899aec ("fs: implement vfs_iter_write using do_iter_write").

This issue affects v4.4 and v4.9 stable series of kernels.

Without this fix for v4.4 and v4.9 stable, the following upstream commits
(and their dependencies would need to be backported):
* commit abbb65899aec ("fs: implement vfs_iter_write using do_iter_write")
* commit 18e9710ee59c ("fs: implement vfs_iter_read using do_iter_read")
* commit edab5fe38c2c
  ("fs: move more code into do_iter_read/do_iter_write")
* commit 19c735868dd0 ("fs: remove __do_readv_writev")
* commit 26c87fb7d10d ("fs: remove do_compat_readv_writev")
* commit 251b42a1dc64 ("fs: remove do_readv_writev")

as well as the following dependencies:
* commit bb7462b6fd64
  ("vfs: use helpers for calling f_op->{read,write}_iter()")
* commit 0f78d06ac1e9
  ("vfs: pass type instead of fn to do_{loop,iter}_readv_writev()")
* commit 7687a7a4435f
  ("vfs: extract common parts of {compat_,}do_readv_writev()")

In order to reduce the changes, this commit uses only the part of
commit abbb65899aec ("fs: implement vfs_iter_write using do_iter_write")
that fixes the issue.

This issue and the reproducer can be found on
https://bugzilla.kernel.org/show_bug.cgi?id=85381

Reported-by: Richard Li <richardpku@gmail.com>
Reported-by: Chad Miller <millchad@amazon.com>
Reviewed-by: Stefan Nuernberger <snu@amazon.de>
Reviewed-by: Frank Becker <becke@amazon.de>
Signed-off-by: Jimmy Durand Wesolowski <jdw@amazon.de>
---
 fs/read_write.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -363,8 +363,10 @@ ssize_t vfs_iter_write(struct file *file
 	iter->type |= WRITE;
 	ret = file->f_op->write_iter(&kiocb, iter);
 	BUG_ON(ret == -EIOCBQUEUED);
-	if (ret > 0)
+	if (ret > 0) {
 		*ppos = kiocb.ki_pos;
+		fsnotify_modify(file);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(vfs_iter_write);


