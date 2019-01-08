Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E956CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DBF20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976939;
	bh=f3dwyVhbGFElR54j0Q8C55HiW+LcCO8EmTMDmEFjppA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UH4Thx/DJrml7/1PXIWx7WSYSvrNr4cS3cxG5Vb1KN2T04+uw/uvzfavhZm98AD88
	 KE9LXFpnZ/HdA1Q5rXc1WkgJAaA4JkfAVVTtbZtcbBIoObzcvsis6PfzKsITQCU5ne
	 5svLJ4lXed5gaoNHibpym7krkmZSIGyE4QeBy3p0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732781AbfAHTs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731293AbfAHTcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:32:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3048620827;
        Tue,  8 Jan 2019 19:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975930;
        bh=f3dwyVhbGFElR54j0Q8C55HiW+LcCO8EmTMDmEFjppA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wGg7eoIdBcelYUw1FHKNp9EAPr/WKkDhpSaIdoQ8IiD+yYH65kVpKFG83vKEaibch
         A7T3eR2GPXSmZ7KPQVEDeM7FOJXSWpgfU/2lK9bTQt/KA2upzajPqo4tCkwh5/JnRQ
         0dRLVz4WX9y9Yok0GWWmW+Bi/eKOcLZhKuNcjkM0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 92/97] iomap: don't search past page end in iomap_is_partially_uptodate
Date:   Tue,  8 Jan 2019 14:29:41 -0500
Message-Id: <20190108192949.122407-92-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sandeen <sandeen@redhat.com>

[ Upstream commit 3cc31fa65d85610574c0f6a474e89f4c419923d5 ]

iomap_is_partially_uptodate() is intended to check wither blocks within
the selected range of a not-uptodate page are uptodate; if the range we
care about is up to date, it's an optimization.

However, the iomap implementation continues to check all blocks up to
from+count, which is beyond the page, and can even be well beyond the
iop->uptodate bitmap.

I think the worst that will happen is that we may eventually find a zero
bit and return "not partially uptodate" when it would have otherwise
returned true, and skip the optimization.  Still, it's clearly an invalid
memory access that must be fixed.

So: fix this by limiting the search to within the page as is done in the
non-iomap variant, block_is_partially_uptodate().

Zorro noticed thiswhen KASAN went off for 512 byte blocks on a 64k
page system:

 BUG: KASAN: slab-out-of-bounds in iomap_is_partially_uptodate+0x1a0/0x1e0
 Read of size 8 at addr ffff800120c3a318 by task fsstress/22337

Reported-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index ec15cf2ec696..e57fb1e534c5 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -488,16 +488,29 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
 }
 EXPORT_SYMBOL_GPL(iomap_readpages);
 
+/*
+ * iomap_is_partially_uptodate checks whether blocks within a page are
+ * uptodate or not.
+ *
+ * Returns true if all blocks which correspond to a file portion
+ * we want to read within the page are uptodate.
+ */
 int
 iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count)
 {
 	struct iomap_page *iop = to_iomap_page(page);
 	struct inode *inode = page->mapping->host;
-	unsigned first = from >> inode->i_blkbits;
-	unsigned last = (from + count - 1) >> inode->i_blkbits;
+	unsigned len, first, last;
 	unsigned i;
 
+	/* Limit range to one page */
+	len = min_t(unsigned, PAGE_SIZE - from, count);
+
+	/* First and last blocks in range within page */
+	first = from >> inode->i_blkbits;
+	last = (from + len - 1) >> inode->i_blkbits;
+
 	if (iop) {
 		for (i = first; i <= last; i++)
 			if (!test_bit(i, iop->uptodate))
-- 
2.19.1

