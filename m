Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D5BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B092083F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B092083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbeGaVx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:53:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726580AbeGaVx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:53:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7AF5402332F;
        Tue, 31 Jul 2018 20:11:29 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C36BF2026D7E;
        Tue, 31 Jul 2018 20:11:26 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Cc:     luto@kernel.org, carlos@redhat.com, viro@zeniv.linux.org.uk,
        dhowells@redhat.com, simo@redhat.com, eparis@parisplace.org,
        serge@hallyn.com, ebiederm@xmission.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak90 (was ghak32) V4 03/10] audit: log container info of syscalls
Date:   Tue, 31 Jul 2018 16:07:38 -0400
Message-Id: <34017c395d03a213d6b0d49b9964429bd32b283d.1533065887.git.rgb@redhat.com>
In-Reply-To: <cover.1533065887.git.rgb@redhat.com>
References: <cover.1533065887.git.rgb@redhat.com>
In-Reply-To: <cover.1533065887.git.rgb@redhat.com>
References: <cover.1533065887.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 31 Jul 2018 20:11:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 31 Jul 2018 20:11:29 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new audit record AUDIT_CONTAINER to document the audit
container identifier of a process if it is present.

Called from audit_log_exit(), syscalls are covered.

A sample raw event:
type=SYSCALL msg=audit(1519924845.499:257): arch=c000003e syscall=257 success=yes exit=3 a0=ffffff9c a1=56374e1cef30 a2=241 a3=1b6 items=2 ppid=606 pid=635 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=3 comm="bash" exe="/usr/bin/bash" subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key="tmpcontainerid"
type=CWD msg=audit(1519924845.499:257): cwd="/root"
type=PATH msg=audit(1519924845.499:257): item=0 name="/tmp/" inode=13863 dev=00:27 mode=041777 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:tmp_t:s0 nametype= PARENT cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0 cap_fver=0
type=PATH msg=audit(1519924845.499:257): item=1 name="/tmp/tmpcontainerid" inode=17729 dev=00:27 mode=0100644 ouid=0 ogid=0 rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=CREATE cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0 cap_fver=0
type=PROCTITLE msg=audit(1519924845.499:257): proctitle=62617368002D6300736C65657020313B206563686F2074657374203E202F746D702F746D70636F6E7461696E65726964
type=CONTAINER msg=audit(1519924845.499:257): op=task contid=123458

See: https://github.com/linux-audit/audit-kernel/issues/90
See: https://github.com/linux-audit/audit-userspace/issues/51
See: https://github.com/linux-audit/audit-testsuite/issues/64
See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
Acked-by: Steve Grubb <sgrubb@redhat.com>
---
 include/linux/audit.h      |  7 +++++++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 24 ++++++++++++++++++++++++
 kernel/auditsc.c           |  3 +++
 4 files changed, 35 insertions(+)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 71a6fc6..d5a48dc 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -155,6 +155,9 @@ extern void		    audit_log_key(struct audit_buffer *ab,
 extern int audit_log_task_context(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab,
 				struct task_struct *tsk);
+extern int audit_log_contid(struct task_struct *tsk,
+				    struct audit_context *context,
+				    char *op);
 
 extern int		    audit_update_lsm_rules(void);
 
@@ -205,6 +208,10 @@ static inline int audit_log_task_context(struct audit_buffer *ab)
 static inline void audit_log_task_info(struct audit_buffer *ab,
 				       struct task_struct *tsk)
 { }
+static inline int audit_log_contid(struct task_struct *tsk,
+					   struct audit_context *context,
+					   char *op)
+{ }
 #define audit_enabled AUDIT_OFF
 #endif /* CONFIG_AUDIT */
 
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 3474f57..dc259c7 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -115,6 +115,7 @@
 #define AUDIT_REPLACE		1329	/* Replace auditd if this packet unanswerd */
 #define AUDIT_KERN_MODULE	1330	/* Kernel Module events */
 #define AUDIT_FANOTIFY		1331	/* Fanotify access decision */
+#define AUDIT_CONTAINER		1332	/* Container ID */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
diff --git a/kernel/audit.c b/kernel/audit.c
index 2a80587..15f54c7 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2045,6 +2045,30 @@ void audit_log_session_info(struct audit_buffer *ab)
 	audit_log_format(ab, " auid=%u ses=%u", auid, sessionid);
 }
 
+/*
+ * audit_log_contid - report container info
+ * @tsk: task to be recorded
+ * @context: task or local context for record
+ * @op: contid string description
+ */
+int audit_log_contid(struct task_struct *tsk,
+			     struct audit_context *context, char *op)
+{
+	struct audit_buffer *ab;
+
+	if (!audit_contid_set(tsk))
+		return 0;
+	/* Generate AUDIT_CONTAINER record with container ID */
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONTAINER);
+	if (!ab)
+		return -ENOMEM;
+	audit_log_format(ab, "op=%s contid=%llu",
+			 op, audit_get_contid(tsk));
+	audit_log_end(ab);
+	return 0;
+}
+EXPORT_SYMBOL(audit_log_contid);
+
 void audit_log_key(struct audit_buffer *ab, char *key)
 {
 	audit_log_format(ab, " key=");
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6125cef..39e5633 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1488,10 +1488,13 @@ static void audit_log_exit(struct audit_context *context, struct task_struct *ts
 
 	audit_log_proctitle(tsk, context);
 
+	audit_log_contid(tsk, context, "task");
+
 	/* Send end of event record to help user space know we are finished */
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_EOE);
 	if (ab)
 		audit_log_end(ab);
+
 	if (call_panic)
 		audit_panic("error converting sid to string");
 }
-- 
1.8.3.1

