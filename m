Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F08EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDBD2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YOgcOO1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfBDMDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:03:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35666 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbfBDMC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bg4hjxM5IGBEf79h/YG7PxQxXFu6QKqjbZsWvg+yTME=; b=YOgcOO1pIX+4vsm+OXVzah8p7
        acFfb58No07LKiXH3dAMcG7yoAxlvMDiYfpQihTf6w9dk/FfSUmQhc0KNr8knY+g3XJW7Tz9LjNfi
        6t34AZ1nDDYQAR7kcYBm0Y36dPIGiBFWdaSqJmomAxV4U40STrquMC2Ifb8EYl0oquS+jURZtjUgE
        nIqgPthb1YvPBRXlYpbrFVn+tEBvLZI3/IZkS0/HiVEQ8pg7hlG0xFY13CRQ4EqTda35cpOY20CbR
        D+2Fb54UAATaOhZKcIk3B0Tw8qpFhkKudjGnGUaW1A5fG8gfEvv1jKHqTbTW6dC2M8MqrnbZX3We5
        I80cWQZcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqcxR-0002Fq-RL; Mon, 04 Feb 2019 12:02:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 985652029FA06; Mon,  4 Feb 2019 13:02:36 +0100 (CET)
Date:   Mon, 4 Feb 2019 13:02:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v6 3/5] cgroup/cpuset: make callback_lock raw
Message-ID: <20190204120236.GC17550@hirez.programming.kicks-ass.net>
References: <20190117084739.17078-1-juri.lelli@redhat.com>
 <20190117084739.17078-4-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117084739.17078-4-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 09:47:37AM +0100, Juri Lelli wrote:
> @@ -3233,11 +3233,11 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&callback_lock, flags);
> +	raw_spin_lock_irqsave(&callback_lock, flags);
>  	rcu_read_lock();
>  	guarantee_online_cpus(task_cs(tsk), pmask);
>  	rcu_read_unlock();
> -	spin_unlock_irqrestore(&callback_lock, flags);
> +	raw_spin_unlock_irqrestore(&callback_lock, flags);
>  }
>  
>  void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
> @@ -3285,11 +3285,11 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
>  	nodemask_t mask;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&callback_lock, flags);
> +	raw_spin_lock_irqsave(&callback_lock, flags);
>  	rcu_read_lock();
>  	guarantee_online_mems(task_cs(tsk), &mask);
>  	rcu_read_unlock();
> -	spin_unlock_irqrestore(&callback_lock, flags);
> +	raw_spin_unlock_irqrestore(&callback_lock, flags);
>  
>  	return mask;
>  }
> @@ -3381,14 +3381,14 @@ bool __cpuset_node_allowed(int node, gfp_t gfp_mask)
>  		return true;
>  
>  	/* Not hardwall and node outside mems_allowed: scan up cpusets */
> -	spin_lock_irqsave(&callback_lock, flags);
> +	raw_spin_lock_irqsave(&callback_lock, flags);
>  
>  	rcu_read_lock();
>  	cs = nearest_hardwall_ancestor(task_cs(current));
>  	allowed = node_isset(node, cs->mems_allowed);
>  	rcu_read_unlock();
>  
> -	spin_unlock_irqrestore(&callback_lock, flags);
> +	raw_spin_unlock_irqrestore(&callback_lock, flags);
>  	return allowed;
>  }

These three appear to be a user-controlled O(n) (depth of cgroup tree).
Which is basically bad for raw_spinlock_t.

The Changelog should really have mentioned this; and ideally we'd
somehow avoid this.
