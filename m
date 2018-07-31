Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18351C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B77A2083F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c7YVbPkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B77A2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbeHABHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 21:07:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44018 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732720AbeHABHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 21:07:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id d17-v6so5385493pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 16:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=co53M4pK26ObFtC679l0n1ZIfgui7/vM89i+zffEc3s=;
        b=c7YVbPkF3ISm7UCBQnKiptcjFYT8yTK6vZHcQiL23YAlZNWO7S4KfkdbkTVV5B+Di4
         MT9u9twECt9LCFCB/yO/VvjSaviTj9CB1f/KXydOyCyhNvBOcmUCyqs6brCoRMUtZUDS
         vuVyuE3g1axdDXAA/xr1CU86WOdLDL4ckRsLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=co53M4pK26ObFtC679l0n1ZIfgui7/vM89i+zffEc3s=;
        b=KnkTJWTrDXJcN8P+kEY04TiEXqrTSwy5vFGHjFAp0PICryPAUORyBb2WMZ2+IHelem
         QUoXBqaQzuPMcOt42zFRuMOCJ0kiUPOQlFvXbQMyLUbz8F6SZ0gGSghnyZY6CT/dTHb2
         H2n6M3wOtKkTaQ0awrKwgvGhjd8EWyzs8xjuFrs6V2/fIkhkPRwxIDXA4RE755JUA7MG
         dWrJ7JpJV23Mj6BveatWTAtxJHicG8Aqt499tn4swK8v0b1+hDbyB2LBzyFrCQoE4LNP
         Gdd7uyWdQ59twHYITO5POry77OpolLuRXaDsupkuz31agHKVaPewEzh9Uhw9XrZ8kwTq
         6mwA==
X-Gm-Message-State: AOUpUlFVHRCprQj4l2fPbTzm9GHsmd1fgFWI4SYvSpgyxiwT7cu+lmX/
        3xJwWMQi5jL78lXT2QOjoGMvKQ==
X-Google-Smtp-Source: AAOMgpceqPBFKvSOACdstniFI9+vtpmrhItHPnvasSwwKcv7Q2teH8CB+XXNWxepveYfqhu11rQG8A==
X-Received: by 2002:a63:943:: with SMTP id 64-v6mr21838244pgj.368.1533079468762;
        Tue, 31 Jul 2018 16:24:28 -0700 (PDT)
Received: from mortonm2.mtv.corp.google.com ([2620:0:1000:1611:d81e:d910:6031:4b81])
        by smtp.gmail.com with ESMTPSA id s195-v6sm28861752pgs.76.2018.07.31.16.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 16:24:28 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
To:     rdunlap@infradead.org
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        serge@hallyn.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, Micah Morton <mortonm@chromium.org>
Subject: [PATCH] security: Add LSM fixup hooks to set*gid syscalls.
Date:   Tue, 31 Jul 2018 16:23:51 -0700
Message-Id: <20180731232351.122951-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <a5ce4d5d-833f-8994-9070-df0e587e5023@infradead.org>
References: <a5ce4d5d-833f-8994-9070-df0e587e5023@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The set*uid system calls all call an LSM fixup hook called
security_task_fix_setuid, which allows for altering the behavior of those
calls by a security module. Comments explaining the LSM_SETID_* constants
in /include/linux/security.h imply that the constants are to be used for
both the set*uid and set*gid syscalls, but the set*gid syscalls do not
have the relevant hooks, meaning a security module can only alter syscalls
that change user identity attributes but not ones that change group
identity attributes. This patch adds the necessary LSM hook, called
security_task_fix_setgid, and calls the hook from the appropriate places
in the set*gid syscalls.Tested by putting a print statement in the hook and
seeing it triggered from the various set*gid syscalls.

Signed-off-by: Micah Morton <mortonm@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>
---
NOTE: the security_task_fix_setgid line in sys_setfsgid is over 80
characters, but I figured I'd just follow how it was done in sys_setfsuid
rather than trying to wrap the line, since the functions are nearly
identical.
---
 include/linux/lsm_hooks.h | 12 ++++++++++++
 include/linux/security.h  |  9 +++++++++
 kernel/sys.c              | 15 ++++++++++++++-
 security/security.c       |  6 ++++++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 8f1131c8dd54..a2166c812a97 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -599,6 +599,15 @@
  *	@old is the set of credentials that are being replaces
  *	@flags contains one of the LSM_SETID_* values.
  *	Return 0 on success.
