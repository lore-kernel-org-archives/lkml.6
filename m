Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2325C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8A52077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="aTvCt94A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfBUT1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:27:14 -0500
Received: from mx.aristanetworks.com ([162.210.129.12]:61629 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbfBUT1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:27:13 -0500
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 0C8021047;
        Thu, 21 Feb 2019 11:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1550777233;
        bh=+YJrL7Kg76u+V0Hkk1Ff3KhGBYzre94Ubcq+0AF92O0=;
        h=Date:To:Subject:From;
        b=aTvCt94APCLccLWRRnclf9hfvt98aLxTaZLM6wJvRDlAbXDXOk072joPTQRyJ2qDB
         ZTX9eln+2+sI/88jBiw/U6vXtC23t5TEenuY3bq6rO5ucwh+faWLdl/ewO9bUB399D
         CAynQhyoMA2CgdSASyF6mTdafUAsiByqOrL+U7xuZinwkruwV7fcgf0c/b7GwgTQw6
         WE5DapKhgxf651hXGx5KNxJVufngWvCG76KfYvvq5VOkCvo1/pq54dVSUQO5VMqIOh
         GpV4ZK3Fn3jPZOcFddNGN1wW/SffIbhvLGBnDMxfylDthyV+NzfWNNtu6fy805BB7f
         ngG0aBTC0cuYg==
Received: from us180.sjc.aristanetworks.com (us180.sjc.aristanetworks.com [172.25.230.4])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 09538104B;
        Thu, 21 Feb 2019 11:27:13 -0800 (PST)
Received: by us180.sjc.aristanetworks.com (Postfix, from userid 10189)
        id E5CD895C343F; Thu, 21 Feb 2019 11:27:12 -0800 (PST)
Date:   Thu, 21 Feb 2019 11:27:12 -0800
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, fruggeri@arista.com
Subject: [PATCH] block: fix inconsistent page index
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20190221192712.E5CD895C343F@us180.sjc.aristanetworks.com>
From:   fruggeri@arista.com (Francesco Ruggeri)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__find_get_block_slow() and grow_buffers() use different methods to compute
a page index for a given block: __find_get_block_slow() computes it from
bd_inode->i_blkbits, while grow_buffers() computes it from the block size
argument.
The two can get out of sync, for example if bd_inode->i_blkbits is modified
while a isofs_fill_super() (in mount) is between sb_min_blocksize() and
sb_read/__bread_gfp/__getblk_gfp/__getblk_slow.
The script below can reproduce such a scenario, resulting in an infinite
loop in __getblk_slow(), as grow_buffers() allocates a page but
__find_get_block() keeps looking for a different one.
This patch changes __find_get_block_slow() to also use the block size.
It implicitly relies on size being a power of 2 in the 256..PAGE_SIZE
range.

FILE=/tmp/fsfile
MNT=/tmp/fsmnt
LOOP=`losetup -f`

rm -rf $FILE $MNT

mkdir $MNT
dd if=/dev/zero of=$FILE count=32 bs=1MiB
losetup $LOOP $FILE
mkfs -t ext4 $LOOP
while true; do losetup -D $LOOP; losetup $LOOP $FILE;done 2>&1 >/dev/null &
for ((i=0; i<100; i++)); do echo ================== $i; \
                            mount $LOOP $MNT; umount $MNT; done

Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
---
 fs/buffer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 48318fb74938..447e8db2ff5f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -190,7 +190,8 @@ EXPORT_SYMBOL(end_buffer_write_sync);
  * succeeds, there is no need to take private_lock.
  */
 static struct buffer_head *
-__find_get_block_slow(struct block_device *bdev, sector_t block)
+__find_get_block_slow(struct block_device *bdev, sector_t block,
+		      unsigned int size)
 {
 	struct inode *bd_inode = bdev->bd_inode;
 	struct address_space *bd_mapping = bd_inode->i_mapping;
@@ -202,7 +203,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	int all_mapped = 1;
 	static DEFINE_RATELIMIT_STATE(last_warned, HZ, 1);
 
-	index = block >> (PAGE_SHIFT - bd_inode->i_blkbits);
+	index = block >> (PAGE_SHIFT - blksize_bits(size));
 	page = find_get_page_flags(bd_mapping, index, FGP_ACCESSED);
 	if (!page)
 		goto out;
@@ -1292,7 +1293,7 @@ __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
 
 	if (bh == NULL) {
 		/* __find_get_block_slow will mark the page accessed */
-		bh = __find_get_block_slow(bdev, block);
+		bh = __find_get_block_slow(bdev, block, size);
 		if (bh)
 			bh_lru_install(bh);
 	} else
-- 
2.19.1

