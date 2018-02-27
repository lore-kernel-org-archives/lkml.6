Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbeB0XcC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:32:02 -0500
Received: from hs01.dk-develop.de ([213.136.71.231]:35134 "EHLO
        hs01.dk-develop.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbeB0XcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:32:01 -0500
From: Danilo Krummrich <danilokrummrich@dk-develop.de>
To: mcgrof@kernel.org, keescook@chromium.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH v2 1/2] fs/sysctl: fix potential page fault while unregistering sysctl table
Date: Wed, 28 Feb 2018 00:31:55 +0100
Message-Id: <20180227233156.29826-1-danilokrummrich@dk-develop.de>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

proc_sys_link_fill_cache() does not take currently unregistering
sysctl tables into account, which might result into a page fault in
sysctl_follow_link() - add a check to fix it.

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
v2: removed empty line between between sysctl_head_grab and IS_ERR
---
 fs/proc/proc_sysctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c5cbbdff3c3d..82ac5f682b73 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -707,7 +707,10 @@ static bool proc_sys_link_fill_cache(struct file *file,
 				    struct ctl_table *table)
 {
 	bool ret = true;
+
 	head = sysctl_head_grab(head);
+	if (IS_ERR(head))
+		return false;
 
 	if (S_ISLNK(table->mode)) {
 		/* It is not an error if we can not follow the link ignore it */
-- 
2.14.1
