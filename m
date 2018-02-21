Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeBUCsh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 21:48:37 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42292 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeBUCsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 21:48:08 -0500
X-Google-Smtp-Source: AH8x224GSL0TyuIlDsJvJ8qdJ8xiaPlNujRvKgMML/lSoM+M2Ne4yZlx+j+aVh4a8YOnGHEErzn3wA==
From: Tycho Andersen <tycho@tycho.ws>
To: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Cc: Tycho Andersen <tycho@tycho.ws>, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 2/3] ptrace, seccomp: tweak get_metadata behavior slightly
Date: Tue, 20 Feb 2018 19:47:46 -0700
Message-Id: <20180221024747.9659-3-tycho@tycho.ws>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180221024747.9659-1-tycho@tycho.ws>
References: <20180221024747.9659-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously if users passed a small size for the input structure size, they
would get get odd behavior. It doesn't make sense to pass a structure
smaller than at least filter_off size, so let's just give -EINVAL in this
case.

This changes userspace visible behavior, but was only introduced in commit
26500475ac1b ("ptrace, seccomp: add support for retrieving seccomp
metadata") in 4.16-rc2, so should be safe to change if merged before then.

Reported-by: Eugene Syromiatnikov <esyr@redhat.com>
Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: Kees Cook <keescook@chromium.org>
CC: Oleg Nesterov <oleg@redhat.com>
---
 kernel/seccomp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 940fa408a288..dc77548167ef 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1076,14 +1076,16 @@ long seccomp_get_metadata(struct task_struct *task,
 
 	size = min_t(unsigned long, size, sizeof(kmd));
 
-	if (copy_from_user(&kmd, data, size))
+	if (size < sizeof(kmd.filter_off))
+		return -EINVAL;
+
+	if (copy_from_user(&kmd.filter_off, data, sizeof(kmd.filter_off)))
 		return -EFAULT;
 
 	filter = get_nth_filter(task, kmd.filter_off);
 	if (IS_ERR(filter))
 		return PTR_ERR(filter);
 
-	memset(&kmd, 0, sizeof(kmd));
 	if (filter->log)
 		kmd.flags |= SECCOMP_FILTER_FLAG_LOG;
 
-- 
2.14.1
