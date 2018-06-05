Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeFEJ6q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:58:46 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:38065 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751473AbeFEJ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:58:44 -0400
Date: Tue, 5 Jun 2018 10:58:43 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 18/19] sched/numa: Reset scan rate whenever task moves
 across nodes
Message-ID: <20180605095843.gfanebla26zvq62j@techsingularity.net>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-19-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1528106428-19992-19-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 03:30:27PM +0530, Srikar Dronamraju wrote:
> Currently task scan rate is reset when numa balancer migrates the task
> to a different node. If numa balancer initiates a swap, reset is only
> applicable to the task that initiates the swap. Similarly no scan rate
> reset is done if the task is migrated across nodes by traditional load
> balancer.
> 
> Instead move the scan reset to the migrate_task_rq. This ensures the
> task moved out of its preferred node, either gets back to its preferred
> node quickly or finds a new preferred node. Doing so, would be fair to
> all tasks migrating across nodes.
> 

By and large you need to be very careful resetting the scan rate without
a lot of justification and I don't think this is enough. With scan rate
resets, there is a significant risk that system CPU overhead is
increased to do the page table updates and handle the resulting minor
faults. There are cases where tasks can get pulled cross-node very
frequently and we do not want NUMA balancing scanning agressively when
that happens.

-- 
Mel Gorman
SUSE Labs
