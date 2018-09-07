Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38C8C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635DB2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635DB2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeIHCJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:09:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47166 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbeIHCJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:09:49 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BB88EF07;
        Fri,  7 Sep 2018 21:26:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 32/89] dm cache metadata: set dirty on all cache blocks after a crash
Date:   Fri,  7 Sep 2018 23:09:26 +0200
Message-Id: <20180907210856.295184121@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit 5b1fe7bec8a8d0cc547a22e7ddc2bd59acd67de4 upstream.

Quoting Documentation/device-mapper/cache.txt:

  The 'dirty' state for a cache block changes far too frequently for us
  to keep updating it on the fly.  So we treat it as a hint.  In normal
  operation it will be written when the dm device is suspended.  If the
  system crashes all cache blocks will be assumed dirty when restarted.

This got broken in commit f177940a8091 ("dm cache metadata: switch to
using the new cursor api for loading metadata") in 4.9, which removed
the code that consulted cmd->clean_when_opened (CLEAN_SHUTDOWN on-disk
flag) when loading cache blocks.  This results in data corruption on an
unclean shutdown with dirty cache blocks on the fast device.  After the
crash those blocks are considered clean and may get evicted from the
cache at any time.  This can be demonstrated by doing a lot of reads
to trigger individual evictions, but uncache is more predictable:

  ### Disable auto-activation in lvm.conf to be able to do uncache in
  ### time (i.e. see uncache doing flushing) when the fix is applied.

  # xfs_io -d -c 'pwrite -b 4M -S 0xaa 0 1G' /dev/vdb
  # vgcreate vg_cache /dev/vdb /dev/vdc
  # lvcreate -L 1G -n lv_slowdev vg_cache /dev/vdb
  # lvcreate -L 512M -n lv_cachedev vg_cache /dev/vdc
  # lvcreate -L 256M -n lv_metadev vg_cache /dev/vdc
  # lvconvert --type cache-pool --cachemode writeback vg_cache/lv_cachedev --poolmetadata vg_cache/lv_metadev
  # lvconvert --type cache vg_cache/lv_slowdev --cachepool vg_cache/lv_cachedev
  # xfs_io -d -c 'pwrite -b 4M -S 0xbb 0 512M' /dev/mapper/vg_cache-lv_slowdev
  # xfs_io -d -c 'pread -v 254M 512' /dev/mapper/vg_cache-lv_slowdev | head -n 2
  0fe00000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
  0fe00010:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
  # dmsetup status vg_cache-lv_slowdev
  0 2097152 cache 8 27/65536 128 8192/8192 1 100 0 0 0 8192 7065 2 metadata2 writeback 2 migration_threshold 2048 smq 0 rw -
                                                            ^^^^
                                7065 * 64k = 441M yet to be written to the slow device
  # echo b >/proc/sysrq-trigger

  # vgchange -ay vg_cache
  # xfs_io -d -c 'pread -v 254M 512' /dev/mapper/vg_cache-lv_slowdev | head -n 2
  0fe00000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
  0fe00010:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
  # lvconvert --uncache vg_cache/lv_slowdev
  Flushing 0 blocks for cache vg_cache/lv_slowdev.
  Logical volume "lv_cachedev" successfully removed
  Logical volume vg_cache/lv_slowdev is not cached.
  # xfs_io -d -c 'pread -v 254M 512' /dev/mapper/vg_cache-lv_slowdev | head -n 2
  0fe00000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
  0fe00010:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................

This is the case with both v1 and v2 cache pool metatata formats.

After applying this patch:

  # vgchange -ay vg_cache
  # xfs_io -d -c 'pread -v 254M 512' /dev/mapper/vg_cache-lv_slowdev | head -n 2
  0fe00000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
  0fe00010:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
  # lvconvert --uncache vg_cache/lv_slowdev
  Flushing 3724 blocks for cache vg_cache/lv_slowdev.
  ...
  Flushing 71 blocks for cache vg_cache/lv_slowdev.
  Logical volume "lv_cachedev" successfully removed
  Logical volume vg_cache/lv_slowdev is not cached.
  # xfs_io -d -c 'pread -v 254M 512' /dev/mapper/vg_cache-lv_slowdev | head -n 2
  0fe00000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
  0fe00010:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................

Cc: stable@vger.kernel.org
Fixes: f177940a8091 ("dm cache metadata: switch to using the new cursor api for loading metadata")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-cache-metadata.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -1322,6 +1322,7 @@ static int __load_mapping_v1(struct dm_c
 
 	dm_oblock_t oblock;
 	unsigned flags;
+	bool dirty = true;
 
 	dm_array_cursor_get_value(mapping_cursor, (void **) &mapping_value_le);
 	memcpy(&mapping, mapping_value_le, sizeof(mapping));
@@ -1332,8 +1333,10 @@ static int __load_mapping_v1(struct dm_c
 			dm_array_cursor_get_value(hint_cursor, (void **) &hint_value_le);
 			memcpy(&hint, hint_value_le, sizeof(hint));
 		}
+		if (cmd->clean_when_opened)
+			dirty = flags & M_DIRTY;
 
-		r = fn(context, oblock, to_cblock(cb), flags & M_DIRTY,
+		r = fn(context, oblock, to_cblock(cb), dirty,
 		       le32_to_cpu(hint), hints_valid);
 		if (r) {
 			DMERR("policy couldn't load cache block %llu",
@@ -1361,7 +1364,7 @@ static int __load_mapping_v2(struct dm_c
 
 	dm_oblock_t oblock;
 	unsigned flags;
-	bool dirty;
+	bool dirty = true;
 
 	dm_array_cursor_get_value(mapping_cursor, (void **) &mapping_value_le);
 	memcpy(&mapping, mapping_value_le, sizeof(mapping));
@@ -1372,8 +1375,9 @@ static int __load_mapping_v2(struct dm_c
 			dm_array_cursor_get_value(hint_cursor, (void **) &hint_value_le);
 			memcpy(&hint, hint_value_le, sizeof(hint));
 		}
+		if (cmd->clean_when_opened)
+			dirty = dm_bitset_cursor_get_value(dirty_cursor);
 
-		dirty = dm_bitset_cursor_get_value(dirty_cursor);
 		r = fn(context, oblock, to_cblock(cb), dirty,
 		       le32_to_cpu(hint), hints_valid);
 		if (r) {


