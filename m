Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbeFEJyD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:54:03 -0400
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:49078 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751540AbeFEJyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:54:02 -0400
Date: Tue, 5 Jun 2018 10:53:59 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 11/19] sched/numa: Restrict migrating in parallel to the
 same node.
Message-ID: <20180605095359.bbutr4psfyepdd4k@techsingularity.net>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-12-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1528106428-19992-12-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 03:30:20PM +0530, Srikar Dronamraju wrote:
> Since task migration under numa balancing can happen in parallel, more
> than one task might choose to move to the same node at the same time.
> This can cause load imbalances at the node level.
> 
> The problem is more likely if there are more cores per node or more
> nodes in system.
> 
> Use a per-node variable to indicate if task migration
> to the node under numa balance is currently active.
> This per-node variable will not track swapping of tasks.
> 
> Testcase       Time:         Min         Max         Avg      StdDev
> numa01.sh      Real:      434.84      676.90      550.53      106.24
> numa01.sh       Sys:      125.98      217.34      179.41       30.35
> numa01.sh      User:    38318.48    53789.56    45864.17     6620.80
> numa02.sh      Real:       60.06       61.27       60.59        0.45
> numa02.sh       Sys:       14.25       17.86       16.09        1.28
> numa02.sh      User:     5190.13     5225.67     5209.24       13.19
> numa03.sh      Real:      748.21      960.25      823.15       73.51
> numa03.sh       Sys:       96.68      122.10      110.42       11.29
> numa03.sh      User:    58222.16    72595.27    63552.22     5048.87
> numa04.sh      Real:      433.08      630.55      499.30       68.15
> numa04.sh       Sys:      245.22      386.75      306.09       63.32
> numa04.sh      User:    35014.68    46151.72    38530.26     3924.65
> numa05.sh      Real:      394.77      410.07      401.41        5.99
> numa05.sh       Sys:      212.40      301.82      256.23       35.41
> numa05.sh      User:    33224.86    34201.40    33665.61      313.40
> 
> Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
> numa01.sh      Real:      674.61      997.71      785.01      115.95 	 -29.86%
> numa01.sh       Sys:      180.87      318.88      270.13       51.32 	 -33.58%
> numa01.sh      User:    54001.30    71936.50    60495.48     6237.55 	 -24.18%
> numa02.sh      Real:       60.62       62.30       61.46        0.62 	 -1.415%
> numa02.sh       Sys:       15.01       33.63       24.38        6.81 	 -34.00%
> numa02.sh      User:     5234.20     5325.60     5276.23       38.85 	 -1.269%
> numa03.sh      Real:      827.62      946.85      914.48       44.58 	 -9.987%
> numa03.sh       Sys:      135.55      172.40      158.46       12.75 	 -30.31%
> numa03.sh      User:    64839.42    73195.44    70805.96     3061.20 	 -10.24%
> numa04.sh      Real:      481.01      608.76      521.14       47.28 	 -4.190%
> numa04.sh       Sys:      329.59      373.15      353.20       14.20 	 -13.33%
> numa04.sh      User:    37649.09    40722.94    38806.32     1072.32 	 -0.711%
> numa05.sh      Real:      399.21      415.38      409.88        5.54 	 -2.066%
> numa05.sh       Sys:      319.46      418.57      363.31       37.62 	 -29.47%
> numa05.sh      User:    33727.77    34732.68    34127.41      447.11 	 -1.353%
> 
> The commit does cause some performance regression but is needed from
> a fairness/correctness perspective.
> 

While it may cause some performance regressions, it may be due to either
a) some workloads benefit from overloading a node if the tasks idle
frequently or b) the regression may be due to delayed convergence. I'm
not 100% convinced this needs to be done from a correctness point of
view based on just this microbenchmark

-- 
Mel Gorman
SUSE Labs
