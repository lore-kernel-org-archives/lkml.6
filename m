Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbeEQPM5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:12:57 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38315 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbeEQPMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:12:53 -0400
X-Google-Smtp-Source: AB8JxZrHnyPGG9ihS2nXoa1a0pMJyPgfw5MrLqDHePS6jsmwCeToF3Ewpv3viKYm4rkgroHJTgCe5g==
From: Tycho Andersen <tycho@tycho.ws>
To: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
Cc: Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v2 2/4] seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
Date: Thu, 17 May 2018 09:12:16 -0600
Message-Id: <20180517151218.12850-3-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517151218.12850-1-tycho@tycho.ws>
References: <20180517151218.12850-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the next commit we'll use this same mnemonic to get a listener for the
nth filter, so we need it available outside of CHECKPOINT_RESTORE. This is
slightly looser than necessary, because it really could be
CHECKPOINT_RESTORE || USER_NOTIFICATION, but it's declared static and this
complicates the code less, so hopefully it's ok.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: Kees Cook <keescook@chromium.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Oleg Nesterov <oleg@redhat.com>
CC: Eric W. Biederman <ebiederm@xmission.com>
CC: "Serge E. Hallyn" <serge@hallyn.com>
CC: Christian Brauner <christian.brauner@ubuntu.com>
CC: Tyler Hicks <tyhicks@canonical.com>
CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>

v2: new in v2
---
 kernel/seccomp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index a169a62cb78a..f136eca93f2f 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1180,7 +1180,7 @@ long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
 	return do_seccomp(op, 0, uargs);
 }
 
-#if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
+#if defined(CONFIG_SECCOMP_FILTER)
 static struct seccomp_filter *get_nth_filter(struct task_struct *task,
 					     unsigned long filter_off)
 {
@@ -1227,6 +1227,7 @@ static struct seccomp_filter *get_nth_filter(struct task_struct *task,
 	return filter;
 }
 
+#if defined(CONFIG_CHECKPOINT_RESTORE)
 long seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
 			void __user *data)
 {
@@ -1299,7 +1300,8 @@ long seccomp_get_metadata(struct task_struct *task,
 	__put_seccomp_filter(filter);
 	return ret;
 }
-#endif
+#endif /* CONFIG_CHECKPOINT_RESTORE */
+#endif /* CONFIG_SECCOMP_FILTER */
 
 #ifdef CONFIG_SYSCTL
 
-- 
2.17.0
