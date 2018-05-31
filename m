Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755458AbeEaPOn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:14:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755025AbeEaPOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:14:38 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak86 V1] audit: use audit_enabled as a boolean where convenient
Date: Thu, 31 May 2018 11:13:10 -0400
Message-Id: <c390a53d148593016df96e880a35e64f42edcf91.1527726830.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most uses of audit_enabled don't care about the distinction between
AUDIT_ON and AUDIT_LOCKED, so using audit_enabled as a boolean makes
more sense and is easier to read. Most uses of audit_enabled treat it as
a boolean, so switch the remaining AUDIT_OFF usage to simply use
audit_enabled as a boolean where applicable.

See: https://github.com/linux-audit/audit-kernel/issues/86

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 drivers/tty/tty_audit.c      | 2 +-
 include/net/xfrm.h           | 2 +-
 kernel/audit.c               | 8 ++++----
 net/netfilter/xt_AUDIT.c     | 2 +-
 net/netlabel/netlabel_user.c | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index e30aa6b..1e48051 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -92,7 +92,7 @@ static void tty_audit_buf_push(struct tty_audit_buf *buf)
 {
 	if (buf->valid == 0)
 		return;
-	if (audit_enabled == 0) {
+	if (!audit_enabled) {
 		buf->valid = 0;
 		return;
 	}
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 7f2e31a..380542b 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -734,7 +734,7 @@ static inline struct audit_buffer *xfrm_audit_start(const char *op)
 {
 	struct audit_buffer *audit_buf = NULL;
 
-	if (audit_enabled == 0)
+	if (!audit_enabled)
 		return NULL;
 	audit_buf = audit_log_start(audit_context(), GFP_ATOMIC,
 				    AUDIT_MAC_IPSEC_EVENT);
diff --git a/kernel/audit.c b/kernel/audit.c
index e7478cb..3a18e59 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -424,7 +424,7 @@ static int audit_do_config_change(char *function_name, u32 *to_change, u32 new)
 	else
 		allow_changes = 1;
 
-	if (audit_enabled != AUDIT_OFF) {
+	if (audit_enabled) {
 		rc = audit_log_config_change(function_name, new, old, allow_changes);
 		if (rc)
 			allow_changes = 0;
@@ -1097,7 +1097,7 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
 {
 	struct audit_buffer *ab;
 
-	if (audit_enabled == AUDIT_OFF)
+	if (!audit_enabled)
 		return;
 	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_FEATURE_CHANGE);
 	if (!ab)
@@ -1270,7 +1270,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				err = auditd_set(req_pid,
 						 NETLINK_CB(skb).portid,
 						 sock_net(NETLINK_CB(skb).sk));
-				if (audit_enabled != AUDIT_OFF)
+				if (audit_enabled)
 					audit_log_config_change("audit_pid",
 								new_pid,
 								auditd_pid,
@@ -1281,7 +1281,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				/* try to process any backlog */
 				wake_up_interruptible(&kauditd_wait);
 			} else {
-				if (audit_enabled != AUDIT_OFF)
+				if (audit_enabled)
 					audit_log_config_change("audit_pid",
 								new_pid,
 								auditd_pid, 1);
diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
index f368ee6..3921553 100644
--- a/net/netfilter/xt_AUDIT.c
+++ b/net/netfilter/xt_AUDIT.c
@@ -72,7 +72,7 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
 	struct audit_buffer *ab;
 	int fam = -1;
 
-	if (audit_enabled == 0)
+	if (!audit_enabled)
 		goto errout;
 	ab = audit_log_start(NULL, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
 	if (ab == NULL)
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 2f328af..e68fa9d 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -101,7 +101,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 	char *secctx;
 	u32 secctx_len;
 
-	if (audit_enabled == 0)
+	if (!audit_enabled)
 		return NULL;
 
 	audit_buf = audit_log_start(audit_context(), GFP_ATOMIC, type);
-- 
1.8.3.1
