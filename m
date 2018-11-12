Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B1EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7802E2241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7802E2241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbeKMCgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:36:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39484 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbeKMCgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:36:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19F4E15AB;
        Mon, 12 Nov 2018 08:42:15 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD10A3F5CF;
        Mon, 12 Nov 2018 08:42:12 -0800 (PST)
Subject: Re: [PATCH v3 03/10] sched/topology: Provide cfs_overload_cpus bitmap
To:     Steve Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
 <1541767840-93588-4-git-send-email-steven.sistare@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <de2d2824-d66e-8852-d67a-d58b478b74c1@arm.com>
Date:   Mon, 12 Nov 2018 16:42:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541767840-93588-4-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 09/11/2018 12:50, Steve Sistare wrote:
> From: Steve Sistare <steve.sistare@oracle.com>
> 
> Define and initialize a sparse bitmap of overloaded CPUs, per
> last-level-cache scheduling domain, for use by the CFS scheduling class.
> Save a pointer to cfs_overload_cpus in the rq for efficient access.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/linux/sched/topology.h |  1 +
>  kernel/sched/sched.h           |  2 ++
>  kernel/sched/topology.c        | 21 +++++++++++++++++++--
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 6b99761..b173a77 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -72,6 +72,7 @@ struct sched_domain_shared {
>  	atomic_t	ref;
>  	atomic_t	nr_busy_cpus;
>  	int		has_idle_cores;
> +	struct sparsemask *cfs_overload_cpus;

Thinking about misfit stealing, we can't use the sd_llc_shared's because
on big.LITTLE misfit migrations happen across LLC domains.

I was thinking of adding a misfit sparsemask to the root_domain, but
then I thought we could do the same thing for cfs_overload_cpus.

By doing so we'd have a single source of information for overloaded CPUs,
and we could filter that down during idle balance - you mentioned earlier
wanting to try stealing at each SD level. This would also let you get
rid of [PATCH 02].

The main part of try_steal() could then be written down as something like
this:

----->8-----

for_each_domain(this_cpu, sd) {
	span = sched_domain_span(sd)
		
	for_each_sparse_wrap(src_cpu, overload_cpus) {
		if (cpumask_test_cpu(src_cpu, span) &&
		    steal_from(dts_rq, dst_rf, &locked, src_cpu)) {
			stolen = 1;
			goto out;
		}
	}
}

------8<-----

We could limit the stealing to stop at the highest SD_SHARE_PKG_RESOURCES
domain for now so there would be no behavioural change - but we'd
factorize the #ifdef SCHED_SMT bit. Furthermore, the door would be open
to further stealing.

What do you think?

[...]
