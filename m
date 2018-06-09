Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xPyeNtHyG1tfYAAAmS7hNA
	; Sat, 09 Jun 2018 15:32:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 10165608C1; Sat,  9 Jun 2018 15:32:38 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAYWBE6z"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9BC6A608BF;
	Sat,  9 Jun 2018 15:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BC6A608BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932513AbeFIPce (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932463AbeFIPc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:32:29 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 085B6204EC;
        Sat,  9 Jun 2018 15:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558348;
        bh=JFdf2M2c3BYfP2nvi91JcrmlBXfdXRGSQpsLUKHoHIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oAYWBE6zgtxwiJ+YS89/4mJB/5IqOzC1QUwKxUhzzeYZlJwVWtx7jjv86CQGMu7sg
         UID2Smvi8nlvo1Ta25QzC59mrEqiNkgXtMiIjGm2LzCnirDSeAAGf/lfv33bA0FNm4
         Acrhujpvm/lsQK6090h8b7c3CO/bE4Zk7vOGUGgE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 02/48] mmap: relax file size limit for regular files
Date: Sat,  9 Jun 2018 17:29:14 +0200
Message-Id: <20180609145947.847276798@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 423913ad4ae5b3e8fb8983f70969fb522261ba26 upstream.

Commit be83bbf80682 ("mmap: introduce sane default mmap limits") was
introduced to catch problems in various ad-hoc character device drivers
doing mmap and getting the size limits wrong.  In the process, it used
"known good" limits for the normal cases of mapping regular files and
block device drivers.

It turns out that the "s_maxbytes" limit was less "known good" than I
thought.  In particular, /proc doesn't set it, but exposes one regular
file to mmap: /proc/vmcore.  As a result, that file got limited to the
default MAX_INT s_maxbytes value.

This went unnoticed for a while, because apparently the only thing that
needs it is the s390 kernel zfcpdump, but there might be other tools
that use this too.

Vasily suggested just changing s_maxbytes for all of /proc, which isn't
wrong, but makes me nervous at this stage.  So instead, just make the
new mmap limit always be MAX_LFS_FILESIZE for regular files, which won't
affect anything else.  It wasn't the regular file case I was worried
about.

I'd really prefer for maxsize to have been per-inode, but that is not
how things are today.

Fixes: be83bbf80682 ("mmap: introduce sane default mmap limits")
Reported-by: Vasily Gorbik <gor@linux.ibm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/mmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1318,7 +1318,7 @@ static inline int mlock_future_check(str
 static inline u64 file_mmap_size_max(struct file *file, struct inode *inode)
 {
 	if (S_ISREG(inode->i_mode))
-		return inode->i_sb->s_maxbytes;
+		return MAX_LFS_FILESIZE;
 
 	if (S_ISBLK(inode->i_mode))
 		return MAX_LFS_FILESIZE;
