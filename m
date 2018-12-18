Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE53C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCFE218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151255;
	bh=7T1tSXXB4hz/K/C1nnFbDfPij8X5uoYpihcGDmvnXfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CQgLrtPx07/HoE3JTxfDNBgQspzXf48SOGBqvY0hEb3SUcv/TuVe8x0zB4y2JvWuV
	 NkeCPLvN4bbP72MlzbSZoGEU+qoawKKejp+bi/ALDuzPqeE9OzvFgTWc0QV8H1X3ZZ
	 +TMUdqsmyrG1yOHIX83mbzcEx+NjKSibZaZH8HDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeLRQky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:40:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeLRQkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB742218A2;
        Tue, 18 Dec 2018 16:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151250;
        bh=7T1tSXXB4hz/K/C1nnFbDfPij8X5uoYpihcGDmvnXfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UauZZBu1QZOytjrIB0CnTYSQ1TujwYEBO/ajwQi6XC/6S5RU+ZjOsbwU50fQJ4oXI
         83fS7Xml8JFa5+/92mbBR17E/YuqejZX63hL5vNgi0+roeabyXDF6C2Qjr5PUvWN9I
         9gnKsna4PtOV5/quqDiF/csv9sus3Kng2IADAyZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        William Kucharski <william.kucharski@oracle.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Brian Foster <bfoster@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 11/44] fs/iomap.c: get/put the page in iomap_page_create/release()
Date:   Tue, 18 Dec 2018 17:39:23 +0100
Message-Id: <20181218163928.831329181@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

From: Piotr Jaroszynski <pjaroszynski@nvidia.com>

commit 61c6de667263184125d5ca75e894fcad632b0dd3 upstream.

migrate_page_move_mapping() expects pages with private data set to have
a page_count elevated by 1.  This is what used to happen for xfs through
the buffer_heads code before the switch to iomap in commit 82cb14175e7d
("xfs: add support for sub-pagesize writeback without buffer_heads").
Not having the count elevated causes move_pages() to fail on memory
mapped files coming from xfs.

Make iomap compatible with the migrate_page_move_mapping() assumption by
elevating the page count as part of iomap_page_create() and lowering it
in iomap_page_release().

It causes the move_pages() syscall to misbehave on memory mapped files
from xfs.  It does not not move any pages, which I suppose is "just" a
perf issue, but it also ends up returning a positive number which is out
of spec for the syscall.  Talking to Michal Hocko, it sounds like
returning positive numbers might be a necessary update to move_pages()
anyway though
(https://lkml.kernel.org/r/20181116114955.GJ14706@dhcp22.suse.cz).

I only hit this in tests that verify that move_pages() actually moved
the pages.  The test also got confused by the positive return from
move_pages() (it got treated as a success as positive numbers were not
expected and not handled) making it a bit harder to track down what's
going on.

Link: http://lkml.kernel.org/r/20181115184140.1388751-1-pjaroszynski@nvidia.com
Fixes: 82cb14175e7d ("xfs: add support for sub-pagesize writeback without buffer_heads")
Signed-off-by: Piotr Jaroszynski <pjaroszynski@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Brian Foster <bfoster@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/iomap.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -117,6 +117,12 @@ iomap_page_create(struct inode *inode, s
 	atomic_set(&iop->read_count, 0);
 	atomic_set(&iop->write_count, 0);
 	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
+
+	/*
+	 * migrate_page_move_mapping() assumes that pages with private data have
+	 * their count elevated by 1.
+	 */
+	get_page(page);
 	set_page_private(page, (unsigned long)iop);
 	SetPagePrivate(page);
 	return iop;
@@ -133,6 +139,7 @@ iomap_page_release(struct page *page)
 	WARN_ON_ONCE(atomic_read(&iop->write_count));
 	ClearPagePrivate(page);
 	set_page_private(page, 0);
+	put_page(page);
 	kfree(iop);
 }
 


