Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162258AbeE1Kgv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161538AbeE1Kgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:36:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 232/329] fs/proc/proc_sysctl.c: fix potential page fault while unregistering sysctl table
Date: Mon, 28 May 2018 12:02:41 +0200
Message-Id: <20180528100301.401236771@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danilo Krummrich <danilokrummrich@dk-develop.de>

[ Upstream commit a0b0d1c345d0317efe594df268feb5ccc99f651e ]

proc_sys_link_fill_cache() does not take currently unregistering sysctl
tables into account, which might result into a page fault in
sysctl_follow_link() - add a check to fix it.

This bug has been present since v3.4.

Link: http://lkml.kernel.org/r/20180228013506.4915-1-danilokrummrich@dk-develop.de
Fixes: 0e47c99d7fe25 ("sysctl: Replace root_list with links between sysctl_table_sets")
Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/proc_sysctl.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -660,7 +660,10 @@ static bool proc_sys_link_fill_cache(str
 				    struct ctl_table *table)
 {
 	bool ret = true;
+
 	head = sysctl_head_grab(head);
+	if (IS_ERR(head))
+		return false;
 
 	if (S_ISLNK(table->mode)) {
 		/* It is not an error if we can not follow the link ignore it */
