Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479CBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8542147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8542147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbeHWMBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:01:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48214 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731232AbeHWMBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:01:19 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B8107C74;
        Thu, 23 Aug 2018 08:32:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 188/217] btrfs: scrub: Dont use inode page cache in scrub_handle_errored_block()
Date:   Thu, 23 Aug 2018 09:55:01 +0200
Message-Id: <20180823075514.088107785@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
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

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 665d4953cde6d9e75c62a07ec8f4f8fd7d396ade ]

In commit ac0b4145d662 ("btrfs: scrub: Don't use inode pages for device
replace") we removed the branch of copy_nocow_pages() to avoid
corruption for compressed nodatasum extents.

However above commit only solves the problem in scrub_extent(), if
during scrub_pages() we failed to read some pages,
sctx->no_io_error_seen will be non-zero and we go to fixup function
scrub_handle_errored_block().

In scrub_handle_errored_block(), for sctx without csum (no matter if
we're doing replace or scrub) we go to scrub_fixup_nodatasum() routine,
which does the similar thing with copy_nocow_pages(), but does it
without the extra check in copy_nocow_pages() routine.

So for test cases like btrfs/100, where we emulate read errors during
replace/scrub, we could corrupt compressed extent data again.

This patch will fix it just by avoiding any "optimization" for
nodatasum, just falls back to the normal fixup routine by try read from
any good copy.

This also solves WARN_ON() or dead lock caused by lame backref iteration
in scrub_fixup_nodatasum() routine.

The deadlock or WARN_ON() won't be triggered before commit ac0b4145d662
("btrfs: scrub: Don't use inode pages for device replace") since
copy_nocow_pages() have better locking and extra check for data extent,
and it's already doing the fixup work by try to read data from any good
copy, so it won't go scrub_fixup_nodatasum() anyway.

This patch disables the faulty code and will be removed completely in a
followup patch.

Fixes: ac0b4145d662 ("btrfs: scrub: Don't use inode pages for device replace")
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/scrub.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1166,11 +1166,6 @@ static int scrub_handle_errored_block(st
 		return ret;
 	}
 
-	if (sctx->is_dev_replace && !is_metadata && !have_csum) {
-		sblocks_for_recheck = NULL;
-		goto nodatasum_case;
-	}
-
 	/*
 	 * read all mirrors one after the other. This includes to
 	 * re-read the extent or metadata block that failed (that was
@@ -1283,13 +1278,19 @@ static int scrub_handle_errored_block(st
 		goto out;
 	}
 
-	if (!is_metadata && !have_csum) {
+	/*
+	 * NOTE: Even for nodatasum case, it's still possible that it's a
+	 * compressed data extent, thus scrub_fixup_nodatasum(), which write
+	 * inode page cache onto disk, could cause serious data corruption.
+	 *
+	 * So here we could only read from disk, and hope our recovery could
+	 * reach disk before the newer write.
+	 */
+	if (0 && !is_metadata && !have_csum) {
 		struct scrub_fixup_nodatasum *fixup_nodatasum;
 
 		WARN_ON(sctx->is_dev_replace);
 
-nodatasum_case:
-
 		/*
 		 * !is_metadata and !have_csum, this means that the data
 		 * might not be COWed, that it might be modified


