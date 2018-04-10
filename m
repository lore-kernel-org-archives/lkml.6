Return-Path: <ksspiers@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523403951; cv=none;
        d=google.com; s=arc-20160816;
        b=cN1l9uiQQV3ZuagPTrc2g2r2wTgt0CWKWRG4lL7GntpnC0oJpCPHp8EJQ/lcwfjKeT
         Q+m3Rjtnhncj+ruvZeYEATbOhOorrJHYbSd4ja48Pn7VcC99Jil16diRXzlEw2tqHqN1
         rVupJ7g7kI1/TuI9/5eGNOWa3d2/MXFxyvaM+vDKEgw+AAO+2Zv+tOT8BGm/5Q9W9/Ei
         rlKFKhRQ9XNMNV3PG2lCq9N8tr1H5yvzLuBgamoBY9Zpu2ZEPfHTgFyt2m13CNkf2PAz
         Q/Oj17QgliPYwSa39ZIPtuHoO3Uw20R1eElUVFGg+Rhp/iJd2wueusHsmmM6YmTRmYrh
         UoOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=2x111VUrFbY9ptnG6wUwPHvDSgg7vfrmlOjc5rNcH6s=;
        b=Gk04oUFnRNO9Mo9zP/fUiidlKcTq6O8/OdmlDyJtdq5OfE9eQIqsiwOtwtoI0C4Vid
         UwY+FBmC0WXASWg9Df6CAcdM3xs4r+8nhlU/Q4PxqzDRWFTBCyYI/gk++gh38vEenfwN
         Ds2dKNNSZRaDeHcq5ZgszwZICsV7g5BhCT1CWfvCFp5rpG0dw2WT4H1lb8eyELhhjHhI
         LIP0wqnxvCPE/TeCIDOLzswomwsS7O6WECHb46IwdERxaOaEfTrY9i5jJ7RplPNH4rBi
         K0KkrnyzD/rSLs6VAn1LZ0phNp8eDf8lIR/uT15i/hG51ZwdU68hWoJ7X1R0XnLPEVMb
         I8dw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=eT7pHYzh;
       spf=pass (google.com: domain of ksspiers@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ksspiers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=eT7pHYzh;
       spf=pass (google.com: domain of ksspiers@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ksspiers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48T6X1Wx+0O9JIYhaYzxQE3J5Z7gEmvbNyQ6iawVW1VEzgJFmmLzpd+t2/Nk/mQ0jvL5rHfXQ==
From: Kyle Spiers <ksspiers@google.com>
To: jack@suse.cz
Cc: arnd@arndb.de,
	dhowells@redhat.com,
	viro@zeniv.linux.org.uk,
	gregkh@linuxfoundation.org,
	keescook@chromium.org,
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	Kyle Spiers <ksspiers@google.com>
Subject: [PATCH v3] isofs compress: Remove VLA usage
Date: Tue, 10 Apr 2018 16:45:32 -0700
Message-Id: <20180410234532.185426-1-ksspiers@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597404821961766971?=
X-GMAIL-MSGID: =?utf-8?q?1597404821961766971?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As part of the effort to remove VLAs from the kernel[1], this changes
the allocation of the bhs and pages arrays from being on the stack to being
kcalloc()ed. This also allows for the removal of the explicit zeroing
of bhs.

https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Kyle Spiers <ksspiers@google.com>
---
Fixed build for sparc64
Fixed error recovery mistakes
---
 fs/isofs/compress.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index 9bb2fe35799d..4eba16bf173c 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/bio.h>
 
+#include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/zlib.h>
 
@@ -59,7 +60,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 				>> bufshift;
 	int haveblocks;
 	blkcnt_t blocknum;
-	struct buffer_head *bhs[needblocks + 1];
+	struct buffer_head **bhs;
 	int curbh, curpage;
 
 	if (block_size > deflateBound(1UL << zisofs_block_shift)) {
@@ -80,7 +81,9 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 
 	/* Because zlib is not thread-safe, do all the I/O at the top. */
 	blocknum = block_start >> bufshift;
-	memset(bhs, 0, (needblocks + 1) * sizeof(struct buffer_head *));
+	bhs = kcalloc(needblocks + 1, sizeof(*bhs), GFP_KERNEL);
+	if (!bhs)
+		return -ENOMEM;
 	haveblocks = isofs_get_blocks(inode, blocknum, bhs, needblocks);
 	ll_rw_block(REQ_OP_READ, 0, haveblocks, bhs);
 
@@ -190,6 +193,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 b_eio:
 	for (i = 0; i < haveblocks; i++)
 		brelse(bhs[i]);
+	kfree(bhs);
 	return stream.total_out;
 }
 
@@ -305,7 +309,7 @@ static int zisofs_readpage(struct file *file, struct page *page)
 	unsigned int zisofs_pages_per_cblock =
 		PAGE_SHIFT <= zisofs_block_shift ?
 		(1 << (zisofs_block_shift - PAGE_SHIFT)) : 0;
-	struct page *pages[max_t(unsigned, zisofs_pages_per_cblock, 1)];
+	struct page **pages;
 	pgoff_t index = page->index, end_index;
 
 	end_index = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -330,6 +334,10 @@ static int zisofs_readpage(struct file *file, struct page *page)
 		full_page = 0;
 		pcount = 1;
 	}
+	pages = kcalloc(max_t(unsigned int, zisofs_pages_per_cblock, 1),
+					sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
 	pages[full_page] = page;
 
 	for (i = 0; i < pcount; i++, index++) {
@@ -357,6 +365,7 @@ static int zisofs_readpage(struct file *file, struct page *page)
 	}			
 
 	/* At this point, err contains 0 or -EIO depending on the "critical" page */
+	kfree(pages);
 	return err;
 }
 
-- 
2.17.0.484.g0c8726318c-goog
