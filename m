Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58697C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1271D20836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1271D20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932902AbeFUKFI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:05:08 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:42078 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753933AbeFUKFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:05:06 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id A34BD98AB2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:05:05 +0000 (UTC)
Received: (qmail 26419 invoked from network); 21 Jun 2018 10:05:05 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.171])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 21 Jun 2018 10:05:05 -0000
Date:   Thu, 21 Jun 2018 11:05:05 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 18/19] sched/numa: Reset scan rate whenever task moves
 across nodes
Message-ID: <20180621100505.a6gzpn7r6yj2gkgd@techsingularity.net>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1529514181-9842-19-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1529514181-9842-19-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:32:59PM +0530, Srikar Dronamraju wrote:
> @@ -6668,6 +6662,19 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu __maybe_unus
>  
>  	/* We have migrated, no longer consider this task hot */
>  	p->se.exec_start = 0;
> +
> +#ifdef CONFIG_NUMA_BALANCING
> +	if (!p->mm || (p->flags & PF_EXITING))
> +		return;
> +
> +	if (p->numa_faults) {
> +		int src_nid = cpu_to_node(task_cpu(p));
> +		int dst_nid = cpu_to_node(new_cpu);
> +
> +		if (src_nid != dst_nid)
> +			p->numa_scan_period = task_scan_start(p);
> +	}
> +#endif
>  }
>  

We talked about this before but I would at least suggest that you not
reset the scan if moving to the preferred node or if the node movement
has nothing to do with the preferred nid. e.g.

	/*
	 * Ignore if the migration is not changing node, if it is migrating to
	 * the preferred node or moving between two nodes that are not preferred
	 */

	if (p->numa_faults) {
		int src_nid = cpu_to_node(task_cpu(p));
		int dst_nid = cpu_to_node(new_cpu);

		if (src_nid == dst_nid || dst_nid == p->numa_preferred_nid ||
		    (p->numa_preferred_nid != -1 && src_nid != p->numa_preferred_nid))
			return;

		p->numa_scan_period = task_scan_start(p);

Note too that the next scan can be an arbitrary amount of time in the
future. Consider as an alternative to schedule an immediate scan instead
of adjusting the rate with

		p->mm->numa_next_scan = jiffies;

That might be less harmful in terms of overhead while still collecting
some data in the short-term.

-- 
Mel Gorman
SUSE Labs
