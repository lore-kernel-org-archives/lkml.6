Return-Path: <ksspiers@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522952244; cv=none;
        d=google.com; s=arc-20160816;
        b=uRwR0PV6ktXXUsoZ+KFE45Bknc+aN9Xw7S7R1dz/28VVhLMQaIofwOjll+mvk7VQ+c
         sslC2e43113NPhqdMEcGJn1stuyJO8SA2tRxPh7rc79tCQARZ+nstHfhIrz0t1xbmd7/
         A73sd4gZHg1jSKiND2XFCWeVBBSOfzzT7Rwl79t4ipN2ABmKU4jCcK18BFRGEuXCeFao
         lyFKTwRX2eI/gFKkao4zv1yueec9Tb1piAKYFYrNkTf5Q6TspTwJfo7mMo+ZIJq0vj9I
         37imL79ctztJbS9xs4TTYxXMYOy8eDbeSMBp6K2zMS+gOZ9aGsUfsyuIxyk3/ivdazLE
         CD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=jmjnOFjiuvvDJO1T8oawdVDww4ktucaP+MLTAWdT5nc=;
        b=IzLQ/AQrMqzDKLiiSQ8Pkgofk08lVWmsrZ8PVlLG+eLKllzqtMEvOYzSfkQcLOtOQz
         pAA8YKqcT1cth9y2MtVbL1fxASVeMFp8tJjMzuCzA7gxSw91CM1+482+1dGT8dsaTBRJ
         bQ0xwY3LJomu1m59oaLI0aw6UH113hcSoL0T5XVp6lC+dK0fIAxCRJH+J5ZCOoVk8rNl
         BpMdXbhifJ49eLJ2YqwkrXW8raQi7PyoteE85/ETpyHt+XzvKzs9weKtgdOWNpjtVQgc
         jzV+YWyjNmr9N7ksrEMCPxAOcVA0YzaKJhdNjGDXI1gNDMTAFSdSboA37bdpr+jfE6v4
         fcjA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=iL9sqoXq;
       spf=pass (google.com: domain of ksspiers@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ksspiers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=iL9sqoXq;
       spf=pass (google.com: domain of ksspiers@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ksspiers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/UyXXeEKeRbw7QdAuXx90l04ep/6+KNdjHGoUvThUG0VX5eG1EgSIQfwqtvMBVgIOz+D9ojw==
From: Kyle Spiers <ksspiers@google.com>
To: jack@suse.cz
Cc: arnd@arndb.de,
	dhowells@redhat.com,
	viro@zeniv.linux.org.uk,
	gregkh@linuxfoundation.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	Kyle Spiers <ksspiers@google.com>
Subject: [PATCH v2] isofs compress: Remove VLA usage
Date: Thu,  5 Apr 2018 11:17:20 -0700
Message-Id: <20180405181720.9659-1-ksspiers@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596931173009580849?=
X-GMAIL-MSGID: =?utf-8?q?1596931173009580849?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As part of the effort to remove VLAs from the kernel[1], this changes
the allocation of the bhs and pages arrays from being on the stack to being
kcalloc()ed. This also allows for the removal of the explicit zeroing
of bhs.

https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Kyle Spiers <ksspiers@google.com>
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
