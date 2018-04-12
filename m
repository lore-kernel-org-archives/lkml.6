Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbeDLWBO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 18:01:14 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:45473 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752943AbeDLWBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 18:01:13 -0400
X-Google-Smtp-Source: AIpwx4/KdOnnaazEKXUiJt0MNqZcIqmQBfXFgPl6SfLH0DVPA9ThRPbqUfm1avbeOK1/vhgFUMT2pQ==
Date: Fri, 13 Apr 2018 01:01:09 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: [PATCH] proc: revalidate kernel thread inodes to root:root
Message-ID: <20180412220109.GA20978@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_dump_owner() has the following code:

	mm = task->mm;
	if (mm) {
		if (get_dumpable(mm) != SUID_DUMP_USER) {
			uid = ...
		}
	}

Check for ->mm is buggy -- kernel thread might be borrowing mm
and inode will go to some random uid:gid pair.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1693,6 +1693,12 @@ void task_dump_owner(struct task_struct *task, umode_t mode,
 	kuid_t uid;
 	kgid_t gid;
 
+	if (unlikely(task->flags & PF_KTHREAD)) {
+		*ruid = GLOBAL_ROOT_UID;
+		*rgid = GLOBAL_ROOT_GID;
+		return;
+	}
+
 	/* Default to the tasks effective ownership */
 	rcu_read_lock();
 	cred = __task_cred(task);
