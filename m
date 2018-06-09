Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vPyeNtHyG1tfYAAAmS7hNA
	; Sat, 09 Jun 2018 15:31:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BF033608C9; Sat,  9 Jun 2018 15:31:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zd9j1+Ou"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CA580608B8;
	Sat,  9 Jun 2018 15:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA580608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932188AbeFIPbo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932124AbeFIPbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:31:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29B15204EC;
        Sat,  9 Jun 2018 15:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558298;
        bh=uzu7ttel23tbXnm5ufsgQRs0pSfVyQ81yCTMIhAwsHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zd9j1+OuWsCJVBE78fOL2qlNZh94NNyGsGXrFEQ1hHnp/3u26TFSWEjgDkdJWIZ+/
         v5I89KICK7zMCdyx2VE2KsjSItQiuhrCDT4iDnZ+NVbwk+ISJ40inZJ3Hm049PmPkF
         nhAdpE4LWD1erqDydgz2auf+NDQcLOlGNOxk8zb8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Willy Tarreau <w@1wt.eu>,
        Dave Airlie <airlied@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 01/48] mmap: introduce sane default mmap limits
Date: Sat,  9 Jun 2018 17:29:13 +0200
Message-Id: <20180609145947.782225494@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/mmap.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1315,6 +1315,35 @@ static inline int mlock_future_check(str
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
@@ -1389,6 +1418,9 @@ unsigned long do_mmap(struct file *file,
 		struct inode *inode = file_inode(file);
 		unsigned long flags_mask;
 
+		if (!file_mmap_ok(file, inode, pgoff, len))
+			return -EOVERFLOW;
+
 		flags_mask = LEGACY_MAP_MASK | file->f_op->mmap_supported_flags;
 
 		switch (flags & MAP_TYPE) {
