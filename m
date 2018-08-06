Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF3EC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB78621A6C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB78621A6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732634AbeHFSyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730503AbeHFSyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:54:47 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0BB121A67;
        Mon,  6 Aug 2018 16:44:50 +0000 (UTC)
Date:   Mon, 6 Aug 2018 12:44:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        paulmck@linux.vnet.ibm.com, mathieu.desnoyers@efficios.com,
        namhyung@kernel.org, peterz@infradead.org
Subject: Re: [RFC] tracepoint: Run tracepoints even after CPU is offline
Message-ID: <20180806124448.4a722f54@gandalf.local.home>
In-Reply-To: <20180806034437.68464-1-joel@joelfernandes.org>
References: <20180806034437.68464-1-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  5 Aug 2018 20:44:37 -0700
"Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> Commit f37755490fe9 ("tracepoints: Do not trace when cpu is offline")
> causes a problem for lockdep using tracepoint code. Once a CPU is
> offline, tracepoints donot get called, however this causes a big problem
> for lockdep probes that need to run so that IRQ annotations are marked
> correctly.
> 
> An issue is possible where while the CPU is going offline, an interrupt
> can come in and then a lockdep assert causes an annotation warning:
> 
> [  106.551354] IRQs not enabled as expected
> [  106.551785] WARNING: CPU: 1 PID: 0 at kernel/time/tick-sched.c:982
>                                          tick_nohz_idle_enter+0x99/0xb0
> [  106.552964] Modules linked in:
> [  106.553299] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
> 
> We need tracepoints to run as late as possible. This commit tries to fix
> the issue by removing the cpu_online check in tracepoint code that was
> introduced in the mentioned commit, however now we run the risk of
> running dereferencing probes that aren't RCU protected, which gives an
> RCU warning like so on boot up:
> [    0.030159] x86: Booting SMP configuration:
> [    0.030169] .... node  #0, CPUs:      #1
> [    0.001000]
> [    0.001000] =============================
> [    0.001000] WARNING: suspicious RCU usage
> [    0.001000] 4.18.0-rc6+ #42 Not tainted
> [    0.001000] -----------------------------
> [    0.001000] ./include/trace/events/timer.h:38 suspicious
> 				rcu_dereference_check() usage!
> [    0.001000]
> [    0.001000] other info that might help us debug this:
> [    0.001000]
> [    0.001000]
> [    0.001000] RCU used illegally from offline CPU!
> [    0.001000] rcu_scheduler_active = 1, debug_locks = 1
> [    0.001000] no locks held by swapper/1/0.
> [    0.001000]
> 
> Any ideas on how we can fix this? Basically we need RCU to work here
> even after !cpu_online. I thought of just using SRCU for all tracepoints
> however that may mean we can't use tracepoints from NMI..
> 
> Tries-to-Fix: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and
>                              unify their usage")
> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/linux/tracepoint.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index d9a084c72541..020885714a0f 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -365,19 +365,17 @@ extern void syscall_unregfunc(void);
>   * "void *__data, proto" as the callback prototype.
>   */
>  #define DECLARE_TRACE_NOARGS(name)					\
> -	__DECLARE_TRACE(name, void, ,					\
> -			cpu_online(raw_smp_processor_id()),		\
> +	__DECLARE_TRACE(name, void, , 1,				\
>  			void *__data, __data)
>  
>  #define DECLARE_TRACE(name, proto, args)				\
> -	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
> -			cpu_online(raw_smp_processor_id()),		\
> +	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1,		\
>  			PARAMS(void *__data, proto),			\
>  			PARAMS(__data, args))
>  
>  #define DECLARE_TRACE_CONDITION(name, proto, args, cond)		\
>  	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
> -			cpu_online(raw_smp_processor_id()) && (PARAMS(cond)), \
> +			PARAMS(cond),					\
>  			PARAMS(void *__data, proto),			\
>  			PARAMS(__data, args))
>  

Actually, I took a look at it too, and came up with this patch. Can you
test it out? The difference is that it doesn't stop the _rcuidle
version of the trace events to not be called by "cpu_online".

Which brings up another question. Can srcu work on cpu offlined CPUs?

-- Steve

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index d9a084c72541..4aba6c807d28 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -211,8 +211,11 @@ extern void syscall_unregfunc(void);
 			__DO_TRACE(&__tracepoint_##name,		\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
+				cpu_online(raw_smp_processor_id()) &&	\
 				TP_CONDITION(cond), 0);			\
-		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
+		if (IS_ENABLED(CONFIG_LOCKDEP) &&			\
+		    cpu_online(raw_smp_processor_id()) &&		\
+		    (cond)) {						\
 			rcu_read_lock_sched_notrace();			\
 			rcu_dereference_sched(__tracepoint_##name.funcs);\
 			rcu_read_unlock_sched_notrace();		\
@@ -365,19 +368,17 @@ extern void syscall_unregfunc(void);
  * "void *__data, proto" as the callback prototype.
  */
 #define DECLARE_TRACE_NOARGS(name)					\
-	__DECLARE_TRACE(name, void, ,					\
-			cpu_online(raw_smp_processor_id()),		\
+	__DECLARE_TRACE(name, void, , 1,				\
 			void *__data, __data)
 
 #define DECLARE_TRACE(name, proto, args)				\
-	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
-			cpu_online(raw_smp_processor_id()),		\
+	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1,		\
 			PARAMS(void *__data, proto),			\
 			PARAMS(__data, args))
 
 #define DECLARE_TRACE_CONDITION(name, proto, args, cond)		\
 	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
-			cpu_online(raw_smp_processor_id()) && (PARAMS(cond)), \
+			PARAMS(cond),					\
 			PARAMS(void *__data, proto),			\
 			PARAMS(__data, args))
 
