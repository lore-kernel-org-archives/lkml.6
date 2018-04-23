Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932620AbeDWVgg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:36:36 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:41223 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932437AbeDWVgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:36:31 -0400
X-Google-Smtp-Source: AIpwx4+6gueY062UBUGKgkF1wtH2MRYY1MwE5VTyOsSn01diWGYSUCGoLhJU8oidxzNoolOGtUVIWA==
Date: Tue, 24 Apr 2018 00:36:26 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc: smaller RCU section in ->getattr()
Message-ID: <20180423213626.GB9043@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct kstat is thread local.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1787,9 +1787,9 @@ int pid_getattr(const struct path *path, struct kstat *stat,
 
 	generic_fillattr(inode, stat);
 
-	rcu_read_lock();
 	stat->uid = GLOBAL_ROOT_UID;
 	stat->gid = GLOBAL_ROOT_GID;
+	rcu_read_lock();
 	task = pid_task(proc_pid(inode), PIDTYPE_PID);
 	if (task) {
 		if (!has_pid_permissions(pid, task, HIDEPID_INVISIBLE)) {
