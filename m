Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4DAC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99BF2430D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99BF2430D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934511AbeFXPx5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:53:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33702 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933919AbeFXPxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:53:54 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 21BE849F;
        Sun, 24 Jun 2018 15:53:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Harvey <jamespharvey20@gmail.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 26/39] btrfs: scrub: Dont use inode pages for device replace
Date:   Sun, 24 Jun 2018 23:24:13 +0800
Message-Id: <20180624152354.920967811@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624152352.038950449@linuxfoundation.org>
References: <20180624152352.038950449@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit ac0b4145d662a3b9e34085dea460fb06ede9b69b upstream.

[BUG]
Btrfs can create compressed extent without checksum (even though it
shouldn't), and if we then try to replace device containing such extent,
the result device will contain all the uncompressed data instead of the
compressed one.

Test case already submitted to fstests:
https://patchwork.kernel.org/patch/10442353/

[CAUSE]
When handling compressed extent without checksum, device replace will
goe into copy_nocow_pages() function.

In that function, btrfs will get all inodes referring to this data
extents and then use find_or_create_page() to get pages direct from that
inode.

The problem here is, pages directly from inode are always uncompressed.
And for compressed data extent, they mismatch with on-disk data.
Thus this leads to corrupted compressed data extent written to replace
device.

[FIX]
In this attempt, we could just remove the "optimization" branch, and let
unified scrub_pages() to handle it.

Although scrub_pages() won't bother reusing page cache, it will be a
little slower, but it does the correct csum checking and won't cause
such data corruption caused by "optimization".

Note about the fix: this is the minimal fix that can be backported to
older stable trees without conflicts. The whole callchain from
copy_nocow_pages() can be deleted, and will be in followup patches.

Fixes: ff023aac3119 ("Btrfs: add code to scrub to copy read data to another disk")
CC: stable@vger.kernel.org # 4.4+
Reported-by: James Harvey <jamespharvey20@gmail.com>
Reviewed-by: James Harvey <jamespharvey20@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
[ remove code removal, add note why ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/scrub.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2519,7 +2519,7 @@ static int scrub_extent(struct scrub_ctx
 			have_csum = scrub_find_csum(sctx, logical, csum);
 			if (have_csum == 0)
 				++sctx->stat.no_csum;
-			if (sctx->is_dev_replace && !have_csum) {
+			if (0 && sctx->is_dev_replace && !have_csum) {
 				ret = copy_nocow_pages(sctx, logical, l,
 						       mirror_num,
 						      physical_for_dev_replace);


