Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26FCC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D60A20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D60A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeLIWND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:13:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37850 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbeLIWNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:13:00 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73B-0002ib-NA; Sun, 09 Dec 2018 21:55:45 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0003QY-7C; Sun, 09 Dec 2018 21:55:12 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Jeff Mahoney" <jeffm@suse.com>,
        "Eric Biggers" <ebiggers@google.com>,
        "Jann Horn" <jannh@google.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.687730563@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 155/328] reiserfs: fix broken xattr handling (heap
 corruption, bad retval)
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit a13f085d111e90469faf2d9965eb39b11c114d7e upstream.

This fixes the following issues:

- When a buffer size is supplied to reiserfs_listxattr() such that each
  individual name fits, but the concatenation of all names doesn't fit,
  reiserfs_listxattr() overflows the supplied buffer.  This leads to a
  kernel heap overflow (verified using KASAN) followed by an out-of-bounds
  usercopy and is therefore a security bug.

- When a buffer size is supplied to reiserfs_listxattr() such that a
  name doesn't fit, -ERANGE should be returned.  But reiserfs instead just
  truncates the list of names; I have verified that if the only xattr on a
  file has a longer name than the supplied buffer length, listxattr()
  incorrectly returns zero.

With my patch applied, -ERANGE is returned in both cases and the memory
corruption doesn't happen anymore.

Credit for making me clean this code up a bit goes to Al Viro, who pointed
out that the ->actor calling convention is suboptimal and should be
changed.

Link: http://lkml.kernel.org/r/20180802151539.5373-1-jannh@google.com
Fixes: 48b32a3553a5 ("reiserfs: use generic xattr handlers")
Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: Jeff Mahoney <jeffm@suse.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16:
 - The xattr handler's list operation does the copy, so also update the
   buffer size we pass to it
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -822,10 +822,12 @@ static int listxattr_filler(void *buf, c
 			return 0;
 		if (b->buf) {
 			size = handler->list(b->dentry, b->buf + b->pos,
-					 b->size, name, namelen,
+					 b->size - b->pos, name, namelen,
 					 handler->flags);
-			if (size > b->size)
+			if (b->pos + size > b->size) {
+				b->pos = -ERANGE;
 				return -ERANGE;
+			}
 		} else {
 			size = handler->list(b->dentry, NULL, 0, name,
 					     namelen, handler->flags);

