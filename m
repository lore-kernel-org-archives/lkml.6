Return-Path: <ksspiers@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523404957; cv=none;
        d=google.com; s=arc-20160816;
        b=p862WK3DyE79SRS6k2js8mc6ml+eQdbxhrS0IQoZuTK2eLfmVsiM6IOghFKL6uzaYE
         jCbQC4NG7jE8SUbMPS8fc/FzOG0ojb0EVQAV6kcwZZY+PPmUGd1ha46ieWoiA7em1C9f
         dBjkYimfhvTiRDxJ24iI1OBD359Y1yBP0u06/MrCmP6yCeqeADpTBSqHtuxmPK12g0z3
         b0kT0Z75BKQy8DxMCbpvMMtoQiQEn4UuNtSFk4zSh1NZmft5ZI2VQnyvYBdOzrba+tk7
         mnKMhAo2/OIrOKSdalVq5K9WPq8Q9PRXelll4KshBoYuHMBFVhM7P/ipAzoinoox/IhH
         c89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=v0lAgVF8zc6YW6n708O/bRUxPPPMHNCEduqqLYXQbaE=;
        b=1F6Nl77mD1Vq12kZhf+b+EnjZLVP6QbSuErzJgEMUMwYmSD34vGHiqto5mrWzACfav
         2DNCQ7WFD1AsaTHlkAmNNnnNl2TpVlYdJSSikAp4Hifg3xL24hyPSAIo3O0jnhpNSUpw
         QNAKQSVd+bHi9z4MBxZ7rygWDKban83WokBD5kNlQcc/6gM3bd3mGt5WEPrRtiURALWs
         NPugVfZynRTsngzrSwmUNEGM/ksIUKfNmbecVwKG0PJH1Ps14FoNRhgNpJG3a9UK4KYW
         xtO9IBpyu5uME2rOhqE2t1SiO9eZGnP1hoIGM2ulVul+7grTbQKcNVpErDfIQPVUeUhL
         kCIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=QFafHn2f;
       spf=pass (google.com: domain of ksspiers@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ksspiers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=QFafHn2f;
       spf=pass (google.com: domain of ksspiers@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ksspiers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx49lRfy4OX0GmEZL6Rqj9bEFkMQz7WsR+rCP3L8fTlj5RUyXMGcqwpU+zLJ6sQotvwK5NBc8+Q==
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
Subject: [PATCH v4] isofs compress: Remove VLA usage
Date: Tue, 10 Apr 2018 17:02:29 -0700
Message-Id: <20180411000229.188137-1-ksspiers@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597404821961766971?=
X-GMAIL-MSGID: =?utf-8?q?1597405876326097543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As part of the effort to remove VLAs from the kernel[1], this changes
the allocation of the bhs and pages arrays from being on the stack to being
kcalloc()ed. This also allows for the removal of the explicit zeroing
of bhs.

https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Kyle Spiers <ksspiers@google.com>
---
Fix sparc64 build
Fix Error recovery Mistakes
---
 fs/isofs/compress.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index 9bb2fe35799d..10205ececc27 100644
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
@@ -80,7 +81,11 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 
 	/* Because zlib is not thread-safe, do all the I/O at the top. */
 	blocknum = block_start >> bufshift;
-	memset(bhs, 0, (needblocks + 1) * sizeof(struct buffer_head *));
+	bhs = kcalloc(needblocks + 1, sizeof(*bhs), GFP_KERNEL);
+	if (!bhs) {
+		*errp = -ENOMEM;
+		return 0;
+	}
 	haveblocks = isofs_get_blocks(inode, blocknum, bhs, needblocks);
 	ll_rw_block(REQ_OP_READ, 0, haveblocks, bhs);
 
@@ -190,6 +195,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 b_eio:
 	for (i = 0; i < haveblocks; i++)
 		brelse(bhs[i]);
+	kfree(bhs);
 	return stream.total_out;
 }
 
@@ -305,7 +311,7 @@ static int zisofs_readpage(struct file *file, struct page *page)
 	unsigned int zisofs_pages_per_cblock =
 		PAGE_SHIFT <= zisofs_block_shift ?
 		(1 << (zisofs_block_shift - PAGE_SHIFT)) : 0;
-	struct page *pages[max_t(unsigned, zisofs_pages_per_cblock, 1)];
+	struct page **pages;
 	pgoff_t index = page->index, end_index;
 
 	end_index = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -330,6 +336,12 @@ static int zisofs_readpage(struct file *file, struct page *page)
 		full_page = 0;
 		pcount = 1;
 	}
+	pages = kcalloc(max_t(unsigned int, zisofs_pages_per_cblock, 1),
+					sizeof(*pages), GFP_KERNEL);
+	if (!pages) {
+		unlock_page(page);
+		return -ENOMEM;
+	}
 	pages[full_page] = page;
 
 	for (i = 0; i < pcount; i++, index++) {
@@ -357,6 +369,7 @@ static int zisofs_readpage(struct file *file, struct page *page)
 	}			
 
 	/* At this point, err contains 0 or -EIO depending on the "critical" page */
+	kfree(pages);
 	return err;
 }
 
-- 
2.17.0.484.g0c8726318c-goog
