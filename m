Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2E6C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC9B2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC9B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeJNXLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35838 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727382AbeJNXLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:49 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0004cS-Rb; Sun, 14 Oct 2018 16:30:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000gw-C4; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Willy Tarreau" <w@1wt.eu>,
        "Dave Airlie" <airlied@redhat.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.33934882@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 313/366] mmap: introduce sane default mmap limits
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

commit be83bbf806822b1b89e0a0f23cd87cddc409e429 upstream.

The internal VM "mmap()" interfaces are based on the mmap target doing
everything using page indexes rather than byte offsets, because
traditionally (ie 32-bit) we had the situation that the byte offset
didn't fit in a register.  So while the mmap virtual address was limited
by the word size of the architecture, the backing store was not.

So we're basically passing "pgoff" around as a page index, in order to
be able to describe backing store locations that are much bigger than
the word size (think files larger than 4GB etc).

But while this all makes a ton of sense conceptually, we've been dogged
by various drivers that don't really understand this, and internally
work with byte offsets, and then try to work with the page index by
turning it into a byte offset with "pgoff << PAGE_SHIFT".

Which obviously can overflow.

Adding the size of the mapping to it to get the byte offset of the end
of the backing store just exacerbates the problem, and if you then use
this overflow-prone value to check various limits of your device driver
mmap capability, you're just setting yourself up for problems.

The correct thing for drivers to do is to do their limit math in page
indices, the way the interface is designed.  Because the generic mmap
code _does_ test that the index doesn't overflow, since that's what the
mmap code really cares about.

HOWEVER.

Finding and fixing various random drivers is a sisyphean task, so let's
just see if we can just make the core mmap() code do the limiting for
us.  Realistically, the only "big" backing stores we need to care about
are regular files and block devices, both of which are known to do this
properly, and which have nice well-defined limits for how much data they
can access.

So let's special-case just those two known cases, and then limit other
random mmap users to a backing store that still fits in "unsigned long".
Realistically, that's not much of a limit at all on 64-bit, and on
32-bit architectures the only worry might be the GPU drivers, which can
have big physical address spaces.

To make it possible for drivers like that to say that they are 64-bit
clean, this patch does repurpose the "FMODE_UNSIGNED_OFFSET" bit in the
file flags to allow drivers to mark their file descriptors as safe in
the full 64-bit mmap address space.

[ The timing for doing this is less than optimal, and this should really
  go in a merge window. But realistically, this needs wide testing more
  than it needs anything else, and being main-line is the only way to do
  that.

  So the earlier the better, even if it's outside the proper development
  cycle        - Linus ]

Cc: Kees Cook <keescook@chromium.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Dave Airlie <airlied@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/mmap.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1234,6 +1234,35 @@ static inline int mlock_future_check(str
 	return 0;
 }
 
+static inline u64 file_mmap_size_max(struct file *file, struct inode *inode)
+{
+	if (S_ISREG(inode->i_mode))
+		return inode->i_sb->s_maxbytes;
+
+	if (S_ISBLK(inode->i_mode))
+		return MAX_LFS_FILESIZE;
+
+	/* Special "we do even unsigned file positions" case */
+	if (file->f_mode & FMODE_UNSIGNED_OFFSET)
+		return 0;
+
+	/* Yes, random drivers might want more. But I'm tired of buggy drivers */
+	return ULONG_MAX;
+}
+
+static inline bool file_mmap_ok(struct file *file, struct inode *inode,
+				unsigned long pgoff, unsigned long len)
+{
+	u64 maxsize = file_mmap_size_max(file, inode);
+
+	if (maxsize && len > maxsize)
+		return false;
+	maxsize -= len;
+	if (pgoff > maxsize >> PAGE_SHIFT)
+		return false;
+	return true;
+}
+
 /*
  * The caller must hold down_write(&current->mm->mmap_sem).
  */
@@ -1301,6 +1330,9 @@ unsigned long do_mmap_pgoff(struct file
 	if (file) {
 		struct inode *inode = file_inode(file);
 
+		if (!file_mmap_ok(file, inode, pgoff, len))
+			return -EOVERFLOW;
+
 		switch (flags & MAP_TYPE) {
 		case MAP_SHARED:
 			if ((prot&PROT_WRITE) && !(file->f_mode&FMODE_WRITE))

