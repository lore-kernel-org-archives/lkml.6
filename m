Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDDFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC84B21479
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf7OU3nI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfABU7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:59:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36299 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfABU7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:59:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so15066181pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 12:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=slOs5HVUDIi/Tpmu6RLaJrzMYZWLNYUNQu8MlH9pJVg=;
        b=kf7OU3nI0S2hH7AACI8TgRbihF5wMq4j1iybBNcdzj8Ii/cRpXvYcM8afgiYGDtzog
         JVPpGA6m1iHi4ki+AoGqnd7Fn6JPv21nmOoF3GB8oQ1Q11TUt4y1CXcZcBRYMPkCgbBR
         G3NDYvWerD+tMhtZX1Z7SKtBxYWNvgReBn+s+Lhd2Znzo40DeAielNeHERmkecPvDOHc
         MBppGX3/cXrnjkfiMDsS+se2Xdr+Xlrp/o1Z5wsgeeXgcYXeYqo55I03FkeOSbDIueaw
         bHYgoP7/t+fveVxzFvBuOtzpJufkvMqLUMXNBM7P0RqurmG9Lgwej8+133rVxjVQt12N
         kDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=slOs5HVUDIi/Tpmu6RLaJrzMYZWLNYUNQu8MlH9pJVg=;
        b=fmS/X1w0wiOy02XQCoh3ZCnZAFdVyeNgGhtNriyyLe78GBf6PQWiEGX/59zgIlE3zv
         BMfJ9olO5zE1xYvmAT05CffdfDXxaY0lmQFMGbjEGBMcY6w6+6EfF9XSeEViSrDdWlU9
         jhscUBGQWA5EVaEsOZDwh6swTjz1711Eo3T/gLmswJq+dexRLwI17VmnBEPcKnmCWMxg
         qZkMhM8iGSPOfNkhYNTRwiXPrF/yepxRCsGe4IC9E9SLiaBW8xcFFRKwhbLhgaF7Ph9r
         ca1+LhpBZdfNdmSPpZJ5YqhHdhgy/g+YLKecrJPyRJUAiQeymEgLg+yxi54vaC3UfIzh
         fWzQ==
X-Gm-Message-State: AA+aEWYRYzReW2W+/J8usLPGdXmnN3fB488eTHcGmDUrt8xVlpX9ZdLv
        kbyLxfui0fmxANAaCgdIUyo=
X-Google-Smtp-Source: AFSGD/Vvax0pYW9NlZyR7zElkVToNVJU1PJQMm6rUcxN2PSXY1xRgUlx+zn2FTTfvTifgdQRzIFGZA==
X-Received: by 2002:a62:4c5:: with SMTP id 188mr46395749pfe.130.1546462781908;
        Wed, 02 Jan 2019 12:59:41 -0800 (PST)
Received: from localhost.localdomain ([2620:0:1008:fd00:78b4:3a07:980a:287b])
        by smtp.gmail.com with ESMTPSA id k24sm79185108pfj.13.2019.01.02.12.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 12:59:41 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH] kernel: release ptraced tasks before zap_pid_ns_processes
Date:   Wed,  2 Jan 2019 12:59:39 -0800
Message-Id: <20190102205939.26231-1-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, exit_ptrace() adds all ptraced tasks in a dead list, than
zap_pid_ns_processes() waits all tasks in a current pid ns, and only
then tasks from the dead list are released.

zap_pid_ns_processes() can stuck on waiting tasks from the dead list. In
this case, we will have one unkillable process with one or more dead
children.

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 kernel/exit.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 0e21e6d21f35..ccaa6f6549ba 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -664,9 +664,6 @@ static void forget_original_parent(struct task_struct *father,
 {
 	struct task_struct *p, *t, *reaper;
 
-	if (unlikely(!list_empty(&father->ptraced)))
-		exit_ptrace(father, dead);
-
 	/* Can drop and reacquire tasklist_lock */
 	reaper = find_child_reaper(father);
 	if (list_empty(&father->children))
@@ -705,8 +702,18 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 	LIST_HEAD(dead);
 
 	write_lock_irq(&tasklist_lock);
-	forget_original_parent(tsk, &dead);
+	if (unlikely(!list_empty(&tsk->ptraced)))
+		exit_ptrace(tsk, &dead);
+	write_unlock_irq(&tasklist_lock);
+
+	/* Ptraced tasks have to be released before zap_pid_ns_processes(). */
+	list_for_each_entry_safe(p, n, &dead, ptrace_entry) {
+		list_del_init(&p->ptrace_entry);
+		release_task(p);
+	}
 
+	write_lock_irq(&tasklist_lock);
+	forget_original_parent(tsk, &dead);
 	if (group_dead)
 		kill_orphaned_pgrp(tsk->group_leader, NULL);
 
-- 
2.17.2

