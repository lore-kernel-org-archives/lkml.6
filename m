Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D5041C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A653208C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDrChOXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A653208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935001AbeFLQsT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933429AbeFLQsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:48:17 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA733208B8;
        Tue, 12 Jun 2018 16:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822096;
        bh=eGI/idKSmkKTJ+OA7qhwkqHXNTiQutlCwDBLjeSYMtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDrChOXSHn0TqUH7z8ETwKBY/5GnZuPVdJRGXhy2qyfu5e1cHt2mINLxBn3zzBsAT
         kb3yUZIG6VfcekA1i6vPUURWKe3g4l4dQY9UwQJi3hhEr9umTbyXLaw+8C3Rnktcnb
         Qvu62ijkgJZKRzPff/aWmTPfMVrQY1IS7Vt7gsxw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 04/31] mmap: relax file size limit for regular files
Date:   Tue, 12 Jun 2018 18:46:07 +0200
Message-Id: <20180612164620.966540380@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
References: <20180612164620.797338191@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1315,7 +1315,7 @@ static inline int mlock_future_check(str
 static inline u64 file_mmap_size_max(struct file *file, struct inode *inode)
 {
 	if (S_ISREG(inode->i_mode))
-		return inode->i_sb->s_maxbytes;
+		return MAX_LFS_FILESIZE;
 
 	if (S_ISBLK(inode->i_mode))
 		return MAX_LFS_FILESIZE;


