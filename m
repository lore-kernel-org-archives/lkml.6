Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeEBW0o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 18:26:44 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:32821 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeEBW0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 18:26:41 -0400
X-Google-Smtp-Source: AB8JxZqKXTG2zXjXD+J1OKGVJwW0EVwrC8k/65rduHiOzMWtgbKGtmo3F6gnNL+kbaoE5e8BY4+LuQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu
Subject: [PATCH] dcache: fix quadratic behavior with parallel shrinkers
Date: Thu,  3 May 2018 00:26:35 +0200
Message-Id: <20180502222635.1862-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple shrinkers are operating on a directory containing many
dentries, it takes much longer than if only one shrinker is operating on
the directory.

Call the shrinker instances A and B, which shrink DIR containing NUM
dentries.

Assume A wins the race for locking DIR's d_lock, then it goes onto moving
all unlinked dentries to its dispose list.  When it's done, then B will
scan the directory once again, but will find that all dentries are already
being shrunk, so it will have an empty dispose list.  Both A and B will
have found NUM dentries (data.found == NUM).

Now comes the interesting part: A will proceed to shrink the dispose list
by killing individual dentries and decrementing the refcount of the parent
(which is DIR).  NB: decrementing DIR's refcount will block if DIR's d_lock
is held.  B will shrink a zero size list and then immediately restart
scanning the directory, where it will lock DIR's d_lock, scan the remaining
dentries and find no dentry to dispose.

So that results in B doing the directory scan over and over again, holding
d_lock of DIR, while A is waiting for a chance to decrement refcount of DIR
and making very slow progress because of this.  B is wasting time and
holding up progress of A at the same time.

Proposed fix is to check this situation in B (found some dentries, but
all are being shrunk already) and just sleep for some time, before retrying
the scan.  The sleep is proportional to the number of found dentries.

Test script:

 --- 8< --- 8< --- 8< --- 8< --- 8< ---
#!/bin/bash

TESTROOT=/var/tmp/test-root
SUBDIR=$TESTROOT/sub/dir

prepare()
{
	rm -rf $TESTROOT
	mkdir -p $SUBDIR

	for (( i = 0; i < 1000; i++ )); do
		for ((j = 0; j < 1000; j++)); do
			if test -e $SUBDIR/$i.$j; then
				echo "This should not happen!"
				exit 1
			fi
		done
		printf "%i (%s) ...\r" $((($i + 1) * $j)) `grep dentry /proc/slabinfo | sed -e "s/dentry *\([0-9]*\).*/\1/"`
	done
}

prepare
printf "\nStarting shrinking\n"
time rmdir $TESTROOT 2> /dev/null

prepare
printf "\nStarting parallel shrinking\n"
time (rmdir $SUBDIR & rmdir $TESTROOT 2> /dev/null & wait)
 --- 8< --- 8< --- 8< --- 8< --- 8< ---

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/dcache.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 60df712262c2..ff250f3843d7 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -30,6 +30,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/delay.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -1479,9 +1480,15 @@ void shrink_dcache_parent(struct dentry *parent)
 			continue;
 		}
 
-		cond_resched();
 		if (!data.found)
 			break;
+
+		/*
+		 * Wait some for other shrinkers to process these found
+		 * dentries.  This formula gives about 100ns on average per
+		 * dentry for large number of dentries.
+		 */
+		usleep_range(data.found / 15 + 1, data.found / 7 + 2);
 	}
 }
 EXPORT_SYMBOL(shrink_dcache_parent);
-- 
2.14.3
