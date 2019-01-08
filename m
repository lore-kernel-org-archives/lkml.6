Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97D3C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D9E2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbfAHQuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:50:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfAHQuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:50:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9A4280F91;
        Tue,  8 Jan 2019 16:50:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.103])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7C33D18EF3;
        Tue,  8 Jan 2019 16:50:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  8 Jan 2019 17:50:45 +0100 (CET)
Date:   Tue, 8 Jan 2019 17:50:43 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] kernel: release ptraced tasks before zap_pid_ns_processes
Message-ID: <20190108165043.GA10240@redhat.com>
References: <20190102205939.26231-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102205939.26231-1-avagin@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 08 Jan 2019 16:50:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for delay, vacation,

On 01/02, Andrei Vagin wrote:
>
> zap_pid_ns_processes() can stuck on waiting tasks from the dead list. In
> this case, we will have one unkillable process with one or more dead
> children.

Thanks!

> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -664,9 +664,6 @@ static void forget_original_parent(struct task_struct *father,
>  {
>  	struct task_struct *p, *t, *reaper;
>  
> -	if (unlikely(!list_empty(&father->ptraced)))
> -		exit_ptrace(father, dead);
> -
>  	/* Can drop and reacquire tasklist_lock */
>  	reaper = find_child_reaper(father);
>  	if (list_empty(&father->children))
> @@ -705,8 +702,18 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>  	LIST_HEAD(dead);
>  
>  	write_lock_irq(&tasklist_lock);
> -	forget_original_parent(tsk, &dead);
> +	if (unlikely(!list_empty(&tsk->ptraced)))
> +		exit_ptrace(tsk, &dead);
> +	write_unlock_irq(&tasklist_lock);
> +
> +	/* Ptraced tasks have to be released before zap_pid_ns_processes(). */
> +	list_for_each_entry_safe(p, n, &dead, ptrace_entry) {
> +		list_del_init(&p->ptrace_entry);
> +		release_task(p);
> +	}
>  
> +	write_lock_irq(&tasklist_lock);
> +	forget_original_parent(tsk, &dead);
>  	if (group_dead)
>  		kill_orphaned_pgrp(tsk->group_leader, NULL);

How about a different fix below? It avoids additional write_lock/unlock(tasklist),
and another list_for_each_entry_safe(dead) loop is called only if it is actually
needed.

Or I missed something?

Oleg.


--- x/kernel/exit.c
+++ x/kernel/exit.c
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
@@ -579,6 +581,11 @@ static struct task_struct *find_child_re
 		panic("Attempted to kill init! exitcode=0x%08x\n",
 			father->signal->group_exit_code ?: father->exit_code);
 	}
+
+	list_for_each_entry_safe(p, n, &dead, ptrace_entry) {
+		list_del_init(&p->ptrace_entry);
+		release_task(p);
+	}
 	zap_pid_ns_processes(pid_ns);
 	write_lock_irq(&tasklist_lock);
 
@@ -668,7 +675,7 @@ static void forget_original_parent(struc
 		exit_ptrace(father, dead);
 
 	/* Can drop and reacquire tasklist_lock */
-	reaper = find_child_reaper(father);
+	reaper = find_child_reaper(father, dead);
 	if (list_empty(&father->children))
 		return;
 

