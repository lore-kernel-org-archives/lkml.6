Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9A5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF3F2243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjQMFTxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF3F2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbeKLWmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:42:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727319AbeKLWmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:42:07 -0500
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92626223DD;
        Mon, 12 Nov 2018 12:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542026938;
        bh=uzg8Lt8lHOn6tzLHMow9cY/p+xZSrZdHSOT8JJtg4lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjQMFTxpjHBFUbLbu5IujHMM1foaqTJGoaOIJu1dQaxJ+8cVvSHTGwiAu3+hKT+Ur
         LZX9G6Yr1d/J5bRwT6EbagxTD9llBMESXqHvx/Te+a+PtLa6EAwgTGromEaePdnAwL
         XizknO4Cc7tNKKwdV3O+Mi8YzpZj6YGTrzBv7eWI=
Date:   Mon, 12 Nov 2018 13:48:52 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 24/41] modules: Replace synchronize_sched()
 and call_rcu_sched()
Message-ID: <20181112124852.GA11833@linux-8ccs>
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-24-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181111194410.6368-24-paulmck@linux.ibm.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.22-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Paul E. McKenney [11/11/18 11:43 -0800]:
>Now that synchronize_rcu() waits for preempt-disable regions of code
>as well as RCU read-side critical sections, synchronize_sched() can
>be replaced by synchronize_rcu().  Similarly, call_rcu_sched() can be
>replaced by call_rcu().  This commit therefore makes these changes.
>
>Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
>Cc: Jessica Yu <jeyu@kernel.org>

Acked-by: Jessica Yu <jeyu@kernel.org>

Thanks!

>---
> kernel/module.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 49a405891587..99b46c32d579 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2159,7 +2159,7 @@ static void free_module(struct module *mod)
> 	/* Remove this module from bug list, this uses list_del_rcu */
> 	module_bug_cleanup(mod);
> 	/* Wait for RCU-sched synchronizing before releasing mod->list and buglist. */
>-	synchronize_sched();
>+	synchronize_rcu();
> 	mutex_unlock(&module_mutex);
>
> 	/* This may be empty, but that's OK */
>@@ -3507,15 +3507,15 @@ static noinline int do_init_module(struct module *mod)
> 	/*
> 	 * We want to free module_init, but be aware that kallsyms may be
> 	 * walking this with preempt disabled.  In all the failure paths, we
>-	 * call synchronize_sched(), but we don't want to slow down the success
>+	 * call synchronize_rcu(), but we don't want to slow down the success
> 	 * path, so use actual RCU here.
> 	 * Note that module_alloc() on most architectures creates W+X page
> 	 * mappings which won't be cleaned up until do_free_init() runs.  Any
> 	 * code such as mark_rodata_ro() which depends on those mappings to
> 	 * be cleaned up needs to sync with the queued work - ie
>-	 * rcu_barrier_sched()
>+	 * rcu_barrier()
> 	 */
>-	call_rcu_sched(&freeinit->rcu, do_free_init);
>+	call_rcu(&freeinit->rcu, do_free_init);
> 	mutex_unlock(&module_mutex);
> 	wake_up_all(&module_wq);
>
>@@ -3526,7 +3526,7 @@ static noinline int do_init_module(struct module *mod)
> fail:
> 	/* Try to protect us from buggy refcounters. */
> 	mod->state = MODULE_STATE_GOING;
>-	synchronize_sched();
>+	synchronize_rcu();
> 	module_put(mod);
> 	blocking_notifier_call_chain(&module_notify_list,
> 				     MODULE_STATE_GOING, mod);
>@@ -3819,7 +3819,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  ddebug_cleanup:
> 	ftrace_release_mod(mod);
> 	dynamic_debug_remove(mod, info->debug);
>-	synchronize_sched();
>+	synchronize_rcu();
> 	kfree(mod->args);
>  free_arch_cleanup:
> 	module_arch_cleanup(mod);
>@@ -3834,7 +3834,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
> 	mod_tree_remove(mod);
> 	wake_up_all(&module_wq);
> 	/* Wait for RCU-sched synchronizing before releasing mod->list. */
>-	synchronize_sched();
>+	synchronize_rcu();
> 	mutex_unlock(&module_mutex);
>  free_module:
> 	/* Free lock-classes; relies on the preceding sync_rcu() */
>-- 
>2.17.1
>
