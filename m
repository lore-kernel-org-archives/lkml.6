Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeCUIrw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:47:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751615AbeCUIrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:47:45 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak21 V4 2/2] audit: add refused symlink to audit_names
Date: Wed, 21 Mar 2018 04:42:21 -0400
Message-Id: <e372c38adc4d2f43ff45b411b8a6b61c9b71b086.1521620371.git.rgb@redhat.com>
In-Reply-To: <cover.1521620371.git.rgb@redhat.com>
References: <cover.1521620371.git.rgb@redhat.com>
In-Reply-To: <cover.1521620371.git.rgb@redhat.com>
References: <cover.1521620371.git.rgb@redhat.com>
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
index e3682bb..5f8e8e2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -945,6 +945,7 @@ static inline int may_follow_link(struct nameidata *nd)
 	if (nd->flags & LOOKUP_RCU)
 		return -ECHILD;
 
+	audit_inode(nd->name, nd->stack[0].link.dentry, 0);
 	audit_log_link_denied("follow_link");
 	return -EACCES;
 }
-- 
1.8.3.1
