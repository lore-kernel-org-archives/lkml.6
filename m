Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0572DC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FF8216FD
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl4sH0ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FF8216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbeKLISr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733142AbeKLISq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:46 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A30B121582;
        Sun, 11 Nov 2018 22:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975329;
        bh=7HmDRDomSlsZaQm9+bwr4Jr0skygfogHoghTtHvXttg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cl4sH0ez+/fUVJK5A4Zmovx2c65oSOM59ysQr0TJR4AQ4SjzpFJ6kxmVPoZxJ3L/X
         yZm7FUw02FgKNTEamfgIO4J0VI28g2t/Lc8hAPhOaTmPI3hm79aHjGh+lMZTBdqQKE
         ZYeG0r1Ubh0SMuhzP8n7+bkCu0M2mZFQQLggu0w8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 341/361] btrfs: make sure we create all new block groups
Date:   Sun, 11 Nov 2018 14:21:28 -0800
Message-Id: <20181111221700.742041688@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

commit 545e3366db823dc3342ca9d7fea803f829c9062f upstream.

Allocating new chunks modifies both the extent and chunk tree, which can
trigger new chunk allocations.  So instead of doing list_for_each_safe,
just do while (!list_empty()) so we make sure we don't exit with other
pending bg's still on our list.

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -10094,7 +10094,7 @@ error:
 void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_block_group_cache *block_group, *tmp;
+	struct btrfs_block_group_cache *block_group;
 	struct btrfs_root *extent_root = fs_info->extent_root;
 	struct btrfs_block_group_item item;
 	struct btrfs_key key;
@@ -10102,7 +10102,10 @@ void btrfs_create_pending_block_groups(s
 	bool can_flush_pending_bgs = trans->can_flush_pending_bgs;
 
 	trans->can_flush_pending_bgs = false;
-	list_for_each_entry_safe(block_group, tmp, &trans->new_bgs, bg_list) {
+	while (!list_empty(&trans->new_bgs)) {
+		block_group = list_first_entry(&trans->new_bgs,
+					       struct btrfs_block_group_cache,
+					       bg_list);
 		if (ret)
 			goto next;
 


