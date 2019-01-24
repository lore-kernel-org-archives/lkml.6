Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418EEC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120A6217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359616;
	bh=ITfGltPSW1MCBXn6Yper8sfocVjpbWbv2zhYkL33lQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zLgu0EqP1JPSkPbGs3baqKZaMYon3sQOa5xyU4tGflwKQfemLPK5Lu1Rzz+IRAXso
	 UHL4HeT4pfdE+5MHgoU3dsLx+gNnLWlot1p1xp8TO9vJiSED/ALoROv+DeNNNwSfV5
	 U6YKcaob7y09S+NSFEkX/qc4eQtLXthoethai75s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbfAXTiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:38:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730445AbfAXTiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:38:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F14E121907;
        Thu, 24 Jan 2019 19:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358683;
        bh=ITfGltPSW1MCBXn6Yper8sfocVjpbWbv2zhYkL33lQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSkzPORroWtRLzr7E+6x+i1eFukhP/MTwN9UfQDYV8VaEPafOTwlyVqW4FmmLVO3b
         S0QssBb52iaPHALtkFW7hT2DwKr2oSgvkKjRmDVWQ6epU0HarIS1eXrSJ4GskoJBOi
         vwvQi1w2o9PuB5/p7AEpVK2I5FU2tk+ZLZsCKkfw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 094/106] iomap: dont search past page end in iomap_is_partially_uptodate
Date:   Thu, 24 Jan 2019 20:20:51 +0100
Message-Id: <20190124190211.970761331@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -488,16 +488,29 @@ done:
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