+ * @task_fix_setgid:
+ *     Update the module's state after setting one or more of the group
+ *     identity attributes of the current process.  The @flags parameter
+ *     indicates which of the set*gid system calls invoked this hook.
+ *     @new is the set of credentials that will be installed.  Modifications
+ *     should be made to this rather than to @current->cred.
+ *     @old is the set of credentials that are being replaced
+ *     @flags contains one of the LSM_SETID_* values.
+ *     Return 0 on success.
  * @task_setpgid:
  *	Check permission before setting the process group identifier of the
  *	process @p to @pgid.
@@ -1587,6 +1596,8 @@ union security_list_options {
 				     enum kernel_read_file_id id);
 	int (*task_fix_setuid)(struct cred *new, const struct cred *old,
 				int flags);
+	int (*task_fix_setgid)(struct cred *new, const struct cred *old,
+				int flags);
 	int (*task_setpgid)(struct task_struct *p, pid_t pgid);
 	int (*task_getpgid)(struct task_struct *p);
 	int (*task_getsid)(struct task_struct *p);
@@ -1876,6 +1887,7 @@ struct security_hook_heads {
 	struct hlist_head kernel_post_read_file;
 	struct hlist_head kernel_module_request;
 	struct hlist_head task_fix_setuid;
+	struct hlist_head task_fix_setgid;
 	struct hlist_head task_setpgid;
 	struct hlist_head task_getpgid;
 	struct hlist_head task_getsid;
diff --git a/include/linux/security.h b/include/linux/security.h
index 63030c85ee19..a82d97cf13ab 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -325,6 +325,8 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags);
+int security_task_fix_setgid(struct cred *new, const struct cred *old,
+			     int flags);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
@@ -929,6 +931,13 @@ static inline int security_task_fix_setuid(struct cred *new,
 	return cap_task_fix_setuid(new, old, flags);
 }
 
+static inline int security_task_fix_setgid(struct cred *new,
+					   const struct cred *old,
+					   int flags)
+{
+	return 0;
+}
+
 static inline int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
 	return 0;
diff --git a/kernel/sys.c b/kernel/sys.c
index 38509dc1f77b..f6ef922c6815 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -392,6 +392,10 @@ long __sys_setregid(gid_t rgid, gid_t egid)
 		new->sgid = new->egid;
 	new->fsgid = new->egid;
 
+	retval = security_task_fix_setgid(new, old, LSM_SETID_RE);
+	if (retval < 0)
+		goto error;
+
 	return commit_creds(new);
 
 error:
@@ -434,6 +438,10 @@ long __sys_setgid(gid_t gid)
 	else
 		goto error;
 
+	retval = security_task_fix_setgid(new, old, LSM_SETID_ID);
+	if (retval < 0)
+		goto error;
+
 	return commit_creds(new);
 
 error:
@@ -755,6 +763,10 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 		new->sgid = ksgid;
 	new->fsgid = new->egid;
 
+	retval = security_task_fix_setgid(new, old, LSM_SETID_RES);
+	if (retval < 0)
+		goto error;
+
 	return commit_creds(new);
 
 error:
@@ -861,7 +873,8 @@ long __sys_setfsgid(gid_t gid)
 	    ns_capable(old->user_ns, CAP_SETGID)) {
 		if (!gid_eq(kgid, old->fsgid)) {
 			new->fsgid = kgid;
-			goto change_okay;
+			if (security_task_fix_setgid(new, old, LSM_SETID_FS) == 0)
+				goto change_okay;
 		}
 	}
 
diff --git a/security/security.c b/security/security.c
index 68f46d849abe..587786fc0aaa 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1062,6 +1062,12 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
 	return call_int_hook(task_fix_setuid, 0, new, old, flags);
 }
 
+int security_task_fix_setgid(struct cred *new, const struct cred *old,
+			     int flags)
+{
+	return call_int_hook(task_fix_setgid, 0, new, old, flags);
+}
+
 int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
 	return call_int_hook(task_setpgid, 0, p, pgid);
-- 
2.18.0.345.g5c9ce644c3-goog

