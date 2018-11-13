Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B5BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B5222511
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHXVY3YH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B5222511
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbeKMPrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732167AbeKMPrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:47 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE47D22512;
        Tue, 13 Nov 2018 05:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088280;
        bh=l63eWjau8eWSW6KgKNgk6fQ5JbF4gNaOZUie1mahD2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHXVY3YHClHMVQQaGhFKdBw6qtLN8rdxFsjT8i+VCvD8INWJKrTRdq0wKcnKpGM9l
         Rx/+t4k+YARCN585yWzqurU+y/ObxCBmtHMBSlrwn/XeaOwLDWXsvCDnxt9j6LUYo6
         tXRte7O31pKCtZo5z3Ev4iKvoDr3tx+CFZmBZIL8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ernesto=20A=2E=20Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 15/39] hfsplus: prevent btree data loss on root split
Date:   Tue, 13 Nov 2018 00:50:29 -0500
Message-Id: <20181113055053.78352-15-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055053.78352-1-sashal@kernel.org>
References: <20181113055053.78352-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>

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
@@ -428,6 +428,10 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
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

