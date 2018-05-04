Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeEDOm2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:42:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41018 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751573AbeEDOm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:42:26 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, linux-ntfs-dev@lists.sourceforge.net,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anton Altaparmakov <anton@tuxera.com>
Subject: [PATCH] ntfs: don't disable interrupts during kmap_atomic()
Date: Fri,  4 May 2018 16:42:22 +0200
Message-Id: <20180504144222.5443-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ntfs_end_buffer_async_read() disables interrupts around kmap_atomic(). This=
 is
a leftover from the old kmap_atomic() implementation which relied on fixed
mapping slots, so the caller had to make sure that the same slot could not =
be
reused from an interrupting context.

kmap_atomic() was changed to dynamic slots long ago and commit 1ec9c5ddc17a
("include/linux/highmem.h: remove the second argument of k[un]map_atomic()")
removed the slot assignements, but the callers were not checked for now
redundant interrupt disabling.

Remove the conditional interrupt disable.

Cc: Anton Altaparmakov <anton@tuxera.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/ntfs/aops.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 3a2e509c77c5..01c770979921 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -93,13 +93,11 @@ static void ntfs_end_buffer_async_read(struct buffer_he=
ad *bh, int uptodate)
 			ofs =3D 0;
 			if (file_ofs < init_size)
 				ofs =3D init_size - file_ofs;
-			local_irq_save(flags);
 			kaddr =3D kmap_atomic(page);
 			memset(kaddr + bh_offset(bh) + ofs, 0,
 					bh->b_size - ofs);
 			flush_dcache_page(page);
 			kunmap_atomic(kaddr);
-			local_irq_restore(flags);
 		}
 	} else {
 		clear_buffer_uptodate(bh);
@@ -146,13 +144,11 @@ static void ntfs_end_buffer_async_read(struct buffer_=
head *bh, int uptodate)
 		recs =3D PAGE_SIZE / rec_size;
 		/* Should have been verified before we got here... */
 		BUG_ON(!recs);
-		local_irq_save(flags);
 		kaddr =3D kmap_atomic(page);
 		for (i =3D 0; i < recs; i++)
 			post_read_mst_fixup((NTFS_RECORD*)(kaddr +
 					i * rec_size), rec_size);
 		kunmap_atomic(kaddr);
-		local_irq_restore(flags);
 		flush_dcache_page(page);
 		if (likely(page_uptodate && !PageError(page)))
 			SetPageUptodate(page);
--=20
2.17.0
