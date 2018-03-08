Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbeCHXyj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:54:39 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35400 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbeCHXyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:54:38 -0500
X-Google-Smtp-Source: AG47ELsMnMfVXqhs0OEpG5YBMr5kpHYRVNy6ZNrlSKwwF/A13IROJTGcCchqrNttJIsvBZtBWVgfZg==
From: David Reynolds <david@omnibond.com>
To: hubcap@omnibond.com, martin@omnibond.com, viro@zeniv.linux.org.uk,
        devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: David Reynolds <david@omnibond.com>
Subject: [PATCH] orangefs: bug fix for a race condition when getting a slot
Date: Thu,  8 Mar 2018 18:54:12 -0500
Message-Id: <20180308235412.12933-1-david@omnibond.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a slot becomes free, call wake_up_locked regardless of the number
of slots available.

Without this patch, wake_up_locked is only called when going from no
free slots to one. This means that there is a chance a waiting task
will not be woken up. In many cases, the system will bounce between 0
and 1 free slots, and the waiting tasks will be woken up. But if there
is still a waiting task and another slot becomes available before the
number of free slots reaches zero, that waiting task may never be woken
up since the number of free slots may never reach zero again.

The bug behavior is easy to reproduce with the following script,
where /mnt/orangefs is an OrangeFS file system.

for i in {1..100}; do
	for j in {1..20}; do
		dd if=/dev/zero of=/mnt/orangefs/tmp$j bs=32768 count=32 &
	done
	wait
done

Signed-off-by: David Reynolds <david@omnibond.com>
Reviewed-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/orangefs-bufmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
index 59f444dced9b..4f927023d095 100644
--- a/fs/orangefs/orangefs-bufmap.c
+++ b/fs/orangefs/orangefs-bufmap.c
@@ -71,9 +71,9 @@ static void put(struct slot_map *m, int slot)
 	spin_lock(&m->q.lock);
 	__clear_bit(slot, m->map);
 	v = ++m->c;
-	if (unlikely(v == 1))	/* no free slots -> one free slot */
+	if (v > 0)
 		wake_up_locked(&m->q);
-	else if (unlikely(v == -1))	/* finished dying */
+	if (unlikely(v == -1))     /* finished dying */
 		wake_up_all_locked(&m->q);
 	spin_unlock(&m->q.lock);
 }
-- 
2.16.2
