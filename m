Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36101C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC28620883
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570216;
	bh=EGfRSHwVVK4JLBnWjWi/pOq5irs3fAZ5FTrbks6GgoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mNKgA8pu9lgmNMSl6W8srocq3AF0GmQIFUyuJ+wb8Hhpr48J/+OPG9Pt9o+PJF9h+
	 SPXKzFB/olIEHmnIphEme8+XXShsqyvif6h+T4mqCZhZM1lwWTjMLNM6QEoIVLKkN/
	 RQlCz07yfi2HBZbfZDfpkWXa3LjJ7CjKgFkpsxMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbfAOQgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731682AbfAOQgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:36:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CAA720675;
        Tue, 15 Jan 2019 16:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570210;
        bh=EGfRSHwVVK4JLBnWjWi/pOq5irs3fAZ5FTrbks6GgoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1WpXvtGHvAZDndTYVBiaolPikdT0Va2lnJLxNc9fEIDD0jnQo6suMdE9hlpuCc1NX
         0/nTUEvOGsgtxRcoSix8sH0EDqdLa7JJzpaZcgaSA1p+ZcJ/jrSegMDJLizGhGKCDF
         M0x0n04SX1/+sXTWfSkwQU2MmDe7Mx77lKCneTMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 10/51] Btrfs: memset to avoid stale content in btree node block
Date:   Tue, 15 Jan 2019 17:35:06 +0100
Message-Id: <20190115154848.410741461@linuxfoundation.org>
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

commit 3eb548ee3a8042d95ad81be254e67a5222c24e03 upstream.

During updating btree, we could push items between sibling
nodes/leaves, for leaves data sections starts reversely from
the end of the block while for nodes we only have key pairs
which are stored one by one from the start of the block.

So we could do try to push key pairs from one node to the next
node right in the tree, and after that, we update the node's
nritems to reflect the correct end while leaving the stale
content in the node.  One may intentionally corrupt the fs
image and access the stale content by bumping the nritems and
causes various crashes.

This takes the in-memory @nritems as the correct one and
gets to memset the unused part of a btree node.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent_io.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3858,6 +3858,17 @@ static noinline_for_stack int write_one_
 	if (btrfs_header_owner(eb) == BTRFS_TREE_LOG_OBJECTID)
 		bio_flags = EXTENT_BIO_TREE_LOG;
 
+	/* set btree node beyond nritems with 0 to avoid stale content */
+	if (btrfs_header_level(eb) > 0) {
+		u32 nritems;
+		unsigned long end;
+
+		nritems = btrfs_header_nritems(eb);
+		end = btrfs_node_key_ptr_offset(nritems);
+
+		memset_extent_buffer(eb, 0, end, eb->len - end);
+	}
+
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
 


