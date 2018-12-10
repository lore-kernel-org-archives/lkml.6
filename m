Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC60CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD8E2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD8E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbeLJWSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:18:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbeLJWSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:18:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26CE658E35;
        Mon, 10 Dec 2018 22:18:37 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7DFB60BF1;
        Mon, 10 Dec 2018 22:18:34 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Cc:     Eric Paris <eparis@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steve Grubb <sgrubb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak59 V3 2/4] audit: add syscall information to CONFIG_CHANGE records
Date:   Mon, 10 Dec 2018 17:17:49 -0500
Message-Id: <43548fafdfa98ee64ecfd0d7a69a2f5cb2c31c50.1544477629.git.rgb@redhat.com>
In-Reply-To: <cover.1544477629.git.rgb@redhat.com>
References: <cover.1544477629.git.rgb@redhat.com>
In-Reply-To: <cover.1544477629.git.rgb@redhat.com>
References: <cover.1544477629.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 10 Dec 2018 22:18:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tie syscall information to all CONFIG_CHANGE calls since they are all a
result of user actions.

Exclude user records from syscall context:
Since the function audit_log_common_recv_msg() is shared by a number of
AUDIT_CONFIG_CHANGE and the entire range of AUDIT_USER_* record types,
and since the AUDIT_CONFIG_CHANGE message type has been converted to a
syscall accompanied record type, special-case the AUDIT_USER_* range of
messages so they remain standalone records.

See: https://github.com/linux-audit/audit-kernel/issues/59
See: https://github.com/linux-audit/audit-kernel/issues/50
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.c          | 27 +++++++++++++++++++--------
 kernel/audit_fsnotify.c |  2 +-
 kernel/audit_tree.c     |  2 +-
 kernel/audit_watch.c    |  2 +-
 kernel/auditfilter.c    |  2 +-
 5 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 0e8026423fbd..a321fea94cc6 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -397,7 +397,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
 	struct audit_buffer *ab;
 	int rc = 0;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return rc;
 	audit_log_format(ab, "op=set %s=%u old=%u ", function_name, new, old);
@@ -1054,7 +1054,8 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
 	return err;
 }
 
-static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
+static void audit_log_common_recv_msg(struct audit_context *context,
+					struct audit_buffer **ab, u16 msg_type)
 {
 	uid_t uid = from_kuid(&init_user_ns, current_uid());
 	pid_t pid = task_tgid_nr(current);
@@ -1064,7 +1065,7 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
 		return;
 	}
 
-	*ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
+	*ab = audit_log_start(context, GFP_KERNEL, msg_type);
 	if (unlikely(!*ab))
 		return;
 	audit_log_format(*ab, "pid=%d uid=%u ", pid, uid);
@@ -1072,6 +1073,16 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
 	audit_log_task_context(*ab);
 }
 
+static inline void audit_log_user_recv_msg(struct audit_buffer **ab, u16 msg_type)
+{
+	audit_log_common_recv_msg(NULL, ab, msg_type);
+}
+
+static inline void audit_log_config_change_alt(struct audit_buffer **ab)
+{
+	audit_log_common_recv_msg(audit_context(), ab, AUDIT_CONFIG_CHANGE);
+}
+
 int is_audit_feature_set(int i)
 {
 	return af.features & AUDIT_FEATURE_TO_MASK(i);
@@ -1339,7 +1350,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				if (err)
 					break;
 			}
-			audit_log_common_recv_msg(&ab, msg_type);
+			audit_log_user_recv_msg(&ab, msg_type);
 			if (msg_type != AUDIT_USER_TTY)
 				audit_log_format(ab, " msg='%.*s'",
 						 AUDIT_MESSAGE_TEXT_MAX,
@@ -1362,7 +1373,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		if (nlmsg_len(nlh) < sizeof(struct audit_rule_data))
 			return -EINVAL;
 		if (audit_enabled == AUDIT_LOCKED) {
-			audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
+			audit_log_config_change_alt(&ab);
 			audit_log_format(ab, " op=%s audit_enabled=%d res=0",
 					 msg_type == AUDIT_ADD_RULE ? "add_rule" : "remove_rule",
 					 audit_enabled);
@@ -1376,7 +1387,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		break;
 	case AUDIT_TRIM:
 		audit_trim_trees();
-		audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
+		audit_log_config_change_alt(&ab);
 		audit_log_format(ab, " op=trim res=1");
 		audit_log_end(ab);
 		break;
@@ -1406,7 +1417,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		/* OK, here comes... */
 		err = audit_tag_tree(old, new);
 
-		audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
+		audit_log_config_change_alt(&ab);
 
 		audit_log_format(ab, " op=make_equiv old=");
 		audit_log_untrustedstring(ab, old);
@@ -1474,7 +1485,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 		old.enabled = t & AUDIT_TTY_ENABLE;
 		old.log_passwd = !!(t & AUDIT_TTY_LOG_PASSWD);
 
-		audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
+		audit_log_config_change_alt(&ab);
 		audit_log_format(ab, " op=tty_set old-enabled=%d new-enabled=%d"
 				 " old-log_passwd=%d new-log_passwd=%d res=%d",
 				 old.enabled, s.enabled, old.log_passwd,
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index cf4512a33675..37ae95cfb7f4 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -127,7 +127,7 @@ static void audit_mark_log_rule_change(struct audit_fsnotify_mark *audit_mark, c
 
 	if (!audit_enabled)
 		return;
-	ab = audit_log_start(NULL, GFP_NOFS, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(audit_context(), GFP_NOFS, AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return;
 	audit_log_session_info(ab);
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index d4af4d97f847..b0bd59ef4271 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -530,7 +530,7 @@ static void audit_tree_log_remove_rule(struct audit_krule *rule)
 
 	if (!audit_enabled)
 		return;
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return;
 	audit_log_format(ab, "op=remove_rule dir=");
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 20ef9ba134b0..e8d1adeb2223 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -242,7 +242,7 @@ static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watc
 
 	if (!audit_enabled)
 		return;
-	ab = audit_log_start(NULL, GFP_NOFS, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(audit_context(), GFP_NOFS, AUDIT_CONFIG_CHANGE);
 	if (!ab)
 		return;
 	audit_log_session_info(ab);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index bf309f2592c4..26a80a9d43a9 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1091,7 +1091,7 @@ static void audit_log_rule_change(char *action, struct audit_krule *rule, int re
 	if (!audit_enabled)
 		return;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (!ab)
 		return;
 	audit_log_session_info(ab);
-- 
1.8.3.1

