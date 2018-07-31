Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2024C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9810320841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cDiFJKdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9810320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbeGaX3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:29:35 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36906 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbeGaX3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:29:35 -0400
Received: by mail-yw0-f196.google.com with SMTP id w76-v6so6391516ywg.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QjLGCvakAgg/+nf5W1HiksRgkxn4bJMaCrBRuLEry2M=;
        b=cDiFJKdu115+UOZmlaO1YqVH7laIqfLFwiw2B129mjEyeBe39v4BMkKFD6Cojsztv1
         I9hjVGxKx5EjKbs6vLaEcgk3gL/Zcg+ao86X/y6WmnuPM2LOYaNA5b+l26J/0JvoMnKV
         7ArWT6n6h4gyxOLclb4W4jk3uPfrNmapwFfvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjLGCvakAgg/+nf5W1HiksRgkxn4bJMaCrBRuLEry2M=;
        b=GDk8tkgSmlfw9oiSGi7CDJTnbbPldK/zbnNNqfflc+hjpgEesbocagSSQW+J6G+3n4
         E97ibosBbKlBrQhC5jziGmZrvPevTrsc4bouBl0EQpQs0fN5IUyWXCsQ6Fii/mHJnviK
         4OUuCZo45Afd5ACC0o8YmQqcfWih0276GjNvgC4OFtiFhb6cW7QD1yhkuYOfnzj7GMbd
         CTQHg9uimD5NKzm3vCN/BqxZisHrEs/swoTHR9qF5tzj1NzS5atOWIEs45Fb7YAdrMWe
         fVYk9u68naIHG7LIuq/E6aetEDSU/nUQUwUR1xuDx1+b9ilt9GSOkVQnWHu0drYGs45a
         dmxQ==
X-Gm-Message-State: AOUpUlFGBAXUOMlRahGGTICoF18sgB9sXsSN/qnQk+lnuerGtbQxC8c9
        OXYBZShN/Vpx7aH/XYxPjpkLPviSnfsqt1ijT1Q70g==
X-Google-Smtp-Source: AAOMgpf8MQMS7Y94W8OLea9ZSvlLPn1coamoZGmfqmxTdCiN+Vc3uGlDH4U35gU+UbDH99Ch3deCCvbYY5kEMM+S3GM=
X-Received: by 2002:a0d:f087:: with SMTP id z129-v6mr11550573ywe.92.1533073633631;
 Tue, 31 Jul 2018 14:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccNNCNrA7to85WrYFjRUP7Z1XC+sJ2JXkargiEvXd11AVg@mail.gmail.com>
 <alpine.LRH.2.21.1808010608080.8072@namei.org>
In-Reply-To: <alpine.LRH.2.21.1808010608080.8072@namei.org>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 31 Jul 2018 14:47:02 -0700
Message-ID: <CAJ-EccOMdg370kMfU2=gMbSEyOE3sRVLpca86BHgr+i0_C=J9Q@mail.gmail.com>
Subject: Re: [PATCH v2] security: Add LSM fixup hooks to set*gid syscalls.
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org, serge@hallyn.com,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ChromiumOS LSM used by ChromeOS will provide a hook for this, in
order to enforce ChromeOS-specific policies regarding which UIDs/GIDs a
process with CAP_SET{UID/GID} can transition to. The
security_task_fix_setuid LSM hook is very helpful in enabling such a feature
for ChromeOS that governs UID transitions, but unfortunately for us it looks
like the equivalent hook that would allow us to govern GID transitions from an
LSM never got added.

Resending with plain text mode enabled.

---

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

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 8f1131c8dd54..a2166c812a97 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -599,6 +599,15 @@
  * @old is the set of credentials that are being replaces
  * @flags contains one of the LSM_SETID_* values.
  * Return 0 on success.
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
  * Check permission before setting the process group identifier of the
  * process @p to @pgid.
@@ -1587,6 +1596,8 @@ union security_list_options {
       enum kernel_read_file_id id);
  int (*task_fix_setuid)(struct cred *new, const struct cred *old,
  int flags);
+ int (*task_fix_setgid)(struct cred *new, const struct cred *old,
+ int flags);
  int (*task_setpgid)(struct task_struct *p, pid_t pgid);
  int (*task_getpgid)(struct task_struct *p);
  int (*task_getsid)(struct task_struct *p);
@@ -1876,6 +1887,7 @@ struct security_hook_heads {
  struct hlist_head kernel_post_read_file;
  struct hlist_head kernel_module_request;
  struct hlist_head task_fix_setuid;
+ struct hlist_head task_fix_setgid;
  struct hlist_head task_setpgid;
  struct hlist_head task_getpgid;
  struct hlist_head task_getsid;
diff --git a/include/linux/security.h b/include/linux/security.h
index 63030c85ee19..a82d97cf13ab 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -325,6 +325,8 @@ int security_kernel_post_read_file(struct file
*file, char *buf, loff_t size,
     enum kernel_read_file_id id);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
       int flags);
+int security_task_fix_setgid(struct cred *new, const struct cred *old,
+      int flags);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
@@ -929,6 +931,13 @@ static inline int security_task_fix_setuid(struct
cred *new,
  return cap_task_fix_setuid(new, old, flags);
 }

+static inline int security_task_fix_setgid(struct cred *new,
+    const struct cred *old,
+    int flags)
+{
+ return 0;
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

+ retval = security_task_fix_setgid(new, old, LSM_SETID_RE);
+ if (retval < 0)
+ goto error;
+
  return commit_creds(new);

 error:
@@ -434,6 +438,10 @@ long __sys_setgid(gid_t gid)
  else
  goto error;

+ retval = security_task_fix_setgid(new, old, LSM_SETID_ID);
+ if (retval < 0)
+ goto error;
+
  return commit_creds(new);

 error:
@@ -755,6 +763,10 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
  new->sgid = ksgid;
  new->fsgid = new->egid;

+ retval = security_task_fix_setgid(new, old, LSM_SETID_RES);
+ if (retval < 0)
+ goto error;
+
  return commit_creds(new);

 error:
@@ -861,7 +873,8 @@ long __sys_setfsgid(gid_t gid)
      ns_capable(old->user_ns, CAP_SETGID)) {
  if (!gid_eq(kgid, old->fsgid)) {
  new->fsgid = kgid;
- goto change_okay;
+ if (security_task_fix_setgid(new, old, LSM_SETID_FS) == 0)
+ goto change_okay;
  }
  }

diff --git a/security/security.c b/security/security.c
index 68f46d849abe..587786fc0aaa 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1062,6 +1062,12 @@ int security_task_fix_setuid(struct cred *new,
const struct cred *old,
  return call_int_hook(task_fix_setuid, 0, new, old, flags);
 }

+int security_task_fix_setgid(struct cred *new, const struct cred *old,
+      int flags)
+{
+ return call_int_hook(task_fix_setgid, 0, new, old, flags);
+}
+
 int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
  return call_int_hook(task_setpgid, 0, p, pgid);

--
4.18-rc2

--

On Tue, Jul 31, 2018 at 1:09 PM James Morris <jmorris@namei.org> wrote:
>
> On Tue, 31 Jul 2018, Micah Morton wrote:
>
> > +static inline int security_task_fix_setgid(struct cred *new,
> > +    const struct cred *old,
> > +    int flags)
> > +{
> > + return 0;
> > +}
> > +
>
> This looks whitespace-damaged.  Please send patches as plain text.
>
>
> --
> James Morris
> <jmorris@namei.org>
>
