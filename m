Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeFEJvl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:51:41 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:58263 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751510AbeFEJvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:51:40 -0400
Date: Tue, 5 Jun 2018 10:51:38 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 10/19] sched/numa: Stop multiple tasks from moving to the
 cpu at the same time
Message-ID: <20180605095138.cslv7wxp7iljqcoe@techsingularity.net>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-11-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1528106428-19992-11-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 03:30:19PM +0530, Srikar Dronamraju wrote:
> Task migration under numa balancing can happen in parallel. More than
> one task might choose to migrate to the same cpu at the same time. This
> can result in
> - During task swap, choosing a task that was not part of the evaluation.
> - During task swap, task which just got moved into its preferred node,
>   moving to a completely different node.
> - During task swap, task failing to move to the preferred node, will have
>   to wait an extra interval for the next migrate opportunity.
> - During task movement, multiple task movements can cause load imbalance.
> 
> This problem is more likely if there are more cores per node or more
> nodes in the system.
> 
> Use a per run-queue variable to check if numa-balance is active on the
> run-queue.
> 

FWIW, I had noticed a similar problem when selecting an idle CPU for
SIS. When prototying something to look at nearby CPUs for cross-node
migrations during wake_affine I found that the patch allowed multiple
tasks to select the same CPU when a waker was waking many wakees and
ultimately dropped the patch. 

Either way for this patch;

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
