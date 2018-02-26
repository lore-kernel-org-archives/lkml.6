Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbeBZXfw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:35:52 -0500
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:37417 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBZXfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:35:51 -0500
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.184
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [PATCH] rcu: Remove the unnecessary separate function,
 rcu_preempt_do_callback()
To: paulmck@linux.vnet.ibm.com, Steven Rostedt <rostedt@goodmis.org>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
References: <1519621896-8786-1-git-send-email-byungchul.park@lge.com>
 <20180226121514.122669b9@vmware.local.home>
 <20180226182254.GU2855@linux.vnet.ibm.com>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <3513ccbe-f803-dbb9-7f14-117e1e39c125@lge.com>
Date: Tue, 27 Feb 2018 08:35:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226182254.GU2855@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/2018 3:22 AM, Paul E. McKenney wrote:
> On Mon, Feb 26, 2018 at 12:15:14PM -0500, Steven Rostedt wrote:
>> On Mon, 26 Feb 2018 14:11:36 +0900
>> Byungchul Park <byungchul.park@lge.com> wrote:
>>
>>> rcu_preemptp_do_callback() was introduced in commit 09223371dea(rcu:
>>> Use softirq to address performance regression), where it had to be
>>> distinguished between in the case CONFIG_TREE_PREEMPT_RCU is set and
>>> it's not.
>>>
>>> Now that the code was cleaned up so that rcu_preemt_do_callback() is
>>> only called in rcu_kthread_do_work() in the same file, tree_plugin.h,
>>> we don't have to keep the separate function anymore. Remove it for a
>>> better readability.
>>
>> Looks good to me (looks like commit f8b7fc6b51 "rcu: use softirq
>> instead of kthreads except when RCU_BOOST=y" cleaned up the ifdefs and
>> removed the requirement).
>>
>> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Thank you both!  I have queued a slightly modified patch for testing
> and further review.  Please see below and let me know if I messed
> something up.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit b8a3012ddba397d4a18d9fd4a00432f8c2626bd6
> Author: Byungchul Park <byungchul.park@lge.com>
> Date:   Mon Feb 26 14:11:36 2018 +0900
> 
>      rcu: Inline rcu_preempt_do_callback() into its sole caller
>      
>      The rcu_preempt_do_callbacks() function was introduced in commit
>      09223371dea(rcu: Use softirq to address performance regression), where it
>      was necessary to handle kernel builds both containing and not containing
>      RCU-preempt.  Since then, various changes (most notably f8b7fc6b51
>      ("rcu: use softirq instead of kthreads except when RCU_BOOST=y")) have
>      resulted in this function being invoked only from rcu_kthread_do_work(),
>      which is present only in kernels containing RCU-preempt, which in turn
>      means that the rcu_preempt_do_callbacks() function is no longer needed.
>      
>      This commit therefore inlines rcu_preempt_do_callbacks() into its
>      sole remaining caller and also removes the rcu_state_p and rcu_data_p
>      indirection for added clarity.
>      
>      Signed-off-by: Byungchul Park <byungchul.park@lge.com>
>      Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>      [ paulmck: Remove the rcu_state_p and rcu_data_p indirection. ]
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index dc6f2319fc21..9dd0ea77faed 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -449,7 +449,6 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
>   static void invoke_rcu_callbacks_kthread(void);
>   static bool rcu_is_callbacks_kthread(void);
>   #ifdef CONFIG_RCU_BOOST
> -static void rcu_preempt_do_callbacks(void);
>   static int rcu_spawn_one_boost_kthread(struct rcu_state *rsp,
>   						 struct rcu_node *rnp);
>   #endif /* #ifdef CONFIG_RCU_BOOST */
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 26d7a31e81cb..b0d7f9ba6bf2 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -686,15 +686,6 @@ static void rcu_preempt_check_callbacks(void)
>   		t->rcu_read_unlock_special.b.need_qs = true;
>   }
>   
> -#ifdef CONFIG_RCU_BOOST
> -
> -static void rcu_preempt_do_callbacks(void)
> -{
> -	rcu_do_batch(rcu_state_p, this_cpu_ptr(rcu_data_p));
> -}
> -
> -#endif /* #ifdef CONFIG_RCU_BOOST */
> -
>   /**
>    * call_rcu() - Queue an RCU callback for invocation after a grace period.
>    * @head: structure to be used for queueing the RCU updates.
> @@ -1170,7 +1161,7 @@ static void rcu_kthread_do_work(void)
>   {
>   	rcu_do_batch(&rcu_sched_state, this_cpu_ptr(&rcu_sched_data));
>   	rcu_do_batch(&rcu_bh_state, this_cpu_ptr(&rcu_bh_data));
> -	rcu_preempt_do_callbacks();
> +	rcu_do_batch(&rcu_preempt_state, this_cpu_ptr(&rcu_preempt_data));

OMG. Sorry for the mistake and thank you very much for fixing it.

I will be more careful.

-- 
Thanks,
Byungchul
