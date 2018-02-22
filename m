Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeBVVFB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:05:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34935 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBVVFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:05:00 -0500
Date: Thu, 22 Feb 2018 13:04:40 -0800
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-04148187aa9df3626168f7429d2287997787e387@git.kernel.org>
Cc: yang.shi@linux.alibaba.com, longman@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        arnd@arndb.de, tglx@linutronix.de
Reply-To: yang.shi@linux.alibaba.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com, arnd@arndb.de,
        tglx@linutronix.de
In-Reply-To: <20180222155335.1647466-1-arnd@arndb.de>
References: <20180222155335.1647466-1-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/debugobjects] debugobjects: Fix debug_objects_freed
 accounting
Git-Commit-ID: 04148187aa9df3626168f7429d2287997787e387
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  04148187aa9df3626168f7429d2287997787e387
Gitweb:     https://git.kernel.org/tip/04148187aa9df3626168f7429d2287997787e387
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Thu, 22 Feb 2018 16:52:58 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 22 Feb 2018 22:00:24 +0100

debugobjects: Fix debug_objects_freed accounting

The removal of the batched object freeing has caused the debug_objects_freed
to become read-only, and the reading is inside an ifdef, so gcc warns that it
is completely unused without CONFIG_DEBUG_FS:

lib/debugobjects.c:71:14: error: 'debug_objects_freed' defined but not used [-Werror=unused-variable]

Assuming we are still interested in this number, this adds back code to
keep track of the freed objects.

Fixes: 636e1970fd7d ("debugobjects: Use global free list in free_object()")
Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Yang Shi <yang.shi@linux.alibaba.com>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lkml.kernel.org/r/20180222155335.1647466-1-arnd@arndb.de

---
 lib/debugobjects.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index faab2c4..105ecfc 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -233,6 +233,7 @@ static void free_obj_work(struct work_struct *work)
 	 */
 	if (obj_nr_tofree) {
 		hlist_move_list(&obj_to_free, &tofree);
+		debug_objects_freed += obj_nr_tofree;
 		obj_nr_tofree = 0;
 	}
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
