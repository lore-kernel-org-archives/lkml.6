Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0662C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CD52086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CD52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935201AbeFROox (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:44:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33793 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934109AbeFROov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:44:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 443BE308625D;
        Mon, 18 Jun 2018 14:44:51 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-25.phx2.redhat.com [10.3.117.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 305DD26DCC;
        Mon, 18 Jun 2018 14:44:41 +0000 (UTC)
Subject: Re: [PATCH v10 6/9] cpuset: Make generate_sched_domains() recognize
 isolated_cpus
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1529295249-5207-1-git-send-email-longman@redhat.com>
 <1529295249-5207-7-git-send-email-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <64a0ea0d-c873-f53e-654e-1dd60f833478@redhat.com>
Date:   Mon, 18 Jun 2018 22:44:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1529295249-5207-7-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 18 Jun 2018 14:44:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 12:14 PM, Waiman Long wrote:
> The generate_sched_domains() function and the hotplug code are modified
> to make them use the newly introduced isolated_cpus mask for schedule
> domains generation.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index cfc9b7b..5ee4239 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -672,13 +672,14 @@ static int generate_sched_domains(cpumask_var_t **domains,
>  	int ndoms = 0;		/* number of sched domains in result */
>  	int nslot;		/* next empty doms[] struct cpumask slot */
>  	struct cgroup_subsys_state *pos_css;
> +	bool root_load_balance = is_sched_load_balance(&top_cpuset);
>  
>  	doms = NULL;
>  	dattr = NULL;
>  	csa = NULL;
>  
>  	/* Special case for the 99% of systems with one, full, sched domain */
> -	if (is_sched_load_balance(&top_cpuset)) {
> +	if (root_load_balance && !top_cpuset.isolation_count) {
>  		ndoms = 1;
>  		doms = alloc_sched_domains(ndoms);
>  		if (!doms)
> @@ -701,6 +702,8 @@ static int generate_sched_domains(cpumask_var_t **domains,
>  	csn = 0;
>  
>  	rcu_read_lock();
> +	if (root_load_balance)
> +		csa[csn++] = &top_cpuset;
>  	cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {
>  		if (cp == &top_cpuset)
>  			continue;
> @@ -711,6 +714,9 @@ static int generate_sched_domains(cpumask_var_t **domains,
>  		 * parent's cpus, so just skip them, and then we call
>  		 * update_domain_attr_tree() to calc relax_domain_level of
>  		 * the corresponding sched domain.
> +		 *
> +		 * If root is load-balancing, we can skip @cp if it
> +		 * is a subset of the root's effective_cpus.
>  		 */
>  		if (!cpumask_empty(cp->cpus_allowed) &&
>  		    !(is_sched_load_balance(cp) &&
> @@ -718,11 +724,16 @@ static int generate_sched_domains(cpumask_var_t **domains,
>  					 housekeeping_cpumask(HK_FLAG_DOMAIN))))
>  			continue;
>  
> +		if (root_load_balance &&
> +		    cpumask_subset(cp->cpus_allowed, top_cpuset.effective_cpus))
> +			continue;
> +
>  		if (is_sched_load_balance(cp))
>  			csa[csn++] = cp;
>  
> -		/* skip @cp's subtree */
> -		pos_css = css_rightmost_descendant(pos_css);
> +		/* skip @cp's subtree if not a scheduling domain root */
> +		if (!is_sched_domain_root(cp))
> +			pos_css = css_rightmost_descendant(pos_css);
>  	}
>  	rcu_read_unlock();
>  
> @@ -849,7 +860,12 @@ static void rebuild_sched_domains_locked(void)
>  	 * passing doms with offlined cpu to partition_sched_domains().
>  	 * Anyways, hotplug work item will rebuild sched domains.
>  	 */
> -	if (!cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
> +	if (!top_cpuset.isolation_count &&
> +	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
> +		goto out;
> +
> +	if (top_cpuset.isolation_count &&
> +	   !cpumask_subset(top_cpuset.effective_cpus, cpu_active_mask))
>  		goto out;
>  
>  	/* Generate domain masks and attrs */

Sorry, that one is bogus. Please ignore that.

NAK

