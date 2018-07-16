Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C079FECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABEC206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABEC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbeGPIHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:07:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47630 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbeGPIHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:07:47 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 91E5FC03;
        Mon, 16 Jul 2018 07:41:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 24/54] Fix up non-directory creation in SGID directories
Date:   Mon, 16 Jul 2018 09:35:21 +0200
Message-Id: <20180716073455.452966215@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073450.534886211@linuxfoundation.org>
References: <20180716073450.534886211@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 0fa3ecd87848c9c93c2c828ef4c3a8ca36ce46c7 upstream.

sgid directories have special semantics, making newly created files in
the directory belong to the group of the directory, and newly created
subdirectories will also become sgid.  This is historically used for
group-shared directories.

But group directories writable by non-group members should not imply
that such non-group members can magically join the group, so make sure
to clear the sgid bit on non-directories for non-members (but remember
that sgid without group execute means "mandatory locking", just to
confuse things even more).

Reported-by: Jann Horn <jannh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/inode.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2006,8 +2006,14 @@ void inode_init_owner(struct inode *inod
 	inode->i_uid = current_fsuid();
 	if (dir && dir->i_mode & S_ISGID) {
 		inode->i_gid = dir->i_gid;
+
+		/* Directories are special, and always inherit S_ISGID */
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
+		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
+			 !in_group_p(inode->i_gid) &&
+			 !capable_wrt_inode_uidgid(dir, CAP_FSETID))
+			mode &= ~S_ISGID;
 	} else
 		inode->i_gid = current_fsgid();
 	inode->i_mode = mode;


