Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF87C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027B9208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027B9208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388932AbeHWMix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:38:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56558 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbeHWMix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:38:53 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1D8C8CA8;
        Thu, 23 Aug 2018 09:10:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Jeff Mahoney <jeffm@suse.com>,
        Eric Biggers <ebiggers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.17 324/324] reiserfs: fix broken xattr handling (heap corruption, bad retval)
Date:   Thu, 23 Aug 2018 09:56:30 +0200
Message-Id: <20180823075012.335959073@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/reiserfs/xattr.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -792,8 +792,10 @@ static int listxattr_filler(struct dir_c
 			return 0;
 		size = namelen + 1;
 		if (b->buf) {
-			if (size > b->size)
+			if (b->pos + size > b->size) {
+				b->pos = -ERANGE;
 				return -ERANGE;
+			}
 			memcpy(b->buf + b->pos, name, namelen);
 			b->buf[b->pos + namelen] = 0;
 		}


