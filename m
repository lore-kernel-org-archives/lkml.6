Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754313AbeBGN7H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:59:07 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37227 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753648AbeBGN7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:59:06 -0500
X-Google-Smtp-Source: AH8x2255qluYKSmhGBLwalJRi6wL86AAWodyV8cugjgfjLZTC2BpT1wHxh2fZHSI2wkPjjwiQt9K8A==
Date: Wed, 7 Feb 2018 13:59:02 +0000
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Atish Patra <atish.patra@oracle.com>
Cc: linux-kernel@vger.kernel.org, joelaf@google.com, jbacik@fb.com,
        mingo@redhat.com, peterz@infradead.org, efault@gmx.de,
        urezki@gmail.com
Subject: Re: [PATCH RFC v2] sched: Minimize the idle cpu selection race
 window.
Message-ID: <20180207135902.GA3505@codeblueprint.co.uk>
References: <1512500947-24444-1-git-send-email-atish.patra@oracle.com>
 <1512500947-24444-2-git-send-email-atish.patra@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1512500947-24444-2-git-send-email-atish.patra@oracle.com>
User-Agent: Mutt/1.5.24+42 (6e565710a064) (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec, at 01:09:07PM, Atish Patra wrote:
> Currently, multiple tasks can wakeup on same cpu from
> select_idle_sibiling() path in case they wakeup simulatenously
> and last ran on the same llc. This happens because an idle cpu
> is not updated until idle task is scheduled out. Any task waking
> during that period may potentially select that cpu for a wakeup
> candidate.
> 
> Introduce a per cpu variable that is set as soon as a cpu is
> selected for wakeup for any task. This prevents from other tasks
> to select the same cpu again. Note: This does not close the race
> window but minimizes it to accessing the per-cpu variable. If two
> wakee tasks access the per cpu variable at the same time, they may
> select the same cpu again. But it minimizes the race window
> considerably.
> 
> Here are some performance numbers:

I ran this patch through some tests here on the SUSE performance grid
and there's a definite regression for Mike's personal favourite
benchmark, tbench.

Here are the results: vanilla 4.15-rc9 on the left, -rc9 plus this
patch on the right.

tbench4
                                 4.15.0-rc9             4.15.0-rc9
                                    vanillasched-minimize-idle-cpu-window
Min       mb/sec-1        484.50 (   0.00%)      463.03 (  -4.43%)
Min       mb/sec-2        961.43 (   0.00%)      959.35 (  -0.22%)
Min       mb/sec-4       1789.60 (   0.00%)     1760.21 (  -1.64%)
Min       mb/sec-8       3518.51 (   0.00%)     3471.47 (  -1.34%)
Min       mb/sec-16      5521.12 (   0.00%)     5409.77 (  -2.02%)
Min       mb/sec-32      7268.61 (   0.00%)     7491.29 (   3.06%)
Min       mb/sec-64     14413.45 (   0.00%)    14347.69 (  -0.46%)
Min       mb/sec-128    13501.84 (   0.00%)    13413.82 (  -0.65%)
Min       mb/sec-192    13237.02 (   0.00%)    13231.43 (  -0.04%)
Hmean     mb/sec-1        505.20 (   0.00%)      485.81 (  -3.84%)
Hmean     mb/sec-2        973.12 (   0.00%)      970.67 (  -0.25%)
Hmean     mb/sec-4       1835.22 (   0.00%)     1788.54 (  -2.54%)
Hmean     mb/sec-8       3529.35 (   0.00%)     3487.20 (  -1.19%)
Hmean     mb/sec-16      5531.16 (   0.00%)     5437.43 (  -1.69%)
Hmean     mb/sec-32      7627.96 (   0.00%)     8021.26 (   5.16%)
Hmean     mb/sec-64     14441.20 (   0.00%)    14395.08 (  -0.32%)
Hmean     mb/sec-128    13620.40 (   0.00%)    13569.17 (  -0.38%)
Hmean     mb/sec-192    13265.26 (   0.00%)    13263.98 (  -0.01%)
Max       mb/sec-1        510.30 (   0.00%)      489.89 (  -4.00%)
Max       mb/sec-2        989.45 (   0.00%)      976.10 (  -1.35%)
Max       mb/sec-4       1845.65 (   0.00%)     1795.50 (  -2.72%)
Max       mb/sec-8       3574.03 (   0.00%)     3547.56 (  -0.74%)
Max       mb/sec-16      5556.99 (   0.00%)     5564.80 (   0.14%)
Max       mb/sec-32      7678.18 (   0.00%)     8098.63 (   5.48%)
Max       mb/sec-64     14463.07 (   0.00%)    14437.58 (  -0.18%)
Max       mb/sec-128    13659.67 (   0.00%)    13602.65 (  -0.42%)
Max       mb/sec-192    13612.01 (   0.00%)    13832.98 (   1.62%)

There's a nice little performance bump around the 32-client mark.
Incidentally, my test machine has 2 NUMA nodes with 24 cpus (12 cores,
2 threads) each. So 32 clients is the point at which things no longer
fit on a single node.

It doesn't look like the regression is caused by the schedule() path
being slightly longer (i.e. it's not a latency issue) because schbench
results show improvements for the low-end:

schbench
                                 4.15.0-rc9             4.15.0-rc9
                                    vanillasched-minimize-idle-cpu-window
Lat 50.00th-qrtle-1        46.00 (   0.00%)       36.00 (  21.74%)
Lat 75.00th-qrtle-1        49.00 (   0.00%)       37.00 (  24.49%)
Lat 90.00th-qrtle-1        52.00 (   0.00%)       38.00 (  26.92%)
Lat 95.00th-qrtle-1        56.00 (   0.00%)       41.00 (  26.79%)
Lat 99.00th-qrtle-1        61.00 (   0.00%)       46.00 (  24.59%)
Lat 99.50th-qrtle-1        63.00 (   0.00%)       48.00 (  23.81%)
Lat 99.90th-qrtle-1        77.00 (   0.00%)       64.00 (  16.88%)
Lat 50.00th-qrtle-2        41.00 (   0.00%)       41.00 (   0.00%)
Lat 75.00th-qrtle-2        47.00 (   0.00%)       46.00 (   2.13%)
Lat 90.00th-qrtle-2        50.00 (   0.00%)       49.00 (   2.00%)
Lat 95.00th-qrtle-2        53.00 (   0.00%)       52.00 (   1.89%)
Lat 99.00th-qrtle-2        58.00 (   0.00%)       57.00 (   1.72%)
Lat 99.50th-qrtle-2        60.00 (   0.00%)       59.00 (   1.67%)
Lat 99.90th-qrtle-2        72.00 (   0.00%)       69.00 (   4.17%)
Lat 50.00th-qrtle-4        46.00 (   0.00%)       45.00 (   2.17%)
Lat 75.00th-qrtle-4        49.00 (   0.00%)       48.00 (   2.04%)
Lat 90.00th-qrtle-4        52.00 (   0.00%)       51.00 (   1.92%)
Lat 95.00th-qrtle-4        55.00 (   0.00%)       53.00 (   3.64%)
Lat 99.00th-qrtle-4        61.00 (   0.00%)       59.00 (   3.28%)
Lat 99.50th-qrtle-4        63.00 (   0.00%)       61.00 (   3.17%)
Lat 99.90th-qrtle-4        69.00 (   0.00%)       74.00 (  -7.25%)
Lat 50.00th-qrtle-8        48.00 (   0.00%)       50.00 (  -4.17%)
Lat 75.00th-qrtle-8        52.00 (   0.00%)       54.00 (  -3.85%)
Lat 90.00th-qrtle-8        54.00 (   0.00%)       58.00 (  -7.41%)
Lat 95.00th-qrtle-8        57.00 (   0.00%)       61.00 (  -7.02%)
Lat 99.00th-qrtle-8        64.00 (   0.00%)       68.00 (  -6.25%)
Lat 99.50th-qrtle-8        67.00 (   0.00%)       72.00 (  -7.46%)
Lat 99.90th-qrtle-8        81.00 (   0.00%)       81.00 (   0.00%)
Lat 50.00th-qrtle-16       50.00 (   0.00%)       47.00 (   6.00%)
Lat 75.00th-qrtle-16       59.00 (   0.00%)       57.00 (   3.39%)
Lat 90.00th-qrtle-16       66.00 (   0.00%)       65.00 (   1.52%)
Lat 95.00th-qrtle-16       69.00 (   0.00%)       68.00 (   1.45%)
Lat 99.00th-qrtle-16       76.00 (   0.00%)       75.00 (   1.32%)
Lat 99.50th-qrtle-16       79.00 (   0.00%)       79.00 (   0.00%)
Lat 99.90th-qrtle-16       86.00 (   0.00%)       89.00 (  -3.49%)
Lat 50.00th-qrtle-23       52.00 (   0.00%)       52.00 (   0.00%)
Lat 75.00th-qrtle-23       65.00 (   0.00%)       65.00 (   0.00%)
Lat 90.00th-qrtle-23       75.00 (   0.00%)       74.00 (   1.33%)
Lat 95.00th-qrtle-23       81.00 (   0.00%)       79.00 (   2.47%)
Lat 99.00th-qrtle-23       95.00 (   0.00%)       90.00 (   5.26%)
Lat 99.50th-qrtle-23    12624.00 (   0.00%)     1050.00 (  91.68%)
Lat 99.90th-qrtle-23    15184.00 (   0.00%)    13872.00 (   8.64%)

If you'd like to run these tests on your own machines they're all
available at https://github.com/gormanm/mmtests.git.
