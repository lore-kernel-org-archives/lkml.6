Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeB0WuD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:50:03 -0500
Received: from hs01.dk-develop.de ([213.136.71.231]:35340 "EHLO
        hs01.dk-develop.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeB0WuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:50:02 -0500
From: Danilo Krummrich <danilokrummrich@dk-develop.de>
To: mcgrof@kernel.org, keescook@chromium.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH 1/2] fs/sysctl: fix potential page fault while unregistering sysctl table
Date: Tue, 27 Feb 2018 23:43:57 +0100
Message-Id: <20180227224358.12672-1-danilokrummrich@dk-develop.de>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

proc_sys_link_fill_cache() does not take currently unregistering
sysctl tables into account, which might result into a page fault in
sysctl_follow_link() - add a check to fix it.

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
 fs/proc/proc_sysctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c5cbbdff3c3d..a0b6c647835e 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -709,6 +709,9 @@ static bool proc_sys_link_fill_cache(struct file *file,
 	bool ret = true;
 	head = sysctl_head_grab(head);
 
+	if (IS_ERR(head))
+		return false;
+
 	if (S_ISLNK(table->mode)) {
 		/* It is not an error if we can not follow the link ignore it */
 		int err = sysctl_follow_link(&head, &table);
-- 
2.14.1
