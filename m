Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BC6A7C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C962208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C962208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755483AbeFNUXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:23:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755429AbeFNUXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:23:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F744406E897;
        Thu, 14 Jun 2018 20:23:13 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-45.rdu2.redhat.com [10.10.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C94AD1116700;
        Thu, 14 Jun 2018 20:23:11 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <aviro@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak59 V1 2/6] audit: add syscall information to CONFIG_CHANGE records
Date:   Thu, 14 Jun 2018 16:21:12 -0400
Message-Id: <244a8049197a23b0cee37dc3f00d070e646fd1b7.1529003588.git.rgb@redhat.com>
In-Reply-To: <cover.1529003588.git.rgb@redhat.com>
References: <cover.1529003588.git.rgb@redhat.com>
In-Reply-To: <cover.1529003588.git.rgb@redhat.com>
References: <cover.1529003588.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 14 Jun 2018 20:23:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 14 Jun 2018 20:23:13 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tie syscall information to all CONFIG_CHANGE calls since they are all a
result of user actions.

See: https://github.com/linux-audit/audit-kernel/issues/59
See: https://github.com/linux-audit/audit-kernel/issues/50
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.c          | 4 ++--
 kernel/audit_fsnotify.c | 2 +-
 kernel/audit_tree.c     | 2 +-
 kernel/audit_watch.c    | 2 +-
 kernel/auditfilter.c    | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index ad54339..e469234 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -400,7 +400,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
 	struct audit_buffer *ab;
 	int rc = 0;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return rc;
 	audit_log_format(ab, "op=set %s=%u old=%u", function_name, new, old);
@@ -1067,7 +1067,7 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
 		return;
 	}
 
-	*ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
+	*ab = audit_log_start(audit_context(), GFP_KERNEL, msg_type);
 	if (unlikely(!*ab))
 		return;
 	audit_log_format(*ab, "pid=%d uid=%u", pid, uid);
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 52f368b..1640eb6 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -127,7 +127,7 @@ static void audit_mark_log_rule_change(struct audit_fsnotify_mark *audit_mark, c
 
 	if (!audit_enabled)
 		return;
-	ab = audit_log_start(NULL, GFP_NOFS, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(audit_context(), GFP_NOFS, AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return;
 	audit_log_format(ab, "auid=%u ses=%u op=%s",
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 5e9d1e5..a01b9da 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -499,7 +499,7 @@ static void audit_tree_log_remove_rule(struct audit_krule *rule)
 
 	if (!audit_enabled)
 		return;
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return;
 	audit_log_format(ab, "op=remove_rule");
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 9b4836b..da2978b 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -242,7 +242,7 @@ static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watc
 
 	if (!audit_enabled)
 		return;
-	ab = audit_log_start(NULL, GFP_NOFS, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(audit_context(), GFP_NOFS, AUDIT_CONFIG_CHANGE);
 	if (!ab)
 		return;
 	audit_log_format(ab, "auid=%u ses=%u op=%s",
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index eaa3201..6e19acb 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1093,7 +1093,7 @@ static void audit_log_rule_change(char *action, struct audit_krule *rule, int re
 	if (!audit_enabled)
 		return;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (!ab)
 		return;
 	audit_log_session_info(ab);
-- 
1.8.3.1

