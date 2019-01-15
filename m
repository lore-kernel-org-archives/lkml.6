Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAFDC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC1C20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571736;
	bh=buEUAmcHUIoOV2OSwgvBsZd1RiMfZ2u9EjxWPQOjxnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sw/9gZqYhO2z/BQNiXxmnHNoNxxhb1eVLr/JROCvba8bmKXdhakc9EU8LiE4LGpYq
	 SEug7m5P5393D28GoIp4sUQ2nGKucd4vrSAOulQ+uxnEHKmQmGuzTHwh+awQ2+NO8U
	 NUiMZ2daMWItPXT+R09pUALXoUA2dW3zkncI05Mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfAOQhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:37:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731687AbfAOQgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:36:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 476DE20868;
        Tue, 15 Jan 2019 16:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570213;
        bh=buEUAmcHUIoOV2OSwgvBsZd1RiMfZ2u9EjxWPQOjxnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLhs9SKuBxlVVEu7JSA8o3ofq81THUrkBFjjX67Kt7iA9eIvFJQLBf1kc0zxhDhZu
         6g1SZGBvGCyB2sjtD7Hzxfjd/pUaq5kFRBd2/+pRjn+Gp1CZybQCiy+P0YN1z2LzTw
         mijvVXXQOzXzfdQXU+iE8v8In5P8QOn+XQ5aGC/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 11/51] Btrfs: improve check_node to avoid reading corrupted nodes
Date:   Tue, 15 Jan 2019 17:35:07 +0100
Message-Id: <20190115154848.513112933@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>

commit 6b722c1747d533ac6d4df110dc8233db46918b65 upstream.

We need to check items in a node to make sure that we're reading
a valid one, otherwise we could get various crashes while processing
delayed_refs.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c |   32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -523,9 +523,10 @@ static int check_tree_block_fsid(struct
 }
 
 #define CORRUPT(reason, eb, root, slot)				\
-	btrfs_crit(root->fs_info, "corrupt leaf, %s: block=%llu,"	\
-		   "root=%llu, slot=%d", reason,			\
-	       btrfs_header_bytenr(eb),	root->objectid, slot)
+	btrfs_crit(root->fs_info, "corrupt %s, %s: block=%llu,"	\
+		   " root=%llu, slot=%d",			\
+		   btrfs_header_level(eb) == 0 ? "leaf" : "node",\
+		   reason, btrfs_header_bytenr(eb), root->objectid, slot)
 
 static noinline int check_leaf(struct btrfs_root *root,
 			       struct extent_buffer *leaf)
@@ -616,6 +617,10 @@ static noinline int check_leaf(struct bt
 static int check_node(struct btrfs_root *root, struct extent_buffer *node)
 {
 	unsigned long nr = btrfs_header_nritems(node);
+	struct btrfs_key key, next_key;
+	int slot;
+	u64 bytenr;
+	int ret = 0;
 
 	if (nr == 0 || nr > BTRFS_NODEPTRS_PER_BLOCK(root)) {
 		btrfs_crit(root->fs_info,
@@ -623,7 +628,26 @@ static int check_node(struct btrfs_root
 			   node->start, root->objectid, nr);
 		return -EIO;
 	}
-	return 0;
+
+	for (slot = 0; slot < nr - 1; slot++) {
+		bytenr = btrfs_node_blockptr(node, slot);
+		btrfs_node_key_to_cpu(node, &key, slot);
+		btrfs_node_key_to_cpu(node, &next_key, slot + 1);
+
+		if (!bytenr) {
+			CORRUPT("invalid item slot", node, root, slot);
+			ret = -EIO;
+			goto out;
+		}
+
+		if (btrfs_comp_cpu_keys(&key, &next_key) >= 0) {
+			CORRUPT("bad key order", node, root, slot);
+			ret = -EIO;
+			goto out;
+		}
+	}
+out:
+	return ret;
 }
 
 static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,


