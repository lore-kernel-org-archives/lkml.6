Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28444C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0A921582
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3qb712p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0A921582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbeKLISw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730142AbeKLISv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:51 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBC32223D1;
        Sun, 11 Nov 2018 22:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975335;
        bh=QtUclkgBP9MKJ3bLwl/+OP+iQqUe3kYDB5zzFpyeKak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3qb712pHvRaV+naeiLB9XWYZFaK/3ws6B/fpLZWGfIRv0aExgDFauggAUi6jGJx3
         bbhJ/4FONMoshSjlUenILcwsqpZrKBdR1tqh9DXOe8XUlAgGidedMYAb6vwLGdHsNo
         C1/J8/lwa0Jvba3qiMayX3WPinv8gSzDYIlohYKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 352/361] btrfs: fix insert_reserved error handling
Date:   Sun, 11 Nov 2018 14:21:39 -0800
Message-Id: <20181111221701.635464174@linuxfoundation.org>
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

commit 80ee54bfe8a3850015585ebc84e8d207fcae6831 upstream.

We were not handling the reserved byte accounting properly for data
references.  Metadata was fine, if it errored out the error paths would
free the bytes_reserved count and pin the extent, but it even missed one
of the error cases.  So instead move this handling up into
run_one_delayed_ref so we are sure that both cases are properly cleaned
up in case of a transaction abort.

CC: stable@vger.kernel.org # 4.18+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2366,6 +2366,9 @@ static int run_one_delayed_ref(struct bt
 					   insert_reserved);
 	else
 		BUG();
+	if (ret && insert_reserved)
+		btrfs_pin_extent(trans->fs_info, node->bytenr,
+				 node->num_bytes, 1);
 	return ret;
 }
 
@@ -7977,21 +7980,14 @@ static int alloc_reserved_tree_block(str
 	}
 
 	path = btrfs_alloc_path();
-	if (!path) {
-		btrfs_free_and_pin_reserved_extent(fs_info,
-						   extent_key.objectid,
-						   fs_info->nodesize);
+	if (!path)
 		return -ENOMEM;
-	}
 
 	path->leave_spinning = 1;
 	ret = btrfs_insert_empty_item(trans, fs_info->extent_root, path,
 				      &extent_key, size);
 	if (ret) {
 		btrfs_free_path(path);
-		btrfs_free_and_pin_reserved_extent(fs_info,
-						   extent_key.objectid,
-						   fs_info->nodesize);
 		return ret;
 	}
 


