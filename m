Return-Path: <ksspiers@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522884522; cv=none;
        d=google.com; s=arc-20160816;
        b=tGN38y/3HVtvSKWQoTk75N2iROB1QDaOn1oIiLpHGGUHawJ9oWZ3u9Nzu5jUkFPZq5
         0U6iDUfePjyG4mkjg7pBlerLq8vn2Nlbe/la0qN0J1qePAvxs7Qabq/p+VT1HdDHhnCL
         MKIAJvT5FhJgf3bsJ7FMz9Yxw1uJARDU/DzJZTV0T67w1jed52tYsPsl7Hz46qq6eXcf
         mWfdRM55KFeLvAdOHVVYwNmnBDDmoQj4AXiNWbRNZaKTu2SVe0OgYhHqs5Gj0XDywCrJ
         dkbzt9CR0M1/C+a4jSqbv/LyKHekdvJ5g39n4FR8xjuvdIco1ssEZE7rSWyB31c/md6f
         +qdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=mCSPjfj0xN7KLcZCP9M9uL4D2caGbxx0L3NxgSdjti4=;
        b=MCKKkYUTF2snPWO598WG1IcAGTBH507oFeVVq2LoQasvu/95Q0EKz5raQUjOL3h7Lh
         moJm2V4gWU7oz14WkOKc3Ru3uoYdmfPQoetFKMfz5uRGM/AJP9S3indi9cax1o/o4U9m
         55h3qDX6mk4VN0q/4Vj8EsBePrtD8/hsRigzDqmSkaslz1GvzXY4l7YhFlcuTYrPSe1N
         RxOWGKEZvr2QSm/8T0msg1i6vFnnA7P5/xU1n2SGJpef1H2W+Zl3p2WR57PfzigxAMui
         UUFQbiQ9B1ol5p0/HESovdTK5Vo7FF9csiFumt9Bfcaim72dLI+5IE47O1cB8bwwl0B1
         dH8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=gNs7xJrq;
       spf=pass (google.com: domain of ksspiers@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ksspiers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=gNs7xJrq;
       spf=pass (google.com: domain of ksspiers@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ksspiers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/rMcjAhbPOqs2UlIcPuA2fFbsuKxQl0PLql4qmPX2xsZLGjJK+uzcbVKTgYLYnZnh7wg7+4w==
From: Kyle Spiers <ksspiers@google.com>
To: jack@suse.cz
Cc: arnd@arndb.de,
	dhowells@redhat.com,
	viro@zeniv.linux.org.uk,
	gregkh@linuxfoundation.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	Kyle Spiers <ksspiers@google.com>
Subject: [PATCH] isofs compress: Remove VLA usage
Date: Wed,  4 Apr 2018 16:28:19 -0700
Message-Id: <20180404232819.174881-1-ksspiers@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596860161447273240?=
X-GMAIL-MSGID: =?utf-8?q?1596860161447273240?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As part of the effort to remove VLAs from the kernel[1], this changes
the allocation of the bhs and pages arrays from being on the stack to being
kcalloc()ed. This also allows for the removal of the explicit zeroing
of bhs.

https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Kyle Spiers <ksspiers@google.com>
---
 fs/isofs/compress.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index 9bb2fe35799d..39cc99aecff8 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -59,7 +59,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 				>> bufshift;
 	int haveblocks;
 	blkcnt_t blocknum;
-	struct buffer_head *bhs[needblocks + 1];
+	struct buffer_head **bhs;
 	int curbh, curpage;
 
 	if (block_size > deflateBound(1UL << zisofs_block_shift)) {
@@ -80,7 +80,9 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 
 	/* Because zlib is not thread-safe, do all the I/O at the top. */
 	blocknum = block_start >> bufshift;
-	memset(bhs, 0, (needblocks + 1) * sizeof(struct buffer_head *));
+	bhs = kcalloc(needblocks + 1, sizeof(*bhs), GFP_KERNEL);
+	if (!bhs)
+		return -ENOMEM;
 	haveblocks = isofs_get_blocks(inode, blocknum, bhs, needblocks);
 	ll_rw_block(REQ_OP_READ, 0, haveblocks, bhs);
 
@@ -190,6 +192,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 b_eio:
 	for (i = 0; i < haveblocks; i++)
 		brelse(bhs[i]);
+	kfree(bhs);
 	return stream.total_out;
 }
 
@@ -305,7 +308,7 @@ static int zisofs_readpage(struct file *file, struct page *page)
 	unsigned int zisofs_pages_per_cblock =
 		PAGE_SHIFT <= zisofs_block_shift ?
 		(1 << (zisofs_block_shift - PAGE_SHIFT)) : 0;
-	struct page *pages[max_t(unsigned, zisofs_pages_per_cblock, 1)];
+	struct page **pages;
 	pgoff_t index = page->index, end_index;
 
 	end_index = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -330,6 +333,10 @@ static int zisofs_readpage(struct file *file, struct page *page)
 		full_page = 0;
 		pcount = 1;
 	}
+	pages = kcalloc(max_t(unsigned int, zisofs_pages_per_cblock, 1),
+					sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
 	pages[full_page] = page;
 
 	for (i = 0; i < pcount; i++, index++) {
@@ -357,6 +364,7 @@ static int zisofs_readpage(struct file *file, struct page *page)
 	}			
 
 	/* At this point, err contains 0 or -EIO depending on the "critical" page */
+	kfree(pages);
 	return err;
 }
 
-- 
2.17.0.484.g0c8726318c-goog
