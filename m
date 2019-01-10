Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D82C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791DD20685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx8nkp/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfAJRwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:52:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46954 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730549AbfAJRwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:52:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so5618967pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DRdaRk/8ytwQJSeaAu1bjHvZrIAwcQKkG4UHD8joGTU=;
        b=Qx8nkp/E/EEP9Tt3fJopv1S088SsbbnQs6TKKt4hB4kVLjNbR/GKzTcZn/iJ8eEsIH
         GMrR6cxv0dVc1rpSDZVjciuRWk31/Nax9loKrxEN+oT52El/PPlB1hMIbGMeZ9BHvY3U
         /93vIQitWcrYs5jRiXpX042NrOJ+QS7bU/P5QNaWe1tQO5uRkZ9Lx2cInHKVFHwpfppR
         cpHUZ5I2hvccKOI1CGlvxtGZbukUqOGoZLoKXYf52m7iDg+XxE1Z52t20B/UhtcrhHvG
         zzGyhEB/lsK26HZnpH6bCj3ZLWSyjbNSAQpLE9687vrGRTB5ew9g3F13TfX9h+Ctw6gs
         yOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DRdaRk/8ytwQJSeaAu1bjHvZrIAwcQKkG4UHD8joGTU=;
        b=BedPNXxkEpBC/Q5VmxIgVppL0Y3uxJu7qHnXHDMP45tg1jOXTDX86Fyc4+Tho83Ek3
         NChRqwXsiHXjUgPUT4uhF3K9J6SuBukLIL7UAxu0KNPE43K/SrKPz12acFJtBoU+EfD5
         4ldYkEC6TE5CQ0yORiYKsSneAfta6Bin3cPUxI8W7DK2bXutk+kGE8yhICjSlMG1yygb
         OR9nWzFXxlUIs/+miuXVGL9vMvd8PZDucDjHjD6F1StI5n0VXNWD9piQoqUVzh0Hu4xp
         pC99MBL1/utgBf55yS2l2q5DODsD4y2OZ8yfZbOCU4APiCVZKI3kzp8hjGUWaNqgR0js
         dGKw==
X-Gm-Message-State: AJcUuke2VzYw27osC89Lk73GhM35vxn1M5W/heti9fisPzDlpaFKHHRW
        6TlVA6E21KYbBimHihJEWnA=
X-Google-Smtp-Source: ALg8bN6O+FtZDF2EugKKy4QGAk4Y6113GHExaJGbtONMrCB2VMjOuez735TSqFEtRdyq8EMBWrniNg==
X-Received: by 2002:a63:960a:: with SMTP id c10mr130391pge.106.1547142728246;
        Thu, 10 Jan 2019 09:52:08 -0800 (PST)
Received: from localhost.localdomain ([2620:0:1008:fd00:78b4:3a07:980a:287b])
        by smtp.gmail.com with ESMTPSA id m85sm123815658pfj.171.2019.01.10.09.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:52:07 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2] kernel: release ptraced tasks before zap_pid_ns_processes
Date:   Thu, 10 Jan 2019 09:52:00 -0800
Message-Id: <20190110175200.12442-1-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, exit_ptrace() adds all ptraced tasks in a dead list, than
zap_pid_ns_processes() waits all tasks in a current pidns, and only
then tasks from the dead list are released.

zap_pid_ns_processes() can stuck on waiting tasks from the dead list. In
this case, we will have one unkillable process with one or more dead
children.

Thanks to Oleg for the advice to release tasks in find_child_reaper().

Fixes: 7c8bd2322c7f ("exit: ptrace: shift "reap dead" code from exit_ptrace() to forget_original_parent()")

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---

v2: Oleg showed that ptraced tasks can be released in
find_child_reaper(). This allows to avoid additional
write_lock/unlock(tasklist), and another list_for_each_entry_safe(dead)
loop is called only if it is actually needed.

 kernel/exit.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 2d14979577ee..5df787a497f5 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -558,12 +558,14 @@ static struct task_struct *find_alive_thread(struct task_struct *p)
 	return NULL;
 }
 
-static struct task_struct *find_child_reaper(struct task_struct *father)
+static struct task_struct *find_child_reaper(struct task_struct *father,
+						struct list_head *dead)
 	__releases(&tasklist_lock)
 	__acquires(&tasklist_lock)
 {
 	struct pid_namespace *pid_ns = task_active_pid_ns(father);
 	struct task_struct *reaper = pid_ns->child_reaper;
+	struct task_struct *p, *n;
 
 	if (likely(reaper != father))
 		return reaper;
@@ -579,6 +581,12 @@ static struct task_struct *find_child_reaper(struct task_struct *father)
 		panic("Attempted to kill init! exitcode=0x%08x\n",
 			father->signal->group_exit_code ?: father->exit_code);
 	}
+
+	list_for_each_entry_safe(p, n, dead, ptrace_entry) {
+		list_del_init(&p->ptrace_entry);
+		release_task(p);
+	}
+
 	zap_pid_ns_processes(pid_ns);
 	write_lock_irq(&tasklist_lock);
 
@@ -668,7 +676,7 @@ static void forget_original_parent(struct task_struct *father,
 		exit_ptrace(father, dead);
 
 	/* Can drop and reacquire tasklist_lock */
-	reaper = find_child_reaper(father);
+	reaper = find_child_reaper(father, dead);
 	if (list_empty(&father->children))
 		return;
 
-- 
2.17.2

