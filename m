Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A2FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D177020868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D177020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeICRFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:05:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:60950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbeICRFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:05:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 237C4B007;
        Mon,  3 Sep 2018 12:45:21 +0000 (UTC)
Date:   Mon, 3 Sep 2018 14:45:20 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v2 1/3] ptrace: Provide ___ptrace_may_access() that can be
 applied on arbitrary tasks
Message-ID: <nycvar.YFH.7.76.1809031443150.25787@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

Current ptrace_may_access() implementation assumes that the 'source' task 
is always the caller (current).

Expose ___ptrace_may_access() that can be used to apply the check on arbitrary
tasks.

Originally-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 include/linux/ptrace.h | 12 ++++++++++++
 kernel/ptrace.c        | 13 ++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 4f36431c380b..09744d4113fb 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -87,6 +87,18 @@ extern void exit_ptrace(struct task_struct *tracer, struct list_head *dead);
  */
 extern bool ptrace_may_access(struct task_struct *task, unsigned int mode);
 
+/**
+ * ___ptrace_may_access - variant of ptrace_may_access that can be used
+ * between two arbitrary tasks
+ * @curr: source task
+ * @task: target task
+ * @mode: selects type of access and caller credentials
+ *
+ * Returns true on success, false on denial.
+ */
+extern int ___ptrace_may_access(struct task_struct *curr, struct task_struct *task,
+				unsigned int mode);
+
 static inline int ptrace_reparented(struct task_struct *child)
 {
 	return !same_thread_group(child->real_parent, child->parent);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 21fec73d45d4..07ff6685ebed 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -268,9 +268,10 @@ static int ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
 }
 
 /* Returns 0 on success, -errno on denial. */
-static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
+int ___ptrace_may_access(struct task_struct *curr, struct task_struct *task,
+		unsigned int mode)
 {
-	const struct cred *cred = current_cred(), *tcred;
+	const struct cred *cred, *tcred;
 	struct mm_struct *mm;
 	kuid_t caller_uid;
 	kgid_t caller_gid;
@@ -290,9 +291,10 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 	 */
 
 	/* Don't let security modules deny introspection */
-	if (same_thread_group(task, current))
+	if (same_thread_group(task, curr))
 		return 0;
 	rcu_read_lock();
+	cred =  __task_cred(curr);
 	if (mode & PTRACE_MODE_FSCREDS) {
 		caller_uid = cred->fsuid;
 		caller_gid = cred->fsgid;
@@ -331,6 +333,11 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 	return security_ptrace_access_check(task, mode);
 }
 
+static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
+{
+	return ___ptrace_may_access(current, task, mode);
+}
+
 bool ptrace_may_access(struct task_struct *task, unsigned int mode)
 {
 	int err;

-- 
Jiri Kosina
SUSE Labs

