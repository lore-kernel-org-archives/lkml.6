Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAD_ENC_HEADER,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FAFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B661221479
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wnDBgMKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B661221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbeKZVx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:53:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:35828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbeKZVx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:53:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E627B2146F;
        Mon, 26 Nov 2018 11:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230011;
        bh=XpORD2Fpb8e40Tqor5LTIE05BH5MM4vsIfvfP6obS9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wnDBgMKmAsHfr2kjf1alVzY+M6a7XrQLM17pM/9oH+v663htMvrfq/+0+72e0NCl2
         0me8KRVse6g7jtPu3/A3h61m2rg+MC1ZInYq+aYvdM8RbZWwTroHJE6ia2bD+8H7ov
         QbGIc9/InGG32RtlxwU3tuuBiX43O8xyCIzfqBOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "=?UTF-8?q?Ernesto=20A . =20Fern=C3=A1ndez?=" 
        <ernesto.mnd.fernandez@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 08/62] hfsplus: prevent btree data loss on root split
Date:   Mon, 26 Nov 2018 11:50:49 +0100
Message-Id: <20181126105051.630839670@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0a3021d4f5295aa073c7bf5c5e4de60a2e292578 ]

Creating, renaming or deleting a file may cause catalog corruption and
data loss.  This bug is randomly triggered by xfstests generic/027, but
here is a faster reproducer:

  truncate -s 50M fs.iso
  mkfs.hfsplus fs.iso
  mount fs.iso /mnt
  i=100
  while [ $i -le 150 ]; do
    touch /mnt/$i &>/dev/null
    ((++i))
  done
  i=100
  while [ $i -le 150 ]; do
    mv /mnt/$i /mnt/$(perl -e "print $i x82") &>/dev/null
    ((++i))
  done
  umount /mnt
  fsck.hfsplus -n fs.iso

The bug is triggered whenever hfs_brec_update_parent() needs to split the
root node.  The height of the btree is not increased, which leaves the new
node orphaned and its records lost.

Link: http://lkml.kernel.org/r/26d882184fc43043a810114258f45277752186c7.1535682461.git.ernesto.mnd.fernandez@gmail.com
Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/brec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index 808f4d8c859c..d3f36982f685 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -428,6 +428,10 @@ skip:
 	if (new_node) {
 		__be32 cnid;
 
+		if (!new_node->parent) {
+			hfs_btree_inc_height(tree);
+			new_node->parent = tree->root;
+		}
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
 		/* create index key and entry */
 		hfs_bnode_read_key(new_node, fd->search_key, 14);
-- 
2.17.1



