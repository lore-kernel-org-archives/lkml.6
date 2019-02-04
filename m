Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AF0C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6522420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277750;
	bh=RExyV5+2oKBZRdAc3a+1ayhpX9W7MorO7HF/rGi4aks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2AnzP6ZJfxpvVsTgx6eruDFJEMtF5ibze7Iiwj9hMJWp1Klc7naENhGtEIkToDATP
	 tTcMw0eMgdJxr52CPf6m7GaC5pKhvuNxZaR/V0GrF3rex8erWEmmwCrUr5b35S20+y
	 en32qBEFMNeTQ/8l4gzncqztlgH3HAD+F+hwxGSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732335AbfBDKzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:55:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732761AbfBDKx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:53:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55653217FA;
        Mon,  4 Feb 2019 10:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277606;
        bh=RExyV5+2oKBZRdAc3a+1ayhpX9W7MorO7HF/rGi4aks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDZeDckfWjNpL+LVAa9L3PJ71UNi/Hp2SHnlU+wba0fvQiZ5k4m+ZnZ20qgrQ7XY5
         avi6GgPMdme+K3eLFgFIipDwh2ObZwHQaDpkjbPGXFJhS26nNOEE48+xcu1TkaTanu
         eT8rB5hO0t9iWePN3+9StUkY3/Zcb/5ZvlkJcRDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.20 68/80] kernel/exit.c: release ptraced tasks before zap_pid_ns_processes
Date:   Mon,  4 Feb 2019 11:37:28 +0100
Message-Id: <20190204103629.518679455@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrei Vagin <avagin@gmail.com>

commit 8fb335e078378c8426fabeed1ebee1fbf915690c upstream.

Currently, exit_ptrace() adds all ptraced tasks in a dead list, then
zap_pid_ns_processes() waits on all tasks in a current pidns, and only
then are tasks from the dead list released.

zap_pid_ns_processes() can get stuck on waiting tasks from the dead
list.  In this case, we will have one unkillable process with one or
more dead children.

Thanks to Oleg for the advice to release tasks in find_child_reaper().

Link: http://lkml.kernel.org/r/20190110175200.12442-1-avagin@gmail.com
Fixes: 7c8bd2322c7f ("exit: ptrace: shift "reap dead" code from exit_ptrace() to forget_original_parent()")
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/exit.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -558,12 +558,14 @@ static struct task_struct *find_alive_th
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
@@ -579,6 +581,12 @@ static struct task_struct *find_child_re
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
 
@@ -668,7 +676,7 @@ static void forget_original_parent(struc
 		exit_ptrace(father, dead);
 
 	/* Can drop and reacquire tasklist_lock */
-	reaper = find_child_reaper(father);
+	reaper = find_child_reaper(father, dead);
 	if (list_empty(&father->children))
 		return;
 


