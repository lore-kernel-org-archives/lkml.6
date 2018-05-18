Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeERCCw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 22:02:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751850AbeERCCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 22:02:51 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH] audit: use existing session info function
Date: Thu, 17 May 2018 22:01:48 -0400
Message-Id: <9ffbbadb26bbc362c74c8c2140425ef614712e1a.1526608767.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the existing audit_log_session_info() function rather than
hardcoding its functionality.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditfilter.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index d7a807e..9e87377 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1089,8 +1089,6 @@ static void audit_list_rules(int seq, struct sk_buff_head *q)
 static void audit_log_rule_change(char *action, struct audit_krule *rule, int res)
 {
 	struct audit_buffer *ab;
-	uid_t loginuid = from_kuid(&init_user_ns, audit_get_loginuid(current));
-	unsigned int sessionid = audit_get_sessionid(current);
 
 	if (!audit_enabled)
 		return;
@@ -1098,7 +1096,7 @@ static void audit_log_rule_change(char *action, struct audit_krule *rule, int re
 	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (!ab)
 		return;
-	audit_log_format(ab, "auid=%u ses=%u" ,loginuid, sessionid);
+	audit_log_session_info(ab);
 	audit_log_task_context(ab);
 	audit_log_format(ab, " op=%s", action);
 	audit_log_key(ab, rule->filterkey);
-- 
1.8.3.1
