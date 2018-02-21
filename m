Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932409AbeBUJeh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:34:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753123AbeBUJeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:34:36 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH] audit: return on memory error to avoid null pointer dereference
Date: Wed, 21 Feb 2018 04:30:07 -0500
Message-Id: <2000f6951431b4f19947d7aa41bb8efd2fe3f15b.1519196084.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a memory allocation error when trying to change an audit
kernel feature value, the ignored allocation error will trigger a NULL
pointer dereference oops on subsequent use of that pointer.  Return
instead.

Passes audit-testsuite.
See: https://github.com/linux-audit/audit-kernel/issues/76
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/audit.c b/kernel/audit.c
index 5c25449..2de74be 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1059,6 +1059,8 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
 		return;
 
 	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
+	if (!ab)
+		return;
 	audit_log_task_info(ab, current);
 	audit_log_format(ab, " feature=%s old=%u new=%u old_lock=%u new_lock=%u res=%d",
 			 audit_feature_names[which], !!old_feature, !!new_feature,
-- 
1.8.3.1
