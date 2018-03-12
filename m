Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeCLGgg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 02:36:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751976AbeCLGgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 02:36:33 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak21 V2 3/4] audit: add refused symlink to audit_names
Date: Mon, 12 Mar 2018 02:31:19 -0400
Message-Id: <ce98e9600a8d7d0169067ae9f3e3a5ae2fb1f54a.1520835596.git.rgb@redhat.com>
In-Reply-To: <cover.1520835596.git.rgb@redhat.com>
References: <cover.1520835596.git.rgb@redhat.com>
In-Reply-To: <cover.1520835596.git.rgb@redhat.com>
References: <cover.1520835596.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audit link denied events for symlinks had duplicate PATH records rather
than just updating the existing PATH record.  Update the symlink's PATH
record with the current dentry and inode information.

See: https://github.com/linux-audit/audit-kernel/issues/21
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/namei.c b/fs/namei.c
index 50d2533..00f5041 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -945,6 +945,7 @@ static inline int may_follow_link(struct nameidata *nd)
 	if (nd->flags & LOOKUP_RCU)
 		return -ECHILD;
 
+	audit_inode(nd->name, nd->stack[0].link.dentry, 0);
 	audit_log_link_denied("follow_link", &nd->stack[0].link);
 	return -EACCES;
 }
-- 
1.8.3.1
