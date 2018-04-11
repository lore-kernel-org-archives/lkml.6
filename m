Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeDKMwz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:52:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752904AbeDKMwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:52:54 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak80 V1] audit: add syscall information to FEATURE_CHANGE records
Date: Wed, 11 Apr 2018 08:46:52 -0400
Message-Id: <08bd08ee9bc70f6e98b9e298ba6a2c0f4dcadb4b.1523372093.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tie syscall information to FEATURE_CHANGE calls since it is a result of
user action.

See: https://github.com/linux-audit/audit-kernel/issues/80

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 8da24ef..23f125b 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1103,10 +1103,9 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
 {
 	struct audit_buffer *ab;
 
-	if (audit_enabled == AUDIT_OFF)
+	if (!audit_enabled)
 		return;
-
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
+	ab = audit_log_start(current->audit_context, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
 	if (!ab)
 		return;
 	audit_log_task_info(ab, current);
-- 
1.8.3.1
