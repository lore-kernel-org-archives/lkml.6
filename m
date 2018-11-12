Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F58C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29121214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmzyY+j+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29121214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbeKLMv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:51:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbeKLMv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:51:57 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C1CC208A3;
        Mon, 12 Nov 2018 03:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541991652;
        bh=VX/wc7asnQUDSmjpNuhkN4UhbmvbrnMP0iacEt1+/zw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PmzyY+j+JmktHnj88DeRP/MkXXd/iU31bR3fyxg7vVsd5G6qiFoUgtavIvFvT9klp
         t+BMIcBQFPG37B9fnx19x32A5jLzBRbsQ4OKtpB/qgtLNshWm2g5dM1aT85WsvyFvN
         rnfv/TMRjVb8Nx8gPRVtk5PmAPAvDTpccuSiP5FY=
Date:   Mon, 12 Nov 2018 12:00:48 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH tip/core/rcu 20/41] kprobes: eplace synchronize_sched()
 with synchronize_rcu()
Message-Id: <20181112120048.12b3fb7549f4b292fea1eefd@kernel.org>
In-Reply-To: <20181111194410.6368-20-paulmck@linux.ibm.com>
References: <20181111194104.GA4787@linux.ibm.com>
        <20181111194410.6368-20-paulmck@linux.ibm.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018 11:43:49 -0800
"Paul E. McKenney" <paulmck@linux.ibm.com> wrote:

> Now that synchronize_rcu() waits for preempt-disable regions of code
> as well as RCU read-side critical sections, synchronize_sched() can be
> replaced by synchronize_rcu().  This commit therefore makes this change.

Would you mean synchronize_rcu() can ensure that any interrupt handler
(which should run under preempt-disable state) run out (even on non-preemptive
kernel)?
If so, I agree with these changes.

Thank you,

> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 90e98e233647..08e31d863191 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -229,7 +229,7 @@ static int collect_garbage_slots(struct kprobe_insn_cache *c)
>  	struct kprobe_insn_page *kip, *next;
>  
>  	/* Ensure no-one is interrupted on the garbages */
> -	synchronize_sched();
> +	synchronize_rcu();
>  
>  	list_for_each_entry_safe(kip, next, &c->pages, list) {
>  		int i;
> @@ -1382,7 +1382,7 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
>  			if (ret) {
>  				ap->flags |= KPROBE_FLAG_DISABLED;
>  				list_del_rcu(&p->list);
> -				synchronize_sched();
> +				synchronize_rcu();
>  			}
>  		}
>  	}
> @@ -1597,7 +1597,7 @@ int register_kprobe(struct kprobe *p)
>  		ret = arm_kprobe(p);
>  		if (ret) {
>  			hlist_del_rcu(&p->hlist);
> -			synchronize_sched();
> +			synchronize_rcu();
>  			goto out;
>  		}
>  	}
> @@ -1776,7 +1776,7 @@ void unregister_kprobes(struct kprobe **kps, int num)
>  			kps[i]->addr = NULL;
>  	mutex_unlock(&kprobe_mutex);
>  
> -	synchronize_sched();
> +	synchronize_rcu();
>  	for (i = 0; i < num; i++)
>  		if (kps[i]->addr)
>  			__unregister_kprobe_bottom(kps[i]);
> @@ -1966,7 +1966,7 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
>  			rps[i]->kp.addr = NULL;
>  	mutex_unlock(&kprobe_mutex);
>  
> -	synchronize_sched();
> +	synchronize_rcu();
>  	for (i = 0; i < num; i++) {
>  		if (rps[i]->kp.addr) {
>  			__unregister_kprobe_bottom(&rps[i]->kp);
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
