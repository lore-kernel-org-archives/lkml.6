Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6415DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F4C20868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570347;
	bh=K7gq89knlN/Z5s3uKyjWI9Sicny7mpxnvOGJvjleiKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J3C/LWhOuvXHTOu3PNNX/qGKWz3Pi+pz2W0tAkogP1r/S4cxQyuMswlaowDC+8Bc8
	 xnj0gr7eb/4gzYKNvlaqEHT/ZBNdCM8t8QctvZX2pNZmuNZUlhH044DZiSS7c16q0R
	 GxWR760tIs8QjKzYbKwHVvGx0PYAm/eZD2MydlEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbfAOQjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:39:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732225AbfAOQi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:38:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA2320868;
        Tue, 15 Jan 2019 16:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570338;
        bh=K7gq89knlN/Z5s3uKyjWI9Sicny7mpxnvOGJvjleiKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVOWHjcycrutztP7R+5isL3eOMtrL3T2AjnXVwe4Ec5VAS225IYqE+PHfTiS0r6/W
         dj/ACaxhWU3olzm4hloSfYdOW5q+tMh14bcPyhmL4hDJWVZ5byi4LtQtCEc5GAJ9Cz
         WxxjRBNt/RMrkIt2PqwE2A32o+ZN4an/C0WAa4Q4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 21/51] btrfs: tree-checker: Enhance btrfs_check_node output
Date:   Tue, 15 Jan 2019 17:35:17 +0100
Message-Id: <20190115154849.711667806@linuxfoundation.org>
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

From: Qu Wenruo <quwenruo.btrfs@gmx.com>

commit bba4f29896c986c4cec17bc0f19f2ce644fceae1 upstream.

Use inline function to replace macro since we don't need
stringification.
(Macro still exists until all callers get updated)

And add more info about the error, and replace EIO with EUCLEAN.

For nr_items error, report if it's too large or too small, and output
the valid value range.

For node block pointer, added a new alignment checker.

For key order, also output the next key to make the problem more
obvious.

Signed-off-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
[ wording adjustments, unindented long strings ]
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 4.4:
 - Use root->sectorsize instead of root->fs_info->sectorsize
 - BTRFS_NODEPTRS_PER_BLOCK() takes a root instead of an fs_info, and yields
   a value of type size_t instead of unsigned int]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-checker.c |   68 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 7 deletions(-)

--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -37,6 +37,46 @@
 		   btrfs_header_level(eb) == 0 ? "leaf" : "node",	\
 		   reason, btrfs_header_bytenr(eb), root->objectid, slot)
 
+/*
+ * Error message should follow the following format:
+ * corrupt <type>: <identifier>, <reason>[, <bad_value>]
+ *
+ * @type:	leaf or node
+ * @identifier:	the necessary info to locate the leaf/node.
+ * 		It's recommened to decode key.objecitd/offset if it's
+ * 		meaningful.
+ * @reason:	describe the error
+ * @bad_value:	optional, it's recommened to output bad value and its
+ *		expected value (range).
+ *
+ * Since comma is used to separate the components, only space is allowed
+ * inside each component.
+ */
+
+/*
+ * Append generic "corrupt leaf/node root=%llu block=%llu slot=%d: " to @fmt.
+ * Allows callers to customize the output.
+ */
+__printf(4, 5)
+static void generic_err(const struct btrfs_root *root,
+			const struct extent_buffer *eb, int slot,
+			const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	btrfs_crit(root->fs_info,
+		"corrupt %s: root=%llu block=%llu slot=%d, %pV",
+		btrfs_header_level(eb) == 0 ? "leaf" : "node",
+		root->objectid, btrfs_header_bytenr(eb), slot, &vaf);
+	va_end(args);
+}
+
 static int check_extent_data_item(struct btrfs_root *root,
 				  struct extent_buffer *leaf,
 				  struct btrfs_key *key, int slot)
@@ -282,9 +322,11 @@ int btrfs_check_node(struct btrfs_root *
 
 	if (nr == 0 || nr > BTRFS_NODEPTRS_PER_BLOCK(root)) {
 		btrfs_crit(root->fs_info,
-			   "corrupt node: block %llu root %llu nritems %lu",
-			   node->start, root->objectid, nr);
-		return -EIO;
+"corrupt node: root=%llu block=%llu, nritems too %s, have %lu expect range [1,%zu]",
+			   root->objectid, node->start,
+			   nr == 0 ? "small" : "large", nr,
+			   BTRFS_NODEPTRS_PER_BLOCK(root));
+		return -EUCLEAN;
 	}
 
 	for (slot = 0; slot < nr - 1; slot++) {
@@ -293,14 +335,26 @@ int btrfs_check_node(struct btrfs_root *
 		btrfs_node_key_to_cpu(node, &next_key, slot + 1);
 
 		if (!bytenr) {
-			CORRUPT("invalid item slot", node, root, slot);
-			ret = -EIO;
+			generic_err(root, node, slot,
+				"invalid NULL node pointer");
+			ret = -EUCLEAN;
+			goto out;
+		}
+		if (!IS_ALIGNED(bytenr, root->sectorsize)) {
+			generic_err(root, node, slot,
+			"unaligned pointer, have %llu should be aligned to %u",
+				bytenr, root->sectorsize);
+			ret = -EUCLEAN;
 			goto out;
 		}
 
 		if (btrfs_comp_cpu_keys(&key, &next_key) >= 0) {
-			CORRUPT("bad key order", node, root, slot);
-			ret = -EIO;
+			generic_err(root, node, slot,
+	"bad key order, current (%llu %u %llu) next (%llu %u %llu)",
+				key.objectid, key.type, key.offset,
+				next_key.objectid, next_key.type,
+				next_key.offset);
+			ret = -EUCLEAN;
 			goto out;
 		}
 	}


