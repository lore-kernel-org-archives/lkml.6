Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E75C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279712086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279712086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbeICVoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:44:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbeICVoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:44:02 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 19B29D0A;
        Mon,  3 Sep 2018 17:22:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ethan Lien <ethanlien@synology.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 090/165] btrfs: use correct compare function of dirty_metadata_bytes
Date:   Mon,  3 Sep 2018 18:56:16 +0200
Message-Id: <20180903165700.004639117@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
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

From: Ethan Lien <ethanlien@synology.com>

commit d814a49198eafa6163698bdd93961302f3a877a4 upstream.

We use customized, nodesize batch value to update dirty_metadata_bytes.
We should also use batch version of compare function or we will easily
goto fast path and get false result from percpu_counter_compare().

Fixes: e2d845211eda ("Btrfs: use percpu counter for dirty metadata count")
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Ethan Lien <ethanlien@synology.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/disk-io.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1098,8 +1098,9 @@ static int btree_writepages(struct addre
 
 		fs_info = BTRFS_I(mapping->host)->root->fs_info;
 		/* this is a bit racy, but that's ok */
-		ret = percpu_counter_compare(&fs_info->dirty_metadata_bytes,
-					     BTRFS_DIRTY_METADATA_THRESH);
+		ret = __percpu_counter_compare(&fs_info->dirty_metadata_bytes,
+					     BTRFS_DIRTY_METADATA_THRESH,
+					     fs_info->dirty_metadata_batch);
 		if (ret < 0)
 			return 0;
 	}
@@ -4030,8 +4031,9 @@ static void __btrfs_btree_balance_dirty(
 	if (flush_delayed)
 		btrfs_balance_delayed_items(fs_info);
 
-	ret = percpu_counter_compare(&fs_info->dirty_metadata_bytes,
-				     BTRFS_DIRTY_METADATA_THRESH);
+	ret = __percpu_counter_compare(&fs_info->dirty_metadata_bytes,
+				     BTRFS_DIRTY_METADATA_THRESH,
+				     fs_info->dirty_metadata_batch);
 	if (ret > 0) {
 		balance_dirty_pages_ratelimited(fs_info->btree_inode->i_mapping);
 	}


