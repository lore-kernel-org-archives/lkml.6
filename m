Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeENJjP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:39:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56526 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbeENJjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:39:13 -0400
Date: Mon, 14 May 2018 11:39:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Ingo Molnar <mingo@kernel.org>, Andre Wild <wild@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [bisected] 051f3ca02e46 "Introduce NUMA identity node sched
 domain" breaks fake NUMA on s390
Message-ID: <20180514093909.GO12217@hirez.programming.kicks-ass.net>
References: <20180512100233.GB3738@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180512100233.GB3738@osiris>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 12:02:33PM +0200, Heiko Carstens wrote:
> Hello,
> 
> Andre Wild reported that fake NUMA doesn't work on s390 anymore. Doesn't
> work means it crashed for Andre, or it is in an endless loop within
> init_sched_groups_capacity() for me (sg != sd->groups is always true).
> 
> I could reproduce this with a very simple setup with only two nodes, where
> each node has only one CPU. This allowed me to bisect it down to commit
> 051f3ca02e46 ("sched/topology: Introduce NUMA identity node sched domain").
> 
> With that commit reverted the system comes up again and the scheduling
> domains look like this:
> 
> [    0.148592] smp: Bringing up secondary CPUs ...
> [    0.148984] smp: Brought up 2 nodes, 2 CPUs
> [    0.149097] CPU0 attaching sched-domain(s):
> [    0.149099]  domain-0: span=0-1 level=NUMA
> [    0.149101]   groups: 0:{ span=0 }, 1:{ span=1 }
> [    0.149106] CPU1 attaching sched-domain(s):
> [    0.149107]  domain-0: span=0-1 level=NUMA
> [    0.149108]   groups: 1:{ span=1 }, 0:{ span=0 }
> [    0.149111] span: 0-1 (max cpu_capacity = 1024)
> 
> Any idea what's going wrong?

Not yet; still trying to decipher your fake nume implementation.

But meanwhile; could you provide me with:

$ cat /sys/devices/system/node/node*/distance
$ cat /sys/devices/system/node/node*/cpulist
