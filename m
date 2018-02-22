Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933123AbeBVP4u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:56:50 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:47953 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932952AbeBVP4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:56:49 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
Cc: Arnd Bergmann <arnd@arndb.de>, Mikulas Patocka <mpatocka@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Aliaksei Karaliou <akaraliou.dev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] dm-bufio: avoid false-positive Wmaybe-uninitialized warning
Date: Thu, 22 Feb 2018 16:56:16 +0100
Message-Id: <20180222155627.1800948-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:OloavdFxcc0SYV1ReVWVno8oZIFbD7y8LyCxKuyHydLQIfmLQI4
 L9cwJ0cbXTP9WtijVZSSO2uU7cfSUqM0GoxWTeur2UcEYZxtIsKm/qos/REOKYEOcNGKrsw
 48A83BtiffY0IdqFUZDYhJU6/NIaIzDE118kw8EmGCUStoqu0Jwy0OOaBg9IlBNw4xpRjLz
 MsKnr82cKCWTJwUP13qzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xH7tW0HxGGg=:n9rNIC1u0j723GrHXnPUBa
 Q8FfwrbevYrLPXSfGfx/WI1gVBfc1qQJRR48o0E8f5hDvDs3zPFKc1vy5dehHPcvXeWRMIeXn
 4c3h/+SyWfzhvXABrOt3l51PDR4+MmNrJ5VyFRSGeKDrmTgiTllhvLBtQcUWa73j+VIGJSc7N
 MhpsHtgKLyeyDEHeR+bfNllla3hxIyyVayh9CznHg1CuJSzhIS9gsXt78ALeBealMHSmH7z7q
 1Kb5fMt1vqumI7P+Bs+uYQu0JofUwslDrJIYzR0/+rqGASUYxzBVhr5c1OkeACCZIr838Q9wU
 883ZMc/wK93xX542LRXdNTuVvikUN2s9e3EIFUvhcJ7PhP42jbiQirXryBxmcLM0BVuFz5gzF
 PKoceCAvMTggpEpJvl2tRlIJIugajDst46IDWWVV6akPzJ79HQ5K/+g6YQEblta7WLpJPBTW+
 I028d1zHLy3TqqPd/5KNCPJzc8zre9krQ9XxZEGmsqZWtx4Fi4zC84PNhRcAHTWe4rV8bcvHu
 /IvR1Is849PotBryd49t3xRYX0PRprBsQlx7rg7FV0SkSTCICIkzqo0adexKobSmKCstgXtsZ
 feaHx2PIXRdYnWqCkUuS7PgCVq1MIvHCA3vGeMm8KTVdRno74Pm9HAVFvMx+CnVcgagY/ZfvB
 YmLmrSB9ghcUpty0DM0HFx62vVm5o0ol/RglxJrxRfVImxWKgFHRCxQWo91Z3J74++kau7b7C
 zxWGy/6Ld4caEMOIOFWfpSM00wq/l4dgZpkKHw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-6.3 and earlier show a new warning after a seemingly unrelated change
to the arm64 PAGE_KERNEL definition:

In file included from drivers/md/dm-bufio.c:14:0:
drivers/md/dm-bufio.c: In function 'alloc_buffer':
include/linux/sched/mm.h:182:56: warning: 'noio_flag' may be used uninitialized in this function [-Wmaybe-uninitialized]
  current->flags = (current->flags & ~PF_MEMALLOC_NOIO) | flags;
                                                        ^

The same warning happened earlier on linux-3.18 for MIPS and I did a
workaround for that, but now it's come back.

gcc-7 and newer are apparently smart enough to figure this out, and
other architectures don't show it, so the best I could come up with is
to rework the caller slightly in a way that makes it obvious enough to
all arm64 compilers what is happening here.

Fixes: 41acec624087 ("arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()")
Link: https://patchwork.kernel.org/patch/9692829/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/md/dm-bufio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 414c9af54ded..e7ad6fc6a5ea 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -413,13 +413,13 @@ static void *alloc_buffer_data(struct dm_bufio_client *c, gfp_t gfp_mask,
 	 * as if GFP_NOIO was specified.
 	 */
 
-	if (gfp_mask & __GFP_NORETRY)
+	if (gfp_mask & __GFP_NORETRY) {
 		noio_flag = memalloc_noio_save();
-
-	ptr = __vmalloc(c->block_size, gfp_mask, PAGE_KERNEL);
-
-	if (gfp_mask & __GFP_NORETRY)
+		ptr = __vmalloc(c->block_size, gfp_mask, PAGE_KERNEL);
 		memalloc_noio_restore(noio_flag);
+	} else {
+		ptr = __vmalloc(c->block_size, gfp_mask, PAGE_KERNEL);
+	}
 
 	return ptr;
 }
-- 
2.9.0
