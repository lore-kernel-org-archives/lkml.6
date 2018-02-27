Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeB0WuE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:50:04 -0500
Received: from hs01.dk-develop.de ([213.136.71.231]:41808 "EHLO
        hs01.dk-develop.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeB0WuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:50:02 -0500
From: Danilo Krummrich <danilokrummrich@dk-develop.de>
To: mcgrof@kernel.org, keescook@chromium.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH 2/2] fs/sysctl: remove redundant link check in proc_sys_link_fill_cache()
Date: Tue, 27 Feb 2018 23:43:58 +0100
Message-Id: <20180227224358.12672-2-danilokrummrich@dk-develop.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180227224358.12672-1-danilokrummrich@dk-develop.de>
References: <20180227224358.12672-1-danilokrummrich@dk-develop.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

proc_sys_link_fill_cache() does not need to check whether we're
called for a link - it's already done by scan().

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
 fs/proc/proc_sysctl.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index a0b6c647835e..7e7d9facb842 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -707,17 +707,16 @@ static bool proc_sys_link_fill_cache(struct file *file,
 				    struct ctl_table *table)
 {
 	bool ret = true;
+	int err = 0;
 	head = sysctl_head_grab(head);
 
 	if (IS_ERR(head))
 		return false;
 
-	if (S_ISLNK(table->mode)) {
-		/* It is not an error if we can not follow the link ignore it */
-		int err = sysctl_follow_link(&head, &table);
-		if (err)
-			goto out;
-	}
+	/* It is not an error if we can not follow the link ignore it */
+	sysctl_follow_link(&head, &table);
+	if (err)
+		goto out;
 
 	ret = proc_sys_fill_cache(file, ctx, head, table);
 out:
-- 
2.14.1
