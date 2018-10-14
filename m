Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE969C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8692077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8692077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbeJNXeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:34:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36115 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727875AbeJNXL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:58 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLl-0004co-2V; Sun, 14 Oct 2018 16:30:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000h7-EC; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Vasily Gorbik" <gor@linux.ibm.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.31657966@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 315/366] mmap: relax file size limit for regular files
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1237,7 +1237,7 @@ static inline int mlock_future_check(str
 static inline u64 file_mmap_size_max(struct file *file, struct inode *inode)
 {
 	if (S_ISREG(inode->i_mode))
-		return inode->i_sb->s_maxbytes;
+		return MAX_LFS_FILESIZE;
 
 	if (S_ISBLK(inode->i_mode))
 		return MAX_LFS_FILESIZE;

