Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeCWTsI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:48:08 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:44029 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752122AbeCWTr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:47:56 -0400
X-Google-Smtp-Source: AG47ELvM8OSlq08S/gxmHqERSPGirbxq0vFA5fNhgKtYJPKvmU/1g4W4/DKduPRMrDcidms0hDKQdA==
Date: Fri, 23 Mar 2018 12:47:53 -0700
From: Tejun Heo <tj@kernel.org>
To: Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH cgroup/for-4.17 2/2] Subject: cgroup: Limit event generation
 frequency
Message-ID: <20180323194753.GF2149215@devbig577.frc2.facebook.com>
References: <20180323194722.GE2149215@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323194722.GE2149215@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

".events" files generate file modified event to notify userland of
possible new events.  Some of the events can be quite bursty
(e.g. memory high event) and generating notification each time is
costly and pointless.

This patch implements a event rate limit mechanism.  If a new
notification is requested before 10ms has passed since the previous
notification, the new notification is delayed till then.

As this only delays from the second notification on in a given close
cluster of notifications, userland reactions to notifications
shouldn't be delayed at all in most cases while avoiding notification
storms.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup-defs.h |    2 ++
 kernel/cgroup/cgroup.c      |   25 +++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -105,6 +105,8 @@ enum {
 struct cgroup_file {
 	/* do not access any fields from outside cgroup core */
 	struct kernfs_node *kn;
+	unsigned long notified_at;
+	struct timer_list notify_timer;
 };
 
 /*
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -61,6 +61,8 @@
 
 #define CGROUP_FILE_NAME_MAX		(MAX_CGROUP_TYPE_NAMELEN +	\
 					 MAX_CFTYPE_NAME + 2)
+/* let's not notify more than 100 times per second */
+#define CGROUP_FILE_NOTIFY_MIN_INTV	DIV_ROUND_UP(HZ, 100)
 
 /*
  * cgroup_mutex is the master lock.  Any modification to cgroup or its
@@ -1554,6 +1556,8 @@ static void cgroup_rm_file(struct cgroup
 		spin_lock_irq(&cgroup_file_kn_lock);
 		cfile->kn = NULL;
 		spin_unlock_irq(&cgroup_file_kn_lock);
+
+		del_timer_sync(&cfile->notify_timer);
 	}
 
 	kernfs_remove_by_name(cgrp->kn, cgroup_file_name(cgrp, cft, name));
@@ -3532,6 +3536,12 @@ static int cgroup_kn_set_ugid(struct ker
 	return kernfs_setattr(kn, &iattr);
 }
 
+static void cgroup_file_notify_timer(struct timer_list *timer)
+{
+	cgroup_file_notify(container_of(timer, struct cgroup_file,
+					notify_timer));
+}
+
 static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 			   struct cftype *cft)
 {
@@ -3558,6 +3568,8 @@ static int cgroup_add_file(struct cgroup
 	if (cft->file_offset) {
 		struct cgroup_file *cfile = (void *)css + cft->file_offset;
 
+		timer_setup(&cfile->notify_timer, cgroup_file_notify_timer, 0);
+
 		spin_lock_irq(&cgroup_file_kn_lock);
 		cfile->kn = kn;
 		spin_unlock_irq(&cgroup_file_kn_lock);
@@ -3807,8 +3819,17 @@ void cgroup_file_notify(struct cgroup_fi
 	unsigned long flags;
 
 	spin_lock_irqsave(&cgroup_file_kn_lock, flags);
-	if (cfile->kn)
-		kernfs_notify(cfile->kn);
+	if (cfile->kn) {
+		unsigned long last = cfile->notified_at;
+		unsigned long next = last + CGROUP_FILE_NOTIFY_MIN_INTV;
+
+		if (time_in_range(jiffies, last, next)) {
+			timer_reduce(&cfile->notify_timer, next);
+		} else {
+			kernfs_notify(cfile->kn);
+			cfile->notified_at = jiffies;
+		}
+	}
 	spin_unlock_irqrestore(&cgroup_file_kn_lock, flags);
 }
 
