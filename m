Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B25C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1987B2151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SVDNfpb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1987B2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbeHBPqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:46:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59926 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731383AbeHBPqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Mw2MSrlFc/rB+Yd2SR0XSXmUKcuCrMcUDCiTP7SUgm4=; b=SVDNfpb8hZI875Z5Ss2B8+5zr
        Y8Zn6s0SLs1IkEJ6uUVrqbyahLlw/4Xq/IsjPYLIQaqdh7nemxAcrnvXbC9JWB4s5LeFKiYLDv7x9
        2iW7/w85aUHGvkxqSAs5ye/dulxyZClmWpvgAwIsDPrvzOic0W1eRAFxKTUDLvSiyB+JJgodEBwmI
        auCcjAj4IjgJ2CniHtjuUmxp/2jYXW626SdKJ8JgiqdjM0idSq+P6rXZp1VaJmpYZB3R+cjv50hnD
        N8u+czPyH85njrkVg9GGvOnyLkd5MqAWCmg6gkgpQMwNeplwGE+htjGqCz+YJ47FQYRAAtCXVXeg4
        tV3k3sG2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flE3g-000674-78; Thu, 02 Aug 2018 13:54:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3AAF120268267; Thu,  2 Aug 2018 15:54:26 +0200 (CEST)
Date:   Thu, 2 Aug 2018 15:54:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v5 12/14] sched/fair: Select an energy-efficient CPU on
 task wake-up
Message-ID: <20180802135426.GX2476@hirez.programming.kicks-ass.net>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-13-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724122521.22109-13-quentin.perret@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 01:25:19PM +0100, Quentin Perret wrote:
> @@ -6385,18 +6492,26 @@ static int
>  select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
>  {
>  	struct sched_domain *tmp, *sd = NULL;
> +	struct freq_domain *fd;
>  	int cpu = smp_processor_id();
>  	int new_cpu = prev_cpu;
> -	int want_affine = 0;
> +	int want_affine = 0, want_energy = 0;
>  	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
>  
> +	rcu_read_lock();
>  	if (sd_flag & SD_BALANCE_WAKE) {
>  		record_wakee(p);
> -		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu)
> -			      && cpumask_test_cpu(cpu, &p->cpus_allowed);
> +		fd = rd_freq_domain(cpu_rq(cpu)->rd);
> +		want_energy = fd && !READ_ONCE(cpu_rq(cpu)->rd->overutilized);
> +		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu) &&
> +			      cpumask_test_cpu(cpu, &p->cpus_allowed);
> +	}
> +
> +	if (want_energy) {
> +		new_cpu = find_energy_efficient_cpu(p, prev_cpu, fd);
> +		goto unlock;
>  	}
>  

And I suppose you rely on the compiler to optimize that for the static
key inside rd_freq_domain()... Does it do a good job of that?

That is, would not something like:


	rcu_read_lock();
	if (sd_flag & SD_BALANCE_WAKE) {
		record_wakee(p);

		if (static_branch_unlikely(&sched_energy_present)) {
			struct root_domain *rd = cpu_rq(cpu)->rd;
			struct freq_domain *fd = rd_freq_domain(rd);

			if (fd && !READ_ONCE(rd->overutilized)) {
				new_cpu = find_energy_efficient_cpu(p, prev_cpu, fd);
				goto unlock;
			}
		}

		/* ... */
	}


Be far more clear ?
