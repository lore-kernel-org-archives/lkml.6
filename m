Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC621C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9F0216F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9F0216F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeHHIv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:51:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:44784 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbeHHIv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:51:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 23:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="61507166"
Received: from shcsbb05.sh.intel.com ([10.239.147.132])
  by fmsmga008.fm.intel.com with ESMTP; 07 Aug 2018 23:33:12 -0700
From:   xiao jin <jin.xiao@intel.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     yanmin.zhang@intel.com, jin.xiao@intel.com
Subject: [PATCH] dm-bufio: adjust the reserved buffer for dm-verify-target.
Date:   Wed,  8 Aug 2018 14:40:57 +0800
Message-Id: <1533710457-6411-1-git-send-email-jin.xiao@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We hit the BUG() report at include/linux/scatterlist.h:144!
The callback is as bellow:
  => verity_work
  => verity_hash_for_block
  => verity_verify_level
  => verity_hash
  => verity_hash_update
  => sg_init_one
  => sg_set_buf

More debug shows the root cause. When creating dufio client it
uses the __vmalloc() to allocate the buffer data for the reserved
dm_buffer. The buffer that allocated by the __vmalloc() is invalid
according to the __virt_addr_valid().

Mostly the reserved dm_buffer is not touched. But occasionally
it might fail to allocate the dm_buffer data when we try to
allocate in the __alloc_buffer_wait_no_callback(). Then it has
to take the reserved dm_buffer for usage. Finally it reports the
BUG() as virt_addr_valid() detects the buffer data address is invalid.

The patch is to adjust the reserved buffer for dm-verity-target. We
allocated two dm_buffers into the reserved buffers list when creating
the buffer interface. The first dm_buffer in the reserved buffer list
is allocated by the __vmalloc(), it's not used after that. The second
dm_buffer in the reserved buffer list is allocated by the
__get_free_pages() which can be consumed after that.

Signed-off-by: xiao jin <jin.xiao@intel.com>
---
 drivers/md/dm-bufio.c         | 4 ++--
 drivers/md/dm-verity-target.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index dc385b7..3b7ca5e 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -841,7 +841,7 @@ static struct dm_buffer *__alloc_buffer_wait_no_callback(struct dm_bufio_client
 			tried_noio_alloc = true;
 		}
 
-		if (!list_empty(&c->reserved_buffers)) {
+		if (!c->need_reserved_buffers) {
 			b = list_entry(c->reserved_buffers.next,
 				       struct dm_buffer, lru_list);
 			list_del(&b->lru_list);
@@ -1701,7 +1701,7 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 		goto bad;
 	}
 
-	while (c->need_reserved_buffers) {
+	if (list_empty(&c->reserved_buffers)) {
 		struct dm_buffer *b = alloc_buffer(c, GFP_KERNEL);
 
 		if (!b) {
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 12decdbd7..40c66fc 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1107,7 +1107,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	v->hash_blocks = hash_position;
 
 	v->bufio = dm_bufio_client_create(v->hash_dev->bdev,
-		1 << v->hash_dev_block_bits, 1, sizeof(struct buffer_aux),
+		1 << v->hash_dev_block_bits, 2, sizeof(struct buffer_aux),
 		dm_bufio_alloc_callback, NULL);
 	if (IS_ERR(v->bufio)) {
 		ti->error = "Cannot initialize dm-bufio";
-- 
2.7.4

