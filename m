Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674E9C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0DF2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbeLOPCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:02:18 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:45922 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbeLOPCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:02:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 2AD2018198DC4;
        Sat, 15 Dec 2018 16:02:15 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hsiangkao@mail.ru, kirill.shutemov@linux.intel.com,
        Richard Weinberger <richard@nod.at>, stable@vger.kernel.org,
        zhangjun <openzhangj@gmail.com>
Subject: [PATCH] ubifs: Get/put page when changing PG_private
Date:   Sat, 15 Dec 2018 16:01:30 +0100
Message-Id: <20181215150130.19381-1-richard@nod.at>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page migration code assumes that a page with PG_private
set has its page count elevated by 1.
UBIFS never did this and therefore the migration code was unable
to migrate some pages owned by UBIFS.
The lead to situations where the CMA memory allocator failed to
allocate memory.

Fix this by using get/put_page when changing PG_private.

Cc: <stable@vger.kernel.org>
Cc: zhangjun <openzhangj@gmail.com>
Fixes: 4ac1c17b2044 ("UBIFS: Implement ->migratepage()")
Reported-by: zhangjun <openzhangj@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
zhangjun,

Please give this patch a try!

Thanks,
//richard
---
 fs/ubifs/file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 1b78f2e09218..abe940d0767c 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -582,6 +582,7 @@ static int ubifs_write_end(struct file *file, struct =
address_space *mapping,
 	}
=20
 	if (!PagePrivate(page)) {
+		get_page(page);
 		SetPagePrivate(page);
 		atomic_long_inc(&c->dirty_pg_cnt);
 		__set_page_dirty_nobuffers(page);
@@ -959,6 +960,7 @@ static int do_writepage(struct page *page, int len)
 	atomic_long_dec(&c->dirty_pg_cnt);
 	ClearPagePrivate(page);
 	ClearPageChecked(page);
+	put_page(page);
=20
 	kunmap(page);
 	unlock_page(page);
@@ -1318,6 +1320,7 @@ static void ubifs_invalidatepage(struct page *page,=
 unsigned int offset,
 	atomic_long_dec(&c->dirty_pg_cnt);
 	ClearPagePrivate(page);
 	ClearPageChecked(page);
+	put_page(page);
 }
=20
 int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasyn=
c)
@@ -1487,6 +1490,8 @@ static int ubifs_migrate_page(struct address_space =
*mapping,
=20
 	if (PagePrivate(page)) {
 		ClearPagePrivate(page);
+		put_page(page);
+		get_page(newpage);
 		SetPagePrivate(newpage);
 	}
=20
@@ -1513,6 +1518,7 @@ static int ubifs_releasepage(struct page *page, gfp=
_t unused_gfp_flags)
 	ubifs_assert(c, 0);
 	ClearPagePrivate(page);
 	ClearPageChecked(page);
+	put_page(page);
 	return 1;
 }
=20
@@ -1582,6 +1588,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_f=
ault *vmf)
 	else {
 		if (!PageChecked(page))
 			ubifs_convert_page_budget(c);
+		get_page(page);
 		SetPagePrivate(page);
 		atomic_long_inc(&c->dirty_pg_cnt);
 		__set_page_dirty_nobuffers(page);
--=20
2.20.0

