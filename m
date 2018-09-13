Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAC6C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139DD20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139DD20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbeIMSn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:43:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58886 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeIMSn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:43:58 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DBBD6D10;
        Thu, 13 Sep 2018 13:34:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ethan Lien <ethanlien@synology.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 60/60] btrfs: use correct compare function of dirty_metadata_bytes
Date:   Thu, 13 Sep 2018 15:31:07 +0200
Message-Id: <20180913131748.413719830@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
References: <20180913131745.261413581@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
nb: Rebased on 4.4.y ]
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/disk-io.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1011,8 +1011,9 @@ static int btree_writepages(struct addre
 
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
@@ -3987,8 +3988,9 @@ static void __btrfs_btree_balance_dirty(
 	if (flush_delayed)
 		btrfs_balance_delayed_items(root);
 
-	ret = percpu_counter_compare(&root->fs_info->dirty_metadata_bytes,
-				     BTRFS_DIRTY_METADATA_THRESH);
+	ret = __percpu_counter_compare(&root->fs_info->dirty_metadata_bytes,
+				     BTRFS_DIRTY_METADATA_THRESH,
+				     root->fs_info->dirty_metadata_batch);
 	if (ret > 0) {
 		balance_dirty_pages_ratelimited(
 				   root->fs_info->btree_inode->i_mapping);


